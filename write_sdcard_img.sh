#!/bin/sh
# ------------------------------------------------------------------------------
# write_sdcard_img - uncompresses the img.gz file to a .img file and then
#                    writes the raw SD Card data
#
# Requires a udev rule that creates a device symlink at /dev/ev3dev
# ------------------------------------------------------------------------------

error_out () {
    echo "$1"
    exit 1
}

if [ "$(whoami)" != "root" ]; then
	error_out "Sorry, you are not root."
fi

if [ ! -e /dev/ev3dev ]; then
    error_out "Error - /dev/ev3dev does not exist - have you set up the udev rules to create it?\n"
fi

# ------------------------------------------------------------------------------

device=$(readlink /dev/ev3dev)

umount "/dev/${device}1"
umount "/dev/${device}2"
umount "/dev/${device}"

sleep 1

echo "-------------------------------------------------------------------------------"
echo "WARNING - If you type \"Yes\" to the prompt, this script"
echo "          will OVERWRITE the existing ev3dev.img file on the hard drive and"
echo "          will OVERWRITE any data on the /dev/ev3dev SD Card"
echo "-------------------------------------------------------------------------------"
echo

echo -n "   Type \"Yes\" to continue ... "
read YesNo

if [ ! "${YesNo}" = "Yes" ]; then
    error_out "\n    .. aborting, you typed \"${YesNo}\""
fi

# ------------------------------------------------------------------------------
# Unzip the raw SD Card image

cd ../ev3dev-rootfs

echo -n "   gunzipping the raw SD Card image - should take about 2 minutes..."

gunzip -k ev3dev.img.gz

echo " done."

echo    "   Writing the raw SD Card image - should take about 5 minutes..."

dd bs=4M if=ev3dev.img of=/dev/ev3dev

if [ $? -gt 0 ]; then
    error_out "   SD Card image write failed"
else
    echo " done."
fi

echo " done."

cd ${OLDPWD}

echo "-------------------------------------------------------------------------------"
exit
