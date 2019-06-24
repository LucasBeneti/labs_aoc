ghdl -a ula.vhd &&
ghdl -e ula &&
ghdl -a ula_tb.vhd &&
ghdl -e ula_tb &&
ghdl -r ula_tb --stop-time=500ns --wave=ula_tb.ghw
#ghdl -a banco_regs.vhd &&
#ghdl -e banco_regs &&
#ghdl -a banco_e_ula.vhd &&
#ghdl -e banco_e_ula &&
#ghdl -a banco_e_ula_tb.vhd &&
#ghdl -e banco_e_ula_tb &&
#ghdl -r banco_e_ula_tb --stop-time=500ns --wave=banc_e_ula_tb.ghw
