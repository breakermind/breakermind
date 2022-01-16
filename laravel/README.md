# Instalacja serwerów aplikacji
Debian 11, Php 8.1, MariaDB 10.5.12-MariaDB, Postfix

## Apt https
```sh
sudo apt install -y apt-transport-https
sed -i 's/http\:/https\:/g' /etc/apt/sources.list
sudo apt update
sudo apt install net-tools mailutils dnsutils ufw nginx mariadb-server php-fpm postfix
```

## Baza danych i użytkownik
mysql -u root -p
```sql
CREATE DATABASE IF NOT EXISTS app_xx CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS app_xx_testing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

GRANT ALL PRIVILEGES ON *.* TO app_xx@localhost IDENTIFIED BY 'toor' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO app_xx@127.0.0.1 IDENTIFIED BY 'toor' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

## Katalog aplikacji (app.xx)
```sh
sudo mkdir -p /home/www/app.xx
sudo chown -R your-user-name:www-data /home/www/app.xx
sudo chmod -R 2775 /home/www/app.xx
```

## Konfiguracja aplikacji
nano .env
```
# App
APP_NAME='Company Name'

# Production env
# APP_ENV=production
# APP_DEBUG=false

# Database
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=app_xx
DB_USERNAME=app_xx
DB_PASSWORD=app_xx

# Localhost smtp
MAIL_MAILER=smtp
MAIL_HOST=localhost
MAIL_PORT=25
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=noreply@localhost
MAIL_FROM_NAME="${APP_NAME}"

# Remote smtp
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=email@gmail.com
MAIL_PASSWORD=YourPassword
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=email@gmail.com
MAIL_FROM_NAME="${APP_NAME}"

SESSION_DRIVER=file
SESSION_LIFETIME=120
# SESSION_SECURE_COOKIE=true
```

## Linki do przesyłanych plików
```sh
php artisan storage:link
```

## Aktualizacja pakietów
```sh
rm -rf vendor

composer update
composer dump-autoload -o
```

## Php

### Php.ini konfiguracja
sudo nano /etc/php/8.1/fpm/php.ini
```sh
allow_url_fopen=off
allow_url_include=off

memory_limit = 500M

post_max_size=100M
upload_max_filesize = 10M
max_file_uploads = 10

session.use_strict_mode=On
session.use_only_cookies=On 
session.cookie_httponly=On
session.cookie_samesite="Strict"
# https
session.cookie_secure=On

max_execution_time = 600 
max_input_vars = 300 
max_input_time = 1000
```

### Instalacja 8.1
```sh
sudo apt install -y curl wget gnupg2 ca-certificates lsb-release software-properties-common

sudo curl https://packages.sury.org/php/apt.gpg | gpg --dearmor > /usr/share/keyrings/sury-php.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list

sudo apt update && sudo apt upgrade -y

sudo apt install -y php8.1-fpm
sudo apt install -y php8.1-{mysql,xml,curl,mbstring,opcache,gd,imagick,imap,bcmath,bz2,zip,intl,redis,memcache,memcached}

sudo update-alternatives --list php
sudo update-alternatives --set php /usr/bin/php8.1
```

### Php restart
```sh
sudo service php8.1-fpm restart
```

## Nginx

### Mginx lokalna domena (app.xx)
nano /etc/hosts
```sh
127.0.0.1 app.xx
```

### Nginx konfiguracja hosta (app.xx)
sudo nano /etc/nginx/sites-enabled
```conf
server {
	listen 80;
	listen [::]:80;
	server_name app.xx;
	root /home/www/app.xx/public;
	index index.php index.html;
    
    charset utf-8;
	disable_symlinks off;
	client_max_body_size 100M;

	access_log /home/www/app.xx/storage/logs/nginx/app.xx.access.log;
	error_log /home/www/app.xx/storage/logs/nginx/app.xx.error.log warn;

	location / {
		# try_files $uri $uri/ =404;
		try_files $uri $uri/ /index.php$is_args$args;
	}

	location ~ \.php$ {
		# fastcgi_pass 127.0.0.1:9000;
		fastcgi_pass unix:/run/php/php8.1-fpm.sock;
		include snippets/fastcgi-php.conf;
	}

	location ~* \.(js|css|scss|txt|pdf|jpg|jpeg|gif|png|webp|ico|svg|gz|mp3|mp4|mov|ogg|ogv|webm)$ {
		expires 1M;
		access_log off;
		add_header Cache-Control "public, no-transform";
	}

	location = /favicon.ico {
		rewrite . /favicon/favicon.ico;
	}
}
```

### Nginx restart
```sh
sudo service php8.1-fpm restart
sudo service nginx restart
```

## Postfix

### hostname
```sh
```

### Smtp host i domena
```cf
mydestination = $myhostname, app.xx, vps.localhost, localhost.localhost, localhost
relayhost =
relay_domains =
```

### Wirtualne skrzynki konfiguracja
sudo nano /etc/postfix/main.cf
```cf
virtual_alias_domains = app.xx
virtual_alias_maps = hash:/etc/postfix/virtual
```

### Wirtualne skrzynki lista
sudo nano /etc/postfix/virtual
```sh
admin@app.xx root
@app.xx username
```

### Aktualizacja listy
```sh
postmap /etc/postfix/virtual
sudo service postfix restart
```

## Ufw firewall

### Ufw porty
```sh
# Dla wszystkich ip
sudo ufw allow 22/tcp

# Dla maski adresów
sudo ufw allow from 1.2.0.0/16 to any port 22
sudo ufw allow from 1.2.0.0/16 to any port 22 proto tcp
```

## Ufw http, https
```sh
# sudo ufw allow 25/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Ufw defaultowa polityka
```sh
sudo ufw default allow outgoing
sudo ufw default deny incoming
```

### Ufw włącz
```sh
sudo ufw logging on
sudo ufw enable
```

## Restart serwerów
```sh
sudo service php8.1-fpm restart
sudo service nginx restart
sudo service postfix restart
```
