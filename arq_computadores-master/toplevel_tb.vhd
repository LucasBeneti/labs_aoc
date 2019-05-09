library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_tb is
end entity;

architecture a_toplevel_tb of toplevel_tb is
    component toplevel
         port(clk : std_logic;
         wr_en : std_logic;
         rst: std_logic;
         entrada : in unsigned(15 downto 0);
         saida : out unsigned(15 downto 0);
         sel: in std_logic;
         sel_wr : in unsigned(2 downto 0);
         sel_read0: in unsigned(2 downto 0);
         sel_read1: in unsigned(2 downto 0);
         op_ula : in unsigned(1 downto 0)
        );
	end component;
    signal clk, wr_en, rst, sel : std_logic;
    signal sel_wr: unsigned(2 downto 0);
    signal entrada, saida : unsigned(15 downto 0);
    signal sel_read0, sel_read1 : unsigned(2 downto 0);
    signal op_ula : unsigned(1 downto 0);
 begin
        top: toplevel port map(
         clk => clk,
         wr_en => wr_en,
         rst=> rst,
         entrada => entrada,
         saida => saida,
         sel=>sel,
         sel_wr => sel_wr,
         sel_read0=>sel_read0,
         sel_read1=>sel_read1,
         op_ula=>op_ula
        );
    
     process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
    end process;

    process
        begin
            rst <= '1';
            wait for 100 ns;
            rst <= '0';
            wr_en <= '1';
            sel_read0 <= "001";
            sel_read1 <= "010";
            op_ula <= "00";
            sel_wr <= "001";
            entrada <= "0000000000000001";
            sel <= '0';
            wait for 100 ns;
            wr_en <= '1';
            sel_wr <= "010";
            entrada <= "0000000000000010";
            sel <= '0';
            wait for 100 ns;
            wr_en <= '1';
            sel_wr <= "010";
            entrada <= "1000000000000000";
            sel <= '1';
            wait;
            wr_en <= '0';
            sel_wr <= "010";
            entrada <= "1000000000000000";
            sel <= '1';
    end process;

end architecture;


