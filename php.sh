#!/bin/bash

sudo apt install -y apt-transport-https
sed -i 's/http\:/https\:/g' /etc/apt/sources.list

sudo apt update -y

sudo apt install -y curl wget gnupg2 ca-certificates lsb-release software-properties-common

sudo curl https://packages.sury.org/php/apt.gpg | gpg --dearmor > /usr/share/keyrings/sury-php.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y php8.0-fpm
sudo apt install -y php8.0-{mysql,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}

sudo update-alternatives --set php /usr/bin/php8.0

exit 1;
# sudo apt install -y php7.4-fpm
# sudo apt install -y php7.4-{mysql,json,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}
# sudo update-alternatives --list php
