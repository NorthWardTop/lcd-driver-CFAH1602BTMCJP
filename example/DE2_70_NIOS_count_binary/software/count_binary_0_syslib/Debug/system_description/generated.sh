#!/bin/sh
#
# generated.sh - shell script fragment - not very useful on its own
#
# Machine generated for a CPU named "cpu" as defined in:
# d:\0Clare\DE2-70\Q80\DE2_70_NIOS_count_binary\software\count_binary_0_syslib\..\..\nios_ii.ptf
#
# Generated: 2008-10-21 15:18:48.953

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# This variable indicates where the PTF file for this design is located
ptf=d:\0Clare\DE2-70\Q80\DE2_70_NIOS_count_binary\software\count_binary_0_syslib\..\..\nios_ii.ptf

# This variable indicates whether there is a CPU debug core
nios2_debug_core=yes

# This variable indicates how to connect to the CPU debug core
nios2_instance=0

# This variable indicates the CPU module name
nios2_cpu_name=cpu

# These variables indicate what the System ID peripheral should hold
sidp=0x096051d0
id=1114575596u
timestamp=1224570194u

# Include operating system specific parameters, if they are supplied.

if test -f /cygdrive/c/altera/80/nios2eds/components/altera_hal/build/os.sh ; then
   . /cygdrive/c/altera/80/nios2eds/components/altera_hal/build/os.sh
fi
