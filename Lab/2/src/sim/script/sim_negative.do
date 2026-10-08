vlib work
vcom -93 -work work ../src/image_handler.vhd
vcom -93 -work work ../src/negative.vhd
vsim negative
do wave.do
run -all