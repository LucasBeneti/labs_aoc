library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(clk : in std_logic;
         wr_en : in std_logic;
         rst: in std_logic;
         estado : out unsigned(1 downto 0);
         endereco: out unsigned(15 downto 0)
 );
end entity;

architecture a_processador of processador is
    component ula
            port(entrada0, entrada1 : in unsigned (15 downto 0);
		    operacao    : in unsigned (1 downto 0);
		    resultado   : out unsigned (15 downto 0);
            flag_psw 	: out unsigned (15 downto 0)
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

    component unidade_controle
        port(clk : in std_logic;
            wr_en: out std_logic;
            rst: in std_logic;
            ula_psw: in unsigned (15 downto 0);
            data_out: out unsigned(15 downto 0);
            wr_r: out unsigned(2 downto 0);
            r0_out: out unsigned(2 downto 0);
            r1_out: out unsigned(2 downto 0);
            const_out: out unsigned(15 downto 0);
            ula_op : out unsigned(1 downto 0);
            estado : out unsigned(1 downto 0);
            const_on : out std_logic
        );
    end component; 
    
    signal data_out0, const_out, data_out1, data_out_mux, mux_const, saida_ula: unsigned(15 downto 0);   
    signal ula_op : unsigned(1 downto 0);
    signal sel_read0, sel_read1, sel_wr : unsigned(2 downto 0);
    signal wr_en_b, sel : std_logic;
    signal flag_psw : unsigned (15 downto 0);
begin
        banco: banco8Reg16bits port map(clk=>clk, wr_en=>wr_en_b, data_in=>saida_ula, rst=>rst, sel_read0=>sel_read0,sel_read1=>sel_read1, data_out0=>data_out0, data_out1=>data_out1, sel_wr_reg=>sel_wr);
        ulax: ula port map(entrada0=>data_out0,  entrada1=>data_out_mux, operacao=>ula_op, resultado=>saida_ula, flag_psw=>flag_psw);
        mux: mux2x1 port map(sel=>sel, entrada0=>data_out1, entrada1=>const_out, saida=>data_out_mux);
        controle : unidade_controle port map(clk=>clk, wr_en=>wr_en_b, rst=>rst, ula_psw=>flag_psw, data_out=>endereco, wr_r=>sel_wr, r0_out=>sel_read0, r1_out=>sel_read1, const_out=>const_out, ula_op=>ula_op, estado=>estado, const_on => sel);
end architecture;

