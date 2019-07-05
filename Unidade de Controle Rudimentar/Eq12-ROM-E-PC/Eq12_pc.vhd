-- Reescrever o componente inteiro. Dentro fica só um registrador,
-- e depois um jeito de incrementar a saida do registrador, colocar
-- num demux com jump_en pra ver se faz o jump ou nao aí entra com isso 
-- no registrador
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eq12_pc is
    port(
        clk, wr_en, rst: in std_logic;
        data_in: in unsigned(6 downto 0);
        data_out: out unsigned(6 downto 0)
    );
end entity;

architecture a_pc of Eq12_pc is
    signal registro:unsigned(6 downto 0);

    begin
        process(clk, rst, wr_en)
        begin
            if rst = '1' then
                registro <= "0000000";
            elsif wr_en = '1' then
                if rising_edge(clk) then
                    registro <= data_in;
                end if;
            end if;
        end process;
    
        data_out <= registro;
end architecture;


-- Maquina de estados vai dentro da UC, junto com a rom e um registrador,
-- que provavelmente será o PC