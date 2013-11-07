#!/bin/sh

# Update in case anything has changed

apt-get update

# Here's what we need to create a grip root file system

apt-get --no-install-recommends install multistrap
apt-get --no-install-recommends install qemu
apt-get --no-install-recommends install qemu-user-static
apt-get --no-install-recommends install binfmt-support
apt-get --no-install-recommends install dpkg-cross

apt-get --no-install-recommends install emdebian-archive-keyring

# trigger a reload of keyrings, just in case they have changed

apt-get update
apt-get upgrade
