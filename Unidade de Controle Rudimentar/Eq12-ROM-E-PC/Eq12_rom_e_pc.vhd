library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_rom_e_pc is
    port(
        clk, rst: in std_logic;
        data_out: out unsigned(11 downto 0) -- saida ROM
    );
end entity;

architecture a_rom_e_pc of Eq12_rom_e_pc is
    component Eq12_rom is
        port(
            clk: in std_logic;
            addr: in unsigned(6 downto 0);
            data: out unsigned(11 downto 0)
        );
    end component;

    component Eq12_pc is
        port(
            clk, wr_en, rst: in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component Eq12_uc is
        port(
            clk, rst: in std_logic;
            pc_wr_en: out std_logic;
            instr: in unsigned(11 downto 0);
            addr_uc: out unsigned(6 downto 0);
            jump_en: out std_logic
        );
    end component;

    signal data_pc_out: unsigned(6 downto 0); -- dado que sai do PC
    signal instruction: unsigned(11 downto 0);
    signal jump_enable, pc_write_en: std_logic;
    
    signal addr_uc_mux: unsigned(6 downto 0);
    signal saida_mux: unsigned(6 downto 0);

    begin
        a_rom: Eq12_rom port map(clk=> clk,
                                addr=>data_pc_out,
                                data=>instruction
                                );
        a_pc: Eq12_pc port map(  clk=>clk, 
                                wr_en=>pc_write_en, 
                                rst=>rst, 
                                data_in=>saida_mux, -- saida do mux
                                data_out=>data_pc_out
                                );
        a_uc: Eq12_uc port map(  clk=>clk, 
                            rst=>rst,
                            pc_wr_en=>pc_write_en,
                            instr=>instruction,
                            jump_en=>jump_enable
                            );

    data_out <= instruction;

    saida_mux <= instruction(6 downto 0) when jump_enable='1' else
                 data_pc_out+"0000001";
        
    
end architecture;