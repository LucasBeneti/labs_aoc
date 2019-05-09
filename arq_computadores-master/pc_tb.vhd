library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end;

architecture a_pc_tb of pc_tb is
	component pc
		port(clk : in std_logic;
         wr_en : in std_logic;
         data_in : in unsigned(6 downto 0);
         rst : in std_logic;
         data_out : out unsigned(6 downto 0)
        );
    	end component;	
	signal clk, wr_en, rst : std_logic;
    signal data_in, data_out: unsigned(6 downto 0);
    
    begin
        uut: pc port map(
            clk=>clk,
            rst=>rst,
            wr_en=>wr_en,
            data_in=>data_in,
            data_out=>data_out
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
            wait for 100 ns;
            wr_en <= '0';
            rst <= '0';
            wait for 300 ns;
            wr_en <= '1';
            wait;
        end process;    
end architecture;