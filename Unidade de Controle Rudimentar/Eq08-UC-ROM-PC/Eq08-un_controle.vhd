	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08

library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity un_controle is
	port( 	clk		 : in std_logic;
			j_en 	 : out std_logic;
			pc_wr_en : out std_logic;
			instr 	 : in unsigned(11 downto 0);
			--saida  : out unsigned(3 downto 0);
			rst 	 : in std_logic
		);
end entity;

architecture a_un_controle of un_controle is
	signal estado : std_logic;
	signal opcode : unsigned(3 downto 0);
begin
	process(clk,rst) 
	begin
		if rst = '1' then
			estado <= '0';
		elsif falling_edge(clk) then
			estado <= not estado;
		end if;
	end process;
	
	opcode <= instr(11 downto 8);
	j_en <= '1' when opcode = "1111" else		--comeco do endereco da ROM la...
			'0';
	pc_wr_en <=	'1' when estado = '1' else
				'0';	
			
end	architecture;