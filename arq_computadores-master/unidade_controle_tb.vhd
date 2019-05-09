library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity unidade_controle_tb is
end entity ; 

architecture a_unidade_controle_tb of unidade_controle_tb is
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
       ula_op : out unsigned(1 downto 0)
    );
    end component;

    signal clk, rst, wr_en : std_logic;
    signal data_in, data_out: unsigned(15 downto 0);
    signal wr_r, r0_out, r1_out : unsigned(2 downto 0);
    signal ula_op : unsigned(1 downto 0);
    signal ula_psw: unsigned (15 downto 0);
begin 
   uut: unidade_controle port map(clk => clk, wr_en=>wr_en, ula_psw=>ula_psw ,rst=>rst, data_out=> data_out,
    wr_r => wr_r, r0_out=> r0_out, r1_out=>r1_out, ula_op=>ula_op);

    process -- sinal de clock
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
    end process;

    process -- sinais dos casos de teste
        begin
            rst <= '1';
            ula_psw <= "0000000000100101";
            wait for 60 ns;
            rst <= '0';
            wait for 100 ns;
            wait;
        end process;
end architecture ;