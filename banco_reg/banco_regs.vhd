library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_regs is
    port(
        a1, a2, a3: in unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
        --reg_out_a, reg_out_b: out unsigned(2 downto 0); -- 3 bits para escolher entre os 8 regs
        wd3: in unsigned(15 downto 0); -- dado a ser gravado
        clk, we3, rst: in std_logic; -- we3 p/ quando for escrever
        rd1,rd2: out unsigned(15 downto 0)
    );
end entity;

architecture a_banco of banco_regs is

    component reg16bits is 
        port(   
                clk: in std_logic;
                rst: in std_logic;
                we3: in std_logic;
                wd3: in unsigned(15 downto 0);
                data_out: out unsigned(15 downto 0)
            );
    end component;
    signal en1, en2, en3, en4, en5, en6, en7: std_logic;
    signal reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7: unsigned(15 downto 0);

begin

    reg0 <= "0000000000000000";
    regist1: reg16bits port map(clk=>clk, rst=>rst, we3=>en1, wrData=>wrdata, readData=>reg1);
    regist2: reg16bits port map(clk=>clk, rst=>rst, we3=>en2, wrData=>wrdata, readData=>reg2);
    regist3: reg16bits port map(clk=>clk, rst=>rst, we3=>en3, wrData=>wrdata, readData=>reg3);
    regist4: reg16bits port map(clk=>clk, rst=>rst, we3=>en4, wrData=>wrdata, readData=>reg4);
    regist5: reg16bits port map(clk=>clk, rst=>rst, we3=>en5, wrData=>wrdata, readData=>reg5);
    regist6: reg16bits port map(clk=>clk, rst=>rst, we3=>en6, wrData=>wrdata, readData=>reg6);
    regist7: reg16bits port map(clk=>clk, rst=>rst, we3=>en7, wrData=>wrdata, readData=>reg7);


    -- write enable
    en1 <= we3 when a3="001" else
            '0';
    en2 <= we3 when a3="010" else
            '0';
    en3 <= we3 when a3="011" else
            '0';
    en4 <= we3 when a3="100" else
            '0';
    en5 <= we3 when a3="101" else
            '0';
    en6 <= we3 when a3="110" else
            '0';
    en7 <= we3 when a3="111" else
            '0';

    -- mux saida p/ registrador A
    regAdata <= reg0 when regA = "000" else
                reg1 when regA = "001" else
                reg2 when regA = "010" else
                reg3 when regA = "011" else
                reg4 when regA = "100" else
                reg5 when regA = "101" else
                reg6 when regA = "110" else
                reg7 when regA = "111" else
                "0000000000000000";
    -- mux saida p/ registrador B
    regBdata <= reg0 when regA = "000" else
                reg1 when regA = "001" else
                reg2 when regA = "010" else
                reg3 when regA = "011" else
                reg4 when regA = "100" else
                reg5 when regA = "101" else
                reg6 when regA = "110" else
                reg7 when regA = "111" else
                "0000000000000000";
end architecture;

    
    
