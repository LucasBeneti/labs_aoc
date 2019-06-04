	--Alunos: Marcos Sikora de Araujo e Gabriel Pereira Andrade
	--Equipe 08
	
cls
ghdl --remove
ghdl --clean

ghdl -a Eq08-reg16bits.vhd
ghdl -e reg16bits

ghdl -a Eq08-program_counter.vhd
ghdl -e program_counter

ghdl -a Eq08-rom.vhd
ghdl -e rom

ghdl -a Eq08-un_controle.vhd
ghdl -e un_controle

ghdl -a Eq08-ROM-PC-UC.vhd
ghdl -e rom_pc_uc

ghdl -a Eq08-ROM-PC-UC_tb.vhd
ghdl -e rom_pc_uc_tb

ghdl -r rom_pc_uc_tb --stop-time=4000ns --wave=Eq08-ROM-PC-UC.ghw
gtkwave Eq08-ROM-PC-UC.ghw

pause
