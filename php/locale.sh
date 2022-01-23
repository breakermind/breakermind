#!/bin/bash

# list locale
sudo locale -a

# generate
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# run select en_US.UTF-8 and then set default en_US.UTF-8
sudo dpkg-reconfigure locales
sudo locale

# exit bash script
exit 1

# default locale
# sudo nano /etc/default/locale

# remove
# sudo apt purge software-properties-common -y

# remove apache2
# sudo apt purge apache2 -y

# show php versions
# sudo update-alternatives --list php