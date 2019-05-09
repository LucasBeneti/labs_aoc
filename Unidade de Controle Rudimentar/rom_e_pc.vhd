library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_e_pc is
    port(
        clk, wr_en: in std_logic;
        data_in: in unsigned(6 downto 0); -- entrada do PC
        data: out unsigned(11 downto 0)
    );
end entity;

architecture a_rom_e_pc of rom_e_pc is
    component rom is
        port(
            clk: in std_logic;
            addr: in unsigned(6 downto 0);
            data: out unsigned(11 downto 0)
        );
    end component;

    component pc is
        port(
            clk, wr_en, rst: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    signal data_out: unsigned(6 downto 0); -- dado que sai do PC

    begin
        a_rom: rom port map(clk=>clk, addr=>addr, data=>data);
        a_pc: pc port map(clk=>clk, wr_en=>wr_en, rst=>rst, data_in=>data_in, data_out=>data_out);
    
end architecture;