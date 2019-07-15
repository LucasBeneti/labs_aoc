ghdl -a rom.vhd &&
ghdl -e rom &&
ghdl -a pc.vhd &&
ghdl -e pc &&
ghdl -a uc.vhd &&
ghdl -e uc &&
ghdl -a reg16bits.vhd &&
ghdl -e reg16bits &&
ghdl -a banco_regs.vhd &&
ghdl -e banco_regs
ghdl -a ula.vhd &&
ghdl -e ula &&
ghdl -a calculadora.vhd &&
ghdl -e calculadora &&
ghdl -a calculadora_tb.vhd &&
ghdl -e calculadora_tb
ghdl -r calculadora_tb --stop-time=4000ns --wave=calculadora_tb.ghw
