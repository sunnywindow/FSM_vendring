onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/clk
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/rst_n
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix binary /top_tb/u_vending_top/key
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix binary /top_tb/u_vending_top/sel
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix binary /top_tb/u_vending_top/seg
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix binary /top_tb/u_vending_top/led
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/buzzer
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/key_out
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/seg_value
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix unsigned /top_tb/u_vending_top/buzzer_en
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/Group1 -group {Region: sim:/top_tb/u_vending_top} -radix binary /top_tb/u_vending_top/dot
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix binary /top_tb/u_vending_top/u_vending/key_in
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/seg_value
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/buzzer_en
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/cstate
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/nstate
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/cnt_1s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/add_cnt_1s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/end_cnt_1s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/cnt_4s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/add_cnt_4s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/end_cnt_4s
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/goods
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/pay_money
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix binary /top_tb/u_vending_top/u_vending/key_r
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/buy_number
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/ram_data
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/summary
add wave -noupdate -expand -label sim:/top_tb/u_vending_top/u_vending/Group1 -group {Region: sim:/top_tb/u_vending_top/u_vending} -radix unsigned /top_tb/u_vending_top/u_vending/rden
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17286468 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {32289010 ps}
