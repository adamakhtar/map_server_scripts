sudo -u postgres psql -U postgres -d osm -a -f ./postgis_helpers.sql
sudo -u postgres psql -U postgres -d osm -a -f ./postgis_index.sql
