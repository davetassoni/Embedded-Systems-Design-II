-------------------------------------------------------------------------------
-- Author           : Alberto Santos
-- Project Adviser  : Dr. Daniel Kaputa
-- Program          : Image manipulation

-- Program Details:
-- This package contains all the necessary functions that will be used 
--   to read images, convert the image into a matrix and manipulate images.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;

package image_handler is
  constant PICTURE_WIDTH            : natural := 640;
  constant PICTURE_HEIGHT           : natural := 480;
  constant PICTURE_SIZE             : natural := PICTURE_WIDTH* PICTURE_HEIGHT;
  constant PICTURE_TOTAL_BYTES      : natural := PICTURE_SIZE*3;
  constant PICTURE_TOTAL_BYTES_RGB  : natural := PICTURE_SIZE*3;
  constant PICTURE_TOTAL_BYTES_BnW  : natural := PICTURE_SIZE/8;
  
  subtype byte is integer range 0 to (2**8) -1;
  type pixel is array (0 to 2) of character;
  type int_file is file of byte;
  type pic_file is file of character;
  type picture_vector is array (0 to (3*PICTURE_SIZE)-1) of byte;
  type picture_matrix is array (0 to PICTURE_WIDTH, 0 to PICTURE_HEIGHT) of pixel;
  type blacknWhite_vector is array (0 to PICTURE_SIZE-1) of byte;
  type char_array is array (natural range<>) of character;
  type byte_array is array (natural range<>) of byte;

  procedure open_tiff_image(input_filename: in string; signal output_vector: out picture_vector);
  procedure save_tiff_image_640x480(output_filename: in string; signal input_vector: in picture_vector);
  procedure image_negative(signal input_vector: in picture_vector; signal output_vector: out picture_vector);
  procedure red_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector);
  procedure green_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector);
  procedure blue_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector);
  procedure rgb_filter(signal input_vector: in picture_vector; 
                       signal output_vector: out picture_vector; 
                       signal rlow: in std_logic_vector(7 downto 0); 
                       signal rhigh: in std_logic_vector(7 downto 0) ;
                       signal glow: in std_logic_vector(7 downto 0); 
                       signal ghigh: in std_logic_vector(7 downto 0); 
                       signal blow: in std_logic_vector(7 downto 0); 
                       signal bhigh: in std_logic_vector(7 downto 0));
end image_handler;  

package body image_handler is

procedure open_tiff_image(input_filename: in string; signal output_vector: out picture_vector) is
  constant IMAGE_WIDTH_TAG        : natural := 256;
  constant IMAGE_LENGTH_TAG       : natural := 257;
  constant COMPRESSION_TAG        : natural := 259;
  constant PHOTOMETRIC_INTERP_TAG : natural := 262;
  constant STRIP_OFFSET_TAG       : natural := 273;
  constant STRIP_BYTE_COUNTS_TAG  : natural := 279;
  constant HEADER_SIZE            : natural := 8;
  
  constant WhiteIsZero    : natural := 0;
  constant BlackIsZero    : natural := 1;
  constant RGB            : natural := 2;
  constant zero           : natural := 0;
  constant one            : natural := 255;
  constant RED_ADDR       : natural := 0;
  constant GREEN_ADDR     : natural := 1;
  constant BLUE_ADDR      : natural := 2;

  variable header_info    : byte_array(0 to 7);
  variable tiff_tag       : byte_array(0 to 11); 
  variable index          : natural := 0;
  variable number_of_tags : natural;
  variable tag_ID         : natural;
  variable data_offset    : natural;
  variable IDF_address    : natural;
  variable image_address  : natural;
  variable photometricInt : natural;
  variable StripByteCount : natural;
  
  variable temp           : std_logic_vector(0 to 7);
  variable temp1          : integer;
  variable temp2          : integer;
  variable blackWhiteVect : blacknWhite_vector;
  variable color1         : byte;
  variable color2         : byte;
  variable data_read      : character;
  file input_file         : pic_file;
  
