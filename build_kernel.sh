#!/bin/sh
#******************************************************************************************************************
#     COMPILE KERNEL
#******************************************************************************************************************
# as normal user on linux pc terminal:

echo
echo -------------------------------------------------------------------------------
echo BUILDING KERNEL
echo -------------------------------------------------------------------------------
echo
sleep 1

project=`pwd`

echo ${project}

. ./env_setup.sh

echo ${AM1808_COMPILER}

PATH=${AM1808_COMPILER}:$PATH
# PATH=${AM1808_UBOOT_DIR}/tools:$PATH

echo ${PATH}
 
cd ${AM1808_KERNEL}

echo "Now we're in $(pwd)"

arm-none-eabi-gcc -v

if [ "$1" = "clean" ]
then
  make distclean ARCH=arm CROSS_COMPILE=${AM1808_ABI}
fi

cp ${project}/ev3dev.config ${AM1808_KERNEL}/.config

echo "CROSS COMPILING KERNEL"

make ARCH=arm CROSS_COMPILE=${AM1808_ABI}

echo "BUILDING BOOTABLE IMAGE"

make -j4 uImage ARCH=arm CROSS_COMPILE=${AM1808_ABI}

echo "COPYING BOOTABLE IMAGE TO LOCAL DIRECTORY"

cp ${AM1808_KERNEL}/arch/arm/boot/uImage ${project}/uImage


