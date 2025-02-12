#!/usr/bin/env bash

echo "Checking nftables status..."
sudo systemctl status nftables --no-pager

echo "Enabling and starting nftables..."
sudo systemctl enable --now nftables

echo "Listing nftables tables..."
sudo nft list tables

echo "Reviewing nftables firewall table..."
sudo nft list table inet firewall

echo "Reviewing nftables inbound rules..."
sudo nft list chain inet firewall inbound

echo "Displaying nftables rules with rule handles..."
sudo nft -a list table inet firewall

# Example: Removing a specific rule by its handle (change '15' as needed)
# Uncomment and replace 15 with the actual handle to remove a rule
# echo "Removing specific nftables rule..."
# sudo nft delete rule inet firewall inbound handle 15

echo "Adding necessary nftables firewall rules..."
sudo nft add rule inet firewall inbound tcp dport { 22, 80, 139, 443, 445 } accept
sudo nft add rule inet firewall inbound udp dport { 137, 138 } accept

echo "nftables setup completed successfully!"
