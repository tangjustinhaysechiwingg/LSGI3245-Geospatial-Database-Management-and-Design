1A(1)
ST_Intersects(geometry A, geometry B) returns true if geometry A intersects geometry B

Example:
SELECT name, boroname
FROM nyc_neighborhoods
WHERE ST_Intersects(
  geom,
  ST_GeomFromText('LINESTRING(586782 4504202,586864 4504216)', 26918)
);


1A(2)
ST_Overlaps(geometry A, geometry B) returns true if geometry A and geometry B share space, but are not completely contained by each other.

Example:
SELECT name
FROM nyc_streets
WHERE ST_Overlaps(
  geom,
  ST_GeomFromText('LINESTRING(586782 4504202,586864 4504216)', 26918),
  0.1
);


1A(3)
ST_Crosses(geometry A, geometry B) returns true if geometry A crosses geometry B

Example:
SELECT
  subways.name AS subway_name,
  neighborhoods.name AS neighborhood_name,
  neighborhoods.boroname AS borough
FROM nyc_neighborhoods AS neighborhoods
JOIN nyc_subway_stations AS subways
ON ST_Crosses(neighborhoods.geom, subways.geom)
WHERE subways.name = 'Broad St';


1A(4)
ST_Touches(geometry A, geometry B) returns true if the boundary of geometry A touches geometry B

Example:
SELECT blocks.blkid
 FROM nyc_census_blocks blocks
 JOIN nyc_subway_stations subways
 ON ST_Touches(blocks.geom, subways.geom)
 WHERE subways.name = 'Broad St';


1B
select *
from nyc_census_blocks
where  ST_Intersects(geom,(select geom from nyc_streets where name ='Lexington Ave'and id = 485));


2A
SELECT s.name, s.routes
FROM nyc_subway_stations AS s
JOIN nyc_neighborhoods AS n
ON ST_Contains(n.geom, s.geom)
WHERE n.name = 'Little Italy';


2B
SELECT DISTINCT n.name, n.boroname
FROM nyc_subway_stations AS s
JOIN nyc_neighborhoods AS n
ON ST_Contains(n.geom, s.geom)
WHERE strpos(s.routes,'6') > 0;


2C
SELECT Sum(popn_total)
FROM nyc_neighborhoods AS n
JOIN nyc_census_blocks AS c
ON ST_Intersects(n.geom, c.geom)
WHERE n.name = 'Battery Park';


2D
SELECT n.name,
Sum(c.popn_total) / (ST_Area(n.geom) / 1000000.0) AS popn_per_sqkm
FROM nyc_census_blocks AS c
JOIN nyc_neighborhoods AS n
ON ST_Intersects(c.geom, n.geom)
WHERE n.name = 'Upper West Side'
OR n.name = 'Upper East Side'
GROUP BY n.name, n.geom;
