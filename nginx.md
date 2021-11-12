# Nginx

### Domena localhost
nano /etc/hosts
```conf
127.0.0.1 domain.xx www.domain.xx
```

### Folder
```sh
mkdir -p /home/username/domain.xx/public
chown -r username:www-data /home/username/domain.xx/public
chmod -R 775 /home/username/domain.xx/public
```

### Host catch all
nano /etc/nginx/sites-available/default
```conf
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.4-fpm.sock;
                # fastcgi_pass 127.0.0.1:9000;
        }
}
```

### Wirtualny host domeny
nano /etc/nginx/sites-available/default
```conf
server {
        listen 80;
        listen [::]:80;
        server_name domain.xx;
        root /home/username/domain.xx/public;
        index index.php index.html;
        location / {
                # try_files $uri $uri/ =404;
                try_files $uri $uri/ /index.php$is_args$args;
        }
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php8.0-fpm.sock;
                # fastcgi_pass 127.0.0.1:9000;
        }
        location ~* \.(js|css|png|jpg|jpeg|gif|webp|svg|ico)$ {
            expires -1;
            access_log off;
        }
        disable_symlinks off;
        client_max_body_size 100M;
}
```

### Utwórz certyfikat ssl/tls dla domeny
```sh
sudo apt install certbot ufw

sudo ufw allow 80

sudo mkdir -p /srv/ssl

sudo service nginx stop

sudo certbot certonly --agree-tos --email admin@domain.xx --standalone --preferred-challenges http --webroot -w /srv/ssl/ -d domain.xx -d www.domain.xx

sudo service nginx start
```

### Wyświetl listę certyfikatów
```sh
sudo ls /etc/letsencrypt/live/domain.xx
```

### Wykonaj po automatycznym odnowieniu certyfikatu
sudo nano /etc/letsencrypt/renewal/domain.xx.conf
```sh
renew_hook = systemctl reload nginx
```

### Sprawdź czy certyfikat można już odnowić
```sh
sudo certbot renew --dry-run
```

### Tls certs
https://gist.github.com/wowpowhub/ba34e07fd094e8b79fdb27e840db91eb
