#!/bin/sh
# ------------------------------------------------------------------------------
# build-rootfs.sh - download and configure a minimal rootfs for ev3dev
#
# Must be run as root (use sudo of course!)
# ------------------------------------------------------------------------------

error_out () {
    echo "$1"
    exit 1
}

if [ "$(whoami)" != "root" ]; then
	error_out "Sorry, you are not root."
fi

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C LANGUAGE=C LANG=C

TARGET_ROOTFS_DIR="ev3-rootfs"

# ------------------------------------------------------------------------------
# Make sure were running at the same level as a directory called ev3dev so
# that our directory structure is maintained!

if [ ! -d ../ev3dev ]; then
	error_out "Not running at same directory level as ev3dev"
fi

if [ ! -d ../ev3dev-rootfs ]; then
	error_out "You need to create or clone ../ev3dev-rootfs first"
fi

# ------------------------------------------------------------------------------
# Download the bare ev3-rootfs directory if we don't already have it

cd ../ev3dev-rootfs

if [ ! -d ${TARGET_ROOTFS_DIR} ]; then
    echo    "-------------------------------------------------------------------------------"
    echo    " Downloading a complete grip rootfs from emDebian - this might take a while"
    echo    " so you might want to tail the multistrap.log file from another shell to keep"
    echo    " track of progress ... "
    echo    ""
    echo -n "    Type \"Yes\" to continue, anything else to skip ... "
    read YesNo

    if [ "${YesNo}" = "Yes" ]; then
#       multistrap -f multistrap.conf > multistrap.log 2>&1
        multistrap -f ../ev3dev/multistrap.conf 

        echo    "Done"
        echo    "-------------------------------------------------------------------------------"
    fi
else
    echo    " Checking for existing ev3-rootfs - already exists!"
fi

cd ${OLDPWD}

# ------------------------------------------------------------------------------
# Configuring the rootfs

cd ../ev3dev-rootfs

    echo    "-------------------------------------------------------------------------------"
    echo    " This step will configure the rootfs - it will take a while and overwrite"
    echo    " any customizations you have done!"
    echo    ""
    echo -n "    Type \"Yes\" to continue, anything else to skip ... "
    read YesNo


    if [ "${YesNo}" = "Yes" ]; then

        if [ ! -e ${TARGET_ROOTFS_DIR}/usr/bin/qemu-arm-static ]; then
            echo -n "    Copying qemu-arm-static to ev3-rootfs/usr/bin ... "
            cp /usr/bin/qemu-arm-static ${TARGET_ROOTFS_DIR}/usr/bin 
            echo    " Done"
        fi

        echo -n "    Running the dash.preinst file in ev3-rootfs ... "
        chroot ${TARGET_ROOTFS_DIR} var/lib/dpkg/info/dash.preinst install > /dev/null
        echo "Done"
    
        echo    "    Configuring packages in ev3-rootfs - this will take a while!"
        chroot ${TARGET_ROOTFS_DIR} dpkg --configure -a

        # mount proc -t proc /proc
        # dpkg --configure -a
    fi

cd ${OLDPWD}

# ------------------------------------------------------------------------------
# Set root password and add users

cd ../ev3dev-rootfs

    echo    "-------------------------------------------------------------------------------"
    echo    " This step will set the root password and add the default ev3dev user to the"
    echo    " sudoer group"
    echo    ""
    echo -n "    Type \"Yes\" to continue, anything else to skip ... "
    read YesNo


    if [ "${YesNo}" = "Yes" ]; then

       echo -n "    Setting the root password ... "
       chroot ev3-rootfs passwd 

       echo -n "    Adding the ev3dev user ... "
       chroot ${TARGET_ROOTFS_DIR} useradd -m -G sudo,plugdev ev3dev
       chroot ${TARGET_ROOTFS_DIR} usermod -s /bin/bash       ev3dev

       # Additional groups we'll add later...
       # ,netdev,audio,video,ssh

       echo -n "    Setting the ev3dev password ... "
       chroot ev3-rootfs passwd ev3dev
    fi

cd ${OLDPWD}

# ------------------------------------------------------------------------------
# Clean out the apt-cache -no sense keeping it around if we've already
# installed the files!

cd ../ev3dev-rootfs

    echo    "-------------------------------------------------------------------------------"
    echo    " Purging unneeded files from the apt-cache..."

    chroot ev3-rootfs apt-get purge
    chroot ev3-rootfs apt-get clean

    chroot ev3-rootfs rm -r    /var/lib/apt/lists
    chroot ev3-rootfs mkdir -p /var/lib/apt/lists/partial

    echo    " done"

cd ${OLDPWD}

# ------------------------------------------------------------------------------
# Customizing the rootfs

cd ../ev3dev-rootfs

