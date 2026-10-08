-------------------------------------------------------------------------------
-- Original: Dr. Kaputa
-- Edited by David Tassoni
-- File: filter.vhd
-- ESD-II Lab 2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter is
  port (
    clk               : in  std_logic;
    reset             : in  std_logic;
    r                 : in  std_logic_vector(7 downto 0);
    g                 : in  std_logic_vector(7 downto 0);
    b                 : in  std_logic_vector(7 downto 0);
    r_min             : in  std_logic_vector(7 downto 0);
    r_max             : in  std_logic_vector(7 downto 0);
    g_min             : in  std_logic_vector(7 downto 0);
    g_max             : in  std_logic_vector(7 downto 0);
    b_min             : in  std_logic_vector(7 downto 0);
    b_max             : in  std_logic_vector(7 downto 0);
    r_out             : out std_logic_vector(7 downto 0);
    g_out             : out std_logic_vector(7 downto 0);
    b_out             : out std_logic_vector(7 downto 0)
  );
end entity filter;

architecture beh of filter is

-- Signal Declarations
signal r_out_filtered : std_logic_vector(7 downto 0) := (others => '0');
signal g_out_filtered : std_logic_vector(7 downto 0) := (others => '0');
signal b_out_filtered : std_logic_vector(7 downto 0) := (others => '0');

begin

r_pixel_modify : process(r)
-- output modified red pixels based on the thresholding values
  begin
    if(r >= r_min) and (r <= r_max) then
      r_out_filtered <= r;
    else
      r_out_filtered <= (others => '0');
    end if;
end process r_pixel_modify;
r_out <= r_out_filtered;

g_pixel_modify : process(g)
-- output modified green pixels based on the thresholding values
  begin
    if(g >= g_min) and (g <= g_max) then
      g_out_filtered <= g;
    else
      g_out_filtered <= (others => '0');
    end if;
end process g_pixel_modify;
g_out <= g_out_filtered;

b_pixel_modify : process(b)
-- output modified blue pixels based on the thresholding values
  begin
    if(b >= b_min) and (b <= b_max) then
      b_out_filtered <= b;
    else
      b_out_filtered <= (others => '0');
    end if;
end process b_pixel_modify;
b_out <= b_out_filtered;

end beh;