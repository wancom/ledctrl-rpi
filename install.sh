#!/bin/sh

echo "ledctrl package installer"
echo


# Environments
BOOTCONFPATH="/boot/config.txt"
BOOTCONFFLAG="# Appended by ledctrl"


# Check user is root
if [ ! $(id -u) = "0" ];then
  echo "Please run as a root. Abort."
  exit 1
fi

# Check already installed
test ! -f ${BOOTCONFPATH} && touch ${BOOTCONFPATH}
if [ ! "$(grep -e "^${BOOTCONFFLAG}$" ${BOOTCONFPATH})" = "" ];then
  echo "Already installed. Abort."
  exit 0
fi


# Install
echo "Installing package..."
mkdir -p /usr/local/lib/ledctrl
cp ledctrl/start /usr/local/lib/ledctrl/
cp ledctrl/ledctrl.conf /usr/local/lib/ledctrl/ledctrl.conf.default
cp ledctrl/ledctrl.conf /etc/ledctrl.conf

echo "Installing service..."
cp service/ledctrl.service /lib/systemd/system/
systemctl enable ledctrl.service

# Update config.txt
echo "Updating ${BOOTCONFPATH}..."
if [ "$(grep -e "^${BOOTCONFFLAG}$" ${BOOTCONFPATH})" = "" ];then
  echo >> ${BOOTCONFPATH}
  echo "#----------------------" >> ${BOOTCONFPATH}
  echo "${BOOTCONFFLAG}" >> ${BOOTCONFPATH}
  echo "dtparam=pwr_led_trigger=timer" >> ${BOOTCONFPATH}
  echo "#----------------------" >> ${BOOTCONFPATH}
  echo >> ${BOOTCONFPATH}
fi

# Start service
systemctl start ledctrl.service


echo "Installation is finished!"