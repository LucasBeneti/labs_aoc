
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_ram_tb is
end entity;

architecture a_ram_tb of Eq12_ram_tb is
    component Eq12_ram port(
        clk: in std_logic;
        addr: in unsigned(6 downto 0);
        wr_en: in std_logic;
        data_in: in unsigned(15 downto 0);
        data_out:out unsigned(15 downto 0)
    );
    end component;

    signal clk, wr_en: std_logic;
    signal addr_s: unsigned(6 downto 0);
    signal data_in_s: unsigned(15 downto 0);
    signal data_out_s: unsigned(15 downto 0);

    begin
        uut: Eq12_ram port map(
            clk => clk, wr_en => wr_en, addr => addr_s,
            data_in => data_in_s, data_out => data_out_s
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
                wr_en <= '1';
                wait for 100 ns;
                wait;
        end process;

        process
            begin
                addr_s <= "0000010";
                data_in_s <= "0000000000000000";
                wait for 100 ns;

                addr_s <= "0001110";
                data_in_s <= "0000111111000000";
                wait for 100 ns;

                addr_s <= "0000011";
                data_in_s <= "0000000000111111";
                wait for 100 ns;
                wait;
        end process;
end architecture;
                
                