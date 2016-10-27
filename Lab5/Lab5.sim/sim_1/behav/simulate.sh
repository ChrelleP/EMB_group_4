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
ExecStep $xv_path/bin/xsim ClockInverter_behav -key {Behavioral:sim_1:Functional:ClockInverter} -tclbatch ClockInverter.tcl -log simulate.log
