library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode is
    port(   entrada : in unsigned(2 downto 0);
            wr_en : std_logic;
            saida: out unsigned(7 downto 0)
         ); 
end entity;

architecture a_decode of decode is
begin
    saida <= "00000001" when entrada="000" and wr_en='1' else
             "00000010" when entrada="001" and wr_en='1' else
             "00000100" when entrada="010" and wr_en='1' else  
             "00001000" when entrada="011" and wr_en='1' else
             "00010000" when entrada="100" and wr_en='1' else
             "00100000" when entrada="101" and wr_en='1' else
             "01000000" when entrada="110" and wr_en='1' else
             "10000000" when entrada="111" and wr_en='1' else
             "00000000";
end architecture;


