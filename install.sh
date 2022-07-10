#!/bin/bash

cd $HOME

sudo apt update -y && sudo add-apt-repository ppa:ubuntugis/ppa -y && sudo apt install postgresql postgresql-contrib postgis gdal-bin unzip osmctools -y && sudo apt install ruby -y

wget https://github.com/omniscale/imposm3/releases/download/v0.11.1/imposm-0.11.1-linux-x86-64.tar.gz
tar xvzf imposm-0.11.1-linux-x86-64.tar.gz
rm imposm-0.11.1-linux-x86-64.tar.gz
mv imposm-0.11.1-linux-x86-64 imposm

wget -O tegola.zip https://github.com/go-spatial/tegola/releases/download/v0.15.2/tegola_linux_amd64.zip
unzip tegola.zip
rm tegola.zip

# allow tegola to listen to ssl port 443. Linux by default does allow users to listen to low level
# ports by default
sudo setcap CAP_NET_BIND_SERVICE=+eip $(which tegola)

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj "/CN=ec2-3-113-244-229.ap-northeast-1.compute.amazonaws.com" \
  -addext "subjectAltName=DNS:ec2-3-113-244-229.ap-northeast-1.compute.amazonaws.com"

mkdir ~/tegola_server_cache
mkdir ~/tegola_osm_build
mkdir ~/tegola_osm_build/cache
mkdir ~/tegola_osm_build/diff

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

sudo -u postgres psql -c "CREATE ROLE $DB_USER LOGIN SUPERUSER PASSWORD '$DB_PW';"
sudo -u postgres psql -c "create database $DB_USER;"

# sudo -u $DB_USER psql -c "ALTER USER $DB_USER PASSWORD '$DB_PW';"