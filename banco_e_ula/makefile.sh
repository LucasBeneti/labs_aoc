ghdl -a reg16bits.vhd &&
ghdl -e reg16bits &&
ghdl -a banco_regs.vhd &&
ghdl -e banco_regs &&
ghdl -a ula.vhd &&
ghdl -e ula &&
ghdl -a banco_e_ula.vhd &&
ghdl -e banco_e_ula &&
ghdl -a banco_e_ula_tb.vhd &&
ghdl -e banco_e_ula_tb &&
ghdl -r banco_e_ula_tb --stop-time=500ns --wave=banco_e_ula_tb.ghw &&
gtkwave banco_e_ula_tb.ghw