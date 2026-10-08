vlib work
vcom -93 -work work ../src/image_handler.vhd
vcom -93 -work work ../src/rgb.vhd
vsim rgb
do wave.do
run -all