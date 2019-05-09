library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_regs_tb is
end;

architecture a_banco_regs_tb of banco_regs_tb is
    component banco_regs 
        port(
            a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            wd3: in unsigned(15 downto 0); -- dado a ser gravado
            clk, we3, rst: in std_logic -- wr_en p/ quando for escrever
        );
    end component;
    signal clk, we3, rst: std_logic;
    signal a1, a2, a3: unsigned(2 downto 0);
    signal wd3, rd1, rd2: unsigned(15 downto 0);
    begin
        uut: banco_regs port map( clk=>clk, we3=>we3, wd3=>wd3, rst=>rst, 
                                  a1=>a1, a2=>a2, rd1=>rd1, rd2=>rd2, a3=>a3
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
            we3 <= '1';
            a1 <= "001";
            a2 <= "010";
            wd3 <= "0000100010000111";
            a3 <= "010";
            rd1 <= "001";
            rd2 <= "010";
            wait for 100 ns;

            we3 <= '0';
            a1 <= "011";
            a2 <= "010";
            wd3 <= "1111111111111111";
            a3 <= "011";
            rd1 <= "010";
            rd2 <= "011";
            wait for 100 ns;

            we3 <= '1';
            a1 <= "001";
            a2 <= "010";
            wd3 <= "0000100010000111";
            a3 <= "110";
            rd1 <= "001";
            rd2 <= "100";
            wait for 100 ns;

            we3 <= '1';
            a1 <= "001";
            a2 <= "010";
            wd3 <= "0000000010000011";
            a3 <= "001";
            rd1 <= "001";
            rd2 <= "010";
            wait;
        end process;
end architecture;