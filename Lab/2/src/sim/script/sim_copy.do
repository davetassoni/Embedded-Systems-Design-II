vlib work
vcom -93 -work work ../src/image_handler.vhd
vcom -93 -work work ../src/copy_image.vhd
vsim copy_image
do wave.do
run -all