connect -url tcp:127.0.0.1:3121
source /home/exchizz/SDU/Skole/7.Semester/EMB1/VHDL/EMB_group_4/Lektion7/Lektion7.sdk/Lektion7./design_1_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "JTAG-ONB4 2516330009BEA"} -index 0
loadhw /home/exchizz/SDU/Skole/7.Semester/EMB1/VHDL/EMB_group_4/Lektion7/Lektion7.sdk/Lektion7./design_1_wrapper_hw_platform_0/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "JTAG-ONB4 2516330009BEA"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 2516330009BEA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 2516330009BEA"} -index 0
dow /home/exchizz/SDU/Skole/7.Semester/EMB1/VHDL/EMB_group_4/Lektion7/Lektion7.sdk/Lektion7./TestSDK1/Debug/TestSDK1.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 2516330009BEA"} -index 0
con
