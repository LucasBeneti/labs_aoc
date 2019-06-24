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
ghdl -r banco_e_ula_tb --stop-time=1000ns --wave=banco_e_ula_tb.ghw
#ghdl -a banco_regs_tb.vhd &&
#ghdl -e banco_regs_tb &&
# ghdl -r banco_regs_tb --stop-time=500ns --wave=banco_regs_tb.ghw
