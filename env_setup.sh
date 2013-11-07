#!/bin/sh
#******************************************************************************************************************
#     ENVIRONMENT SETUP
#******************************************************************************************************************
# as normal user on linux pc terminal:

export AM1808_COMPILER="${project}/../bin/arm-2011.03/bin"

export LEGO_AM1808_DISTRO="lego-DaVinci-PSP-SDK-03.20.00.13"
export LEGO_AM1808_DISTRO="lego-DaVinci-PSP-SDK-03.20.00.13"
export LEGO_AM1808_LINUX="linux-03.20.00.13"
export LEGO_AM1808_UBOOT="uboot-03.20.00.13"
export LEGO_AM1808_ABI="arm-none-eabi-"

export LEGO_AM1808_KERNEL="/opt/${LEGO_AM1808_DISTRO}/src/kernel/${LEGO_AM1808_LINUX}"

export EV3DEV_AM1808_ROOT="${project}"
export EV3DEV_AM1808_DISTRO=".."
export EV3DEV_AM1808_LINUX="ev3dev-kernel"
# export EV3DEV_AM1808_UBOOT=uboot-03.22.00.02
export EV3DEV_AM1808_ABI="arm-none-eabi-"

export AM1808_ROOT="${EV3DEV_AM1808_ROOT}"
export AM1808_DISTRO="${EV3DEV_AM1808_DISTRO}"
export AM1808_LINUX="${EV3DEV_AM1808_LINUX}"
# export AM1808_UBOOT=${EV3DEV_AM1808_UBOOT}"
export AM1808_ABI="${EV3DEV_AM1808_ABI}"

# export AM1808_UBOOT_DIR=/opt/${AM1808_DISTRO}/src/u-boot/${AM1808_UBOOT}
export AM1808_KERNEL="${EV3DEV_AM1808_ROOT}/${AM1808_DISTRO}/${AM1808_LINUX}"

#export AM1808_MODULES=~/projects/lms2012/lms2012/Linux_AM1808/sys/mod

#export X86_KERNEL=/lib/modules/$(uname -r)/build
#export X86_MODULES=~/projects/lms2012/lms2012/Linux_X86/sys/mod
