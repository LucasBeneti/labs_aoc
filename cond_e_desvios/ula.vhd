library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        in_A, in_B: in unsigned(15 downto 0);
        op: in unsigned(5 downto 0);
        flag: out unsigned(1 downto 0); -- 2 bits: 00 igual, 01 maior, 10 menor
        out_S: out unsigned(15 downto 0)
    );
end entity;

-- LDI  -> 111000KKKKKddddd (só falta colocar a impl do LDI)
-- ADD  -> 000011rrrrrddddd
-- ADDI -> 000100KKKKKddddd 
-- SUB  -> 000110rrrrrddddd
-- SUBI -> 000101kkkkkddddd (subtrai de imediato)
-- MOV  -> 001011rrrrrddddd
-- JMP  -> 100101KKKKKKKKKK <- fica pra UC e PC se resolverem depois
-- CP   -> 001010rrrrrddddd <- compara dois regs

architecture a_ula of ula is    

    begin
        -- flag_maior <= '1'when op="10" and in_A>in_B else
        --               '0';

        out_S <=in_A+in_B when op="000011" else -- (ADD antre Regs)
                -- in_A/in_B when op="01" else
                in_A-in_B when op="000110" else
                in_A-in_B when op="000101" else
                 -- op de LDI, teoricamente aqui to fazendo um append de 11 bits na frente dos 5 do imediato findo
                in_B when op="001011" else -- op de MOV
                "0000000000000000";

        -- impl. da flag de CP do processador
        flag <= "00" when in_A=in_B else
                "01" when in_A>in_B else
                "10" when in_A<in_B else
                "11";
end architecture;

 