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

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj "/CN=ec2-3-113-244-229.ap-northeast-1.compute.amazonaws.com" \
  -addext "subjectAltName=DNS:ec2-3-113-244-229.ap-northeast-1.compute.amazonaws.com"

mkdir ~/tegola_server_cache
mkdir ~/tegola_osm_build
mkdir ~/tegola_osm_build/cache
mkdir ~/tegola_osm_build/diff

sudo -u postgres "CREATE ROLE $DB_USER LOGIN SUPERUSER PASSWORD '$DB_PW';"

# sudo -u $DB_USER psql -c "ALTER USER $DB_USER PASSWORD '$DB_PW';"