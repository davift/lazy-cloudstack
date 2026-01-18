#!/usr/bin/bash
sudo apt update && sudo apt install cloudstack-management -y
sudo mysql -e "CREATE DATABASE cloud;"
sudo mysql -e "CREATE DATABASE cloud_usage;"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo cloudstack-setup-databases cloud:dft.wiki@localhost --schema-only && sudo cloudstack-setup-management
sleep 5
sudo tail -f /var/log/cloudstack/management/management-server.log
