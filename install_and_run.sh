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

./install.sh && \
./create_osm_db.sh && \
./import_osm.sh && \
./import_ne.sh && \
./run_imposm.sh && \
./add_pg_index.sh && \
./start_server.sh
