#!/usr/bin/env bash

# Define default password
DEFAULT_PASS="bitnami1"

# Create Samba users without home directories or shell access
echo "Creating Samba users..."
sudo adduser --no-create-home --shell /usr/sbin/nologin clismb --gecos ""
echo -e "$DEFAULT_PASS\n$DEFAULT_PASS" | sudo passwd clismb

sudo adduser --uid 1004 --no-create-home --shell /bin/false smbguest --gecos ""
sudo groupadd --gid 1004 smbguest
sudo passwd -d smbguest  # No password for smbguest

# Set ownership and permissions for Samba directories
echo "Setting ownership and permissions for Samba directories..."
sudo chown -R smbguest:smbguest /srv/samba/guest
sudo chown -R clismb:clismb /srv/samba/client
sudo chmod 2774 /srv/samba/guest
sudo chmod 2770 /srv/samba/client

# Add users to Samba authentication
echo "Adding Samba users with default password..."
(echo "$DEFAULT_PASS"; echo "$DEFAULT_PASS") | sudo smbpasswd -a clismb
(echo ""; echo "") | sudo smbpasswd -a smbguest  # No password for smbguest

# Restart and check Samba services
echo "Restarting Samba services..."
sudo systemctl restart smbd nmbd

echo "Checking Samba service status..."
sudo systemctl status smbd --no-pager
sudo systemctl status nmbd --no-pager

# Check running services on the system
echo "Checking running services..."
sudo systemctl --type=service --state=running

# Test Samba user communication
echo "Testing Samba user access..."
smbclient -U clismb%"$DEFAULT_PASS" -L 192.168.56.102
smbclient -U smbguest -L 192.168.56.102
smbclient -L 192.168.56.102

echo "Samba user setup completed successfully!"
echo "Done!"
