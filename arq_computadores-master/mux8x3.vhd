library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x3 is
    port(sel : in unsigned(2 downto 0);
        entrada0 : in unsigned(15 downto 0);
        entrada1 : in unsigned(15 downto 0);
        entrada2 : in unsigned(15 downto 0);
        entrada3 : in unsigned(15 downto 0);
        entrada4 : in unsigned(15 downto 0);
        entrada5 : in unsigned(15 downto 0);
        entrada6 : in unsigned(15 downto 0);
        entrada7 : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0)
 );
end entity;

architecture a_mux8x3 of mux8x3 is
begin
 saida <=  "0000000000000000" when sel="000" else
          entrada1 when sel="001" else
          entrada2 when sel="010" else
          entrada3 when sel="011" else
          entrada4 when sel="100" else
          entrada5 when sel="101" else
          entrada6 when sel="110" else
          entrada7 when sel="111" else
          "0000000000000000"; -- esse '0' é pra quando "der pau" 
end architecture;

