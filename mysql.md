# Mysql podstawy

### Logowanie
```sh
mysql -u root -p
```

### Tworzenie użytkownika
```sql
GRANT ALL PRIVILEGES ON *.* TO root@localhost IDENTIFIED BY 'toor' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO root@127.0.0.1 IDENTIFIED BY 'toor' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### Tworzenie bazy danych
```sh
# mysql
CREATE DATABASE IF NOT EXISTS db_name CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# cmd
mysql -uroot -ptoor -e "CREATE DATABASE IF NOT EXISTS laravel;"
```

### Wyłącz cache
```sql
# show
SHOW VARIABLES LIKE '%query_cache%';

# disable
SET SESSION query_cache_type=0;
SET GLOBAL query_cache_type=0;
```
