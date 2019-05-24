library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity unidade_controle is
  port(clk : in std_logic; --
       wr_en: out std_logic; --
       rst: in std_logic; --
       data_out: out unsigned(15 downto 0);--
       wr_r: out unsigned(2  downto 0); --
       const_out: out unsigned(15 downto 0);
       estado : out unsigned(1 downto 0); --
       const_on : out std_logic
  );
end unidade_controle ; 

architecture a_unidade_controle of unidade_controle is
    component reg16bits
	port(clk : in std_logic;
         wr_en : in std_logic;
         data_in : in unsigned(15 downto 0);
         rst : in std_logic;
         data_out : out unsigned(15 downto 0)
        );
	end component;
    component rom
        port( 
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado : out unsigned(15 downto 0)
        );
    end component;

    component fft
        port(
            clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
        );
    end component;	

    signal opcode: unsigned(2 downto 0);
    signal data, d_out_rom, data_saida : unsigned(11 downto 0); 
    signal endereco, prox_endereco: unsigned(15 downto 0);
    signal jump_end: unsigned(4 downto 0);
    signal jump_en: std_logic;
    signal wr_en_pc, wr_en_psw: std_logic;
    signal estado_s : unsigned(1 downto 0);
    signal ula_psw_out : unsigned (15 downto 0);
    signal branchSoma : unsigned (15 downto 0);
    signal branchCode : unsigned (3 downto 0);
    signal brachOn :std_logic;
    signal brachOp : unsigned (3 downto 0);

begin
    pc: reg16bits port map(clk=>clk, wr_en=>wr_en_pc, data_in=>prox_endereco, rst=>rst, data_out=>endereco);
    romx  : rom port map(clk=> clk, endereco => endereco(6 downto 0), dado=> d_out_rom);
    m_estado : fft port map(clk=> clk, rst=>rst, estado=>estado_s);
    
    --Program Status Word (PSW)
    psw: reg16bits port map(clk=>clk, wr_en=>wr_en_psw, data_in=>ula_psw, rst=>rst, data_out=>ula_psw_out);

    wr_en_pc <= '1';
    
    data_out <= endereco;
    estado <= estado_s;
    
    --Pega opcode
    opcode <= d_out_rom(10 downto 5);
    brachOp <= d_out_rom(10 downto 7);

    --branch
    branchSoma <= ("000000000" & d_out_rom(15 downto 12) & d_out_rom(6 downto 4)) when d_out_rom(15) = '0' else
                  ("111111111" & d_out_rom(15 downto 12) & d_out_rom(6 downto 4));
    branchCode <= d_out_rom(3 downto 0);
    brachOn <= '1' when brachOp="1011" else
               '0';

    jump_en <= '1' when opcode = "000011" else
               '0';
    --opcodes
    --R = recebe resultado
    --i constante 
    --MOV imm5, reg2 == rrrrr010000iiiii
    --MOV reg1, reg2 == rrrrr001010RRRRR
    --NOP 0000000000000000
    --SUB reg1, reg2 -- rrrrr001101RRRRR    
    --JMP reg1 -- 00000 000011 RRRRR
    --CMP imm5, reg2 --rrrrr010011iiiii
    --CMP reg1, reg2  --rrrrr001111RRRRR
    --BL disp9  ---- ddddd1011ddd0001


    ---MOV 5, reg3 --    00011 010000 00101
    ---MOV 8, reg4 --    00100 010000 01000
    ---MOV reg5, reg3 -- 00011 001010 00101
    ---ADD reg5, reg4 -- 00100 001110 00101
    ---MOV 1, reg6 --    00110 010000 00001
    ---SUB reg6, reg5 -- 00110 001101 00101
    ---JMP 19 --         00000 000011 10011
    ---MOV reg3, reg5 -- 00101 001010 00011
    ---JMP 2          -- 00000 000011 00010

    ---MOV 0, reg3 --    00011 010000 00000
    ---MOV 0, reg4 --    00100 010000 00000
    ---ADD reg4, reg3 -- 00011 001110 00100
    ---MOV 1, reg5    -- 00101 010000 00001
    ---ADD reg3, reg5 -- 00101 001110 00011
    ---CMP imm5, reg3 -- 00011 010011 11110
    ---BL disp9  ----    11111 101110 00001
    ---MOV reg5, reg4 -- 00100 001010 00101


    --Define operacao ula
    ula_op <= "00" when opcode = "010000" or opcode="001010" or opcode="001110" else
              "01" when opcode = "001101" else
              "10";

    --pega registrador 1
    r0_out <=   "000" when opcode="010000" else
                 d_out_rom(13 downto 11) ;

    --habilita o PSW
    wr_en_psw <= '1' when (opcode = "001111" or  opcode = "010011") and estado_s = "01" else
                 '0';
    
    --pega registrador 2
    r1_out <= d_out_rom(2 downto 0);

    jump_end <= d_out_rom(4 downto 0);
    --
    const_out <= "0000000000000000" when opcode = "001010" else
                 "00000000000" & d_out_rom(4 downto 0);
    
    --Habilita o escrever
    wr_en <= '1' when estado_s="01" and brachOn='0' and wr_en_psw='0' else
             '0';

    --pega registrador a ser escrito
    wr_r <= d_out_rom(13 downto 11) when opcode="010000" else
            d_out_rom(2 downto 0);

    --Passa constante 
    const_on <= '1' when opcode = "010000" or opcode = "001010" or opcode = "010011" else
                '0';
    
             
             --Joga a próximo endereço
    prox_endereco <= (endereco + 1) when estado_s = "00" and brachOn = '0' else
                     (endereco + branchSoma) when branchCode="0010" and ula_psw_out(0) = '1' and estado_s = "00" else
                     (endereco + branchSoma) when branchCode="0001" and (ula_psw_out(1) = '1') and estado_s = "00" else-- bl
                     (endereco + 1) when estado_s = "00" else
                     endereco;  
end architecture;