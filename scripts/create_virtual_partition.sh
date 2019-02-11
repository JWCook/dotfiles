#!/usr/bin/env bash
# Create a virtual partition using a disk image and loopback device
# Note: better option is to just create a real partition
# TODO: Instead of fdisk, do a non-interactive one-liner with parted or sfdisk instead
# TODO: Automount with script + fstab instead of systemd?
# /home/cookjo/ZONEMINDER_DRIVE.img    /media/zoneminder   ext4   loop  0 0

VPART_MOUNT=/media/zoneminder
VPART_IMAGE=/home/cookjo/ZONEMINDER_DRIVE.img
VPART_SIZE_GB=120

# Create and format disk image
dd if=/dev/zero of=$VPART_IMAGE bs=1M count=$(expr $VPART_SIZE_GB \* 1024)
fdisk $VPART_IMAGE
# g: GPT table
# n: New partition (w/ all defaults)
# w: Write changes
mkfs.ext4 $VPART_IMAGE

# Create systemd service, and create and mount loopback device
sudo cp zoneminder/zm_vpart.service /usr/lib/systemd/system/zm_vpart.service
sudo cp zoneminder/virtual_partition_manager.sh /usr/local/bin/virtual_partition_manager
sudo systemctl enable zm_vpart
sudo systemctl start zm_vpart
