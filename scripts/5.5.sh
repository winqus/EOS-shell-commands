#!/usr/bin/env bash

echo "5.5 - Section: Preparing CMSMADESIMPLE for Installation."

echo "5.5.1 - Moving CMSMADESIMPLE installation to the server's document root..."
sudo mv ~/cmsms-2.2.20-install.php /opt/bitnami/apache/htdocs/

echo "5.5.2 - Granting execution permissions..."
sudo chmod +x /opt/bitnami/apache/htdocs/cmsms-2.2.20-install.php

echo "5.5.3 - Creating the e-store directory..."
sudo mkdir /opt/bitnami/apache/htdocs/paysera

echo "5.5.4 - Changing ownership of the e-store directory..."
sudo chown bitnami:bitnami /opt/bitnami/apache/htdocs/paysera

echo "5.5.5 - Granting temporary full access permissions to the e-store directory..."
sudo chmod 777 /opt/bitnami/apache/htdocs/paysera

echo "5.5.6 - Moving CMSMADESIMPLE installation to the e-store directory..."
sudo mv /opt/bitnami/apache/htdocs/cmsms-2.2.20-install.php /opt/bitnami/apache/htdocs/paysera/

echo "5.5.7 - You can now proceed with the installation via a web browser."
echo "Open: http://192.168.56.102/paysera/cmsms-2.2.20-install.php"

echo "5.5 - CMSMADESIMPLE installation preparation completed!"
