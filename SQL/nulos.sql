SELECT
  COUNTIF(host_id IS NULL) AS null_host_id,
  COUNTIF(host_name IS NULL) AS null_host_name
FROM `airbnb-pj6.datasets_pj6.hosts-pre-charge`;


SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(name IS NULL) AS null_name,
  COUNTIF(neighbourhood IS NULL) AS null_neighbourhood,
  COUNTIF(neighbourhood_group IS NULL) AS null_neighbourhood_group,
  COUNTIF(latitude IS NULL) AS null_latitude,
  COUNTIF(longitude IS NULL) AS null_longitude,
  COUNTIF(room_type IS NULL) AS null_room_type,
  COUNTIF(minimum_nights IS NULL) AS null_minimum_nights
FROM `airbnb-pj6.datasets_pj6.rooms-pre-charge`;

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(host_id IS NULL) AS null_host_id,
  COUNTIF(price IS NULL) AS null_price,
  COUNTIF(number_of_reviews IS NULL) AS null_number_of_reviews,
  COUNTIF(last_review IS NULL) AS null_last_review,
  COUNTIF(reviews_per_month IS NULL) AS null_reviews_per_month,
  COUNTIF(calculated_host_listings_count IS NULL) AS null_calculated_host_listings_count,
  COUNTIF(availability_365 IS NULL) AS null_availability_365
FROM `airbnb-pj6.datasets_pj6.reviews-pre-charge`;