begin
  -- Open file to obtain the image information(width, height, pixel_address, etc.).  
  file_open(input_file,input_filename,READ_MODE);

  for i in 0 to (HEADER_SIZE-1) loop
    read(input_file, data_read);
    header_info(i)    := character'pos(data_read);
    index      := index+1;
  end loop;
  IDF_address   := header_info(4) +  (header_info(5)*(2**8)) + (header_info(6)*(2**16)) + (header_info(7)*(2**24)) ;
  
  assert (header_info(0) = 16#49#) report "ERROR: Conditions are not set for this type of file" severity error;
  assert (header_info(2) = 16#2a#) report "ERROR: Binary file is not a TIFF file" severity error;
  
  while(index < IDF_address) loop
    read(input_file, data_read);
    index  := index +1;
  end loop;

  read(input_file, data_read);
  temp1    := character'pos(data_read);
  read(input_file, data_read);
  temp2    := character'pos(data_read);
  
  number_of_tags   := temp1 + temp2*(2**8);
  
  -- Identifying tags from tiff file
  for i in 1 to number_of_tags loop
    for j in 0 to 11 loop
      read(input_file, data_read);
      tiff_tag(j)   :=  character'pos(data_read);
    end loop;    
    tag_ID          := tiff_tag(0) + tiff_tag(1)*(2**8);
    data_offset     := tiff_tag(8) + tiff_tag(9)*(2**8)  + tiff_tag(10)*(2**16)  + tiff_tag(11)*(2**24);
    
    case tag_ID is
      when IMAGE_WIDTH_TAG =>
        assert(data_offset = PICTURE_WIDTH) report "ERROR!! Image WIDTH does not match the expected" severity error;
      when IMAGE_LENGTH_TAG =>
        assert(data_offset = PICTURE_HEIGHT) report "ERROR!! Image HEIGHT does not match the expected" severity error;
      when COMPRESSION_TAG =>
        assert(data_offset = 1) report "ERROR!! Image is compressed" severity error;
      when PHOTOMETRIC_INTERP_TAG =>
        assert(data_offset <= 2) report "ERROR!! Image read is not set to 'RGB' nor 'black and White'. Does not match the expected" severity error;
        photometricInt  := data_offset;
      when STRIP_OFFSET_TAG =>
        image_address  := data_offset;
      when STRIP_BYTE_COUNTS_TAG  =>
        assert((data_offset = PICTURE_TOTAL_BYTES_RGB) or (data_offset = PICTURE_TOTAL_BYTES_BnW)) report "ERROR!! Image SIZE does not match the expected" severity error;
        StripByteCount  := data_offset;
      when others =>
        report "A different tag" severity note;
    end case;  
  end loop;
  file_close(input_file);
  
-- Opening Image to obtain the picture vector from the address given in info.  
  file_open(input_file,input_filename,READ_MODE);
  index   :=0;
  while(index < image_address) loop
    read(input_file, data_read);
    index  := index +1;
  end loop;

  -- RGB Images will return a RGB-format vector
  index   := 0;
  if(photometricInt = RGB) then      
    for i in 0 to (StripByteCount-1) loop
      read(input_file, data_read);
      output_vector(i)  <= character'pos(data_read);
    end loop;

  -- Black-White Images will return a RGB-format vector
  -- Black-White Images only have one bit per pixel (instead of 24 bits per pixel)

  elsif(photometricInt = BlackIsZero) or (photometricInt = WhiteIsZero) then
    if photometricInt = BlackIsZero then 
      color1    := one;
      color2    := zero;
    elsif photometricInt = WhiteIsZero then
      color1    := zero;
      color2    := one;
    end if;

    for i in 0 to (StripByteCount-1) loop
      read(input_file, data_read);
      temp    := conv_std_logic_vector(character'pos(data_read),8);
      for j in 7 downto 0 loop
        if temp(j) = '1' then
          output_vector((i*24)+(j*3)+RED_ADDR)    <= color1;
          output_vector((i*24)+(j*3)+GREEN_ADDR)  <= color1;
          output_vector((i*24)+(j*3)+BLUE_ADDR)   <= color1;
        else
          output_vector((i*24)+(j*3)+RED_ADDR)    <= color2;
          output_vector((i*24)+(j*3)+GREEN_ADDR)  <= color2;
          output_vector((i*24)+(j*3)+BLUE_ADDR)   <= color2;
        end if;
      end loop;
    end loop;

  else
    for i in 0 to (StripByteCount-1) loop
      output_vector(i)  <= 255;
    end loop; 
  end if;

  file_close(input_file);

end open_tiff_image;

procedure save_tiff_image_640x480(output_filename: in string; signal input_vector: in picture_vector) is
  constant TAG_ENTRY_COUNT        : natural := 14;  
  constant BYTES_PER_TAG          : natural := 12;
  constant HEADER_SIZE            : natural := 8;
  constant IDF_ENTRY_EXIT_BYTES   : natural := 2+4;     
  constant IDF_TAG_SIZE           : natural := (TAG_ENTRY_COUNT)*(BYTES_PER_TAG);
  constant IDF_TOTAL_SIZE         : natural := IDF_TAG_SIZE + IDF_ENTRY_EXIT_BYTES;
  alias TOTAL_DIRECTORIES is TAG_ENTRY_COUNT;

  -- dividing a large integer into four byte-size integers for the width, lenght and total pic size
  constant W4  : natural :=  PICTURE_WIDTH  /  (2**24);
  constant W3  : natural := (PICTURE_WIDTH  /  (2**16)) mod (2**8);
  constant W2  : natural := (PICTURE_WIDTH  /  (2**08)) mod (2**8);
  constant W1  : natural :=  PICTURE_WIDTH mod (2**08);
  
  constant L4  : natural :=  PICTURE_HEIGHT  /  (2**24);
  constant L3  : natural := (PICTURE_HEIGHT  /  (2**16)) mod (2**8);
  constant L2  : natural := (PICTURE_HEIGHT  /  (2**08)) mod (2**8);
  constant L1  : natural :=  PICTURE_HEIGHT mod (2**08);
  
  constant S4  : natural :=  PICTURE_TOTAL_BYTES  /  (2**24);
  constant S3  : natural := (PICTURE_TOTAL_BYTES  /  (2**16)) mod (2**8);
  constant S2  : natural := (PICTURE_TOTAL_BYTES  /  (2**08)) mod (2**8);
  constant S1  : natural :=  PICTURE_TOTAL_BYTES mod (2**08);
  -------------------------------------------------------------------------------------------------

  constant tiff_header          : byte_array(0 to 7)   := (73,73,42,0,8,0,0,0);    
  constant ImageFileDirectory   : byte_array(0 to IDF_TOTAL_SIZE-1)  := (

  TOTAL_DIRECTORIES,00,       -- numberOfDir (Entry_Bytes)
  
--  Tiff Tag ID         Data Type    Data Count      Data Offset       Tag Name(Value)                      UPDATE ADDR
  16#FE#, 16#00#,       04, 00,      01,00,00,00,    00,00,00,00,      -- 1.  NewSubFile(Zero)         
  16#00#, 16#01#,       03, 00,      01,00,00,00,    W1,W2,W3,W4,      -- 2.  ImageWidth
  16#01#, 16#01#,       03, 00,      01,00,00,00,    L1,L2,L3,L4,      -- 3.  ImageLength                     
  16#02#, 16#01#,       03, 00,      03,00,00,00,    182,00,00,00,     -- 4.  BitsPerSample(8,8,8)              ** 
  16#03#, 16#01#,       03, 00,      01,00,00,00,    01,00,00,00,      -- 5.  Compression(Uncompressed)
  16#06#, 16#01#,       03, 00,      01,00,00,00,    02,00,00,00,      -- 6.  PhotometricInterpretation (RGB)
  16#11#, 16#01#,       04, 00,      01,00,00,00,    249,00,00,00,     -- 7.  StripOffset(addr first image byte)**
--16#12#, 16#01#,       03, 00,      01,00,00,00,    01,00,00,00,      --     Orientation(TopLeft)
  16#15#, 16#01#,       03, 00,      01,00,00,00,    03,00,00,00,      -- 8.  SamplesPerPixel(3)
  16#16#, 16#01#,       03, 00,      01,00,00,00,    L1,L2,L3,L4,      -- 9.  RowsPerStrip
  16#17#, 16#01#,       03, 00,      01,00,00,00,    S1,S2,S3,S4,      -- 10. StripByteCounts
  16#1A#, 16#01#,       05, 00,      01,00,00,00,    233,00,00,00,     -- 11. XResolution (X Pixels per Inch)  **
  16#1B#, 16#01#,       05, 00,      01,00,00,00,    241,00,00,00,     -- 12. YResolution (Y Pixels per Inch)  **
  16#28#, 16#01#,       03, 00,      01,00,00,00,    02,00,00,00,      -- 13. ResolutionUnit(Inch)
  16#31#, 16#01#,       02, 00,      45,00,00,00,    188,00,00,00,     -- 14. Software                         **
          
  00,00,00,00        -- Next IDF Offset (Exit_Bytes)
  );
  
  constant bitsPerSample    : byte_array(0 to 5)  := (8,0,8,0,8,0);
  constant XYresolution     : byte_array(0 to 15) := (
    00,166,14,00,16,39,00,00,      
    00,166,14,00,16,39,00,00
  );  
  constant SoftwareVer      : byte_array(0 to 44) := (
    65,108,98,101,114,116,111,32,83,97,110,116,111,115,
    32,45,32,82,73,84,32,67,69,32,71,114,97,100,
    117,97,116,101,32,80,114,111,106,101,99,116,32,50,
    48,49,55
    );
    
  file output_file    : pic_file; --open READ_MODE is filename_out;
  
begin
  
  -- writing the data in binary file
  file_open(output_file,output_filename,WRITE_MODE);
  
  for i in tiff_header' range loop
    write(output_file, character'val(tiff_header(i)));  
  end loop;
  
  for i in ImageFileDirectory' range loop
    write(output_file, character'val(ImageFileDirectory(i)));  
  end loop;

  for i in bitsPerSample' range loop
    write(output_file, character'val(bitsPerSample(i)));  
  end loop;
  
  for i in SoftwareVer' range loop
    write(output_file, character'val(SoftwareVer(i)));  
  end loop;
  
  for i in XYResolution' range loop
    write(output_file, character'val(XYResolution(i)));  
  end loop;
  
  for i in input_vector' range loop
    write(output_file, character'val(input_vector(i)));  
  end loop;

  file_close(output_file);
end save_tiff_image_640x480;

procedure image_negative(signal input_vector: in picture_vector; signal output_vector: out picture_vector) is
variable temp_logic_vector  : std_logic_vector(7 downto 0);
variable temp_int    : integer;

begin
  for i in input_vector' range loop
    temp_logic_vector     := conv_std_logic_vector(input_vector(i),8);
    temp_logic_vector     := not temp_logic_vector;
    temp_int              := conv_integer(unsigned(temp_logic_vector));
    output_vector(i)      <= temp_int;
  end loop;
  wait for 20 ns;
end image_negative;

procedure red_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector) is
begin
  for i in input_vector' range loop
    if(i mod 3 = 0) then
      output_vector(i)    <= input_vector(i);          
    else 
      output_vector(i)    <= 0;          
    end if;
  end loop;
end red_components;

procedure green_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector) is
begin
  for i in input_vector' range loop
    if(i mod 3 = 1) then
      output_vector(i)    <= input_vector(i);          
    else 
      output_vector(i)    <= 0;          
    end if;
  end loop;
end green_components;

procedure blue_components(signal input_vector: in picture_vector; signal output_vector: out picture_vector) is
begin
  for i in input_vector' range loop
    if(i mod 3 = 2) then
      output_vector(i)    <= input_vector(i);          
    else 
      output_vector(i)    <= 0;          
    end if;
  end loop;
end blue_components;

procedure rgb_filter(signal input_vector: in picture_vector; 
                     signal output_vector: out picture_vector; 
                     signal rlow: in std_logic_vector(7 downto 0); 
                     signal rhigh: in std_logic_vector(7 downto 0) ;
                     signal glow: in std_logic_vector(7 downto 0); 
                     signal ghigh: in std_logic_vector(7 downto 0); 
                     signal blow: in std_logic_vector(7 downto 0); 
                     signal bhigh: in std_logic_vector(7 downto 0)) is
                     
variable temp_logic_vector  : std_logic_vector(7 downto 0);
begin
  for i in input_vector' range loop
    temp_logic_vector   := conv_std_logic_vector(input_vector(i),8);
    if(i mod 3 = 0) then
      -- red
      if (temp_logic_vector > rlow) and (temp_logic_vector < rhigh) then
        output_vector(i)    <= input_vector(i);
      else
        output_vector(i)    <= 0;  
      end if;
    elsif(i mod 3 = 1) then
      -- green
      if (temp_logic_vector > glow) and (temp_logic_vector < ghigh) then
        output_vector(i)    <= input_vector(i);
      else
        output_vector(i)    <= 0;  
      end if;
    else 
      -- blue
      if (temp_logic_vector > blow) and (temp_logic_vector < bhigh) then
        output_vector(i)    <= input_vector(i);
      else
        output_vector(i)    <= 0;  
      end if;
    end if;
  end loop;
end rgb_filter;

end package body;