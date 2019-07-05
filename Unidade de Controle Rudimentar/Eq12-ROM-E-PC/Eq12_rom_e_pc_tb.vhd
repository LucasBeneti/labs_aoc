library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_rom_e_pc_tb is
end entity;

architecture a_rom_e_pc_tb of Eq12_rom_e_pc_tb is
    component Eq12_rom_e_pc
    port(
        clk, rst: in std_logic;
        data_out: out unsigned(11 downto 0) -- saida ROM
    );
    end component;
    -- signal clk, wr_en, rst: std_logic;
    -- signal data_in: unsigned(6 downto 0);
    -- signal data: unsigned(11 downto 0);
    signal clk,rst: std_logic;
    signal data_out: unsigned(11 downto 0);

    begin
        uut: Eq12_rom_e_pc port map(
            clk=>clk,rst=>rst,
            data_out=>data_out
        );

        process
            begin
                clk <= '0';
                wait for 50 ns;
                clk <= '1';
                wait for 50 ns;
        end process;

        -- process
        --     begin
        --         wr_en<= '1';
        --         data_in<= "0000000";
        --         wait for 50 ns;
        --         wait;
        -- end process;
        process
	        begin
                rst <= '1';
                wait for 100 ns;
                rst <= '0';
            wait;
	end process;
end architecture;