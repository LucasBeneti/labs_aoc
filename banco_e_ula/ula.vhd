library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        in_A, in_B: in unsigned(15 downto 0);
        op: in unsigned(5 downto 0);
        --flag_maior: out std_logic;
        out_S: out unsigned(15 downto 0)
    );
end entity;

architecture a_ula of ula is    
    begin
        --flag_maior <= '1'when op="10" and in_A>in_B else
                     -- '0';

        out_S <= in_A+in_B when op="00" else
                in_A/in_B when op="01" else
                in_A-in_B when op="11" else
                "0000000000000000";
end architecture;

 