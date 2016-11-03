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
ExecStep $xv_path/bin/xelab -wto 7d5182fbcb694f36a995dbac27761712 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot debounce_behav xil_defaultlib.debounce -log elaborate.log
