ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a reg16bits_tb.vhd
ghdl -e reg16bits_tb
ghdl -a banco_regs.vhd
ghdl -e banco_regs
ghdl -a banco_regs_tb.vhd
ghdl -e banco_regs_tb
ghdl -r banco_regs_tb --stop-time=1000ns --wave=banco_regs_tb.ghw
