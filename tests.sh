#!/bin/bash
echo "**************************************************************************"
echo '*            `                                                           *'
echo '*            `b                                                          *'
echo '*             Y.                                    oo8""      ooo       *'
echo '*              8.                                 d88"         :88       *'
echo '*              `8.                         ,o.  o88P          ,dP        *'
echo '*               :8                      ,d888P,8888 ,od8ooood8"'         *'
echo '*    `.          Y8.                ,o88888888888P8P"'  `""'             *'
echo '*     `b.         Y8.              Y88888888888888o.   o                 *'
echo '*      `Yb.        Y8.           .""88888888888888888P"       ,          *'
echo '*        "8bo       Y8o           o8888888888888""           db   ,,o    *'
echo '*          Y88o      Y8b.        ` 888888"""8P'             888' :88;    *'
echo '*           `"88o.   oY88o        :88888'                   Y8P ,d8"'    *'
echo '*              "88b. `8d88b.      :88888                    :8 ,88;  ,   *'
echo '* `"ooo          "888o'88888o     :8888b                    d8b88P,od88"'*'
echo '*    ""888oo.      `Y888888888.    88888b                  ,888888888P'  *'
echo '*        "Y88888boo'Y8888888888.   `888888bo              ,888888"'      *'
echo '*           `"Y8888888888888888'    `88888888bo          d8888P'         *'
echo '*               `"Y8888888888P'     ,d88o8888888.      o88888'           *'
echo '*                "Y888888888'      d888888888888Y;   ,888P':P            *'
echo '*                  od8888888b.    d888888888888b   od88P'  8;            *'
echo '*             ,ood888888888888o.,d8888888888888o od888"   ,88            *'
echo '*           `"""""' ,8888888888888888Y"8P8d888888'888'    Y8"            *'
echo '*                  o888888888888888P:d888888888888'P'      "             *'
echo '*                ,d888Y88888888888P :Y8888888888888.                     *'
echo '*              ,o88P",8":P"8Y8P8P ,oY88888888888888b                     *'
echo '*             o88" ,d" `' ` :P  ,8P8888888888888888'                     *'
echo '*           ""    ''         d88Y8888888888888888888.     :8o.           *'
echo '*                        ooo8P8d888888888888888888888.    88' ,o..       *'
echo '*                     ood8P88888888888888888888Y8888Y8b  d8'o888P        *'
echo '*                    ,88Pb888888888888888888888d8;"8 Y88o88d88""         *'
echo '*                  od8P888888888888888888Y88888;8     `Y8888'  ,o.       *'
echo '*                  88`8888888888888888o8bd8888P        ,88888888PY       *'
echo '*                ,88`8888888888888888888888P"         d8"     ""         *'
echo '*                Y8b88888888"88888888P"""'         ood8P                 *'
echo '*                o8d888888Pb888""'                 Y888'                 *'
echo '*               `8;888888b88P"          ,ooo88bo.  ";                    *'
echo '*                o888888b88'          o8888888888b.                      *'
echo '*               "8d88888d8'        ,o888888"Y888"8b                      *'
echo '*                :88888b88       o'88888Pbd888888.8;                     *'
echo '*                8;88888'88oooo8"b8888"o8P"""Y8888:;                     *'
echo '*                `8'88888dP""Ybd8888P88"      `888d                      *'
echo '*                `88'8888888888888Pb"'         88`P                      *'
echo '*                 `88dY888888888Pb'           d88d'                      *'
echo '*                   `88bd8"""YoP"          ,d888P                        *'
echo '*                    `""""""""'    ,oooo888888"'                         *'
echo '*                               ,o888888P"""                             *'
echo '*                              d88P""                                    *'
echo '*                             :88'                                       *'
echo '*                             88;                                        *'
echo '*                             Y8b                                        *'
echo '*                              "88o                                      *'
echo '*                                `Yb                                     *'
echo '**************************************************************************'

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
