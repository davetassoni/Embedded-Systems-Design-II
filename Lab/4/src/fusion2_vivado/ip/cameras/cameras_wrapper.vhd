--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Thu Mar 11 20:48:27 2021
--Host        : DESKTOP-GNIHBM1 running 64-bit major release  (build 9200)
--Command     : generate_target cameras_wrapper.bd
--Design      : cameras_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity cameras_wrapper is
  port (
    M00_AXI1_0_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI1_0_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI1_0_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arready : in STD_LOGIC;
    M00_AXI1_0_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI1_0_arvalid : out STD_LOGIC;
    M00_AXI1_0_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI1_0_rlast : in STD_LOGIC;
    M00_AXI1_0_rready : out STD_LOGIC;
    M00_AXI1_0_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_rvalid : in STD_LOGIC;
    M00_AXIS1_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXIS1_0_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXIS1_0_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_0_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_0_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_0_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awready : in STD_LOGIC;
    M00_AXI_0_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_0_awvalid : out STD_LOGIC;
    M00_AXI_0_bready : out STD_LOGIC;
    M00_AXI_0_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_bvalid : in STD_LOGIC;
    M00_AXI_0_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI_0_wlast : out STD_LOGIC;
    M00_AXI_0_wready : in STD_LOGIC;
    M00_AXI_0_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_0_wvalid : out STD_LOGIC;
    M_AXI_S2MM_0_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_S2MM_0_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_S2MM_0_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awready : in STD_LOGIC;
    M_AXI_S2MM_0_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_S2MM_0_awvalid : out STD_LOGIC;
    M_AXI_S2MM_0_bready : out STD_LOGIC;
    M_AXI_S2MM_0_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_bvalid : in STD_LOGIC;
    M_AXI_S2MM_0_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_S2MM_0_wlast : out STD_LOGIC;
    M_AXI_S2MM_0_wready : in STD_LOGIC;
    M_AXI_S2MM_0_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_S2MM_0_wvalid : out STD_LOGIC;
    S00_AXI_0_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arready : out STD_LOGIC;
    S00_AXI_0_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_arvalid : in STD_LOGIC;
    S00_AXI_0_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awready : out STD_LOGIC;
    S00_AXI_0_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_awvalid : in STD_LOGIC;
    S00_AXI_0_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_bready : in STD_LOGIC;
    S00_AXI_0_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_bvalid : out STD_LOGIC;
    S00_AXI_0_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_rlast : out STD_LOGIC;
    S00_AXI_0_rready : in STD_LOGIC;
    S00_AXI_0_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_rvalid : out STD_LOGIC;
    S00_AXI_0_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_wid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_wlast : in STD_LOGIC;
    S00_AXI_0_wready : out STD_LOGIC;
    S00_AXI_0_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_wvalid : in STD_LOGIC;
    S_AXIS_S2MM_0_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXIS_S2MM_0_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXIS_S2MM_0_tlast : in STD_LOGIC;
    S_AXIS_S2MM_0_tready : out STD_LOGIC;
    S_AXIS_S2MM_0_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXIS_S2MM_0_tvalid : in STD_LOGIC;
    cam_d1_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cam_d_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cam_href1_0 : in STD_LOGIC;
    cam_href_0 : in STD_LOGIC;
    cam_pclk1_0 : in STD_LOGIC;
    cam_pclk_0 : in STD_LOGIC;
    cam_pdwn_0 : out STD_LOGIC;
    cam_rst_0 : out STD_LOGIC;
    cam_trigger1_0 : out STD_LOGIC;
    cam_trigger_0 : out STD_LOGIC;
    cam_vsync1_0 : in STD_LOGIC;
    cam_vsync_0 : in STD_LOGIC;
    cam_xclk_0 : out STD_LOGIC;
    irq_0 : out STD_LOGIC;
    peripheral_aresetn_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    resetn_0 : in STD_LOGIC;
    s_axi_aclk_0 : in STD_LOGIC
  );
end cameras_wrapper;

