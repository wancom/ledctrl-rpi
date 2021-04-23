# LED control for Raspberry Pi
This program manages Raspberry Pi power LED.
- When booting, the power LED blinks.
- After almost booted, the power LED flashes once/5sec.
  - (almost booted means services wanted by multi-user.target is started.)

# How to install
Please run installer.

``` sh
git clone https://github.com/wancom/ledctrl-rpi.git
cd ledctrl-rpi
sudo ./install.sh
```

# How to uninstall
Uninstaller is not provided for now.
Please do follows.

- Stop and disable service
``` sh
sudo systemctl stop ledctrl.service
sudo systemctl disable ledctrl.service
```

- Edit config /boot/config.txt to remove config followings.
```
#----------------------
# Appended by ledctrl
dtparam=pwr_led_trigger=timer
#----------------------
```

- Remove files
``` sh
sudo rm /usr/local/lib/ledctrl/start
sudo rm /usr/local/lib/ledctrl/ledctrl.conf.default
sudo rmdir /usr/local/lib/ledctrl
sudo rm /etc/ledctrl.conf
sudo rm /lib/systemd/system/ledctrl.service
```