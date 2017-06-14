# (Currently) Unscripted setup steps

# Misc

* Virtual desktop / workspace settings
* Printer setup
* Browser plugins + config


## GNOME

* User theme
* System font
* Dynamic workspaces off
* Extensions: AlternateTab, RemovableDriveMenu, No Top Left HotCorner
* Tweak tool: add startup apps,a

Partially scripted with `gsettings`, but double-check:

* Tweak tool: install extensions
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


## Misc System Config

* `sudo visudo` -> add/edit lines:
  ```
  Defaults        env_reset,timestamp_timeout=120
  Defaults        secure_path = ...:/usr/local/bin
  ```
* Add to `/etc/yum.conf`:
    ```
    installonly_limit=2  # Limit number of installed kernel versions
    ```
