transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/EngineeringDocument/FPGA_DOC/DAC7512 {C:/EngineeringDocument/FPGA_DOC/DAC7512/dac7512.v}

vlog -vlog01compat -work work +incdir+C:/EngineeringDocument/FPGA_DOC/DAC7512/simulation/modelsim {C:/EngineeringDocument/FPGA_DOC/DAC7512/simulation/modelsim/dac7512.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone_ver -L rtl_work -L work -voptargs="+acc" dac7512_vlg_tst

add wave *
view structure
view signals
run -all
