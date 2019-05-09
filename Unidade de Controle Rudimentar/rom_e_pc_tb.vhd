library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_e_pc_tb is
end entity;

architecture a_rom_e_pc_tb of rom_e_pc_tb is
    component rom_e_pc
        port(
            clk, wr_en: in std_logic;
            data_in: in unsigned(6 downto 0); -- entrada do PC
            data: out unsigned(11 downto 0)
        );
    end component;
    signal clk, wr_en: std_logic;
    signal data_in: unsigned(6 downto 0);
    signal data: unsigned(11 downto 0);

    begin
        uut: rom_e_pc port map(
            clk=>clk, wr_en=>wr_en,
            data_in=>data_in, data=>data
        );

        process
            begin
                clk <= '0';
                wait for 50 ns;
                clk <= '1';
                wait for 50 ns;
        end process;

        process
            begin
                wr_en<= '1';
                data_in<= "0000000";
                wait for 50 ns;
                wait;
        end process;
end architecture;