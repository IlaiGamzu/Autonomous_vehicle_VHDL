quit -sim

vcom manoa.vhd
vsim engine

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /engine/dir
add wave -noupdate /engine/output
add wave -noupdate /engine/Estop
add wave -noupdate /engine/forward
add wave -noupdate /engine/backwards
add wave -noupdate /engine/stop
add wave -noupdate /engine/f_right
add wave -noupdate /engine/b_right
add wave -noupdate /engine/f_left
add wave -noupdate /engine/b_left
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3341 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 94
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {362 ps} {824 ps}
