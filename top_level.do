quit -sim
vcom top_level.vhd

vsim -t ns top_level_of_wheels

#add wave

add wave                       clk Reset
add wave -divider "Inputs: " 
add wave -color orange         Estop
add wave -color orange         track
add wave -color orange         dir

add wave -divider "output:"
add wave -color Magenta            outputFromEngines


force clk 0, 1 50 ns -r 100 ns
force Reset 0
#Add
# case 1: 01 A(2), B (8)     
force track 01 
force dir 001
force Estop 0
run

force Reset 1 
run 300 ns

force track 01 
force dir 000
force Estop 1 
run 300 ns
