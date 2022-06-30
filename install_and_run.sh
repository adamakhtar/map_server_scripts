#!/bin/bash

PS3='Choose a data source: '
places=("manchester" "newyork" "unitedstates" "kanto" "japan")
select place in "${places[@]}"; do
    case $place in
        "manchester")
            wget -O $OSM_MAP_PATH "http://download.geofabrik.de/europe/great-britain/england/greater-manchester-latest.osm.pbf"
            break
            ;;
        "newyork")
            wget -O $OSM_MAP_PATH "http://download.geofabrik.de/north-america/us/new-york-latest.osm.pbf"
            break
	    # optionally call a function or run some code here
            ;;
        "unitedstates")
            wget -O $OSM_MAP_PATH "http://download.geofabrik.de/north-america/us-latest.osm.pbf"
            break
            ;;
        "kanto")
            wget -O $OSM_MAP_PATH "http://download.geofabrik.de/asia/japan/kanto-latest.osm.pbf"
            break
            ;;
        "japan")
            wget -O $OSM_MAP_PATH "http://download.geofabrik.de/asia/japan-latest.osm.pbf"
            break
            ;;

        *) echo "invalid option $REPLY";;
    esac
done

./install.sh && \
./create_osm_db.sh && \
./run_imposm.sh && \
./import_osm.sh && \
./import_ne.sh && \
./add_pg_index.sh \
./start_server.sh
