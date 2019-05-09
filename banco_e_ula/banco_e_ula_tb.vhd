library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_e_ula_tb is
end entity;

architecture a_banco_e_ula_tb of banco_e_ula_tb is
    component banco_e_ula
        port(
            a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            -- reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
            wd3: in unsigned(15 downto 0); -- dado a ser gravado
            clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
            op_ula: in unsigned(1 downto 0); -- operacao da ula
            flag_maior: out std_logic; -- flag de maior ou menor, soh booleano mesmo
            output_s: out unsigned(15 downto 0) -- saida geral (da ULA)
            --saida1, saida2: out unsigned(15 downto 0)
        );
    end component;
    signal clk, we3, rst: std_logic;
    signal a1, a2, a3: unsigned(2 downto 0);
    --signal saida1, saida2: unsigned(15 downto 0);
    signal op_ula: unsigned(1 downto 0);
    signal flag_maior: std_logic;
    signal wd3: unsigned(15 downto 0);
    signal output_s: unsigned(15 downto 0);

    begin
        uut: banco_e_ula port map(
            clk=>clk, we3=>we3, rst=>rst,
            wd3=>wd3, a1=>a1, a2=>a2, a3=>a3,
            op_ula=>op_ula, flag_maior=>flag_maior,
            output_s=>output_s
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
                a1 <= "010";
                a2 <= "011";
                op_ula <= "00";
                a3 <= "010";
                wd3 <= "0000000000000001";
                wait for 100 ns;

                we3 <= '1';
                a3 <= "010";
                wd3 <= "0000000100010001";
                wait for 100 ns;

                we3 <= '0';
                a3 <= "010";
                wd3 <= "0000110010001000";
                flag_maior <= '1'; -- compara se in_A > in_B
                wait;
        end process;
end architecture;