library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_tb is
end entity;

architecture xmux2x1 of mux2x1_tb is 
    component mux2x1 is
        port(
            entr0, entr1, enable, sel: in std_logic;
            saida: out std_logic
        );
    end component;
    signal enable, sel, entr0, entr1: std_logic;
begin
    uut: mux2x1 port map(enable => enable, sel => sel, entr0 => entr0, entr1 => entr1);
    process
    begin
        enable <= '0';
        sel <= '1';
        wait for 50 ns;
        enable <= '1';
        sel <= '0';
        wait for 50 ns;
        enable <= '1';
        sel <= '1';
        entr1 <= '1';
        wait for 50 ns;
        wait;
    end process;
    end architecture;