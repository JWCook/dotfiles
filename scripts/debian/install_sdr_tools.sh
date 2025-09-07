#!/usr/bin/env bash
# Note: If not working, unplug and reconnect SDR after restarting udev

# Blacklist the default DVB-T driver that conflicts with RTL-SDR
lsusb | grep -i dvb
lsmod | grep dvb
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee /etc/modprobe.d/blacklist-dvb.conf

# Add udev rules to allow non-root access
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="plugdev", MODE="0666", SYMLINK+="rtl_sdr"' \
    | sudo tee /etc/udev/rules.d/20-rtlsdr.rules
sudo usermod -a -G plugdev $USER
sudo udevadm control --reload-rules && sudo udevadm trigger

# Install driver + libs
sudo apt install -y rtl-sdr rtl-433 librtlsdr-dev libsoapysdr-dev soapysdr-tools soapysdr-module-rtlsdr

# Get device info and test
SoapySDRUtil --find
SoapySDRUtil --probe="driver=rtlsdr"
rtl_test
