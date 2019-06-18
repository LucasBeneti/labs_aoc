library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk, rst: in std_logic;
        pc_wr_en: out std_logic;
        instr: in unsigned(15 downto 0);
        addr_uc: out unsigned(6 downto 0); -- address out
        jump_en: out std_logic;
        reg_destino: out unsigned(4 downto 0); -- reg destino da operacao
        reg_operando: out unsigned(4 downto 0); -- reg usado na operacao
        imm: out std_logic; -- flag para ver se operacao sera com imediato (LDI)
        immediate: out unsigned(4 downto 0);
        opcode: out unsigned(5 downto 0)
    );
end entity;

architecture a_uc of uc is
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

    jump_en <= '1' when opcode = "100101" else
               '0';

    pc_wr_en <= '1' when estate = '1' else
                '0';

    imm <=  '1' when opcode = "111000" else
            '0';

    addr_uc <= instr(6 downto 0);
    
    reg_destino <=  "0000000" when opcode = "100101" else -- JMP
                    instr(4 downto 0);

    reg_operando <= "0000000" when opcode = "100101" else -- JMP
                    "0000000" when opcode = "111000" else -- LDI
                    instr(9 downto 5);

    immediate <= instr(9 downto 5) when opcode = "111000" else -- se for op para LDI
                 "00000";
                    
    opcode <= opcode_s; -- verificar se isso pode
end architecture;

-- LDI -> 111000KKKKKddddd
-- ADD -> 000011rrrrrddddd
-- SUB -> 000110rrrrrddddd
-- MOV -> 001011rrrrrddddd
-- JMP -> 100101KKKKKKKKKK