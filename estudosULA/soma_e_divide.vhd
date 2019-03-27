library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_divide is
    port(   x, y: in unsigned(7 downto 0);
            soma, quoc: out unsigned(7 downto 0);
            maior, x_negativo: out std_logic
    );
end entity;

architecture a_soma_e_divide of soma_e_divide is
    begin
        soma <= x+y;
        quoc <= x/y;
        maior <= '1' when x>y else
                 '0' when x<=y else
                 '0';
        x_negativo <= x(7);
        
end architecture;