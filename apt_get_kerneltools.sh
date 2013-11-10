#!/bin/sh

# Update in case anything has changed

apt-get update

# We need these to build and configure the kernel

apt-get --no-install-recommends install build-essential
apt-get --no-install-recommends install ncurses-dev
apt-get --no-install-recommends install uboot-mkimage