architecture STRUCTURE of cameras_wrapper is
  component cams is
  port (
    cam_d_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cam_d1_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cam_href_0 : in STD_LOGIC;
    cam_href1_0 : in STD_LOGIC;
    cam_pclk_0 : in STD_LOGIC;
    cam_pclk1_0 : in STD_LOGIC;
    cam_pdwn_0 : out STD_LOGIC;
    cam_rst_0 : out STD_LOGIC;
    cam_trigger_0 : out STD_LOGIC;
    cam_trigger1_0 : out STD_LOGIC;
    cam_vsync_0 : in STD_LOGIC;
    cam_vsync1_0 : in STD_LOGIC;
    cam_xclk_0 : out STD_LOGIC;
    irq_0 : out STD_LOGIC;
    peripheral_aresetn_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    resetn_0 : in STD_LOGIC;
    s_axi_aclk_0 : in STD_LOGIC;
    M_AXI_S2MM_0_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_S2MM_0_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_S2MM_0_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_S2MM_0_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_S2MM_0_awvalid : out STD_LOGIC;
    M_AXI_S2MM_0_awready : in STD_LOGIC;
    M_AXI_S2MM_0_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_S2MM_0_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_S2MM_0_wlast : out STD_LOGIC;
    M_AXI_S2MM_0_wvalid : out STD_LOGIC;
    M_AXI_S2MM_0_wready : in STD_LOGIC;
    M_AXI_S2MM_0_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_S2MM_0_bvalid : in STD_LOGIC;
    M_AXI_S2MM_0_bready : out STD_LOGIC;
    S00_AXI_0_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_awlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_awvalid : in STD_LOGIC;
    S00_AXI_0_awready : out STD_LOGIC;
    S00_AXI_0_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_wlast : in STD_LOGIC;
    S00_AXI_0_wvalid : in STD_LOGIC;
    S00_AXI_0_wready : out STD_LOGIC;
    S00_AXI_0_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_bvalid : out STD_LOGIC;
    S00_AXI_0_bready : in STD_LOGIC;
    S00_AXI_0_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_arlock : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_0_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_0_arvalid : in STD_LOGIC;
    S00_AXI_0_arready : out STD_LOGIC;
    S00_AXI_0_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_0_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_0_rlast : out STD_LOGIC;
    S00_AXI_0_rvalid : out STD_LOGIC;
    S00_AXI_0_rready : in STD_LOGIC;
    M00_AXI1_0_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI1_0_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI1_0_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI1_0_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI1_0_arvalid : out STD_LOGIC;
    M00_AXI1_0_arready : in STD_LOGIC;
    M00_AXI1_0_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI1_0_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI1_0_rlast : in STD_LOGIC;
    M00_AXI1_0_rvalid : in STD_LOGIC;
    M00_AXI1_0_rready : out STD_LOGIC;
    M00_AXI_0_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_0_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_0_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_0_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_0_awvalid : out STD_LOGIC;
    M00_AXI_0_awready : in STD_LOGIC;
    M00_AXI_0_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI_0_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_0_wlast : out STD_LOGIC;
    M00_AXI_0_wvalid : out STD_LOGIC;
    M00_AXI_0_wready : in STD_LOGIC;
    M00_AXI_0_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_0_bvalid : in STD_LOGIC;
    M00_AXI_0_bready : out STD_LOGIC;
    S_AXIS_S2MM_0_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXIS_S2MM_0_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXIS_S2MM_0_tlast : in STD_LOGIC;
    S_AXIS_S2MM_0_tready : out STD_LOGIC;
    S_AXIS_S2MM_0_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXIS_S2MM_0_tvalid : in STD_LOGIC;
    M00_AXIS1_0_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXIS1_0_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXIS1_0_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXIS1_0_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_0_arid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_awid : in STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_bid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_rid : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S00_AXI_0_wid : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component cams;
begin
cameras_i: component cams
     port map (
      M00_AXI1_0_araddr(31 downto 0) => M00_AXI1_0_araddr(31 downto 0),
      M00_AXI1_0_arburst(1 downto 0) => M00_AXI1_0_arburst(1 downto 0),
      M00_AXI1_0_arcache(3 downto 0) => M00_AXI1_0_arcache(3 downto 0),
      M00_AXI1_0_arlen(3 downto 0) => M00_AXI1_0_arlen(3 downto 0),
      M00_AXI1_0_arlock(1 downto 0) => M00_AXI1_0_arlock(1 downto 0),
      M00_AXI1_0_arprot(2 downto 0) => M00_AXI1_0_arprot(2 downto 0),
      M00_AXI1_0_arqos(3 downto 0) => M00_AXI1_0_arqos(3 downto 0),
      M00_AXI1_0_arready => M00_AXI1_0_arready,
      M00_AXI1_0_arsize(2 downto 0) => M00_AXI1_0_arsize(2 downto 0),
      M00_AXI1_0_arvalid => M00_AXI1_0_arvalid,
      M00_AXI1_0_rdata(63 downto 0) => M00_AXI1_0_rdata(63 downto 0),
      M00_AXI1_0_rlast => M00_AXI1_0_rlast,
      M00_AXI1_0_rready => M00_AXI1_0_rready,
      M00_AXI1_0_rresp(1 downto 0) => M00_AXI1_0_rresp(1 downto 0),
      M00_AXI1_0_rvalid => M00_AXI1_0_rvalid,
      M00_AXIS1_0_tdata(63 downto 0) => M00_AXIS1_0_tdata(63 downto 0),
      M00_AXIS1_0_tkeep(7 downto 0) => M00_AXIS1_0_tkeep(7 downto 0),
      M00_AXIS1_0_tlast(0) => M00_AXIS1_0_tlast(0),
      M00_AXIS1_0_tready(0) => M00_AXIS1_0_tready(0),
      M00_AXIS1_0_tuser(0) => M00_AXIS1_0_tuser(0),
      M00_AXIS1_0_tvalid(0) => M00_AXIS1_0_tvalid(0),
      M00_AXI_0_awaddr(31 downto 0) => M00_AXI_0_awaddr(31 downto 0),
      M00_AXI_0_awburst(1 downto 0) => M00_AXI_0_awburst(1 downto 0),
      M00_AXI_0_awcache(3 downto 0) => M00_AXI_0_awcache(3 downto 0),
      M00_AXI_0_awlen(3 downto 0) => M00_AXI_0_awlen(3 downto 0),
      M00_AXI_0_awlock(1 downto 0) => M00_AXI_0_awlock(1 downto 0),
      M00_AXI_0_awprot(2 downto 0) => M00_AXI_0_awprot(2 downto 0),
      M00_AXI_0_awqos(3 downto 0) => M00_AXI_0_awqos(3 downto 0),
      M00_AXI_0_awready => M00_AXI_0_awready,
      M00_AXI_0_awsize(2 downto 0) => M00_AXI_0_awsize(2 downto 0),
      M00_AXI_0_awvalid => M00_AXI_0_awvalid,
      M00_AXI_0_bready => M00_AXI_0_bready,
      M00_AXI_0_bresp(1 downto 0) => M00_AXI_0_bresp(1 downto 0),
      M00_AXI_0_bvalid => M00_AXI_0_bvalid,
      M00_AXI_0_wdata(63 downto 0) => M00_AXI_0_wdata(63 downto 0),
      M00_AXI_0_wlast => M00_AXI_0_wlast,
      M00_AXI_0_wready => M00_AXI_0_wready,
      M00_AXI_0_wstrb(7 downto 0) => M00_AXI_0_wstrb(7 downto 0),
      M00_AXI_0_wvalid => M00_AXI_0_wvalid,
      M_AXI_S2MM_0_awaddr(31 downto 0) => M_AXI_S2MM_0_awaddr(31 downto 0),
      M_AXI_S2MM_0_awburst(1 downto 0) => M_AXI_S2MM_0_awburst(1 downto 0),
      M_AXI_S2MM_0_awcache(3 downto 0) => M_AXI_S2MM_0_awcache(3 downto 0),
      M_AXI_S2MM_0_awlen(3 downto 0) => M_AXI_S2MM_0_awlen(3 downto 0),
      M_AXI_S2MM_0_awlock(1 downto 0) => M_AXI_S2MM_0_awlock(1 downto 0),
      M_AXI_S2MM_0_awprot(2 downto 0) => M_AXI_S2MM_0_awprot(2 downto 0),
      M_AXI_S2MM_0_awqos(3 downto 0) => M_AXI_S2MM_0_awqos(3 downto 0),
      M_AXI_S2MM_0_awready => M_AXI_S2MM_0_awready,
      M_AXI_S2MM_0_awsize(2 downto 0) => M_AXI_S2MM_0_awsize(2 downto 0),
      M_AXI_S2MM_0_awvalid => M_AXI_S2MM_0_awvalid,
      M_AXI_S2MM_0_bready => M_AXI_S2MM_0_bready,
      M_AXI_S2MM_0_bresp(1 downto 0) => M_AXI_S2MM_0_bresp(1 downto 0),
      M_AXI_S2MM_0_bvalid => M_AXI_S2MM_0_bvalid,
      M_AXI_S2MM_0_wdata(63 downto 0) => M_AXI_S2MM_0_wdata(63 downto 0),
      M_AXI_S2MM_0_wlast => M_AXI_S2MM_0_wlast,
      M_AXI_S2MM_0_wready => M_AXI_S2MM_0_wready,
      M_AXI_S2MM_0_wstrb(7 downto 0) => M_AXI_S2MM_0_wstrb(7 downto 0),
      M_AXI_S2MM_0_wvalid => M_AXI_S2MM_0_wvalid,
      S00_AXI_0_araddr(31 downto 0) => S00_AXI_0_araddr(31 downto 0),
      S00_AXI_0_arburst(1 downto 0) => S00_AXI_0_arburst(1 downto 0),
      S00_AXI_0_arcache(3 downto 0) => S00_AXI_0_arcache(3 downto 0),
      S00_AXI_0_arid(11 downto 0) => S00_AXI_0_arid(11 downto 0),
      S00_AXI_0_arlen(3 downto 0) => S00_AXI_0_arlen(3 downto 0),
      S00_AXI_0_arlock(1 downto 0) => S00_AXI_0_arlock(1 downto 0),
      S00_AXI_0_arprot(2 downto 0) => S00_AXI_0_arprot(2 downto 0),
      S00_AXI_0_arqos(3 downto 0) => S00_AXI_0_arqos(3 downto 0),
      S00_AXI_0_arready => S00_AXI_0_arready,
      S00_AXI_0_arsize(2 downto 0) => S00_AXI_0_arsize(2 downto 0),
      S00_AXI_0_arvalid => S00_AXI_0_arvalid,
      S00_AXI_0_awaddr(31 downto 0) => S00_AXI_0_awaddr(31 downto 0),
      S00_AXI_0_awburst(1 downto 0) => S00_AXI_0_awburst(1 downto 0),
      S00_AXI_0_awcache(3 downto 0) => S00_AXI_0_awcache(3 downto 0),
      S00_AXI_0_awid(11 downto 0) => S00_AXI_0_awid(11 downto 0),
      S00_AXI_0_awlen(3 downto 0) => S00_AXI_0_awlen(3 downto 0),
      S00_AXI_0_awlock(1 downto 0) => S00_AXI_0_awlock(1 downto 0),
      S00_AXI_0_awprot(2 downto 0) => S00_AXI_0_awprot(2 downto 0),
      S00_AXI_0_awqos(3 downto 0) => S00_AXI_0_awqos(3 downto 0),
      S00_AXI_0_awready => S00_AXI_0_awready,
      S00_AXI_0_awsize(2 downto 0) => S00_AXI_0_awsize(2 downto 0),
      S00_AXI_0_awvalid => S00_AXI_0_awvalid,
      S00_AXI_0_bid(11 downto 0) => S00_AXI_0_bid(11 downto 0),
      S00_AXI_0_bready => S00_AXI_0_bready,
      S00_AXI_0_bresp(1 downto 0) => S00_AXI_0_bresp(1 downto 0),
      S00_AXI_0_bvalid => S00_AXI_0_bvalid,
      S00_AXI_0_rdata(31 downto 0) => S00_AXI_0_rdata(31 downto 0),
      S00_AXI_0_rid(11 downto 0) => S00_AXI_0_rid(11 downto 0),
      S00_AXI_0_rlast => S00_AXI_0_rlast,
      S00_AXI_0_rready => S00_AXI_0_rready,
      S00_AXI_0_rresp(1 downto 0) => S00_AXI_0_rresp(1 downto 0),
      S00_AXI_0_rvalid => S00_AXI_0_rvalid,
      S00_AXI_0_wdata(31 downto 0) => S00_AXI_0_wdata(31 downto 0),
      S00_AXI_0_wid(11 downto 0) => S00_AXI_0_wid(11 downto 0),
      S00_AXI_0_wlast => S00_AXI_0_wlast,
      S00_AXI_0_wready => S00_AXI_0_wready,
      S00_AXI_0_wstrb(3 downto 0) => S00_AXI_0_wstrb(3 downto 0),
      S00_AXI_0_wvalid => S00_AXI_0_wvalid,
      S_AXIS_S2MM_0_tdata(63 downto 0) => S_AXIS_S2MM_0_tdata(63 downto 0),
      S_AXIS_S2MM_0_tkeep(7 downto 0) => S_AXIS_S2MM_0_tkeep(7 downto 0),
      S_AXIS_S2MM_0_tlast => S_AXIS_S2MM_0_tlast,
      S_AXIS_S2MM_0_tready => S_AXIS_S2MM_0_tready,
      S_AXIS_S2MM_0_tuser(0) => S_AXIS_S2MM_0_tuser(0),
      S_AXIS_S2MM_0_tvalid => S_AXIS_S2MM_0_tvalid,
      cam_d1_0(7 downto 0) => cam_d1_0(7 downto 0),
      cam_d_0(7 downto 0) => cam_d_0(7 downto 0),
      cam_href1_0 => cam_href1_0,
      cam_href_0 => cam_href_0,
      cam_pclk1_0 => cam_pclk1_0,
      cam_pclk_0 => cam_pclk_0,
      cam_pdwn_0 => cam_pdwn_0,
      cam_rst_0 => cam_rst_0,
      cam_trigger1_0 => cam_trigger1_0,
      cam_trigger_0 => cam_trigger_0,
      cam_vsync1_0 => cam_vsync1_0,
      cam_vsync_0 => cam_vsync_0,
      cam_xclk_0 => cam_xclk_0,
      irq_0 => irq_0,
      peripheral_aresetn_0(0) => peripheral_aresetn_0(0),
      resetn_0 => resetn_0,
      s_axi_aclk_0 => s_axi_aclk_0
    );
end STRUCTURE;
