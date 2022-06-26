#!/bin/bash

PS3='Choose a data source: '
foods=("manchester" "newyork" "unitedstates" "kanto" "japan")
select fav in "${foods[@]}"; do
    case $fav in
        "manchester")
            wget -O map.osm.pbf "http://download.geofabrik.de/europe/great-britain/england/greater-manchester-latest.osm.pbf"
            ;;
        "newyork")
            wget -O map.osm.pbf "http://download.geofabrik.de/north-america/us/new-york-latest.osm.pbf"
	    # optionally call a function or run some code here
            ;;
        "unitedstates")
            wget -O map.osm.pbf "http://download.geofabrik.de/north-america/us-latest.osm.pbf"
            ;;
        "kanto")
            wget -O map.osm.pbf "http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf"
            ;;
        "japan")
            wget -O map.osm.pbf "http://download.geofabrik.de/asia/japan-latest.osm.pbf"
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

wget https://raw.github.com/adamakhtar/map_tools/master/setup/install.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/create_osm_db.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/run_imposm.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/import_osm.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/import_ne.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/add_pg_index.sh
wget https://raw.github.com/adamakhtar/map_tools/master/setup/start_server.sh
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/tegola.toml
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/imposm3.json
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/postgis_helpers.sql
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/postgis_index.sql
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/natural_earth.sh
wget https://raw.githubusercontent.com/adamakhtar/tegola-osm/aa-my-version/osm_land.sh

chmod +x install.sh
chmod +x create_osm_db.sh
chmod +x run_imposm.sh
chmod +x import_osm.sh
chmod +x add_pg_index.sh
chmod +x start_server.sh
chmod +x tegola.toml
chmod +x imposm3.json
chmod +x postgis_helpers.sql
chmod +x postgis_index.sql
chmod +x natural_earth.sh
chmod +x osm_land.sh

./install.sh && \
./create_osm_db.sh && \
./import_osm.sh && \
./import_ne.sh && \
./run_imposm.sh && \
./add_pg_index.sh && \
./start_server.sh
