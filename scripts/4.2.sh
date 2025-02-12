#!/usr/bin/env bash

BITNAMI_USER="bitnami"
SSH_DIR="/home/$BITNAMI_USER/.ssh"
SAMBA_CLIENT_DIR="/srv/samba/client"

echo "4.2.1 - Removing SSH restrictions in Bitnami LampStack..."
sudo rm -f /etc/ssh/sshd_not_to_be_run

echo "4.2.2 - Removing old RSA cryptographic keys..."
sudo rm -f /etc/ssh/ssh_host_rsa*

echo "4.2.3 - Creating a backup of SSH configuration..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp

echo "4.2.4 - Updating SSH configuration..."
sudo tee /etc/ssh/sshd_config > /dev/null <<EOL
Port 22
AddressFamily any
ListenAddress 0.0.0.0
HostKey /etc/ssh/ssh_host_ed25519_key
SyslogFacility AUTH
LogLevel INFO
MaxAuthTries 3
MaxSessions 2
RSAAuthentication yes
PubkeyAuthentication yes
ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin no
UsePAM no
EOL

echo "4.2.5 - Enabling SSH service..."
sudo systemctl enable ssh

echo "4.2.6 - Starting SSH service..."
sudo systemctl start ssh

echo "4.2.7 - Generating a cryptographic key pair for SSH authentication..."
sudo -u $BITNAMI_USER ssh-keygen -t rsa -b 4096 -f $SSH_DIR/id_rsa -N ""

echo "4.2.8 - Checking hostname..."
hostname

echo "4.2.8 - Retrieving external cryptographic layer control data..."
ssh-keyscan debian | ssh-keygen -l -f /dev/stdin

echo "4.2.9 - Adding public key to authorized_keys..."
cat $SSH_DIR/id_rsa.pub | sudo tee -a $SSH_DIR/authorized_keys > /dev/null

echo "Ensuring proper permissions on SSH directory and keys..."
sudo chown -R $BITNAMI_USER:$BITNAMI_USER $SSH_DIR
sudo chmod 700 $SSH_DIR
sudo chmod 600 $SSH_DIR/id_rsa
sudo chmod 644 $SSH_DIR/id_rsa.pub

echo "4.2.10 - Copying private key to Samba client directory..."
sudo cp $SSH_DIR/id_rsa $SAMBA_CLIENT_DIR

echo "4.2.11 - Setting permissions for the private key in Samba client directory..."
sudo chown clismb:clismb $SAMBA_CLIENT_DIR/id_rsa

echo "SSH setup for Bitnami LampStack completed! Done!"
