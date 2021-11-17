#!/bin/bash

sudo apt install -y apt-transport-https
sed -i 's/http\:/https\:/g' /etc/apt/sources.list

sudo apt update -y
sudo apt install -y curl wget gnupg2 ca-certificates lsb-release software-properties-common

sudo curl https://packages.sury.org/php/apt.gpg | gpg --dearmor > /usr/share/keyrings/sury-php.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

sudo apt update -y
sudo apt upgrade -y

# vps
sudo apt install -y net-tools dnsutils mailutils git composer ufw redis memcached nginx mariadb-server postfix

# php
sudo apt install -y php8.0-fpm
sudo apt install -y php8.0-{mysql,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}
sudo service php8.0-fpm restart

sudo update-alternatives --set php /usr/bin/php8.0

# Php
# sudo php -v
# sudo php -m

# Firewall
# sudo ufw allow from 5.6.0.0/16 to any port 22 proto tcp
# sudo ufw allow 22/tcp
# sudo ufw allow 80/tcp
# sudo ufw allow 443/tcp
# sudo ufw logging on
# sudo ufw default allow outgoing
# sudo ufw default deny incoming
# sudo ufw enable

exit 1

# sudo apt install -y php7.4-fpm
# sudo apt install -y php7.4-{mysql,json,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}
# sudo update-alternatives --list php
