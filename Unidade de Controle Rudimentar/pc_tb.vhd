library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;

architecture a_pc_tb of pc_tb is
    component pc 
        port(
            clk, wr_en, rst: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    signal clk, wr_en, rst: std_logic;
    signal data_in, data_out: unsigned(6 downto 0);

    begin
        uut: pc port map(clk => clk, wr_en => wr_en, rst => rst, data_in => data_in, data_out => data_out);

        process
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;

        process
        begin
            rst <= '1';
            wr_en <= '1';
            wait for 50 ns;

            wr_en <= '1';
            rst <= '0';
            data_in <="0000000";
            wait for 50 ns;

            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;
            data_in <= data_out;
            wait for 50 ns;

            -- wr_en <= '1';
            -- wait for 50 ns;

            -- wr_en <= '0';
            -- wait for 50 ns;

            -- wr_en <= '1';
            -- wait for 50 ns;
            wait;
        end process;
end architecture;