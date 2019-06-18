library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        addr: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
    );
end entity;

architecture a_rom of rom is 
    type mem is array (0 to 127) of unsigned(11 downto 0); --  verificar o que eh esse tipo
    constant rom_content : mem := (
        --caso endereco => conteudo
        0 => "0000000000000011",
        1 => "1110000000000111",
        2 => "1000000000000010",
        3 => "0000000000000000",
        4 => "0000000000000000",
        5 => "0000111000000000",
        6 => "0000000000000000",
        7 => "1110000001010000",
        8 => "0000000000010000",
        9 => "0000110001000000",
        10 => "0000000000000000",
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
        