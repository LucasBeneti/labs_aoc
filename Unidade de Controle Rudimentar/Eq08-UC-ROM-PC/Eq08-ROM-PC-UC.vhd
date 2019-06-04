	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_uc is
	port( 	rst	: in std_logic;
			clk	: in std_logic;
			
			rom_out	: out unsigned(11 downto 0)
		);
end entity;

architecture a_rom_pc_uc of rom_pc_uc is
	component un_controle is
		port( 	clk 		: in std_logic;
				j_en 		: out std_logic;
				pc_wr_en 	: out std_logic;
				instr 		: in unsigned(11 downto 0);
				--saida : out unsigned(3 downto 0);
				rst 		: in std_logic
			);
	end component;
	component rom is
		port( clk 			: in std_logic;
			  endereco		: in unsigned(6 downto 0);
			  dado 			: out unsigned(11 downto 0)
			);  
	end component;
	component program_counter is
		port( 	clk 		: in std_logic;
				rst 		: in std_logic;
				wr_en 		: in std_logic;	 
				j_en		: in std_logic;
				address_in	: in unsigned(7 downto 0);
				data_out 	: out unsigned(15 downto 0)
			);
	end component;
	
	signal j_en, pc_wr_en: std_logic;
	signal instr : unsigned(11 downto 0);
	signal address_in, data_out: unsigned(15 downto 0);
	
	
begin
	uc: un_controle port map (clk => clk, j_en => j_en, pc_wr_en => pc_wr_en, instr => instr, rst => rst);
	mem: rom port map (clk => clk, endereco => data_out(6 downto 0), dado => instr);
	pc: program_counter port map (clk => clk, rst => rst, wr_en => pc_wr_en, j_en => j_en, address_in => instr(7 downto 0), data_out => data_out);
	
	rom_out <= instr;


end	architecture;