library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end;

architecture a_ula_tb of ula_tb is
	component ula
		port( entrada0,entrada1		 : in unsigned (15 downto 0);
			  operacao   : in unsigned (1 downto 0);
			  resultado	 : out unsigned (15 downto 0);
			  flag_psw 	 : out unsigned (15 downto 0)
     		);
	end component;
	signal operacao: unsigned (1 downto 0);
	signal entrada0,entrada1, flag_psw , resultado: unsigned (15 downto 0);
	
	begin
		uut: ula port map( entrada0 => entrada0,
						   entrada1 => entrada1,
						   operacao => operacao,
						   resultado => resultado,
						   flag_psw=>flag_psw);
							 
	process
	begin
		entrada0 <= "1111111111111111"; -- 0
		entrada1 <= "1111111111111111"; -- 1
		operacao <= "00";		 -- +
		wait for 50 ns;
		entrada0 <= "0000000000010111"; -- 23
		entrada1 <= "0000000000010111"; -- 23
		operacao <= "00";		 -- +
		wait for 50 ns;
		entrada0 <= "0001111010101100"; -- 7852
		entrada1 <= "0000111110100000"; -- 4000
		operacao <= "00";		 -- +
		wait for 50 ns;
		entrada0 <= "0000111110100000"; -- 4000
		entrada1 <= "0001111010101100"; -- 7852
		operacao <= "00";		 -- +
		wait for 50 ns;
		entrada0 <= "0111111111111111"; -- 32767
		entrada1 <= "0011111111111111"; -- 16383
		operacao <= "00";		 -- +
		entrada0 <= "0000000000000000"; -- 0
		entrada1 <= "0000000000000001"; -- 1
		operacao <= "01";		 -- -
		wait for 50 ns;
		entrada0 <= "0000000000010111"; -- 23
		entrada1 <= "0000000000010111"; -- 23
		operacao <= "01";		 -- -
		wait for 50 ns;
		entrada0 <= "0001111010101100"; -- 7852
		entrada1 <= "0000111110100000"; -- 4000
		operacao <= "01";		 -- -
		wait for 50 ns;
		entrada0 <= "0000111110100000"; -- 4000
		entrada1 <= "0001111010101100"; -- 7852
		operacao <= "01";		 -- -
		wait for 50 ns;
		entrada0 <= "0111111111111111"; -- 32767
		entrada1 <= "0011111111111111"; -- 16383
		operacao <= "01";		 -- -
		entrada0 <= "0000000000000000"; -- 0
		entrada1 <= "0000000000000001"; -- 1
		operacao <= "10";		 -- ==
		wait for 50 ns;
		entrada0 <= "0000000000010111"; -- 23
		entrada1 <= "0000000000010111"; -- 23
		operacao <= "10";		 -- ==
		wait for 50 ns;
		entrada0 <= "0001111010101100"; -- 7852
		entrada1 <= "0000111110100000"; -- 4000
		operacao <= "10";		 -- ==
		wait for 50 ns;
		entrada0 <= "0000111110100000"; -- 4000
		entrada1 <= "0001111010101100"; -- 7852
		operacao <= "10";		 -- ==
		wait for 50 ns;
		entrada0 <= "0111111111111111"; -- 32767
		entrada1 <= "0011111111111111"; -- 16383
		operacao <= "10";		 -- ==
		entrada0 <= "0000000000000000"; -- 0
		entrada1 <= "0000000000000001"; -- 1
		operacao <= "11";		 -- entrada0<entrada1
		wait for 50 ns;
		entrada0 <= "0000000000010111"; -- 23
		entrada1 <= "0000000000010111"; -- 23
		operacao <= "11";		 -- entrada0<entrada1
		wait for 50 ns;
		entrada0 <= "0001111010101100"; -- 7852
		entrada1 <= "0000111110100000"; -- 4000
		operacao <= "11";		 -- entrada0<entrada1
		wait for 50 ns;
		entrada0 <= "0000111110100000"; -- 4000
		entrada1 <= "0001111010101100"; -- 7852
		operacao <= "11";		 -- entrada0<entrada1
		wait for 50 ns;
		entrada0 <= "0111111111111111"; -- 32767
		entrada1 <= "0011111111111111"; -- 16383
		operacao <= "11";		 -- entrada0<entrada1
		wait for 50 ns;
		wait;
	end process;
end architecture;