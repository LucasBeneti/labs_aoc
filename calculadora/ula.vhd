library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        in_A, in_B: in unsigned(15 downto 0);
        op: in unsigned(5 downto 0);
        -- flag_maior: out std_logic;
        out_S: out unsigned(15 downto 0)
    );
end entity;

-- LDI -> 111000KKKKKddddd (só falta colocar a impl do LDI)
-- ADD -> 000011rrrrrddddd
-- SUB -> 000110rrrrrddddd
-- MOV -> 001011rrrrrddddd
-- JMP -> 100101KKKKKKKKKK <- fica pra UC e PC se resolverem depois

architecture a_ula of ula is    
    begin
        -- flag_maior <= '1'when op="10" and in_A>in_B else
        --               '0';

        out_S <= in_A+in_B when op="000011" else
                -- in_A/in_B when op="01" else
                in_A-in_B when op="000110" else
                 -- op de LDI, teoricamente aqui to fazendo um append de 11 bits na frente dos 5 do imediato findo
                in_B when op="001011" else -- op de MOV
                "0000000000000000";
end architecture;

 