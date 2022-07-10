sudo -u $DB_USER psql -U postgres -d osm -a -f ./postgis_helpers.sql
sudo -u $DB_USER psql -U postgres -d osm -a -f ./postgis_index.sql
