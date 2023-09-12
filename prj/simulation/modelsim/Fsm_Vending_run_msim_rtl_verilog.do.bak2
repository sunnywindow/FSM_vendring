transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/vending_top.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/vending.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/seg_driver.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/pwm_buzzer.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/key_debounce.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/rtl {D:/FPGA_verilog_training_core/Fsm_Vending/rtl/buzzer_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/ip/ram_10x32 {D:/FPGA_verilog_training_core/Fsm_Vending/ip/ram_10x32/ram_10x32.v}

vlog -vlog01compat -work work +incdir+D:/FPGA_verilog_training_core/Fsm_Vending/prj/../tb {D:/FPGA_verilog_training_core/Fsm_Vending/prj/../tb/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

do D:/FPGA_verilog_training_core/Fsm_Vending/prj/../tb/wave.do
