#!/usr/bin/env bash

MOUNT_POINT="/mnt/loc"
SERVER_IP="192.168.56.102"
CLIENT_SHARE="//${SERVER_IP}/client"
PUBLIC_SHARE="//${SERVER_IP}/public"
USERNAME_CLISMB="clismb"
USERNAME_SMBGUEST="smbguest"
PASSWORD="bitnami1"  # Default password for clismb

echo "Creating mount directory..."
sudo mkdir -p "$MOUNT_POINT"

echo "Mounting client share as clismb..."
sudo mount -t cifs -o username=$USERNAME_CLISMB,password=$PASSWORD,vers=2.1 "$CLIENT_SHARE" "$MOUNT_POINT"

echo "Checking mounted directory..."
ls -la "$MOUNT_POINT"

echo "Unmounting client share..."
sudo umount "$MOUNT_POINT"

echo "Mounting public share as smbguest (no password)..."
sudo mount -t cifs -o username=$USERNAME_SMBGUEST,vers=2.1 "$PUBLIC_SHARE" "$MOUNT_POINT"

echo "Checking mounted directory..."
ls -la "$MOUNT_POINT"

echo "Unmounting public share..."
sudo umount "$MOUNT_POINT"

echo "Checking SMB configuration..."
testparm -s

echo "Displaying Samba logs..."
sudo ls -lah /var/log/samba/

echo "SMB mounting, configuration check, and logging completed!"
