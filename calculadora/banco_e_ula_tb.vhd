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
            op_ula: in unsigned(5 downto 0); -- operacao da ula
            -- flag_maior: out std_logic; -- flag de maior ou menor, soh booleano mesmo
            output_s: out unsigned(15 downto 0); -- saida geral (da ULA)
            --saida1, saida2: out unsigned(15 downto 0)
            imm_flag: in std_logic; -- flag, vem da UC
            imm_value: in unsigned(4 downto 0) -- vem da UC
        );
    end component;

    signal clk, we3_s, rst: std_logic;
    signal a1_s, a2_s, a3_s: unsigned(2 downto 0);
    --signal saida1, saida2: unsigned(15 downto 0);
    signal op_ula_s: unsigned(5 downto 0);
    -- signal flag_maior: std_logic;
    signal wd3_s: unsigned(15 downto 0);
    signal output_sig: unsigned(15 downto 0);
    signal imm_flag_s: std_logic;
    signal imm_value_s: unsigned(4 downto 0);

    begin
        uut: banco_e_ula port map(
            clk=>clk, we3=>we3_s, rst=>rst,
            wd3=>wd3_s, a1=>a1_s, a2=>a2_s, a3=>a3_s,
            op_ula=>op_ula_s,output_s=>output_sig,
            imm_flag=>imm_flag_s,imm_value=>imm_value_s
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
                a1_s <= "010";
                a2_s <= "011";
                -- op_ula <= "000011";
                a3_s <= "010";
                wd3_s <= "0000000000000001";
                wait for 100 ns;

                we3_s <= '0';
                a1_s <= "010";
                a2_s <= "011";
                op_ula_s <= "000011";
                a3_s <= "011";
                wd3_s <= "0000000100010001";
                wait for 100 ns;

                we3_s <= '1';
                a1_s <= "010";
                a2_s <= "011";
                op_ula_s <= "000011";
                a3_s <= "011";
                wd3_s <= "0000000100010001";
                wait for 100 ns;

                -- we3 <= '0';
                -- a3 <= "010";
                -- wd3 <= "0000110010001000";
                -- flag_maior <= '1'; -- compara se in_A > in_B
                -- wait for 100 ns;
                wait;
        end process;
end architecture;