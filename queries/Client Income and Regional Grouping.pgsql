SELECT client_id, name, region, 
CASE
WHEN income < 30000 THEN 'Low income'
  WHEN income BETWEEN 30000 AND 70000 THEN 'Middle income'
  ELSE 'High income'
END AS income_category,
CASE
WHEN region IN ('North', 'East') THEN 'Group A'
  WHEN region IN ('South', 'West') THEN 'Group B'
  ELSE 'Other'
END AS region_group
FROM clients
ORDER BY income_category ASC, name ASC; 