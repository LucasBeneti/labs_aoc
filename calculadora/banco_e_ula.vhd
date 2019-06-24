library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_e_ula is
    port(
        a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
        -- reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
        wd3: in unsigned(15 downto 0); -- dado a ser gravado
        clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
        op_ula: in unsigned(5 downto 0); -- operacao da ula
        -- flag_maior: out std_logic; -- flag de maior ou menor, soh booleano mesmo
        output_s: out unsigned(15 downto 0); -- saida geral (da ULA)
        --aida1, saida2: out unsigned(15 downto 0) -- aqui nao eh uma saida
        imm_flag: in std_logic; -- flag, vem da UC
        imm_value: in unsigned(4 downto 0) -- vem da UC
    );
end entity;

architecture a_banco_e_ula of banco_e_ula is
    component banco_regs is
        port(
            a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            wd3: in unsigned(15 downto 0); -- dado a ser gravado
            clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
            rd1, rd2: out unsigned(15 downto 0)
        );
    end component;

    component ula is
        port(
            in_A, in_B: in unsigned(15 downto 0);
            op: in unsigned(5 downto 0);
            -- flag_maior: out std_logic; -- verfica se eh maior
            out_S: out unsigned(15 downto 0)
        );
    end component;

    signal rd1_s, rd2_s: unsigned(15 downto 0); -- saida do banco e entrada da ula
    signal imm_flag_s: std_logic;
    signal imm_value_s: unsigned(4 downto 0);

    --signals do Banco
    signal a1_s, a2_s, a3_s: unsigned(2 downto 0);
    signal wd3_s: unsigned(15 downto 0);
    signal we3_s: std_logic;

    --signals da ULA
    signal op_ula_s: unsigned(5 downto 0);
    signal saida_ula: unsigned(15 downto 0);
    

    begin
        banco: banco_regs port map(clk=>clk, we3=>we3_s, wd3=>wd3_s, rst=>rst, rd1=>rd1_s, rd2=>rd2_s, a1=>a1_s, a2=>a2_s, a3=>a3_s);
        a_ula: ula port map(in_A=>rd1_s, in_B=>rd2_s, op=>op_ula_s, out_S=>output_s);

        -- rd2_s <= "00000000000" & imm_value_s when imm_flag_s = '1' else
        --          rd2_s;
    
end architecture;

--(clk=>clk, wr_en=>wr_en, data_in=>entrada, rst=>rst, sel_read0=>sel_read0,sel_read1=>sel_read1, data_out0=>data_out0, data_out1=>data_out1, sel_wr_reg=>sel_wr);
--ulax: ula port map(entrada0=>data_out0,  entrada1=>data_out_mux, operacao=>op_ula, resultado=>saida);