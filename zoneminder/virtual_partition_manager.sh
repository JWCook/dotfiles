#!/usr/bin/env bash

VPART_MOUNT=/media/zoneminder
VPART_IMAGE=/home/cookjo/ZONEMINDER_DRIVE.img

# Create a new loop device for the image, if one doesn't already exist; otherwise, use existing one
LOOP_DEVICE=$(losetup --find --partscan --show --nooverlap $VPART_IMAGE)
echo "Mouting $VPART_IMAGE to mount point $VPART_MOUNT using loop device $LOOP_DEVICE"
mount $LOOP_DEVICE $VPART_MOUNT
