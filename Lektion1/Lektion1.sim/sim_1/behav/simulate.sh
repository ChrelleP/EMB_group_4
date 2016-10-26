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
ExecStep $xv_path/bin/xsim Guide_EMB1_behav -key {Behavioral:sim_1:Functional:Guide_EMB1} -tclbatch Guide_EMB1.tcl -view /home/exchizz/SDU/Skole/7.Semester/EMB1/VHDL/EMB_group_4/Lektion1/EMB_guide_design_wrapper_behav.wcfg -log simulate.log
