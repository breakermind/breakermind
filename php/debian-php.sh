#!/bin/bash
# Run it:
# bash ./debian-php.sh

# set default php version number 7.3 or 7.4 or 8.0
VERSION=7.4

# install nginx unhide line below
# NGINX=yes

# instal apt https
sudo apt install -y apt-transport-https

# change all urls to https in file
sed -i 's/http\:/https\:/g' /etc/apt/sources.list

# update
sudo apt update

# install
sudo apt install -y curl wget gnupg2 ca-certificates lsb-release software-properties-common

# apt php keys
sudo curl https://packages.sury.org/php/apt.gpg | gpg --dearmor > /usr/share/keyrings/sury-php.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

# update
sudo apt update

# upgrade
sudo apt upgrade -y

# php for nginx
sudo apt install -y php7.3-fpm
sudo apt install -y php7.4-fpm
sudo apt install -y php8.0-fpm

# install extenstions
sudo apt install -y php7.3-{mysql,json,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}
sudo apt install -y php7.4-{mysql,json,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}
sudo apt install -y php8.0-{mysql,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}

# default php
sudo update-alternatives --list php
sudo update-alternatives --set php /usr/bin/php$VERSION

# restart
sudo service php7.3-fpm restart
sudo service php7.4-fpm restart
sudo service php8.0-fpm restart

# nginx
if [[ -v NGINX ]];
then
sudo apt install -y nginx
sudo service nginx restart
fi

# show version
sudo php -v

echo "Php works ... Good day"

# exit bash script
exit 1
# exit bash script

### Helpers ###
# https://wiki.debian.org/DebianRepository/UseThirdParty

# loaded modules
sudo php -m

# show list of extensions
sudo apt install php8.0-

# search extensions
sudo apt search php8.0-* 

# vps server, firewall, db, smtp, net
sudo apt install -y net-tools dnsutils mailutils git composer ufw nginx mariadb-server postfix

# dirs
sudo mkdir -p /home/site1/www/site1.xx

# permissions {username} - your linux user
sudo chown -R {username}:www-data /home/site1/www/site1.xx
sudo chmod 2770 /home/site1/www/site1.xx

# ufw firewall
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# with mask
# sudo ufw allow from 66.111.0.0/16 to any port 22
# sudo ufw allow from 66.111.0.0/16 to any port 22 proto tcp

# enable logs
sudo ufw logging on

# default policy
sudo ufw default allow outgoing
sudo ufw default deny incoming

# enable on boot
sudo ufw enable

# show rules
# sudo ufw status verbose
# show rules numbered
# sudo ufw status numbered
# delete rule
# sudo ufw delete 1

# do not delete !!!
exit 1
# exit bash script

# clear and add to file
echo "Create some text" > file.txt

# append to file
echo "Append some text" >> file.txt

# enable special chars
echo -e 'foo\nbar'
echo -e 'Pierwsz\0141 linia\nDruga linia'

# gpg keys apt php key without dearmor (not recomended)
# sudo wget -O /usr/share/keyrings/sury-php.gpg https://packages.sury.org/php/apt.gpg
# sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ stable main" | sudo tee /etc/apt/sources.list.d/sury-php.list

# gpg keys apt php key (deprecated)
# sudo wget https://packages.sury.org/php/apt.gpg
# sudo apt-key add apt.gpg
# sudo echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

# mysql commandline query (password without blank space)
mysql -u [USER] -p[PASSWORD] -e "create database testdb"

# mysql db and user
CREATE DATABASE `app` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'toor' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'toor' WITH GRANT OPTION;
FLUSH PRIVILEGES;

# nginx virtualhost 
# nano /etc/nginx/sites-available/default
server {
	listen 80;
	listen [::]:80;
	server_name site1.xx;
	root /home/site1/www/site1.xx;
	index index.php index.html;

	charset utf-8;
	disable_symlinks off;
	client_max_body_size 100M;

	access_log /var/log/nginx/site1.xx.access.log;
	error_log /var/log/nginx/site1.xx.error.log warn;
	
	location / {
		try_files $uri $uri/ /index.php$is_args$args;
		# try_files $uri $uri/ /public/index.php$is_args$args;
		# try_files $uri $uri/ =404;
	}

	location ~ \.php$ {
		# fastcgi_pass 127.0.0.1:9000;
		# CHANGE PHP VERSION HERE
		# fastcgi_pass unix:/run/php/php7.3-fpm-site1.xx.sock;
		# fastcgi_pass unix:/run/php/php7.4-fpm-site1.xx.sock;
		fastcgi_pass unix:/run/php/php8.0-fpm-site1.xx.sock;
		include snippets/fastcgi-php.conf;
	}

	location ~* \.(jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp3|mp4|mov|ogg|ogv|webm|webp)$ {
		expires 1M;
		access_log off;
		add_header Cache-Control "public, no-transform";
	}

	location = /favicon.ico {
		rewrite . /favicon/favicon.ico;
	}
}

# For certbot
# certbot certonly -d example.com -d www.example.com -d shop.example.com
# curl -L http://example.com/.well-known/acme-challenge/index.html
# For certbot add first
# location /.well-known {
#	root /var/www/html;
# }

# Show working version
# php -i | grep "Loaded Configuration File"
# Install only for apache2
# apt install -y php7.3 php7.3-cli php7.3-common
# Install
# sudo apt install apache2 libapache2-mod-php7.3
# Enable
# sudo a2enmod php7.3
# Disable
# sudo a2dismod php7.4
# sudo a2dismod php8.0 
# Config default version
# sudo update-alternatives --config php
# Restart
# sudo service apache2 restart