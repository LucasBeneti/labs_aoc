-- Equipe 12            Autor: Lucas Silva Beneti

-- O código em assembly estará no .txt contido na pasta para melhor explicação.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_rom is
    port(
        clk: in std_logic;
        addr: in unsigned(6 downto 0);
        data: out unsigned(15 downto 0)
    );
end entity;

architecture a_rom of Eq12_rom is 
    type mem is array (0 to 127) of unsigned(15 downto 0); --  verificar o que eh esse tipo
    constant rom_content : mem := (
        --caso endereco => conteudo
        0 => b"111000_00000_00011", -- LDI R3, #0
        1 => b"111000_00000_00100", -- LDI R4, #0
        2 => b"000011_00011_00100", -- ADD R4, R3 (res vai ficar no R4)
        3 => b"111000_00001_00001", -- LDI R1, #1
        4 => b"000011_00001_00011", -- ADD R3, R1
        5 => b"111000_11110_00010", -- LDI R2, #30
        6 => b"001010_00010_00011", -- CP  R3, R2 (compara os dois regs e seta uma flag da relacao)
        7 => b"111100_00011_11011", -- BRLT #-4
        8 => b"001011_00100_00101", -- MOV R5, R4
        9 => b"111000_00000_00010", -- LDI R2, #0
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
        20 => b"000000_00000_00000",
        21 => b"000000_00000_00000",
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
-- CP   -> 001010rrrrrddddd (depois dela qualquer branch pode ser usado)
-- BRLT -> 111100000skkkkkk (jump relativo com contante sendo signed)