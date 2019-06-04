library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is 
end entity;

architecture a_uc_tb of uc_tb is

    component uc port(
                    clk, rst: in std_logic;
                    pc_wr_en: out std_logic;
                    instr: in unsigned(11 downto 0);
                    -- estado_uc: out unsigned(1 downto 0);
                    -- addr_uc: out unsigned(6 downto 0);
                    jump_en: out std_logic
                );
    end component;

    signal clk, rst, jump_en, pc_wr_en: std_logic;
    signal instr: unsigned(11 downto 0);

    begin
        uut: uc port map(clk => clk, rst => rst, jump_en => jump_en, 
                        pc_wr_en => pc_wr_en, instr => instr);

        process
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;

        process
        begin
            rst <= '1';
            instr <= "100000000000";
            wait for 125 ns;
            instr <= "100000000000";
            rst <= '0';
            wait for 100 ns;
            instr <= "100000001111";
            wait for 100 ns;
            instr <= "100100000000";
            wait for 100 ns;
            instr <= "111100000001";
            wait;
        end process;
        
end architecture; -- a_uc_tb