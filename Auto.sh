#!/bin/bash
answer="Y"

read -p "ARE YOU READY TO INSTALL?? (Y/n) " pilih;

if [ $pilih == $answer ];
then
    echo "========================Melakukan Installasi Update========================"
    sudo apt-get update
    echo "======================Melakukan Installasi Webserver======================="
    sudo apt-get install -y apache2 php php-mysql
    echo "===================Melakukan Installasi Database Server===================="
    sudo apt-get install -y mysql-server
    echo "==============================Restart Apache2=============================="
    sudo systemctl restart apache2
    echo "==========================Masuk ke Direktory Html=========================="
    cd /var/www/html
    echo "========================Mulai clone git Sosial Media======================="
    sudo git clone https://github.com/sdcilsy/sosial-media.git
    sudo systemctl restart mysql
    sudo systemctl enable mysql
    echo "===================================Login MySQL============================="
    sudo mysql -uroot -e "create user 'devopscilsy'@'localhost' identified by '1234567890';"
    sudo mysql -uroot -e "grant all privileges on *.* to 'devopscilsy'@'localhost';"
    sudo mysql -uroot -e "create database dbsosmed;"
    echo "========================Masuk ke Direktory Sosial Media===================="
    cd /var/www/html/sosial-media
    sudo systemctl restart mysql
    sudo systemctl enable mysql
    echo "===================Redirect isi file dump kearah dbsosmed=================="
    sudo mysql -u devopscilsy -p1234567890 dbsosmed < dump.sql
    echo "=========================Kembali ke Direktori Html========================="
    cd /var/www/html/
    echo "=========================Mulai clone git WordPress========================="
    sudo git clone https://github.com/WordPress/WordPress.git
    sudo mv /var/www/html/WordPress /var/www/html/wordpress
    echo "========================Mulai clone git Landing Page======================="
    sudo git clone https://github.com/sdcilsy/landing-page.git
    echo "==============================Restart Apache2=============================="
    sudo systemctl restart apache2
    exit 0
else
    echo
    "===============================INSTALLATION FAILED=============================="
    exit 1
fi
