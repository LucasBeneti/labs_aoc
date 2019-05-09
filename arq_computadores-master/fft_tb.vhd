library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fft_tb is
end;

architecture a_fft_tb of fft_tb is
	component fft
		port(clk : in std_logic;
            rst : in std_logic;
            estado : out unsigned(1 downto 0)
         );
    end component;	
	signal clk, rst : std_logic;
    signal estado: unsigned(1 downto 0);

    begin
        uut: fft port map(
            clk=>clk,
            rst=>rst,
            estado=>estado
        );
        
        process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;
        
        process -- sinal de reset
        begin
            rst <= '1';
            wait for 400 ns;
            rst <= '0';
            wait;
        end process;
end architecture;