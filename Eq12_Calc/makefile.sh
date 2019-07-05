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
ghdl -a Eq12_calculadora.vhd &&
ghdl -e eq12_calculadora &&
ghdl -a Eq12_calculadora_tb.vhd &&
ghdl -e eq12_calculadora_tb
ghdl -r eq12_calculadora_tb --stop-time=4000ns --wave=eq12_calculadora_tb.ghw
