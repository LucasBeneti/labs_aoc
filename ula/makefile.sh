ghdl -a lucasbeneti_ula.vhd
ghdl -e lucasbeneti_ula
ghdl -a lucasbeneti_ula_tb.vhd
ghdl -e lucasbeneti_ula_tb
ghdl -r lucasbeneti_ula_tb --wave=lucasbeneti_ula_tb.ghw
gtkwave lucasbeneti_ula_tb.ghw
