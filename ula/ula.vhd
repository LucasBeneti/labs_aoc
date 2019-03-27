library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--verificar com julius se a implementação tá certa e pra que 
-- serve o flag...

entity ula is
    port(
        in_A, in_B: in unsigned(15 downto 0);
        op: in unsigned(1 downto 0);
        soma, quoc: out unsigned(15 downto 0);
        maior, x_negativo: out std_logic
        out_S: out unsigned(15 downto 0)
    );
end entity;

architecture a_ula of ula is
    begin
        soma <= in_A+in_B;
        quoc <= in_A/in_B;
        maior <= '1'when in_A>in_B else
                 '0' when in_A<=in_B else
                 '0';
        x_negativo <= x(15);

        out_S <= soma when op="00" else
                 quoc when op="01" else
                 maior when op="10" else
                 x_negativo when op="11" else
                 "0";
end architecture;

