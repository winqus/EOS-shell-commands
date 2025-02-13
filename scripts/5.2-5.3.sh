#!/usr/bin/env bash

echo "5.2 - Section: Downloading and/or Installing the Application Software."

echo "5.2.1 - Archiver: Installing zip and unzip..."
sudo apt-get install -y zip unzip

echo "5.2.2 - Browser (Web server component): Installing lynx..."
sudo apt-get install -y lynx lynx-common

echo "5.2.3 - Database management client: Installing mycli..."
sudo apt-get install -y mycli

echo "5.2.4 - CMSMADESIMPLE application software archive and execution permissions..."
curl --output ~/cmsmadesimple.zip "https://developers.paysera.com/plugin/download?plugin_name=cmsmadesimple.zip"
chmod ug+x ~/cmsmadesimple.zip

echo "5.2.5 - PAYSERA CMSMADESIMPLE extension archive and execution permissions..."
curl --output ~/cmsms-2.2.20-install.zip "http://s3.amazonaws.com/cmsms/downloads/15173/cmsms-2.2.20-install.zip"
chmod ug+x ~/cmsms-2.2.20-install.zip

echo "5.2.6 - Extracting CMSMADESIMPLE..."
unzip ~/cmsms-2.2.20-install.zip

echo "5.2.7 - Extracting PAYSERA CMSMADESIMPLE extension..."
unzip ~/cmsmadesimple.zip

echo "5.3 - Section: BITNAMI Service Package Versions."

echo "5.3.1 - Web Server Apache Version..."
/opt/bitnami/apache/bin/apachectl -v
sudo /opt/bitnami/ctlscript.sh status apache

echo "5.3.2 - Database Management System MariaDB Version..."
/opt/bitnami/mariadb/sbin/mariadbd --version
sudo /opt/bitnami/ctlscript.sh status mariadb

echo "5.3.3 - Pre-processor PHP Version..."
/opt/bitnami/php/sbin/php-fpm --version
sudo /opt/bitnami/ctlscript.sh status php-fpm
/opt/bitnami/php/bin/php -r 'echo phpversion() . "\n";'

echo "5.2 - Application software installation completed!"
