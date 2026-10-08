onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /solution/clk
add wave -noupdate /solution/reset
add wave -noupdate /solution/r
add wave -noupdate /solution/g
add wave -noupdate /solution/b
add wave -noupdate /solution/r_min
add wave -noupdate /solution/r_max
add wave -noupdate /solution/g_min
add wave -noupdate /solution/g_max
add wave -noupdate /solution/b_min
add wave -noupdate /solution/b_max
add wave -noupdate /solution/r_out
add wave -noupdate /solution/g_out
add wave -noupdate /solution/b_out
add wave -noupdate /solution/rgb_done_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19999388474 ps} 0}
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
WaveRestoreZoom {59999050 ns} {59999294032 ps}
