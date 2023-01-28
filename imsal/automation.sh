#!/bin/bash
echo "=============updating & upgrading system and installing dependencies============="
sudo apt update && sudo apt upgrade -y
sudo apt-get install apache2 php php-mysql mysql-server git -y
echo "=============creating account and granting privileges============="
sudo mysql -u root -e "create user 'devopscilsy'@'localhost' identified by '1234567890';"
sudo mysql -u root -e "grant all privileges on *.* to 'devopscilsy'@'localhost';"
echo "=============create database using devopscilsy user============="
sudo mysql -u devopscilsy -p1234567890 -e "create database dbsosmed;"
echo "=============cloning sosial media to /var/www/html and dumping dbsosmed with dump.sql============="
cd /var/www/html/
sudo git clone "https://github.com/sdcilsy/sosial-media.git"
cd /var/www/html/sosial-media/
sudo mysql -u devopscilsy -p1234567890 dbsosmed<dump.sql
echo "=============installing-wordpress============"
cd /var/www/html
sudo git clone "https://github.com/WordPress/WordPress.git"
sudo mv /var/www/html/WordPress /var/www/html/wordpress
echo "=============installing-landing-page==========="
cd /var/www/html
sudo git clone "https://github.com/sdcilsy/landing-page.git"
