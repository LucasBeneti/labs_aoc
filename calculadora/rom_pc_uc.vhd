library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_e_pc is
    port(
        clk, rst: in std_logic;
        data_out: out unsigned(11 downto 0) -- saida ROM
    );
end entity;

architecture a_rom_e_pc of rom_e_pc is
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

    component uc is
        port(
            clk, rst: in std_logic;
            pc_wr_en: out std_logic;
            instr: in unsigned(11 downto 0);
            -- estado_uc: out unsigned(1 downto 0);
            addr_uc: out unsigned(6 downto 0);
            jump_en: out std_logic;
            reg_destino: out unsigned(4 downto 0); -- reg destino da operacao
            reg_operando: out unsigned(4 downto 0); -- reg usado na operacao
            imm_flag: out std_logic; -- flag para ver se operacao sera com imediato (LDI)
            immediate: out unsigned(4 downto 0);
            opcode: out unsigned(5 downto 0)
        );
    end component;

    signal adress_in, data_pc_out: unsigned(6 downto 0); -- dado que sai do PC
    signal instruction: unsigned(11 downto 0);
    signal jump_enable, pc_write_en: std_logic;

    signal reg_destino_s, reg_oper_s: unsigned(4 downto 0);
    signal imm_flag_s: std_logic;
    signal immediate_s: unsigned(4 downto 0);
    signal opcode_s: unsigned(5 downto 0);
    
    signal addr_uc_mux: unsigned(6 downto 0);
    signal saida_mux: unsigned(6 downto 0);

    begin
        a_rom: rom port map(clk=> clk,
                            addr=>data_pc_out,
                            data=>instruction
                        );

        a_pc: pc port map(  clk=>clk, 
                            wr_en=>pc_write_en, 
                            rst=>rst, 
                            data_in=>saida_mux, -- saida do mux
                            data_out=>data_pc_out
                        );
                        
        a_uc: uc port map(  clk=>clk, 
                            rst=>rst,
                            pc_wr_en=>pc_write_en,
                            instr=>instruction,
                            jump_en=>jump_enable,
                            reg_destino=>reg_destino_s,
                            reg_operando=>reg_oper_s,
                            imm_flag=>imm_flag_s,
                            immediate=>immediate_s,
                            opcode=>opcode_s
                        );

    data_out <= instruction;

    saida_mux <= instruction(6 downto 0) when jump_enable='1' else -- nao alterado ainda pro tamanho atual do jump
                 data_pc_out+"0000001";
        
    
end architecture;