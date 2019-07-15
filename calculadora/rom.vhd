-- O código em assembly estará no .txt contido na pasta para melhor explicação.
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
    type mem is array (0 to 127) of unsigned(15 downto 0); --  verificar o que eh esse tipo
    constant rom_content : mem := (
        --caso endereco => conteudo
        0 => b"111000_00101_00011", -- LDI R3, #5
        1 => b"111000_01000_00100", -- LDI R4, #8
        2 => b"000011_00100_00011", -- ADD R3, R4 (res vai ficar no R4)
        3 => b"001011_00011_00101", -- MOV R5, R3
        4 => b"000101_00001_00101", -- SUBI R5, #1
        5 => b"100101_00000_10100", -- JMP #20 (acho que tem que ser binario ou hexa)
        6 => b"000000_00000_00000",
        7 => b"000000_00000_00000",
        8 => b"000000_00000_00000",
        9 => b"000000_00000_00000",
        10 => b"000000_00000_00000",
        11 => b"000000_00000_00000",
        12 => b"000000_00000_00000",
        13 => b"000000_00000_00000",
        14 => b"000000_00000_00000",
        15 => b"000000_00000_00000",
        16 => b"000000_00000_00000",
        17 => b"000000_00000_00000",
        18 => b"000000_00000_00000",
        19 => b"000000_00000_00000",
        20 => b"001011_00101_00011", -- MOV R3, R5
        21 => b"100101_00000_00010", -- JMP #3 (ou pro endereço 2, que é onde tem o que ele cita no exercicio)
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
        
-- LDI  -> 111000KKKKKddddd (só falta colocar a impl do LDI)
-- ADD  -> 000011rrrrrddddd
-- SUB  -> 000110rrrrrddddd
-- SUBI -> 000101kkkkkddddd (subtrai de imediato)
-- MOV  -> 001011rrrrrddddd
-- JMP  -> 100101KKKKKKKKKK <- fica pra UC e PC se resolverem depois