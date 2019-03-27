library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_divide_tb is
end entity;

architecture asoma_e_divide_tb of soma_e_divide_tb is
    component soma_e_divide is
        port(   x, y: in unsigned(7 downto 0);
                soma, quoc: out unsigned(7 downto 0);
                maior, x_negativo: out std_logic
        );
    end component;
    signal x, y: unsigned(7 downto 0);
begin
    uut: soma_e_divide port map(x => x, y => y);
    process
    begin
        y <= "00000011";
        x <= "00000101";
        wait for 50 ns;
        x <= "11001000";
        y <= "11001000";
        wait for 50 ns;
        wait;
    end process;
end architecture;