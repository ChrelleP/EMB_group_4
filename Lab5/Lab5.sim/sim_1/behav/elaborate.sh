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
ExecStep $xv_path/bin/xelab -wto 27c24bec4d55472c96ce9950807f9156 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot ClockInverter_behav xil_defaultlib.ClockInverter -log elaborate.log
