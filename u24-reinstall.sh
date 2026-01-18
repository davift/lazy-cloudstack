#!/usr/bin/bash
sudo apt purge cloudstack-management cloudstack-common -y
sudo rm -rf /etc/cloudstack /var/lib/cloudstack /var/log/cloudstack /usr/share/cloudstack-common
sudo mysql -e "DROP DATABASE cloud;"
sudo mysql -e "DROP DATABASE cloud_usage;"
