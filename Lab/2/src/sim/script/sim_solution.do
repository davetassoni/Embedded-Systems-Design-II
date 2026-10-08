vlib work
vcom -93 -work work ../../src/filter.vhd
vcom -93 -work work ../src/image_handler.vhd
vcom -93 -work work ../src/solution.vhd
vsim solution
do wave.do
run 20 ms