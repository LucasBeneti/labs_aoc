library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity processador_tb is
end processador_tb ; 

architecture a_processador_tb of processador_tb is
    component processador
        port(clk : in std_logic;
                wr_en : in std_logic;
                rst:  in std_logic;
                estado : out unsigned(1 downto 0);
                endereco:  out unsigned(15 downto 0)
        );
    end component;

    signal clk, wr_en, rst : std_logic;
    signal estado : unsigned(1 downto 0);
    signal endereco :  unsigned(15 downto 0);
begin

    uut : processador port map(clk=>clk, wr_en=>wr_en, rst=>rst, estado=>estado, endereco=>endereco);

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
            wait for 60 ns;
            rst <= '0';
            wait for 100 ns;
            wait;
        end process;
end architecture;