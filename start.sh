#!/bin/bash

private_ip=$(hostname -i)

echo "-------------------------"
echo "Welcome to Steam-Cache v1"
echo "Private IP: ${private_ip}"
echo "-------------------------"

echo "Ensuring appropriate folders are created..."
mkdir -p /var/www/logs
mkdir -p /var/www/steam
mkdir -p /var/www/tmp

echo "Setting permissions..."
find /var/www -type d -exec chmod 777 {} +

echo "Pre-checks complete."

echo "Updating db.cache.steam with ${private_ip}"
sed -i -e "s/PRIVATE_IP/${private_ip}/g" /etc/bind/db.cache.steam

echo "Starting DNS server in the background..."
named -c /etc/bind/named.local.steam
echo "Started DNS."

echo "Starting nginx..."
nginx -g "daemon off;"