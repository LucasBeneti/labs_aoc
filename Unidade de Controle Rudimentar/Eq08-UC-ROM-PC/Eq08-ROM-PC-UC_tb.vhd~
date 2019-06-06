	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_uc_tb is
end entity;

architecture a_rom_pc_uc_tb of rom_pc_uc_tb is
	component rom_pc_uc
	port( 	clk		: in std_logic;
			rst 	: in std_logic;
			rom_out	: out unsigned(11 downto 0)
		);
	end component;
	
signal clk, rst: std_logic;
signal rom_out : unsigned(11 downto 0);

begin
	uut : rom_pc_uc port map(	clk => clk,
								rst => rst,
								rom_out => rom_out
						    );	
						 
	process
	begin
		clk  <= '0';
		wait for 50 ns;
		clk  <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		rst <= '1';
		wait for 125 ns;
		rst <= '0';
		wait;
	end process;

end architecture;
		