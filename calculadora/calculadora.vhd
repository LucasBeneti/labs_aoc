library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
    port(
        clk, rst, wr_en: in std_logic
    );

end entity;

architecture a_calculadora of calculadora is

    component rom is 
        port(   clk: in std_logic;
                addr: in unsigned(6 downto 0);
                data: out unsigned(15 downto 0)
        );
    end component;

    component pc is 
        port(   clk, wr_en, rst: in std_logic;
                data_in: in unsigned(6 downto 0);
                data_out: out unsigned(6 downto 0)
        );
    end component;

    component uc is 
        port(   clk, rst: in std_logic;
                pc_wr_en: out std_logic;
                instr: in unsigned(15 downto 0);-- vem da ROM
                addr_uc: out unsigned(6 downto 0); -- address out (para o jump)
                jump_en: out std_logic;
                reg_destino: out unsigned(4 downto 0); -- reg destino da operacao
                reg_operando: out unsigned(4 downto 0); -- reg usado na operacao
                imm_flag: out std_logic; -- flag para ver se operacao sera com imediato (LDI)
                immediate: out unsigned(4 downto 0);
                opcode: out unsigned(5 downto 0)
        );
    end component;

    component banco_regs is 
        port(   a1, a2, a3: in unsigned(4 downto 0); -- 5 bits para escolher entre os 32 regs (nao coloquei 32 ainda)
                --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
                wd3: in unsigned(15 downto 0); -- dado a ser gravado
                clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
                rd1, rd2: out unsigned(15 downto 0) -- register data (saidas do banco de regs)
        );
    end component;

    component ula is 
        port(   in_A, in_B: in unsigned(15 downto 0);
                op: in unsigned(5 downto 0);
                -- flag_maior: out std_logic;
                out_S: out unsigned(15 downto 0)
        );
    end component;

    --signals ROM
    signal instruction: unsigned(15 downto 0);

    --signal PC
    signal pc_wr_enable: std_logic;
    signal data_pc_out: unsigned(6 downto 0); -- entra no ROM e sai do PC (data_out)
    signal saida_mux: unsigned(6 downto 0); -- saida do mux que tem o jmp_en


    --signal UC
    signal instr_da_rom: unsigned(15 downto 0);
    signal rd_para_banco: unsigned(4 downto 0); -- eh pra ser de 5 bits (colocar 00 na frente)
    signal rr_para_banco: unsigned(4 downto 0);
    signal immediate_value: unsigned(4 downto 0); -- valor para entrar no mux cujo res vai pra in_B da ULA
    signal immediate_flag: std_logic; -- 
    signal addr_pc: unsigned(6 downto 0); -- possivel resultado mux da entrada do PC
    signal jump_enable: std_logic; -- determina mux da entrada do PC
    -- signal opcode_ula: unsigned(5 downto 0);

    --signal Banco
    signal rd: unsigned(2 downto 0); -- a1, saida da UC (parte da instr)
    signal rr: unsigned(2 downto 0); -- a2, saida da UC (parte da instr)
    signal sel: unsigned(2 downto 0); -- a3, acredito que o mesmo que rd
    --signal res_ula: unsigned(15 downto 0); -- saida da ula mas é o conteudo do sel
    signal saida_1: unsigned(15 downto 0); -- entrada_1 da ULA
    signal saida_2: unsigned(15 downto 0); -- concorrente da entrada_2 da ULA (mux com imm_value)

    --signal ULA
    signal entrada_1: unsigned(15 downto 0); -- vem direto do banco
    signal entrada_2: unsigned(15 downto 0); -- vem do mux que depende de coisa da UC
    signal opcode_ula: unsigned(5 downto 0); -- vem da UC
    signal res_ula: unsigned(15 downto 0); -- entra no wd3 do banco

    -- rd_para_banco <= "00" & rd_para_banco;
    begin
        -- rr_para_banco <= "00" & rr_para_banco; ESSAS DUAS SAIDAS VAO TER QUE SER TRATADAS EM ALGUM LUGAR
        a_rom: rom port map(
            clk => clk,
            addr => data_pc_out,
            data => instruction
        );

        a_pc: pc port map(
            clk => clk,
            wr_en => pc_wr_enable,
            rst => rst,
            data_in => saida_mux,
            data_out => data_pc_out
        );

        a_uc: uc port map(
            clk => clk, 
            rst => rst,
            pc_wr_en => pc_wr_enable,
            instr => instruction,
            jump_en => jump_enable,
            reg_destino => rd_para_banco,
            reg_operando => rr_para_banco,
            imm_flag => immediate_flag,
            immediate => immediate_value,
            opcode => opcode_ula
        );

        a_banco: banco_regs port map(
            a1=>rd_para_banco,
            a2=>rr_para_banco,
            a3=>rd_para_banco,
            clk => clk, 
            rst => rst,
            we3 => pc_wr_enable,
            wd3 => res_ula,
            rd1 => saida_1,
            rd2 => saida_2
        );

        a_ula: ula port map(
            in_A => entrada_1,
            in_B => entrada_2,
            op => opcode_ula,
            out_S => res_ula
        );

-- dar uma olhada melhor nas ligações porque acredito que algumas estão duplicadas
-- ver certinho se cada componente está fazendo o esperado e se existem todos os signal necessários
end architecture;
