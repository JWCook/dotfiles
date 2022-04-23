# Unscripted setup steps

# Misc

* Virtual desktop / workspace settings
* Printer setup
* Browser plugins + config
* Configure KeePassXC


## GNOME

* User theme
* Edit `~/.config/user-dirs.dirs` (wallpapers dir):
    * `XDG_PICTURES_DIR="$HOME/Pictures/wallpapers"`
* Dynamic workspaces off
* Extensions: AlternateTab, RemovableDriveMenu, No Top Left HotCorner
* Tweak tool: add startup apps, extesions, etc.
* set system monospace font to DroidSansMono or whatever
* Display -> Enable Night Light (until flux and/or Reshift are updated to support Wayland)
* Privacy -> enable location services (if needed i.e. for Redshift)
* Run `ibus-setup` -> change/disable shortcut for emoji picker

Partially scripted with `gsettings`, but double-check:

* Screen lock / Power settings
* File browser -> Preferences:
    * Sort Folders First
    * Expand Folders
    * Add minimize & mazimize buttons

Keyring:
* Edit `/etc/xdg/autostart/gnome-keyring-ssh.desktop`, comment out `X-GNOME-Autostart-Phase` line
    * Or: `sudo chmod -x $(type -p gnome-keyring-daemon)`
* Enable Secret Service Integration and SSH Agent in KeepassXC
* `echo $SSH_AUTH_SOCK` and set that in KeepassXC

Display/appearance:
* In Fedora with Gnome 40+, to add window minimize/maximize buttons:
```
settings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
```

## XFCE

* Edit `/etc/pulse/default.pa`, add `load-module module-switch-on-connect`

## Enable Hibernate (Fedora)

* Find swap partition: `swapon -s`
* Add this partition to grub resume:
  * `sudo vim /etc/default/grub`
  * `GRUB_CMDLINE_LINUX="... resume=/dev/whatever/"`
  * BIOS: `sudo grub2-mkconfig -o /boot/grub2/grub.cfg`
  * UEFI: `sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`

## GRUB

* `sudo vim /etc/default/grub`
```ini
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
# Optional
# GRUB_THEME="/usr/share/grub/themes/<theme name>/theme.txt"
```
* `sudo update-grub` OR `sudo grub2-mkconfig -o /boot/grub2/grub.cfg`

## Networking
Disable IPv6 support, if needed:
* `sudo vim /etc/sysctl.conf`
```ini
net.ipv6.conf.all.disable_ipv6 = 1 
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```
* `sudo sysctl -p`
* Verify: `cat /proc/sys/net/ipv6/conf/all/disable_ipv6`

## Misc System Config

* `sudo update-alternatives --config editor` -> select `nvim`
* `sudo visudo` -> add/edit lines:
  ```
  Defaults        env_reset,timestamp_timeout=120
  Defaults        secure_path = ...:/usr/local/bin
  ```
* `sudo vim /etc/systemd/system.conf`: Uncommend/edit:
  ```
  DefaultTimeoutStopSec=15s
  ```

## Fix broken openssl after Ubuntu upgrade
```
wget https://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.0l-1~deb9u5_amd64.deb
sudo dpkg -i libssl1.1*.deb
```

## Fedora-specific:

* Limit number of installed kernel versions: Add to `/etc/yum.conf`:
    ```
    installonly_limit=2
    ```
* Automatic updates: Edit `/etc/dnf/automatic.conf`:
    ```
    upgrade_type = security
    download_updates = yes
    apply_updates = yes
    ```

## WSL2

* Copy over SSH keys
* Add git SSH config
* Clone & install dotfiles

## Dual-boot, shared storage partition
```
ln -s "/media/$USER/STORAGE/Nextcloud" "/home/$USER/Nextcloud"
```
