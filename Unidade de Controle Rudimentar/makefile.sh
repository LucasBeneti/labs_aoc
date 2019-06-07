ghdl -a rom.vhd &&
ghdl -e rom &&
#ghdl -a rom_tb.vhd &&
#ghdl -e rom_tb &&
#ghdl -r rom_tb --stop-time=800ns --wave=rom_tb.ghw &&
#gtkwave -a relevant_data.gtkw rom_tb.ghw
#gtkwave rom_tb.ghw
# ghdl -a maq_estados.vhd &&
# ghdl -e maq_estados &&
# ghdl -a maq_estados_tb.vhd &&
# ghdl -e maq_estados_tb &&
# ghdl -r maq_estados_tb --stop-time=500ns --wave=maq_estados_tb.ghw &&
# gtkwave maq_estados_tb.ghw
ghdl -a pc.vhd &&
ghdl -e pc &&
#ghdl -a pc_tb.vhd &&
#ghdl -e pc_tb &&
#ghdl -r pc_tb --stop-time=1000ns --wave=pc_tb.ghw &&
#gtkwave -a relevant_data_pc.gtkw pc_tb.ghw
ghdl -a uc.vhd &&
ghdl -e uc &&
ghdl -a rom_e_pc.vhd &&
ghdl -e rom_e_pc &&
ghdl -a rom_e_pc_tb.vhd &&
ghdl -e rom_e_pc_tb &&
ghdl -r rom_e_pc_tb --stop-time=2000ns --wave=rom_e_pc_tb.ghw
# gtkwave rom_e_pc_tb.ghw
