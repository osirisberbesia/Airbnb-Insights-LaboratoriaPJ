SELECT
  id,
  COUNT(*) AS count
FROM
  `airbnb-pj6.datasets_pj6.reviews-pre-charge`
GROUP BY
  id
HAVING
  COUNT(*) > 1
ORDER BY
  count DESC;
SELECT
  host_id,
  COUNT(*) AS count
FROM
  `airbnb-pj6.datasets_pj6.reviews-pre-charge`
GROUP BY
  host_id
HAVING
  COUNT(*) > 1
ORDER BY
  count DESC;
