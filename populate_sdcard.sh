#!/bin/sh
# ------------------------------------------------------------------------------
# populate_sdcard.sh - puts uImage on the FAT32 partition
#                    - puts target-rootfs on the ext3 partition
#
# Requires a udev rule that creates a device symlink at /dev/ev3dev
#
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

echo "-------------------------------------------------------------------------------"
echo "WARNING - If you type \"Yes\" to the prompt, this script"
echo "          will OVERWRITE everything on the /dev/ev3dev card!!!"
echo "-------------------------------------------------------------------------------"
echo

echo -n "    Type \"Yes\" to continue ... "
read YesNo

if [ ! "${YesNo}" = "Yes" ]; then
    error_out "\n    .. aborting, you typed \"${YesNo}\""
fi

# ------------------------------------------------------------------------------
# Create the mount points for the ev3dev card partitions if they do not already
# exist...

for file in "LMS2012" "LMS2012_EXT"
do
    if [ ! -d "./${file}" ]; then
        echo -n "    Creating local mount point for ${file} ... "
        mkdir "./${file}"
        echo    " done."
    fi
done

if [ -d "./LMS2012" ]; then
    echo -n "    Mounting /dev/ev3dev_1 at LMS2012 ... "
    umount LMS2012
    sleep 1
    mount -t vfat /dev/ev3dev_1 LMS2012
    sleep 2
    echo    " done."

    echo -n "    copying uImage to LMS2012 ... "
    cp      "./uImage" ./LMS2012
    echo    " done."
fi 

if [ -d "./LMS2012_EXT" ]; then
    echo -n "    Mounting /dev/ev3dev_2 at LMS2012_EXT ... "
    umount LMS2012_EXT
    sleep 1
    mount -t ext3 /dev/ev3dev_2 LMS2012_EXT
    sleep 2
    echo    " done."

    echo -n "    copying target_rootfs to LMS2012_EXT ... "
    cp -pR "../ev3dev-rootfs/ev3-rootfs/." ./LMS2012_EXT/
    echo    " done."
fi 

echo "-------------------------------------------------------------------------------"
echo " Even though the copy command completes - the OS will continue writing"
echo " buffered data to the SD Card. Try to umount /dev/ev3dev_2 and when that"
echo " command completes, you know the write has completed"


echo "-------------------------------------------------------------------------------"
exit
