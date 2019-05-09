library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x3_tb is
end;

architecture a_mux8x3_tb of mux8x3_tb is
	component mux8x3
		port(sel : in unsigned(2 downto 0);
        entrada0 : in unsigned(15 downto 0);
        entrada1 : in unsigned(15 downto 0);
        entrada2 : in unsigned(15 downto 0);
        entrada3 : in unsigned(15 downto 0);
        entrada4 : in unsigned(15 downto 0);
        entrada5 : in unsigned(15 downto 0);
        entrada6 : in unsigned(15 downto 0);
        entrada7 : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0)
        );
    	end component;	
	signal saida, entrada0, entrada1, entrada2, entrada3, entrada4, entrada5, entrada6, entrada7 : unsigned(15 downto 0);
    signal sel: unsigned(2 downto 0);
    
    begin
        uut: mux8x3 port map(
            sel => sel,  
            entrada0=> entrada0,
            entrada1=> entrada1,
            entrada2=> entrada2,
            entrada3=> entrada3,
            entrada4=> entrada4,
            entrada5=> entrada5,
            entrada6=> entrada6,
            entrada7=> entrada7,
            saida => saida
        );
        process -- sinais dos casos de teste
        begin               
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "000";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "001";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "010";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "011";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "100";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "101";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "110";
            wait for 100 ns;
            entrada0 <= "0000000000000001";
            entrada1 <= "0000000000000011";
            entrada2 <= "0000000000000111";
            entrada3 <= "0000000000001111";
            entrada4 <= "0000000000011111";
            entrada5 <= "0000000000111111";
            entrada6 <= "0000000001111111";
            entrada7 <= "0000000001111111";
            sel <= "111";
            wait;
        end process;
end architecture;
