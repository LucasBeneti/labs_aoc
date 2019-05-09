library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_registradores_tb is
end;

architecture a_banco_registradores_tb of banco_registradores_tb is
	component banco8Reg16bits
		port(clk : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            rst : in std_logic;
            sel_read0 : in unsigned(2 downto 0);
            sel_read1 : in unsigned(2 downto 0);
            data_out0 : out unsigned(15 downto 0);
            data_out1 : out unsigned(15 downto 0);
            sel_wr_reg: in unsigned(2 downto 0)
        );
    	end component;	
	signal clk, wr_en, rst : std_logic;
    signal  sel_read0,  sel_read1, sel_wr_reg : unsigned(2 downto 0);
    signal data_in, data_out0, data_out1 : unsigned(15 downto 0);
    begin
        uut: banco8Reg16bits port map(
         clk => clk,
         wr_en => wr_en,
         data_in => data_in,
         rst => rst,
         sel_read0 => sel_read0,
         sel_read1 => sel_read1,
         data_out0 => data_out0,
         data_out1 => data_out1,
         sel_wr_reg=> sel_wr_reg
        );
        
        process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end process;
        
        process -- sinal de reset
        begin
            rst <= '1';
            wait for 100 ns;
            rst <= '0';
            wait;
        end process;

        process -- sinais dos casos de teste
        begin
            wr_en <= '1';
            data_in <= "0000000000000001";
            sel_read0 <="001";
            sel_read1 <="001";
            sel_wr_reg <="001";
            wait for 100 ns;
            wr_en <= '1';
            data_in <= "0000000000000010";
            sel_read0 <="010";
            sel_read1 <="010";
            sel_wr_reg <="010";
            wait for 100 ns;
            wr_en <= '1';
            data_in <= "0000000000000010";
            sel_read0 <="001";
            sel_read1 <="001";
            sel_wr_reg <="010";
            wait for 100 ns;
            data_in <= "1111111111111000";
            sel_read0 <="001";
            sel_read1 <="001";
            sel_wr_reg <="001";
            wait;
        end process;
end architecture;