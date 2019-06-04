	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity un_controle_tb is
end entity;

architecture a_un_controle_tb of un_controle_tb is
	component un_controle
	port( 	clk 		: in std_logic;
			j_en 		: out std_logic;
			pc_wr_en 	: out std_logic;
			instr 		: in unsigned(11 downto 0);
			--saida : out unsigned(3 downto 0);
			rst 		: in std_logic
		);
	end component;
	
signal clk, rst, j_en, pc_wr_en	: std_logic;
signal instr					: unsigned(11 downto 0);

begin
	uut : un_controle port map(	clk => clk,
								rst => rst,
								j_en => j_en,
								pc_wr_en => pc_wr_en,
								instr => instr
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
		instr <= "100000000000";
		wait for 125 ns;
		instr <= "100000000000";
		rst <= '0';
		wait for 100 ns;
		instr <= "100000001111";
		wait for 100 ns;
		instr <= "100100000000";
		wait for 100 ns;
		instr <= "111100000001";
		wait;
	end process;

end architecture;
		