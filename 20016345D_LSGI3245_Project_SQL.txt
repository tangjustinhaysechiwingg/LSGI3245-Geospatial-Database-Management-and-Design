LSGI3245 
Individual Project 

20016345D 
Tang Justin Hayse Chi Wing G.



GIVEN Q1.

SELECT
  facilities.name,
  facilities.category,
  facilities.district,
  facilities.geom
FROM
  facilities
ORDER BY
  facilities.geom <#>
  'SRID=4326;POINT(114.168086 22.318153)'::geometry LIMIT 1;



GIVEN Q2.

Select *
From facilities
Where ST_DWithin(
      geom:: geography,
      ST_GeomFromText('POINT (114.168086 22.318153 )',4326)::geography,
      500);



GIVEN Q3.

SELECT  n.district , count (*)
FROM facilities AS s
JOIN hkadmin AS n
ON ST_Contains(n.geom, s.geom)
where category ='Basketball Courts'
Group by n.district
Order by count (*) desc;



GIVEN Q4.

Select district, popn_num,(tot_number/cast(popn_num as decimal))*100000 as facilitiles_per_100000_people
from (select district, count (name)as tot_number 
	 from facilities 
	 where category = 'Basketball Courts'
	 group by district
	 ) as T natural join census
	 order by facilitiles_per_100000_people desc;




Additional Q1.

Select district, popn_num,
(tot_number/cast(popn_num as decimal))*100000 
as hospital_per_100000_people
from (select district, count (name)as tot_number 
	  from hospital 
	  group by district
	 ) as T 
	 natural join census 
	 order by hospital_per_100000_people desc;



Additional Q2.

SELECT cluster, district, name, address, ST_Distance(geom, ref_geom) 
        AS distance, geom
FROM hospital
CROSS JOIN (SELECT 
ST_MakePoint(114.168086,22.318153):: geography AS ref_geom) 
			AS r  
WHERE ST_DWithin(geom, ref_geom, 3000)  
ORDER BY ST_Distance(geom, ref_geom) asc;  



--- This Is the END of this individual report. Thank You! ---
