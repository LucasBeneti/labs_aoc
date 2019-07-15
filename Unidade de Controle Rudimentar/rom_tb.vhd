library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_rom_tb is
end entity;

architecture a_tom_tb of Eq12_rom_tb is
    component rom
        port(
            clk: in std_logic;
            addr: in unsigned(6 downto 0);
            data: out unsigned(11 downto 0)
        );
    end component;

    signal clk: std_logic;
    signal addr: unsigned(6 downto 0);
    signal data: unsigned(11 downto 0);

    begin
        uut: Eq12_rom port map(clk => clk, addr => addr, data => data);

        process
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;

        process
        begin
            addr <= "0000000";
            wait for 100 ns;

            addr <= "0000010";
            wait for 100 ns;

            addr <= "0000111";
            wait for 100 ns;

            addr <= "0100110";
            wait for 100 ns;

            addr <= "0001001";
            wait for 100 ns;

            addr <= "1100111";
            wait for 45 ns;

            addr <= "0000101";
            wait for 45 ns;
        end process;
end architecture;