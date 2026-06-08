#!/usr/bin/bash
sudo apt update && sudo apt install cloudstack-management -y
sudo mysql -e "CREATE DATABASE cloud;"
sudo mysql -e "CREATE DATABASE cloud_usage;"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo sed -i "s/^127\.0\.1\.1.*/$(hostname -I | awk '{print $1}') acs.local acs/" /etc/hosts
sudo cloudstack-setup-databases cloud:dft.wiki@localhost --schema-only && sudo cloudstack-setup-management
sleep 5
sudo tail -f /var/log/cloudstack/management/management-server.log
