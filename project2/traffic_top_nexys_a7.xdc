set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -name sys_clk -period 10.000 [get_ports clk]

set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports rst]
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports ped_button]

set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports ew_red]
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports ew_yellow]
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports ew_green]
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports ns_red]
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports ns_yellow]
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports ns_green]
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports ped_walk]
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports ped_stop]
