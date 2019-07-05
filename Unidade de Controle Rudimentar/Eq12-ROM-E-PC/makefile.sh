ghdl -a Eq12_rom.vhd &&
ghdl -e eq12_rom &&
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
ghdl -a Eq12_pc.vhd &&
ghdl -e eq12_pc &&
#ghdl -a pc_tb.vhd &&
#ghdl -e pc_tb &&
#ghdl -r pc_tb --stop-time=1000ns --wave=pc_tb.ghw &&
#gtkwave -a relevant_data_pc.gtkw pc_tb.ghw
ghdl -a Eq12_uc.vhd &&
ghdl -e eq12_uc &&
ghdl -a Eq12_rom_e_pc.vhd &&
ghdl -e eq12_rom_e_pc &&
ghdl -a Eq12_rom_e_pc_tb.vhd &&
ghdl -e eq12_rom_e_pc_tb &&
ghdl -r eq12_rom_e_pc_tb --stop-time=2000ns --wave=eq12_rom_e_pc_tb.ghw
