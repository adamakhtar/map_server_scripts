/*
	Adds indexes to OSM table columns to increase query performance per the tegola configuration.
*/

BEGIN;
	CREATE INDEX ON osm_transport_lines_gen_50 (type);
	CREATE INDEX ON osm_transport_lines (type);
	CREATE INDEX ON osm_water_areas (type);
	CREATE INDEX ON osm_water_areas_gen_50_gt_500_000 (type);
	CREATE INDEX ON osm_water_ways (type);
	CREATE INDEX ON osm_water_ways_gen_50_gt_100_000 (type);
COMMIT;

/*
   For some strange reason openlayers will not render any buildings
   when a filter is applied to the layers column. To get round this
   I'm adding a another column called underground which will store
   either 0 or 1. Openlayers works with this.
*/
ALTER TABLE osm_buildings ADD COLUMN IF NOT EXISTS underground smallint;
update osm_buildings
set underground = (CASE
  WHEN layer IS NULL
		THEN 0
	WHEN layer >= 0
		THEN 0
	WHEN layer < 0
		THEN 1
	END);