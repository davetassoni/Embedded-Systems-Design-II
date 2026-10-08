LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.image_handler.all;

entity red is
end red;

architecture beh of red is

-- Image names            : rit.tif     ritchie.tif       rit_jersey.tif
constant image_name       : string := "rit_jersey.tif";   
constant output_name      : string := "output.tif";
constant image_path       : string := "Images\\";
constant result_path      : string := "Results\\";

constant input_filename   : string := image_path & image_name;
constant output_filename  : string := result_path & output_name;

signal image_data         : picture_vector := (others => 255);
signal done_flag          : std_logic := '0' ;

begin

process is
begin
  open_tiff_image(input_filename, image_data);
  wait for 40 ns;

  red_components(image_data, image_data); 
  wait for 40 ns;

  save_tiff_image_640x480(output_filename, image_data);
  wait for 40 ns;

  done_flag <= '1';
  wait;
end process;
end beh;   
