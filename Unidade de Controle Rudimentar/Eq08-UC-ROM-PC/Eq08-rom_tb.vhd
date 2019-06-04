reg16bits	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
component rom
	port( clk		: in std_logic;
		  endereco  : in unsigned(6 downto 0);
		  dado 		: out unsigned(11 downto 0)
		);
end component;
signal clk		: std_logic;
signal endereco : unsigned(6 downto 0);
signal dado		: unsigned(11 downto 0);

begin
	uut : rom port map( clk => clk,
						endereco => endereco,
						dado => dado
						);
process
begin
	endereco <= "0000000";
	wait for 50 ns;
	endereco <= "0000000";
	wait for 100 ns;
	endereco <= "1111111";
	wait for 100 ns;
	endereco <= "0000001";
	wait for 100 ns;
	endereco <= "0001000";
	wait for 100 ns;
	endereco <= "0000110";
	wait;
end process;

process
begin
	clk <= '1';
	wait for 50 ns;
	clk <= '0';
	wait for 50 ns;
end process;

end architecture;	