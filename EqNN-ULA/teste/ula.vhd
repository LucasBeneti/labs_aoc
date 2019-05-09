-- AUTOR: Lucas Beneti
-- Professor, não sei se queria que mudasse o nome da ULA tbm, 
-- porque não pode usar - no nome da file, aí acabei não mudando.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        in_A, in_B: in unsigned(15 downto 0);
        op: in unsigned(1 downto 0);
        flag: out std_logic; -- flag de maior
        out_s: out unsigned(15 downto 0)
    );
end entity;

architecture a_ula of ula is
    begin
        flag <= '1'when op="10" and in_A>in_B else
                '0';

        out_s <= in_A+in_B when op="00" else
                in_A/in_B when op="01" else
                in_A-in_B when op="11" else
                "0000000000000000";
end architecture;

