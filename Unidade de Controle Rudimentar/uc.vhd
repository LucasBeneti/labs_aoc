library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all

entity uc is
    port(
        clk, rst, wr_en: in std_logic;
        instr: in unsigned(11 downto 0);
        estado_uc: out unsigned(1 downto 0);
        addr_uc: out unsigned(6 downto 0);
        jump_en: out std_logic
    );
end entity;

architecture a_uc of uc is
    component maq_estados is
        port(
            clk, rst: in std_logic;
            estado: out unsigned(1 downto 0);
            wr_en: in std_logic
        );
    end component;

    component rom is
        port(
            clk: in std_logic;
            addr: in unsigned(6 downto 0);
            data: out unsigned(11 downto 0)
        );
    end component;

    component pc is
        port(
            clk, wr_en, rst: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;
    

    -- signal clk1: std_logic;
    -- signal clockrom1: std_logic;
    -- signal clockpc1: std_logic;
    signal estado_s: std_logic;
    signal address,prox_addr: unsigned(6 downto 0); --addr que sai da UC e entra no demux do PC
    signal opcode: unsigned(2 downto 0);
    signal instr_rom: unsigned(11 downto 0); --saida da rom          
    
    begin
        amaq: maq_estados port map(clk => clk, rst => rst, wr_en => wr_en, estado => estado_s); -- maquin a de estados
        arom: rom port map(clk => clk , addr => instr, data => instr_rom);
        apc: pc port map(clk => clk, rst => rst, wr_en => wr_en, data_in => prox_addr, data_out => address);

    opcode <= instr_rom(11 downto 9);
    addr_uc <= instr_rom(6 downto 0);

    estado_uc <= estado_s;