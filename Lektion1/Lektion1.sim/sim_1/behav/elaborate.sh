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
ExecStep $xv_path/bin/xelab -wto 12f0ac0d60ac4f39b7c8f77583e3bcad -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot Guide_EMB1_behav xil_defaultlib.Guide_EMB1 -log elaborate.log
