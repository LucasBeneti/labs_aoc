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
            op: in unsigned(1 downto 0);
            flag_maior: out std_logic; -- verfica se eh maior
            out_S: out unsigned(15 downto 0)
        );
    end component;

    signal rd1, rd2: unsigned(15 downto 0); -- saido do banco e entrada da ula

    begin
        banco: banco_regs port map(clk=>clk, we3=>we3, wd3=>wd3, rst=>rst, rd1=>rd1, rd2=>rd2, a3=>a3, a1=>a1, a2=>a2);
        a_ula: ula port map(in_A=>rd1, in_B=>rd2, op=>op_ula, out_S=>output_s , flag_maior=>flag_maior);



end architecture;

--(clk=>clk, wr_en=>wr_en, data_in=>entrada, rst=>rst, sel_read0=>sel_read0,sel_read1=>sel_read1, data_out0=>data_out0, data_out1=>data_out1, sel_wr_reg=>sel_wr);
--ulax: ula port map(entrada0=>data_out0,  entrada1=>data_out_mux, operacao=>op_ula, resultado=>saida);