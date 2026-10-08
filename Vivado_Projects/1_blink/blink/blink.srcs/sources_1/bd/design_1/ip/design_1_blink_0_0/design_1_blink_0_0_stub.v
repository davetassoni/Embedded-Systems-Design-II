// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar  8 11:03:48 2021
// Host        : Ryzen-DT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/ESD2/Embedded-Systems-Design-II/Vivado_Projects/1_blink/blink/blink.srcs/sources_1/bd/design_1/ip/design_1_blink_0_0/design_1_blink_0_0_stub.v
// Design      : design_1_blink_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blink,Vivado 2019.1" *)
module design_1_blink_0_0(clk, reset_n, blink_out)
/* synthesis syn_black_box black_box_pad_pin="clk,reset_n,blink_out" */;
  input clk;
  input reset_n;
  output blink_out;
endmodule
