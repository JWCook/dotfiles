# (Currently) Unscripted setup steps

# Misc

* Virtual desktop / workspace settings
* Printer setup
* Browser plugins + config
* Configure KeePassXC + KeePassHTTP + ChromeIPass


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

Partially scripted with `gsettings`, but double-check:

* Screen lock / Power settings
* File browser -> Preferences:
    * Sort Folders First
    * Expand Folders
    * Add minimize & mazimize buttons


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
```
* `sudo update-grub`

## Misc System Config

* `sudo update-alternatives --config editor` -> select `vim`
* `sudo visudo` -> add/edit lines:
  ```
  Defaults        env_reset,timestamp_timeout=120
  Defaults        secure_path = ...:/usr/local/bin
  ```
* Fedora-based: Add to `/etc/yum.conf`:
    ```
    installonly_limit=2  # Limit number of installed kernel versions
    ```
