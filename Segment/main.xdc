# Clock (clk)
set_property PACKAGE_PIN E3 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# Buttons (BTNL, BTNR, BTNU, BTND, BTNC)
set_property PACKAGE_PIN P17 [get_ports {buttons[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[0]}]

set_property PACKAGE_PIN M17 [get_ports {buttons[1]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[1]}]

set_property PACKAGE_PIN M18 [get_ports {buttons[2]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[2]}]

set_property PACKAGE_PIN P18 [get_ports {buttons[3]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[3]}]

set_property PACKAGE_PIN N17 [get_ports {buttons[4]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[4]}]

# Seven Segment Display (segment_display[0] ~ segment_display[7])
set_property PACKAGE_PIN T10 [get_ports {segment_display[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[0]}]

set_property PACKAGE_PIN R10 [get_ports {segment_display[1]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[1]}]

set_property PACKAGE_PIN K16 [get_ports {segment_display[2]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[2]}]

set_property PACKAGE_PIN K13 [get_ports {segment_display[3]}]   
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[3]}]

set_property PACKAGE_PIN P15 [get_ports {segment_display[4]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[4]}]

set_property PACKAGE_PIN T11 [get_ports {segment_display[5]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[5]}]

set_property PACKAGE_PIN L18 [get_ports {segment_display[6]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[6]}]

set_property PACKAGE_PIN H15 [get_ports {segment_display[7]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {segment_display[7]}]

# Digit Enable (digit_enable[0] ~ digit_enable[7])
set_property PACKAGE_PIN U13 [get_ports {digit_enable[0]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[0]}]

set_property PACKAGE_PIN K2 [get_ports {digit_enable[1]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[1]}]

set_property PACKAGE_PIN T14 [get_ports {digit_enable[2]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[2]}]

set_property PACKAGE_PIN P14 [get_ports {digit_enable[3]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[3]}]

set_property PACKAGE_PIN J14 [get_ports {digit_enable[4]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[4]}]

set_property PACKAGE_PIN T9 [get_ports {digit_enable[5]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[5]}]

set_property PACKAGE_PIN J18 [get_ports {digit_enable[6]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[6]}]

set_property PACKAGE_PIN J17 [get_ports {digit_enable[7]}]  
set_property IOSTANDARD LVCMOS33 [get_ports {digit_enable[7]}]
