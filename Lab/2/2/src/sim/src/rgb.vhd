LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.image_handler.all;

entity rgb is
end rgb;

architecture beh of rgb is

-- Image names            : rit.tif     ritchie.tif       rit_jersey.tif
constant image_name       : string := "rit_jersey.tif";   
constant output_name1     : string := "output1.tif";
constant output_name2     : string := "output2.tif";
constant output_name3     : string := "output3.tif";
constant image_path       : string := "Images\\";
constant result_path      : string := "Results\\";

constant input_filename   : string := image_path & image_name;
constant output_filename1 : string := result_path & output_name1;
constant output_filename2 : string := result_path & output_name2;
constant output_filename3 : string := result_path & output_name3;

signal image_data         : picture_vector := (others => 255);
signal image_data_proc1   : picture_vector := (others => 255);
signal image_data_proc2   : picture_vector := (others => 255);
signal image_data_proc3   : picture_vector := (others => 255);
signal done_flag          : std_logic := '0' ;

begin

process is
begin
  open_tiff_image(input_filename, image_data);
  wait for 40 ns;

  red_components(image_data, image_data_proc1); 
  wait for 40 ns;

  save_tiff_image_640x480(output_filename1, image_data_proc1);
  wait for 40 ns;

  green_components(image_data, image_data_proc2); 
  wait for 40 ns;

  save_tiff_image_640x480(output_filename2, image_data_proc2);
  wait for 40 ns;
  
  blue_components(image_data, image_data_proc3); 
  wait for 40 ns;

  save_tiff_image_640x480(output_filename3, image_data_proc3);
  wait for 40 ns;

  done_flag <= '1';
  wait;
end process;
end beh;   
