-------------------------------------------------------------------------------
-- Dr. Kaputa
-- axiFeedthrough 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;      

entity axiFeedthrough is
  port (
    aclk                      : in  std_logic;
    resetn                    : in  std_logic;
    
    s00_axi_aclk	: in std_logic;
    s00_axi_aresetn	: in std_logic;
    s00_axi_awaddr	: in std_logic_vector(3 downto 0);
    s00_axi_awprot	: in std_logic_vector(2 downto 0);
    s00_axi_awvalid	: in std_logic;
    s00_axi_awready	: out std_logic;
    s00_axi_wdata	: in std_logic_vector(31 downto 0);
    s00_axi_wstrb	: in std_logic_vector(3 downto 0);
    s00_axi_wvalid	: in std_logic;
    s00_axi_wready	: out std_logic;
    s00_axi_bresp	: out std_logic_vector(1 downto 0);
    s00_axi_bvalid	: out std_logic;
    s00_axi_bready	: in std_logic;
    s00_axi_araddr	: in std_logic_vector(3 downto 0);
    s00_axi_arprot	: in std_logic_vector(2 downto 0);
    s00_axi_arvalid	: in std_logic;
    s00_axi_arready	: out std_logic;
    s00_axi_rdata	: out std_logic_vector(31 downto 0);
    s00_axi_rresp	: out std_logic_vector(1 downto 0);
    s00_axi_rvalid	: out std_logic;
    s00_axi_rready	: in std_logic;
    
    m_axis_video_tdata        : in  std_logic_vector(63 downto 0); 
    m_axis_video_tlast        : in  std_logic;
    m_axis_video_tready       : out std_logic;
    m_axis_video_tuser        : in  std_logic;
    m_axis_video_tvalid       : in  std_logic;
    
    s_axis_video_tdata        : out std_logic_vector(63 downto 0); 
    s_axis_video_tlast        : out std_logic;
    s_axis_video_tready       : in std_logic;
    s_axis_video_tuser        : out std_logic;
    s_axis_video_tvalid       : out std_logic
  );  
end axiFeedthrough;  

architecture beh of axiFeedthrough  is

begin
  s_axis_video_tlast      <= m_axis_video_tlast; 
  m_axis_video_tready     <= s_axis_video_tready;
  s_axis_video_tuser      <= m_axis_video_tuser; 
  s_axis_video_tvalid     <= m_axis_video_tvalid;
  s_axis_video_tdata      <= m_axis_video_tdata; 
  
  s00_axi_awready         <= '0';
  s00_axi_wready          <= '0';
  s00_axi_bvalid          <= '0';
  s00_axi_bresp           <= "00";
  s00_axi_arready         <= '0';
  s00_axi_rdata           <= "00000000000000000000000000000000";
  s00_axi_rresp           <= "00";
  s00_axi_rvalid          <= '0';
end beh;