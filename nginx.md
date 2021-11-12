# Nginx

### Domena localhost
nano /etc/hosts
```conf
127.0.0.1 app.xx www.app.xx
```

### Host catch all
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
```conf
server {
        listen 80;
        listen [::]:80;
        server_name app.xx;
        root /home/username/app/public;
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
