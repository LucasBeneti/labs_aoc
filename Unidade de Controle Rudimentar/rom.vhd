library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        addr: in unsigned(6 downto 0);
        data: out unsigned(11 downto 0)
    );
end entity;

architecture a_rom of rom is 
    type mem is array (0 to 127) of unsigned(11 downto 0); --  verificar o que eh esse tipo
    constant rom_content : mem := (
        --caso endereco => conteudo
        0 => "000000000011",
        1 => "000000000001",
        2 => "100000000010",
        3 => "000000000000",
        4 => "000000000000",
        5 => "000011100000",
        6 => "000000000000",
        7 => "001000100000",
        8 => "000000000001",
        9 => "000011000100",
        10 => "000000000000",
        others => (others=>'0')
    );
    begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                data <= rom_content(to_integer(addr));
            end if;
        end process;
end architecture;
        