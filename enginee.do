quit -sim

vcom Manoa.vhd
vsim engine


add wave *
force dir 001
force Estop 001
run 500ns

#force dir 000
#force Estop 0
#run 500ns

#force dir 001
#force Estop 1

#run 500ns

#force dir 010
#run 500ns

#force dir 011
#run 500ns

#force dir 100
#run 500ns

#force dir 111 --stop
#run 500ns
