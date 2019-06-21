library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula is
        port(   in_A, in_B: in unsigned(15 downto 0);
                op: in unsigned(5 downto 0);
                -- flag_maior: out std_logic;
                out_S: out unsigned(15 downto 0)
        );
    end component;
    signal in_A, in_B, out_S: unsigned(15 downto 0);
    signal op: unsigned(5 downto 0);
    -- signal flag_maior: std_logic;
begin
    uut: ula port map(in_A => in_A, in_B => in_B, op => op, out_S => out_S);
    process
    begin
        in_A <= "0000000000001111";
        in_B <= "0000000100010010";
        op <= "000011"; -- soma
        wait for 50 ns;
        -- in_A <= "1101000100010010";
        -- in_B <= "0011010001001111";
        -- op <= "01"; -- divisao
        -- wait for 50 ns;
        in_A <= "0000000000010110";
        in_B <= "1111110001111101";-- -3
        op <= "000110"; -- sub
        wait for 50 ns;
        in_A <= "0000000000010010";-- +18
        in_B <= "1111111111110100";-- -12
        op <= "001011"; -- ldi
        wait for 50 ns;
        -- wait for 50 ns;
        -- in_A <= "1111111111111111";
        -- in_B <= "0000000000000010";
        -- op <= "00"; -- soma
        -- wait for 50 ns;
        -- in_A <= "1111111111111111";
        -- in_B <= "0000000000000010";
        -- op <= "11"; -- sub 
        -- wait for 50 ns;
        wait;
    end process;
end architecture;