library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_banco_regs_tb is
end;

architecture a_banco_regs_tb of Eq12_banco_regs_tb is
    component banco_regs 
        port(
            a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            wd3: in unsigned(15 downto 0); -- dado a ser gravado
            clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
            rd1, rd2: out unsigned(15 downto 0)
        );
    end component;

    signal clk, we3_s, rst: std_logic;
    signal a1_s, a2_s, a3_s: unsigned(2 downto 0);
    signal wd3_s: unsigned(15 downto 0);
    signal rd1_s, rd2_s: unsigned(15 downto 0);
    
    begin
        uut: banco_regs port map( clk=>clk, we3=>we3_s, wd3=>wd3_s, rst=>rst, 
                                  a1=>a1_s, a2=>a2_s, rd1=>rd1_s, rd2=>rd2_s, a3=>a3_s
                                );

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
            wait for 100 ns;
            rst <= '0';
            wait;
        end process;

        process
        begin
            we3_s <= '1';
            a1_s <= "001";
            a2_s <= "010";
            wd3_s <= "0000100010000111";
            a3_s <= "010";
            wait for 100 ns;

            we3_s <= '0';
            a1_s <= "011";
            a2_s <= "010";
            wd3_s <= "1111111111111111";
            a3_s <= "011";
            wait for 100 ns;

            we3_s <= '1';
            a1_s <= "001";
            a2_s <= "010";
            wd3_s <= "0000100010000111";
            a3_s <= "110";
            wait for 100 ns;

            we3_s <= '1';
            a1_s <= "001";
            a2_s <= "010";
            wd3_s <= "0000000010000011";
            a3_s <= "001";
            wait for 100 ns;
            wait;
        end process;
end architecture;