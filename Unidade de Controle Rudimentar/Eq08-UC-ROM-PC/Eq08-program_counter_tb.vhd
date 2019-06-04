	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end entity;

architecture a_program_counter_tb of program_counter_tb is
	component program_counter is
		port( 	clk 		: in std_logic;
				rst 		: in std_logic;
				wr_en 		: in std_logic;	 
				j_en		: in std_logic;
				address_in	: in unsigned(15 downto 0);
				data_out 	: out unsigned(15 downto 0)
		);
	end component;	
	
signal clk, rst, wr_en, j_en : std_logic;
signal data_out, address_in : unsigned(15 downto 0);	

begin
	uut : program_counter port map( clk => clk,
									rst => rst,
									wr_en => wr_en,
									data_out => data_out,
									address_in => address_in,
									j_en => j_en
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
		wr_en <= '1';
		rst <= '1';
		j_en <= '0';
		address_in <= to_unsigned(0, 16);
		wait for 125 ns;
		rst <= '0';
		wait for 475 ns;
		address_in <= to_unsigned(3, 16);
		j_en <= '1';
		wait for 100 ns;
		j_en <= '0';
		wait;
	end process;
	
		
		
end architecture;				