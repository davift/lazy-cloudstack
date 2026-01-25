#!/usr/bin/bash
sudo dpkg -s cloudstack-management >/dev/null 2>&1 || { echo "Cloudstack not installed"; exit 1; }
sudo sed -i 's/4.20/4.22/g' /etc/apt/sources.list.d/cloudstack.list
sudo systemctl stop cloudstack-management
sudo apt update && apt upgrade -y
sudo systemctl start cloudstack-management
sleep 5
sudo tail -f /var/log/cloudstack/management/management-server.log

