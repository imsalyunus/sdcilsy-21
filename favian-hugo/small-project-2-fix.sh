#!/bin/bash
echo "=============updating & upgrading system and installing dependencies============="
sudo apt update && sudo apt upgrade -y
sudo apt-get install apache2 php php-mysql mysql-server git -y
echo "=============installing-wordpress============"
cd /var/www/html
sudo git clone "https://github.com/WordPress/WordPress.git"
sudo mv /var/www/html/WordPress /var/www/html/wordpress

wordpress = $(ls| grep wordpress|wc -l)
if [[wordpress -eq1]];then
  echo "wordpress has sucessfully renamed"
elif [[wordpress -ne 1]];then
  echo "Still Wordpress not wordpress"
echo "=============creating-user-and-db-for-wordpress============"
sudo mysql -u root -e"create user 'saya'@'localhost' identified by '12345';"
sudo mysql -u root -e "grant all privileges on *.*to 'saya'@'localhost';"
sudo mysql -u root -e "create database db_saya;"
echo "=============changing wp-config-sample========="
cd /var/www/html/wordpress
sudo sed -i -e "s/database_name_here/db_saya/" wp-config-sample.php
sudo sed -i -e "s/username_here/saya/" wp-config-sample.php 
sudo sed -i -e "s/password_here/12345/" wp-config-sample.php
sudo cp wp-config-sample.php wp-config.php
echo "=============installing-landing-page==========="
cd /var/www/html
sudo git clone "https://github.com/sdcilsy/landing-page.git"
echo "=============creating account and granting privileges sosial media============="
sudo mysql -u root -e "create user 'devopscilsy'@'localhost' identified by '1234567890';"
sudo mysql -u root -e "grant all privileges on *.* to 'devopscilsy'@'localhost';"
echo "=============create database using devopscilsy user============="
sudo mysql -u devopscilsy -p1234567890 -e "create database dbsosmed;"
echo "=============cloning sosial media to /var/www/html and dumping dbsosmed with dump.sql============="
cd /var/www/html/
sudo git clone "https://github.com/sdcilsy/sosial-media.git"
cd /var/www/html/sosial-media/
sudo mysql -u devopscilsy -p1234567890 dbsosmed<dump.sql
#sudo sed -i -e "s/localhost/$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)/" wp-config-sample.php
