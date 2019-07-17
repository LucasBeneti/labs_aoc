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
        0 => b"111000_00011_00010", -- LDI R2, #3
        1 => b"111000_01100_00100", -- LDI R4, #12
        2 => b"000000_00000_00000", -- STD R4, 7 100101_00111_00100
        3 => b"001011_00100_00010", -- MOV R2, R4
        4 => b"000000_00000_00000", -- LDS R5, 7 000011_00111_00101
        5 => b"100100_11110_00010", -- LDI R2, #30
        6 => b"000000_00000_00000", -- CP  R3, R2 (compara os dois regs e seta uma flag da relacao)
        7 => b"000000_00000_00000", -- BRLT #-4
        8 => b"000000_00000_00000", -- MOV R5, R4
        9 => b"000000_00000_00000", -- LDI R2, #0
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