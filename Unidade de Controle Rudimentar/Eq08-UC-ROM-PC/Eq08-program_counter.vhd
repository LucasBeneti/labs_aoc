	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
	port( 	clk 		: in std_logic;
			rst 		: in std_logic;
			wr_en 		: in std_logic;	 
			data_out 	: out unsigned(15 downto 0);
			j_en		: in std_logic;
			address_in	: in unsigned(7 downto 0)
		);
end entity;

architecture a_program_counter of program_counter is
	component reg16bits is
		port( clk		: in std_logic;
			  rst 		: in std_logic;
			  wr_en 	: in std_logic;
			  data_in 	: in unsigned(15 downto 0);
			  data_out 	: out unsigned(15 downto 0)
		);
	end component;	
	signal registro, PC_in : unsigned(15 downto 0);
begin	
	reg: reg16bits port map(clk=>clk, rst=>rst, wr_en =>wr_en, data_in=>PC_in, data_out=>registro);

	PC_in <= 	registro + 1 when j_en = '0' else
				to_unsigned(to_integer(address_in), 16) when j_en = '1' else	--Pula para o endereço se o j_en tiver setado
				"0000000000000000";
	data_out <= registro;
end architecture;
