#!/bin/sh
#******************************************************************************************************************
#     COMPILE KERNEL
#******************************************************************************************************************
# as normal user on linux pc terminal:

echo
echo -------------------------------------------------------------------------------
echo BUILDING MODULES
echo -------------------------------------------------------------------------------
echo
sleep 1

project=`pwd`

echo ${project}

. ./env_setup.sh

echo ${AM1808_COMPILER}
echo ${AM1808_KERNEL}

PATH=${AM1808_COMPILER}:$PATH

echo ${PATH}

if [ ! -e modules ]; then
  mkdir -p ./modules
fi

for module in "d_ui" "d_pwm" 
# for module in "d_pwm" 
do 
    cd ../ev3dev-modules/lms2012/${module}/Linuxmod_AM1808
    echo "Now we're in $(pwd)"
    make -C ${AM1808_KERNEL} MOD=${module} M=`pwd` ARCH=arm CROSS_COMPILE=${AM1808_ABI}
    cd ${project}
    cp ../ev3dev-modules/lms2012/${module}/Linuxmod_AM1808/*.ko ./modules
done

# cp $1.ko $AM1808_MODULES/$1.ko

