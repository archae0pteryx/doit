#!/bin/bash

php libapache2-mod-php php-mcrypt php-mysql python-letsencrypt-apache

mkdir /var/www/live
chown -R www-data:www-data /var/www/live
echo "THIS IS A MONKIKI" >/var/www/live/index.html
/etc/apache2/sites-enabled/000-default.conf
 #ServerName www.example.com/ServerName <whatever.whatever>

# Webmin
deb http://download.webmin.com/download/repository sarge contrib
wget -qO - http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
ufw allow 10000/tcp
# WP install

# WP DEPS
php-curl php-gd php-mbstring php-mcrypt php-xml php-xmlrpc

curl -O https://wordpress.org/latest.tar.gz
touch /tmp/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
cp -a /tmp/wordpress/. /var/www/html
chown -R $user:www-data /var/www/html
#set g inheritance
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins

# Spice
curl -s https://api.wordpress.org/secret-key/1.1/salt/
