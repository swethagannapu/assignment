#!/bin/bash -xe
# Install Nginx
sudo apt -y update;
sudo apt install -y nginx-core;
sudo mkdir /var/www/images;
sudo systemctl stop nginx;
sudo systemctl start nginx;