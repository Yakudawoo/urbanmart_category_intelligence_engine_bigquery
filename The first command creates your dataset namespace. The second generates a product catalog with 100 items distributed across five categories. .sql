-- Create the dataset
CREATE SCHEMA IF NOT EXISTS `urbanmart_raw`;

-- Generate Product Catalog
CREATE OR REPLACE TABLE `urbanmart_raw.products` AS
SELECT 
  product_id,
  CASE MOD(product_id, 5)
    WHEN 0 THEN 'Electronics'
    WHEN 1 THEN 'Home & Garden'
    WHEN 2 THEN 'Fashion'
    WHEN 3 THEN 'Sports'
    ELSE 'Toys'
  END AS category,
  ROUND(10 + RAND() * 90, 2) AS price
FROM UNNEST(GENERATE_ARRAY(1, 100)) AS product_id;

-- Generate Transaction History
CREATE OR REPLACE TABLE `urbanmart_raw.transactions` AS
SELECT
  GENERATE_UUID() AS order_id,
  DATE_ADD(CURRENT_DATE(), INTERVAL -CAST(FLOOR(RAND() * 730) AS INT64) DAY) AS order_date,
  CAST(FLOOR(1 + RAND() * 100) AS INT64) AS product_id,
  CAST(FLOOR(1 + RAND() * 5) AS INT64) AS quantity
FROM UNNEST(GENERATE_ARRAY(1, 10000));
