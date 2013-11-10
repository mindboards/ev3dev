#!/bin/sh
#******************************************************************************************************************
#     COMPILE KERNEL
#******************************************************************************************************************
# as normal user on linux pc terminal:

echo
echo -------------------------------------------------------------------------------
echo BUILDING KCONFIG
echo -------------------------------------------------------------------------------
echo
sleep 1

project=`pwd`

echo ${project}

. ./env_setup.sh

echo ${AM1808_COMPILER}

PATH=${AM1808_COMPILER}:$PATH

echo ${PATH}
 
cd "${AM1808_KERNEL}"

echo "Now we're in $(pwd)"

cp ${project}/ev3dev.config ${AM1808_KERNEL}/.config

echo "BUILDING KCONFIG"

make ARCH=arm CROSS_COMPILE=${AM1808_ABI} menuconfig

echo "COPYING .config BACK"

cp ${AM1808_KERNEL}/.config ${project}/ev3dev.config.new 


