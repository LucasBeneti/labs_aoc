ghdl -a Eq12_rom.vhd &&
ghdl -e eq12_rom &&
ghdl -a Eq12_pc.vhd &&
ghdl -e eq12_pc &&
ghdl -a Eq12_uc.vhd &&
ghdl -e eq12_uc &&
ghdl -a Eq12_reg16bits.vhd &&
ghdl -e eq12_reg16bits &&
ghdl -a Eq12_banco_regs.vhd &&
ghdl -e eq12_banco_regs
ghdl -a Eq12_ula.vhd &&
ghdl -e eq12_ula &&
ghdl -a Eq12_processador.vhd &&
ghdl -e eq12_processador &&
ghdl -a Eq12_processador_tb.vhd &&
ghdl -e eq12_processador_tb
ghdl -a Eq12_ram.vhd &&
ghdl -e eq12_ram &&
ghdl -a Eq12_ram_tb.vhd &&
ghdl -e eq12_ram_tb &&
# ghdl -r eq12_ram_tb --stop-time=8000ns --wave=eq12_ram_tb.ghw
ghdl -r eq12_processador_tb --stop-time=8000ns --wave=eq12_ram.ghw
