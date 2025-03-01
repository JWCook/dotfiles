#!/bin/bash
SWAPFILE=/swapfile
sudo fallocate -l 8G $SWAPFILE
sudo dd if=/dev/zero of=$SWAPFILE bs=1024 count=8388608
sudo chmod 600 $SWAPFILE
sudo mkswap $SWAPFILE
sudo swapon $SWAPFILE
echo "$SWAPFILE swap swap defaults 0 0" | sudo tee -a /etc/fstab
