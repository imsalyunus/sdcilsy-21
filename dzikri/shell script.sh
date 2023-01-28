#!/bin/bash -xe
sudo apt-get update -y && sudo apt-get upgrade -y 
sudo apt-get install apache2 php php-mysql mysql-server -y
sudo systemctl restart apache2
cd /var/www/html
pwd
sudo git clone https://github.com/sdcilsy/sosial-media.git

SOSIAL_MEDIA=$(ls | grep sosial-media | wc -l)

if [[ SOSIAL_MEDIA -eq 1 ]]; then # eq = equal
    echo "sukses"
elif [[ SOSIAL_MEDIA -ne 1 ]]; then # ne = not equal
    echo "gagal"
fi

sudo mysql -uroot -e "create user 'devopscilsy'@'localhost' identified by '1234567890';"
sudo mysql -uroot -e "grant all privileges on *.* to 'devopscilsy'@'localhost';"
sudo mysql -uroot -e "create database dbsosmed;"
sudo mysql -uroot -e "create user 'wordpress'@'localhost' identified by '1234567890';"
sudo mysql -uroot -e "grant all privileges on *.* to 'wordpress'@'localhost';"
sudo mysql -uroot -e "create database dbwordpress;"
cd /var/www/html/sosial-media
pwd
sudo mysql -udevopscilsy -p1234567890 dbsosmed < dump.sql
cd /var/www/html/
pwd
sudo git clone https://github.com/WordPress/WordPress.git
sudo mv /var/www/html/WordPress /var/www/html/wordpress
cd /var/www/html/wordpress

sed -i '' -e 's/database_name_here/db_wordpress/' wp-config.php
sed -i '' -e 's/username_here/wp-user/' wp-config.php
sed -i '' -e 's/password_here/wp-pass123/' wp-config.php
sed -i '' -e 's/localhost/$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)/' wp-config.php

sudo git clone https://github.com/sdcilsy/landing-page.git
sudo systemctl restart apache2