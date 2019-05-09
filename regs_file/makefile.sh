ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a banco_regs.vhd
ghdl -e banco_regs
ghdl -a banco_regs_tb.vhd
ghdl -e banco_regs_tb
ghdl -r banco_regs_tb --stop-time=500ns --wave=banco_regs_tb.ghw
gtkwave banco_regs_tb.ghw