#Directories used to mount microSD partitions 
for media_dir in "mmc_p1" "data"
do
    if [ ! -d ${TARGET_ROOTFS_DIR}/media/${media_dir} ]; then
        echo -n "    Creating mount directories ... "
        mkdir ${TARGET_ROOTFS_DIR}/media/${media_dir}
        echo    "    done"
    fi
done

#Set the target board hostname
filename="${TARGET_ROOTFS_DIR}/etc/hostname"

    if [ ! -d "${filename}" ]; then
        echo -n "    Creating "${filename}" ... "

        echo "ev3dev" > "${filename}"

        echo    "done"
    fi

#Set the default name server - use Google's DNS for now...
filename="${TARGET_ROOTFS_DIR}/etc/resolv.conf"

    if [ ! -d "${filename}" ]; then
        echo -n "    Creating "${filename}" ... "

        echo "nameserver 8.8.8.8"  > "${filename}"
        echo "nameserver 8.8.8.4" >> "${filename}"

        echo    "done"
    fi

#Set the default network interfaces including wireless
filename="${TARGET_ROOTFS_DIR}/etc/network/interfaces"

    if [ ! -d "${filename}" ]; then
        echo -n "    Creating "${filename}" ... "

        echo "auto lo"                            > $filename
        echo "iface lo inet loopback"            >> $filename
        echo ""                                  >> $filename
        echo "allow-hotplug eth0"                >> $filename
        echo "iface eth0 inet dhcp"              >> $filename
        echo "hwaddress ether 00:04:25:12:34:56" >> $filename
        echo ""                                  >> $filename
        echo "auto wlan0"                        >> $filename
        echo "iface wlan0 inet dhcp"             >> $filename

        echo    "done"
    fi

#Set a terminal to the debug port
filename="${TARGET_ROOTFS_DIR}/etc/inittab"

        echo -n "    Updating "${filename}" ... "

        sed -n -i -e "/^T0:2345:respawn:\/sbin\/getty -L ttyS1 115200 vt100/ d" \
                  -e "p"                                                        \
                     "${filename}"

        echo "T0:2345:respawn:/sbin/getty -L ttyS1 115200 vt100" >> "${filename}"

        echo    "done"

#Set how to mount the microSD partitions
filename="${TARGET_ROOTFS_DIR}/etc/fstab"

        echo -n "    Updating "${filename}" ... "

        echo "/dev/mmcblk0p1 /media/mmc_p1 vfat noatime  0 0"  > ${filename}
        echo "/dev/mmcblk0p2 /             ext3 noatime  0 0" >> ${filename}
        echo "proc           /proc         proc defaults 0 0" >> ${filename}

        echo    "done"

#Set up wpa_supplicant.conf - add your own keys here!!!
filename="${TARGET_ROOTFS_DIR}/etc/wpa_supplicant.conf"

        echo -n "    Updating "${filename}" ... "

        echo "ctrl_interface=/var/run/wpa_supplicant"   > ${filename}
        echo "#ap_scan=2"                              >> ${filename}
        echo ""                                        >> ${filename}
        echo "network={"                               >> ${filename}
        echo "       ssid=\"Your SSID Here\""          >> ${filename}
        echo "       scan_ssid=1"                      >> ${filename}
        echo "       proto=WPA RSN"                    >> ${filename}
        echo "       key_mgmt=WPA-PSK"                 >> ${filename}
        echo "       pairwise=CCMP TKIP"               >> ${filename}
        echo "       group=CCMP TKIP"                  >> ${filename}
        echo "       psk=\"Your text key here\""       >> ${filename}
        echo "}"                                       >> ${filename}

        echo    "done"

cd ${OLDPWD}

# ------------------------------------------------------------------------------
# Create the custom issue

cd ../ev3dev-rootfs

filename="${TARGET_ROOTFS_DIR}/etc/issue"

        echo -n "    Creating "${filename}" ... "

        echo "             _____     _"                                        > "${filename}"
        echo "   _____   _|___ /  __| | _____   __"                           >> "${filename}"
        echo "  / _ \\\\\\ \\\\\\ / / |_ \\\\\\ / _\` |/ _ \\\\\\ \\\\\\ / /" >> "${filename}"
        echo " |  __/\\\\\\ V / ___) | (_| |  __/\\\\\\ V / "                 >> "${filename}"
        echo "  \\\\\\___| \\\\\\_/ |____/ \\\\\\__,_|\\\\\\___| \\\\\\_/  "  >> "${filename}"
        echo ""                                                               >> "${filename}"
        echo "Debian GNU/Linux 7 on LEGO MINDSTORMS EV3! \\\\n \\\\l"         >> "${filename}"

        echo    "done"
exit

echo "-------------------------------------------------------------------------------"
exit
