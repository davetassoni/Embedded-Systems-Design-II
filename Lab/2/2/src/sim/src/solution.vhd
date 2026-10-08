-------------------------------------------------------------------------------
-- Original: Dr. Kaputa
-- Edited by David Tassoni
-- File: solution.vhd
-- ESD-II Lab 2
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
use ieee.std_logic_arith.all;
use work.image_handler.all;

entity solution is
end solution;

architecture beh of solution is

-- Image names           : rit.tif    ritchie.tif       rit_jersey.tif
constant image_name      : string := "rit_jersey.tif";
constant output_name     : string := "output1.tif";
constant image_path      : string := "Images\\";
constant result_path     : string := "Results\\";
constant input_filename  : string := image_path & image_name;
constant output_filename : string := result_path & output_name;

-- Signal Declarations
signal image_data        : picture_vector := (others => 100);
signal image_data_proc   : picture_vector := (others => 100);
signal rgb_done_flag     : std_logic := '0';

signal clk               : std_logic := '0';
signal reset             : std_logic;
signal r                 : std_logic_vector(7 downto 0);
signal g                 : std_logic_vector(7 downto 0);
signal b                 : std_logic_vector(7 downto 0);
-- Default values are 0 for min and 255 for max
signal r_min             : std_logic_vector(7 downto 0) := x"60"; -- 0
signal r_max             : std_logic_vector(7 downto 0) := x"FF"; -- 255
signal g_min             : std_logic_vector(7 downto 0) := x"80"; -- 0
signal g_max             : std_logic_vector(7 downto 0) := x"FF"; -- 255
signal b_min             : std_logic_vector(7 downto 0) := x"00"; -- 0
signal b_max             : std_logic_vector(7 downto 0) := x"AF"; -- 255
signal r_out             : std_logic_vector(7 downto 0);
signal g_out             : std_logic_vector(7 downto 0);
signal b_out             : std_logic_vector(7 downto 0);

constant period          : time := 20ns;

component filter is
port (
  clk                    : in  std_logic;
  reset                  : in  std_logic;
  r                      : in  std_logic_vector(7 downto 0);
  g                      : in  std_logic_vector(7 downto 0);
  b                      : in  std_logic_vector(7 downto 0);
  r_min                  : in  std_logic_vector(7 downto 0);
  r_max                  : in  std_logic_vector(7 downto 0);
  g_min                  : in  std_logic_vector(7 downto 0);
  g_max                  : in  std_logic_vector(7 downto 0);
  b_min                  : in  std_logic_vector(7 downto 0);
  b_max                  : in  std_logic_vector(7 downto 0);
  r_out                  : out std_logic_vector(7 downto 0);
  g_out                  : out std_logic_vector(7 downto 0);
  b_out                  : out std_logic_vector(7 downto 0)
);
end component filter;

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

process is
begin
  -- open the image
  open_tiff_image(input_filename, image_data);
  wait for 40 ns;

  for i in image_data' range loop
    wait for period;
    
    if(i mod 3 = 0) then
    -- 0 is red
      r <= conv_std_logic_vector(image_data(i),8);
      image_data_proc(i)    <= conv_integer(unsigned(r_out));
    
    elsif(i mod 3 = 1) then
    -- 1 is green
      g <= conv_std_logic_vector(image_data(i),8);
      image_data_proc(i)    <= conv_integer(unsigned(g_out));
    
    elsif(i mod 3 = 2) then
    -- 2 is blue
      b <= conv_std_logic_vector(image_data(i),8);
      image_data_proc(i)    <= conv_integer(unsigned(b_out));
    
    else
    -- if not any of the above, set to 0 (black)
      image_data_proc(i)    <= 0;
    end if;
  end loop;
  wait for 40 ns;
  -- save and close the resultant RGB filtered image
  save_tiff_image_640x480(output_filename, image_data_proc);
  -- set flag to 1 to signify operation is done
  rgb_done_flag <= '1';
  
  wait;
end process;

uut: filter
  port map (
    clk   => clk,
    reset => reset,
    r     => r,
    g     => g,
    b     => b,
    r_min => r_min,
    r_max => r_max,
    g_min => g_min,
    g_max => g_max,
    b_min => b_min,
    b_max => b_max,
    r_out => r_out,
    g_out => g_out,
    b_out => b_out
  );
end beh;