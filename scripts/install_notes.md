Unscripted setup steps:
* Virtual desktop / workspace settings
* Printer setup
* Browser plugins + config
* Screen lock / power settings
* Desktop environment extensions
* User theme
* System font
* Adjust sudoers file:
  ```
  sudo visudo
  # Defaults        env_reset, timestamp_timeout=...
  # Defaults        env_keep=...
  ```
* Limit kernel installations (CentOS):
  ```
  # /etc/yum.comf
  installonly_limit=2
  ```
