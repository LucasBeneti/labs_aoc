ghdl -a soma_e_divide.vhd
ghdl -e soma_e_divide
ghdl -a soma_e_divide_tb.vhd
ghdl -e soma_e_divide_tb
ghdl -r soma_e_divide_tb --wave=soma_e_divide_tb.ghw
gtkwave soma_e_divide_tb.ghw