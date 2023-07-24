quit -sim

vcom stm.vhd

vsim -t ns stm
#vsim rec_road
#vsim back_and_forward
#vsim mux

add wave  restN
add wave -color green stm_clock
add wave -color magenta track dir
add wave -color orange s
#add wave -color blue next_state state
#add wave *


force restN 0
force track 2'd0
force dir 3'd2
force stm_clock 1, 0 20 ns -r 40 ns
run 150

force restN 1
run 600 ns

force track 2'd1
#force stm_clock 1, 0 20 -r 40
run 600 ns

force track 2'd2
# force stm_clock 1, 0 20 -r 40
run 600 ns

force track 2'd3
# force stm_clock 1, 0 20 -r 40
run 600 ns

force track 2'd1
# force stm_clock 1, 0 20 -r 40
run 600 ns
