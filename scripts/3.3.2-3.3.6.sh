#!/usr/bin/env bash

# Create necessary Samba directories
echo "Creating Samba directories..."
sudo mkdir -p /srv/samba
sudo mkdir -p /srv/samba/guest
sudo mkdir -p /srv/samba/client

# Backup existing Samba configuration
echo "Backing up current Samba configuration..."
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bkp

# Writing new Samba configuration
echo "Applying new Samba configuration..."
sudo tee /etc/samba/smb.conf > /dev/null <<EOL
[global]
   workgroup = WORKGROUP
   bind interfaces only = yes
   interfaces = 192.168.56.0/24
   log file = /var/log/samba/log.%m
   log level = 1
   netbios name = bitnami
   server role = standalone server
   security = user
   map to guest = Bad User
   guest account = smbguest

[public]
   comment = Public Storage
   path = /srv/samba/guest/
   read only = no
   guest ok = yes
   writable = yes
   browsable = yes

[client]
   comment = Client Storage
   path = /srv/samba/client/
   read only = no
   writable = yes
   browsable = yes
   guest ok = no
   inherit permissions = yes
EOL
