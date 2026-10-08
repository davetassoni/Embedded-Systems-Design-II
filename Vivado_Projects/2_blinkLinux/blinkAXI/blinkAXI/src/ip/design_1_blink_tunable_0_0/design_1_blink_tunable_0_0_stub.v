// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Mar 12 15:59:40 2021
// Host        : Ryzen-DT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/ESD2/Embedded-Systems-Design-II/Vivado_Projects/2_blinkLinux/blinkAXI/blinkAXI/src/ip/design_1_blink_tunable_0_0/design_1_blink_tunable_0_0_stub.v
// Design      : design_1_blink_tunable_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blink_tunable,Vivado 2019.1" *)
module design_1_blink_tunable_0_0(clk, reset, max_count, \output )
/* synthesis syn_black_box black_box_pad_pin="clk,reset,max_count[26:0],\output " */;
  input clk;
  input reset;
  input [26:0]max_count;
  output \output ;
endmodule
