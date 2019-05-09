library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(entrada0, entrada1 : in unsigned (15 downto 0);
		  operacao    	         : in unsigned (1 downto 0);
		  resultado          : out unsigned (15 downto 0);
		  flag_psw 			 : out unsigned (15 downto 0)
	);
end entity;

architecture a_ula of ula is
	signal cy, z, j: std_logic;
	signal in_a_17, in_b_17, soma: unsigned(16 downto 0);
begin
	resultado <= (entrada0 + entrada1) 				   when operacao="00" else
				 (entrada1 - entrada0) 		 		   when operacao="01" else
				 "0000000000000001" 			       when (operacao="10" and entrada0 = entrada1) else
				 "0000000000000001"                    when (operacao="11" and entrada0 < entrada1) else
				 "0000000000000000";

	in_a_17 <= '0' & entrada0;
	in_b_17 <= '0' & entrada1; 	
	soma <= in_a_17 + in_b_17;
	cy <= soma(16);
	z <= '1' when (entrada0 = entrada1) else
		 '0';
	j <= '1' when entrada0 < entrada1 else
		 '0';

	flag_psw <= "000000000000" & cy & "0" & j & z;	
end architecture;