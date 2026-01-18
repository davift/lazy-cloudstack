#!/usr/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt install apt-transport-https ca-certificates -y
sudo hostnamectl set-hostname acs.local
sudo sed -i 's/ubuntu/acs.local/g' /etc/hosts
sudo sed -i "s/127.0.1.1/`hostname -I`/g" /etc/hosts
echo 'deb http://download.cloudstack.org/ubuntu noble 4.22' | sudo tee /etc/apt/sources.list.d/cloudstack.list
wget -O - http://download.cloudstack.org/release.asc | sudo tee /etc/apt/trusted.gpg.d/cloudstack.asc
sudo apt update && sudo apt install cloudstack-management -y
sudo apt install mysql-server -y
sudo mysql -e "CREATE DATABASE cloud;"
sudo mysql -e "CREATE DATABASE cloud_usage;"
sudo mysql -e "CREATE USER cloud@localhost identified by 'dft.wiki';"
sudo mysql -e "CREATE USER cloud_usage@localhost identified by 'dft.wiki';"
sudo mysql -e "GRANT ALL ON *.* to cloud@localhost;"
sudo mysql -e "GRANT process ON *.* TO cloud@localhost;"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo cloudstack-setup-databases cloud:dft.wiki@localhost --schema-only && sudo cloudstack-setup-management
sleep 5
sudo tail -f /var/log/cloudstack/management/management-server.log
