-- Equipe 12            Autor: Lucas Silva Beneti
-- A maior dificuldade foi mapear as portas e decidir a lógica de mux e demux que deveria
-- ser realizada para a selecao tanto de saida quanto de entrada. E também de alinhar o componente
-- de registrador de 16 bits com as entradas do banco.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_banco_regs is
    port(
        a1, a2, a3: in unsigned(4 downto 0); -- 5 bits para escolher entre os 32 regs (nao coloquei 32 ainda)
        --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
        wd3: in unsigned(15 downto 0); -- dado a ser gravado
        clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
        rd1, rd2: out unsigned(15 downto 0) -- register data (saidas do banco de regs)
    );
end entity;

architecture a_banco of Eq12_banco_regs is

    component Eq12_reg16bits is 
        port(   
                clk: in std_logic;
                rst: in std_logic;
                we3: in std_logic;
                wd3: in unsigned(15 downto 0);
                data_out: out unsigned(15 downto 0)
            );
    end component;
    signal en1, en2, en3, en4, en5, en6, en7: std_logic; -- enable pra escrever em casa registrador
    signal reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7: unsigned(15 downto 0); -- dado armazenado no reg

begin

    reg0 <= "0000000000000000";
    regist1: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en1, wd3=>wd3, data_out=>reg1);
    regist2: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en2, wd3=>wd3, data_out=>reg2);
    regist3: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en3, wd3=>wd3, data_out=>reg3);
    regist4: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en4, wd3=>wd3, data_out=>reg4);
    regist5: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en5, wd3=>wd3, data_out=>reg5);
    regist6: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en6, wd3=>wd3, data_out=>reg6);
    regist7: Eq12_reg16bits port map(clk=>clk, rst=>rst, we3=>en7, wd3=>wd3, data_out=>reg7);


    -- write enable
    en1 <=  we3 when a3="00001" else -- enable para escrita (escolhendo qual enx será setado)
            '0';
    en2 <=  we3 when a3="00010" else
            '0';
    en3 <=  we3 when a3="00011" else
            '0';
    en4 <=  we3 when a3="00100" else
            '0';
    en5 <=  we3 when a3="00101" else
            '0';
    en6 <=  we3 when a3="00110" else
            '0';
    en7 <=  we3 when a3="00111" else
            '0';

    -- mux saida p/ registrador A
    rd1 <=  reg0 when a1 = "00000" else
            reg1 when a1 = "00001" else
            reg2 when a1 = "00010" else
            reg3 when a1 = "00011" else
            reg4 when a1 = "00100" else
            reg5 when a1 = "00101" else
            reg6 when a1 = "00110" else
            reg7 when a1 = "00111" else
            "0000000000000000";

    -- mux saida p/ registrador B
    rd2 <=  reg0 when a2 = "00000" else
            reg1 when a2 = "00001" else
            reg2 when a2 = "00010" else
            reg3 when a2 = "00011" else
            reg4 when a2 = "00100" else
            reg5 when a2 = "00101" else
            reg6 when a2 = "00110" else
            reg7 when a2 = "00111" else
            "0000000000000000";
end architecture;