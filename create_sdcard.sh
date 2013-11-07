#!/bin/sh
# ------------------------------------------------------------------------------
# create_sdcard.sh - repartitions and formats an SD card for use with the
#                    LEGO MINDSTORMS EV3
#
# Requires a udev rule that creates a device symlink at /dev/ev3dev
#
# Repartitions the SD card with a 50 MB FAT32 partition to hold the u-boot
# compatible uImage file, and the rest for the root filesystem
#
# Here's a link to a page that describes the optimal alignment issue:
#
# http://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/
# http://h10025.www1.hp.com/ewfrf/wc/document?cc=uk&lc=en&dlc=en&docname=c03479326#
#
# Added a feature to completely zero out the SD Card - useful for when you
# want to build an image file that's not pulluted by all kinds of cruft
# left over from when the card was in your phone or camera :-)
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

sleep 1

sector_size=$(cat /sys/block/${device}/queue/physical_block_size)
sectors=$(cat /sys/block/${device}/size)

part1_start=$((1))
part1_end=$((((48 * 1024 * 1024) / ${sector_size}) - 1 ))
part2_start=$((((48 * 1024 * 1024) / ${sector_size})     ))
part2_end=$((((${sectors}-1 ))))

echo "-------------------------------------------------------------------------------"
echo "WARNING - If you type \"Yes\" to the prompt, this script"
echo "          will DELETE everything on the /dev/ev3dev card!!!"
echo "-------------------------------------------------------------------------------"
echo

echo -n "   Type \"Yes\" to continue ... "
read YesNo

if [ ! "${YesNo}" = "Yes" ]; then
    error_out "\n    .. aborting, you typed \"${YesNo}\""
fi

# ------------------------------------------------------------------------------
# Repartition /dev/ev3dev

echo -n "   Creating new disk label for /dev/ev3dev ..."
parted -s --align minimal /dev/ev3dev mklabel msdos                                      \
                                      mkpart primary fat32 ${part1_start}s ${part1_end}s \
                                      mkpart primary ext3  ${part2_start}s ${part2_end}s

if [ $? -gt 0 ]; then
    error_out "   Can't create disklabel - is the SD Card automounted?"
else
    echo " done."
fi

echo -n "   Retriggering usev rules for /dev/ev3dev ..."
udevadm trigger --action=add --sysname-match=${device}*
sleep 1
echo " done."

# ------------------------------------------------------------------------------
# Completely erase (fill with 0's) the SD Card

echo    "   Displaying new partition table for /dev/ev3dev ...\n"
parted /dev/${device} print

echo    "   Filling the first partition with 0's, should take a few seconds..."

dd bs=4M if=/dev/zero of=/dev/ev3dev_1

echo    "   Filling the second partition with 0's, should take about 5 minutes..."

dd bs=4M if=/dev/zero of=/dev/ev3dev_2

echo    "   done"

echo -n "   Retriggering usev rules for /dev/ev3dev ..."
udevadm trigger --action=add --sysname-match=${device}*
sleep 1
echo " done."

# ------------------------------------------------------------------------------
# Now build up the file systems

echo "   Displaying new partition table for /dev/ev3dev ...\n"
parted /dev/${device} print

echo -n "   Creating FAT32 filesystem on /dev/ev3dev_1 ..."
mkfs.msdos -n LMS2012 /dev/ev3dev_1

echo -n "   Creating ext3 filesystem on /dev/ev3dev_2 ..."
mkfs.ext3 -L LMS2012_EXT /dev/ev3dev_2 > /dev/null

echo -n "   Retriggering usev rules for /dev/ev3dev ..."
udevadm trigger --action=add --sysname-match=${device}*
sleep 1
echo " done."

echo "-------------------------------------------------------------------------------"
exit
