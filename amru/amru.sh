#!/bin/bash -xe
sudo apt-get update -y && sudo apt-get upgrade -y 
sudo apt-get install apache2 php php-mysql mysql-server -y
sudo systemctl restart apache2
cd /var/www/html
pwd
sudo git clone https://github.com/sdcilsy/sosial-media.git
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
sudo git clone https://github.com/sdcilsy/landing-page.git
sudo systemctl restart apache2
