ghdl -a ula.vhd &&
ghdl -e ula &&
ghdl -a ula_tb.vhd &&
ghdl -e ula_tb &&
ghdl -r ula_tb --stop-time=500ns --wave=ula_tb.ghw