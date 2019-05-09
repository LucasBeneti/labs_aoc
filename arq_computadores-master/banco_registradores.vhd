library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity banco8Reg16bits is
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
end entity;

architecture a_banco8Reg16bits of banco8Reg16bits is
     component reg16bits
		port(clk : in std_logic;
         wr_en : in std_logic;
         data_in : in unsigned(15 downto 0);
         rst : in std_logic;
         data_out : out unsigned(15 downto 0)
        );
	end component;
    component decode
      port(entrada : in unsigned(2 downto 0);
            wr_en :in std_logic;
            saida: out unsigned(7 downto 0)
         );
    end component;
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
        signal out0, out1, out2, out3, out4, out5, out6, out7 : unsigned(15 downto 0);
        signal out_decode : unsigned(7 downto 0);
    begin
        
        decodeS: decode port map(entrada => sel_wr_reg, wr_en=>wr_en, saida=>out_decode);
        reg0: reg16bits port map(clk=>clk, wr_en=>out_decode(0), data_in=>data_in, rst=>rst, data_out=>out0);
        reg1: reg16bits port map(clk=>clk, wr_en=>out_decode(1), data_in=>data_in, rst=>rst, data_out=>out1);
        reg2: reg16bits port map(clk=>clk, wr_en=>out_decode(2), data_in=>data_in, rst=>rst, data_out=>out2);
        reg3: reg16bits port map(clk=>clk, wr_en=>out_decode(3), data_in=>data_in, rst=>rst, data_out=>out3);
        reg4: reg16bits port map(clk=>clk, wr_en=>out_decode(4), data_in=>data_in, rst=>rst, data_out=>out4);
        reg5: reg16bits port map(clk=>clk, wr_en=>out_decode(5), data_in=>data_in, rst=>rst, data_out=>out5);
        reg6: reg16bits port map(clk=>clk, wr_en=>out_decode(6), data_in=>data_in, rst=>rst, data_out=>out6);
        reg7: reg16bits port map(clk=>clk, wr_en=>out_decode(7), data_in=>data_in, rst=>rst, data_out=>out7);

        mux0: mux8x3 port map(sel => sel_read0, entrada0=>out0, entrada1=>out1,entrada2=>out2,entrada3=>out3,entrada4=>out4,entrada5=>out5, entrada6=>out6, entrada7=>out7, saida=>data_out0);
        mux1: mux8x3 port map(sel => sel_read1, entrada0=>out0, entrada1=>out1,entrada2=>out2,entrada3=>out3,entrada4=>out4,entrada5=>out5, entrada6=>out6, entrada7=>out7, saida=>data_out1);
        
end architecture;
