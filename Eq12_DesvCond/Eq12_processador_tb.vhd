-- Equipe 12            Autor: Lucas Silva Beneti

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_processador_tb is
end entity;

architecture a_calculadora_tb of Eq12_processador_tb is
    component Eq12_processador port(
        clk, rst, wr_en: in std_logic
    );
    end component;

    signal clk, rst, wr_en: std_logic;
    --signal resultado_ula: unsigned(15 downto 0);

    begin
        uut: Eq12_processador port map(
            clk=>clk,rst=>rst,
            wr_en=>wr_en
        );

        process
            begin
                clk <='0';
                wait for 50 ns;
                clk <='1';
                wait for 50 ns;
        end process;

        process
            begin
                rst <= '1';
                wait for 100 ns;
                rst <= '0';
                wait;
        end process;

        process
            begin
                wr_en <= '1';
                wait for 100 ns;
                wait;
        end process;
end architecture;