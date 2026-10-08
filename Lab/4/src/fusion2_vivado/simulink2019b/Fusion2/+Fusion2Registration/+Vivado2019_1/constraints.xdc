### JB1.36 (IO_L12N_T1_MRCC_34)
set_property PACKAGE_PIN    U19         [get_ports led]
set_property IOSTANDARD     LVCMOS33    [get_ports led]

### BMI088 IMU1
### JB1.35 (IO_L11P_T1_SRCC_34)
set_property PACKAGE_PIN    U14         [get_ports i2c0_sda_io]   
set_property IOSTANDARD     LVCMOS33    [get_ports i2c0_sda_io]

### JB1.37 (IO_L11N_T1_SRCC_34)
set_property PACKAGE_PIN    U15         [get_ports i2c0_scl_io]   
set_property IOSTANDARD     LVCMOS33    [get_ports i2c0_scl_io]

### CAM ####
### JB2.13 (IO_L20N_T3_34)
set_property PACKAGE_PIN    R18         [get_ports i2c0_scl_io]
set_property IOSTANDARD     LVCMOS33    [get_ports i2c0_scl_io]

### JB2.11 (IO_L20P_T3_34)
set_property PACKAGE_PIN    T17         [get_ports i2c0_sda_io]
set_property IOSTANDARD     LVCMOS33    [get_ports i2c0_sda_io]

### JB2.24 (IO_L18N_T2_34)
set_property PACKAGE_PIN    W16         [get_ports cam_xclk]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_xclk]
set_property DRIVE          16          [get_ports cam_xclk]
set_property SLEW           "FAST"      [get_ports cam_xclk]

### JB2.29 (IO_L16P_T2_34)
set_property PACKAGE_PIN    V20         [get_ports cam_rst]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_rst]

### JB2.35 (IO_L14P_T2_SRCC_34)
set_property PACKAGE_PIN    N20         [get_ports cam_pdwn]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_pdwn]

### JB2.26 (IO_L18P_T2_34)
set_property PACKAGE_PIN    V16         [get_ports cam_pclk]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_pclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk_IBUF] 

### JB2.5 (IO_L23P_T3_34)
set_property PACKAGE_PIN    N17         [get_ports cam_vsync]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_vsync]

### JB2.6 (IO_L24N_T3_34)
set_property PACKAGE_PIN    P16         [get_ports cam_href]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_href]

# pointing cam0 to cam2 and cam7 to cam9
### JB2.36 (IO_L13N_T2_MRCC_34)
set_property PACKAGE_PIN    P19         [get_ports {cam_d[0]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[0]}]

### JB2.38 (IO_L13P_T2_MRCC_34)
set_property PACKAGE_PIN    N18         [get_ports {cam_d[1]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[1]}]

### JB2.37 (IO_L14N_T2_SRCC_34)
set_property PACKAGE_PIN    P20         [get_ports {cam_d[2]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[2]}]

### JB2.20 (IO_L22P_T3_34)
set_property PACKAGE_PIN    W18         [get_ports {cam_d[3]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[3]}]

### JB2.18 (IO_L22N_T3_34)
set_property PACKAGE_PIN    W19         [get_ports {cam_d[4]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[4]}]

### JB2.14 (IO_L19P_T3_34)
set_property PACKAGE_PIN    R16         [get_ports {cam_d[5]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[5]}]

### JB2.12 (IO_L19N_T3_VREF_34)
set_property PACKAGE_PIN    R17         [get_ports {cam_d[6]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[6]}]

### JB2.8 (IO_L24P_T3_34)
set_property PACKAGE_PIN    P15         [get_ports {cam_d[7]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d[7]}]

### JB2.7 (IO_L23N_T3_34)
set_property PACKAGE_PIN    P18         [get_ports {cam_trigger}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_trigger}]


### CAM2 ####
### JA2.13 (IO_L23N_T3_35)
set_property PACKAGE_PIN    M15         [get_ports i2c1_scl_io]
set_property IOSTANDARD     LVCMOS33    [get_ports i2c1_scl_io]

### JA2.11 (IO_L23P_T3_35)
set_property PACKAGE_PIN    M14         [get_ports i2c1_sda_io]
set_property IOSTANDARD     LVCMOS33    [get_ports i2c1_sda_io]

### JA2.24 (IO_L10N_T1_AD11N_35)
set_property PACKAGE_PIN    J19         [get_ports cam_xclk1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_xclk1]
set_property DRIVE          16          [get_ports cam_xclk1]
set_property SLEW           "FAST"      [get_ports cam_xclk1]

### JA2.29 (IO_L8P_T1_AD10P_35)
set_property PACKAGE_PIN    M17         [get_ports cam_rst1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_rst1]

### JA2.35 (IO_L11P_T1_SRCC_35)
set_property PACKAGE_PIN    L16         [get_ports cam_pdwn1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_pdwn1]

### JA2.26 (IO_L10P_T1_AD11P_35)
set_property PACKAGE_PIN    K19         [get_ports cam_pclk1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_pclk1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk1_IBUF] 

### JA2.5 (IO_L22P_T3_AD7P_35)
set_property PACKAGE_PIN    L14         [get_ports cam_vsync1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_vsync1]

### JA2.6 (IO_L24N_T3_AD15N_35)
set_property PACKAGE_PIN    J16         [get_ports cam_href1]
set_property IOSTANDARD     LVCMOS33    [get_ports cam_href1]

# pointing cam0 to cam2 and cam7 to cam9
### JA2.30 (IO_L7N_T1_AD2N_35)
#set_property PACKAGE_PIN    M20         [get_ports {cam_d1[0]}]
#set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[0]}]

### JA2.32 (IO_L7P_T1_AD2P_35)
#set_property PACKAGE_PIN    M19         [get_ports {cam_d1[1]}]
#set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[1]}]

### JA2.36 (IO_L12N_T1_MRCC_35)
set_property PACKAGE_PIN    K18         [get_ports {cam_d1[0]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[0]}]

### JA2.38 (IO_L12P_T1_MRCC_35)
set_property PACKAGE_PIN    K17         [get_ports {cam_d1[1]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[1]}]

### JA2.37 (IO_L11N_T1_SRCC_35)
set_property PACKAGE_PIN    L17         [get_ports {cam_d1[2]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[2]}]

### JA2.20 (IO_L20P_T3_AD6P_35)
set_property PACKAGE_PIN    K14         [get_ports {cam_d1[3]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[3]}]

### JA2.18 (IO_L20N_T3_AD6N_35)
set_property PACKAGE_PIN    J14         [get_ports {cam_d1[4]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[4]}]

### JA2.14 (IO_L19P_T3_35)
set_property PACKAGE_PIN    H15         [get_ports {cam_d1[5]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[5]}]

### JA2.12 (IO_L19N_T3_VREF_35)
set_property PACKAGE_PIN    G15         [get_ports {cam_d1[6]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[6]}]

### JA2.8 (IO_L24P_T3_AD15P_35)
set_property PACKAGE_PIN    K16         [get_ports {cam_d1[7]}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_d1[7]}]

### JA2.7 (IO_L22N_T3_AD7N_35)
#set_property PACKAGE_PIN    L15         [get_ports {cam_trigger1}]
#set_property IOSTANDARD     LVCMOS33    [get_ports {cam_trigger1}]

### JA2.7 (IO_L22N_T3_AD7N_35)
set_property PACKAGE_PIN    L15         [get_ports {cam_trigger1}]
set_property IOSTANDARD     LVCMOS33    [get_ports {cam_trigger1}]