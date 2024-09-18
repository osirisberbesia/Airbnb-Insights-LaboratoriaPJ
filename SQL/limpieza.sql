--Limpieza rooms

  SELECT 
  id, 
  name,
  neighbourhood,
  CASE 
    WHEN REGEXP_CONTAINS(CAST(neighbourhood_group AS STRING), r'\d') THEN NULL
    ELSE neighbourhood_group   END AS neighbourhood_group,
  CASE 
    WHEN REGEXP_CONTAINS(CAST(latitude AS STRING), r'[a-zA-Z]') THEN NULL
    ELSE latitude
  END AS latitude,
  
  CASE 
    WHEN REGEXP_CONTAINS(CAST(longitude AS STRING), r'[a-zA-Z]') THEN NULL
    ELSE longitude
  END AS longitude,
    CASE 
    WHEN REGEXP_CONTAINS(CAST(room_type AS STRING), r'\d') THEN NULL
    ELSE  room_type  END AS  room_type,    
  minimum_nights
  FROM `airbnb-pj6.datasets_pj6.original_rooms`
  WHERE
   REGEXP_CONTAINS(CAST(id AS STRING), r'^\d+$') = TRUE

-- Limpieza host

WITH temporal_host AS (

  SELECT 
    CASE 
      WHEN REGEXP_CONTAINS(CAST(host_id AS STRING), r'[a-zA-Z]') THEN NULL
      ELSE host_id
    END AS host_id,

    CASE 
      WHEN host_name IS NULL THEN 'Sin nombre en base de datos'
      ELSE host_name
    END AS host_name
  FROM `airbnb-pj6.datasets_pj6.original_hosts`

)

SELECT host_id, host_name 
FROM temporal_host 
WHERE host_id IS NOT NULL



--Limpieza reviews

SELECT 

id,
host_id,
price,
number_of_reviews,
last_review,
reviews_per_month,
calculated_host_listings_count,
availability_365

 FROM `airbnb-pj6.datasets_pj6.original_reviews` 
 WHERE
REGEXP_CONTAINS(CAST(id AS STRING), r'^\d+$') = TRUE
order by id ASC


