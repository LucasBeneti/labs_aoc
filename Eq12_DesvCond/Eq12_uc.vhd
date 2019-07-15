-- Equipe 12            Autor: Lucas Silva Beneti

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_uc is
    port(
        clk, rst: in std_logic;
        pc_wr_en: out std_logic;
        instr: in unsigned(15 downto 0);-- vem da ROM
        addr_uc: out unsigned(6 downto 0); -- address out (para o jump)
        jump_en: out std_logic;
        -- flag_s: out unsigned(1 downto 0); -- flag para BRLT
        reg_destino: out unsigned(4 downto 0); -- reg destino da operacao
        reg_operando: out unsigned(4 downto 0); -- reg usado na operacao
        imm_flag: out std_logic; -- flag para ver se operacao sera com imediato (LDI)
        immediate: out unsigned(15 downto 0);
        opcode: out unsigned(5 downto 0)
    );
end entity;

architecture a_uc of Eq12_uc is
    signal opcode_s: unsigned(5 downto 0);
    signal estate: std_logic;

begin
    process(clk, rst)
    begin
        if rst = '1' then estate <= '0';
        elsif rising_edge(clk) then estate <= not estate;
        end if;

    end process;

    opcode_s <= instr(15 downto 10);

    jump_en <= '1' when opcode_s = "100101" else
               '0';

    pc_wr_en <= '1' when estate = '1' else
                '0';    

    imm_flag <=  '1' when opcode_s = "000101" else -- implementado SUBI
                 '0';

    addr_uc <= instr(6 downto 0);
    
    reg_destino <=  "00000" when opcode_s = "100101" else -- JMP
                    "00000" when opcode_s = "111100" else -- BRLT
                    -- "00000" when opcode_s = "001010" else -- CP
                    instr(4 downto 0);

    reg_operando <= "00000" when opcode_s = "100101" else -- JMP
                    "00000" when opcode_s = "111000" else -- LDI
                    "00000" when opcode_s = "000101" else -- SUBI
                    "00000" when opcode_s = "111100" else -- BRLT
                    instr(9 downto 5);

    immediate <= "00000000000" & instr(9 downto 5) when opcode_s = "111000" else -- se for op para LDI
                 --"00000000000" & instr(9 downto 5) when opcode_s = "000110" else
                 "00000000000" & instr(9 downto 5) when opcode_s = "000101" else -- SUBI
                 "00000000000" & "00000";
                    
    opcode <= opcode_s; -- verificar se isso pode
end architecture;

-- LDI  -> 111000KKKKKddddd (só falta colocar a impl do LDI)
-- ADD  -> 000011rrrrrddddd
-- SUB  -> 000110rrrrrddddd
-- SUBI -> 000101kkkkkddddd (subtrai de imediato)
-- MOV  -> 001011rrrrrddddd
-- JMP  -> 100101KKKKKKKKKK <- fica pra UC e PC se resolverem depois

-- CP   -> 001010rrrrrddddd (depois dela qualquer branch pode ser usado)
-- BRLT -> 111100000skkkkkk (jump relativo com contante sendo signed)