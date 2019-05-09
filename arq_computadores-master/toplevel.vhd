library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
    port(clk : std_logic;
         wr_en : std_logic;
         rst: std_logic;
         entrada : in unsigned(15 downto 0);
         saida : out unsigned(15 downto 0);
         sel: in std_logic;
         sel_wr : in unsigned(2 downto 0);
         sel_read0: in unsigned(2 downto 0);
         sel_read1: in unsigned(2 downto 0);
         op_ula : in unsigned(1 downto 0)
 );
end entity;

architecture a_toplevel of toplevel is
    component ula
            port(entrada0, entrada1 : in unsigned (15 downto 0);
		    operacao    : in unsigned (1 downto 0);
		    resultado   : out unsigned (15 downto 0)
	);
    end component;
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
    component mux2x1 is
        port(sel : in std_logic;
            entrada0 : in unsigned(15 downto 0);
            entrada1 : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0)
        );
    end component;


    signal data_out0, data_out1, data_out_mux, mux_const: unsigned(15 downto 0);   
    
begin
        banco: banco8Reg16bits port map(clk=>clk, wr_en=>wr_en, data_in=>entrada, rst=>rst, sel_read0=>sel_read0,sel_read1=>sel_read1, data_out0=>data_out0, data_out1=>data_out1, sel_wr_reg=>sel_wr);
        ulax: ula port map(entrada0=>data_out0,  entrada1=>data_out_mux, operacao=>op_ula, resultado=>saida);
        mux: mux2x1 port map(sel=>sel, entrada0=>data_out1, entrada1=>entrada, saida=>data_out_mux);
end architecture;

