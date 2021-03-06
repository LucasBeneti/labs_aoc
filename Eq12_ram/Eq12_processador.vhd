-- Equipe 12            Autor: Lucas Silva Beneti

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_processador is
    port(
        clk, rst, wr_en: in std_logic
    );

end entity;

architecture a_calculadora of Eq12_processador is

    component Eq12_rom is 
        port(   clk: in std_logic;
                addr: in unsigned(6 downto 0);
                data: out unsigned(15 downto 0)
        );
    end component;

    component Eq12_pc is 
        port(   clk, wr_en, rst: in std_logic;
                data_in: in unsigned(6 downto 0);
                data_out: out unsigned(6 downto 0)
        );
    end component;

    component Eq12_uc is 
        port(   clk, rst: in std_logic;
                pc_wr_en: out std_logic;
                instr: in unsigned(15 downto 0);-- vem da ROM
                addr_uc: out unsigned(6 downto 0); -- address out (para o jump)
                jump_en: out std_logic;
                reg_destino: out unsigned(4 downto 0); -- reg destino da operacao
                reg_operando: out unsigned(4 downto 0); -- reg usado na operacao
                imm_flag: out std_logic; -- flag para ver se operacao sera com imediato (LDI)
                immediate: out unsigned(15 downto 0);
                opcode: out unsigned(5 downto 0)
        );
    end component;

    component Eq12_banco_regs is 
        port(   a1, a2, a3: in unsigned(4 downto 0); -- 5 bits para escolher entre os 32 regs (nao coloquei 32 ainda)
                --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
                wd3: in unsigned(15 downto 0); -- dado a ser gravado
                clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
                rd1, rd2: out unsigned(15 downto 0) -- register data (saidas do banco de regs)
        );
    end component;

    component Eq12_ula is 
        port(   in_A, in_B: in unsigned(15 downto 0);
                op: in unsigned(5 downto 0);
                flag: out unsigned(1 downto 0);
                out_S: out unsigned(15 downto 0)
        );
    end component;

    component Eq12_reg16bits is -- para salvar flag
        port(   clk: in std_logic;
                rst: in std_logic;
                we3: in std_logic;
                wd3: in unsigned(15 downto 0);
                data_out: out unsigned(15 downto 0)
        );
    end component;

    component Eq12_ram is
        port(   clk: in std_logic;
                addr: in unsigned(6 downto 0);
                wr_en: in std_logic;
                data_in: in unsigned(15 downto 0);
                data_out:out unsigned(15 downto 0)
        );
    end component;

    --signals ROM
    signal instruction: unsigned(15 downto 0);

    --signal PC
    signal pc_wr_enable: std_logic;
    signal data_pc_out: unsigned(6 downto 0); -- entra no ROM e sai do PC (data_out)
    signal saida_mux: unsigned(6 downto 0); -- saida do mux que tem o jmp_en


    --signal UC
    signal rd_para_banco: unsigned(4 downto 0); -- eh pra ser de 5 bits (colocar 00 na frente)
    signal rr_para_banco: unsigned(4 downto 0);
    signal immediate_value: unsigned(15 downto 0); -- valor para entrar no mux cujo res vai pra in_B da ULA
    signal immediate_flag: std_logic; -- 
    signal jump_enable: std_logic; -- determina mux da entrada do PC
    signal addr_uc_s: unsigned(6 downto 0);
    signal immed_ldi: unsigned(4 downto 0);

    --signal Banco
    signal data_banco: unsigned(15 downto 0);
    signal saida_1: unsigned(15 downto 0); -- entrada_1 da ULA
    signal saida_2: unsigned(15 downto 0); -- concorrente da entrada_2 da ULA (mux com imm_value)

    --signal ULA
    signal opcode_ula: unsigned(5 downto 0); -- vem da UC
    signal res_ula: unsigned(15 downto 0); -- entra no wd3 do banco
    signal in_B_mux_ula: unsigned(15 downto 0);
    signal flag_sig: unsigned(1 downto 0);

    -- signal Reg16bits (salvar flag)
    signal data_flag_in: unsigned(15 downto 0); -- entrada do reg
    signal en_wr: std_logic;
    signal data_flag_out: unsigned(15 downto 0);

    signal addr_relativo: signed(6 downto 0);

    --signals ram
    signal addr_ram: unsigned(6 downto 0);
    signal wr_en_ram: std_logic;
    signal data_in_ram: unsigned(15 downto 0);
    signal data_out_ram: unsigned(15 downto 0);
    
    begin
        a_rom: Eq12_rom port map(
            clk => clk,
            addr => data_pc_out,
            data => instruction
        );

        a_pc: Eq12_pc port map(
            clk => clk,
            wr_en => pc_wr_enable,
            rst => rst,
            data_in => saida_mux,
            data_out => data_pc_out
        );

        a_uc: Eq12_uc port map(
            clk => clk, 
            rst => rst,
            pc_wr_en => pc_wr_enable,
            instr => instruction,
            addr_uc=>addr_uc_s,
            jump_en => jump_enable,
            reg_destino => rd_para_banco,
            reg_operando => rr_para_banco,
            imm_flag => immediate_flag,
            immediate => immediate_value,   
            opcode => opcode_ula
        );

        a_banco: Eq12_banco_regs port map(
            a1=>rd_para_banco,
            a2=>rr_para_banco,
            a3=>rd_para_banco,
            clk => clk, 
            rst => rst,
            we3 => pc_wr_enable,
            wd3 => data_banco,
            rd1 => saida_1,
            rd2 => saida_2
        );

        a_ula: Eq12_ula port map(
            in_A => saida_1,
            in_B => in_B_mux_ula, -- saida do mux para in_B
            op => opcode_ula,
            flag=>flag_sig,
            out_S => res_ula        
        );

        a_reg16bits: Eq12_reg16bits port map(
            clk=> clk,
            rst=> rst,
            we3=> en_wr,
            wd3=> data_flag_in,
            data_out => data_flag_out
        );

       a_ram: Eq12_ram port map(
            clk=>clk,
            addr=>addr_ram,
            wr_en=>wr_en_ram,
            data_in=>data_in_ram,
            data_out => data_out_ram
        );

        

    en_wr <= '1' when opcode_ula="001010" else
             '0';
    data_flag_in <= "00000000000000" & flag_sig when en_wr = '1' else
                    "0000000000000000";
    

    -- opcode_ula <= isntruction(15 downto 10);
    addr_uc_s <= instruction(6 downto 0);

    addr_relativo <= signed(instruction(6 downto 0));
    
    saida_mux <= instruction(6 downto 0) when jump_enable='1' else
                 unsigned(signed(data_pc_out) + addr_relativo) when data_flag_out(1 downto 0) = "10" and opcode_ula = "111100" else
                 data_pc_out + "0000001";

    -- se opcode for LDI
    immed_ldi <= instruction(9 downto 5) when opcode_ula="111000" else
                 "00000";
    data_banco <= "00000000000" & immed_ldi when opcode_ula="111000" else
                  data_out_ram when opcode_ula = "110100" else -- LDS
                  res_ula;

    immediate_flag <= '1' when opcode_ula="000101" else -- SUBI
                      '0';
    in_B_mux_ula <= immediate_value when immediate_flag = '1' else
                    saida_2;

    -- atrr RAM
    -- impl STD (Store from Register to Data Space)
    wr_en_ram <= '1' when opcode_ula="110101" else
                 '0';

    -- ja setado pras duas ops
    addr_ram <= "00" & instruction(9 downto 5); -- when opcode_ula = "110101" or opcode_ula = "110100" else
                -- "0000000";
    data_in_ram <= saida_1; -- saida 1 do banco é o data_in pra RAM

    -- impl LDS (Load imm from Data Space)
    -- addr_ram <= instruction(4 downto 0) when opcode_ula = "100100" else
    --             "0000000";
    -- rd_para_banco <= addr_ram(4 downto 0) when opcode_ula = "110100" else
    --                  "00000";
    -- data_banco <= data_out_ram;
end architecture;