library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;


architecture a_rom_tb of rom_tb is
component rom
     port(clk : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado : out unsigned(15 downto 0)
        );
end component;

signal clk:std_logic;
signal dado : unsigned(15 downto 0);
signal endereco : unsigned(6 downto 0);

begin
    uut: rom port map(clk => clk,
					  endereco => endereco,
					  dado => dado);
    
    process -- sinal de clock
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;
    process
    begin
		endereco <= "0000000"; -- 1		 -- +
		wait for 49 ns;
        endereco <= "0000001"; -- 1		 -- +
		wait for 49 ns;
         endereco <= "0000010"; -- 1		 -- +
		wait for 49 ns;
         endereco <= "0000011"; -- 1		 -- +
		wait for 49 ns;
         endereco <= "0000100"; -- 1		 -- +
		wait for 49 ns;
         endereco <= "1000111"; -- 1		 -- +
		wait for 49 ns;
    end process;
end architecture;
