#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2016.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim debounce_behav -key {Behavioral:sim_1:Functional:debounce} -tclbatch debounce.tcl -view /home/exchizz/SDU/Skole/7.Semester/EMB1/VHDL/EMB_group_4/Lektion7/rotary_encoder_behav.wcfg -log simulate.log
