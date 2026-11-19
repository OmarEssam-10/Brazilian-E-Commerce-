USE [brazilian e-commerce]
GO

SELECT * FROM customers_dataset

SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_NULL,
    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS customer_unique_id_NULL,
    SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS zip_NULL,
    SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS city_NULL,
    SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS state_NULL
FROM customers_dataset



SELECT customer_id ,
           
           COUNT (*) AS IS_DUPLICATES

FROM customers_dataset
GROUP BY  customer_id
HAVING COUNT(*) >1



SELECT customer_unique_id ,
           
           COUNT (*) AS IS_DUPLICATES

FROM customers_dataset
GROUP BY  customer_unique_id
HAVING COUNT(*) >1







SELECT * FROM geolocation_dataset

SELECT
       SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END) AS geolocation_city_is_null ,
       SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END) AS geolocation_state_is_null
FROM geolocation_dataset


UPDATE geolocation_dataset
SET geolocation_city = 
LOWER ( CAST (geolocation_city AS nvarchar(MAX)) COLLATE LATIN1_GENERAL_100_CI_AI)


UPDATE geolocation_dataset
SET geolocation_city = 
REPLACE(geolocation_city , '?' , 'o')
WHERE geolocation_city LIKE '%?%'







SELECT * FROM order_items_dataset

UPDATE order_items_dataset 
SET shipping_limit_date =
CAST (shipping_limit_date AS DATE)


ALTER TABLE order_items_dataset
ALTER COLUMN shipping_limit_date DATE


SELECT order_id , 
                  COUNT(*) AS order_id_is_duplicated
FROM order_items_dataset
GROUP BY order_id
HAVING COUNT(*) >1


SELECT product_id , 
                  COUNT(*) AS order_id_is_duplicated
FROM order_items_dataset
GROUP BY product_id
HAVING COUNT(*) >1



SELECT 
       SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_is_null ,
       SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) AS price_is_null
FROM order_items_dataset







SELECT * FROM order_payments_dataset

SELECT order_id ,
                  COUNT(*) AS order_id_is_duplicated
FROM order_payments_dataset
GROUP BY order_id
HAVING COUNT(*) >1


SELECT
      SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) AS payment_value_IS_NULL
FROM order_payments_dataset







SELECT * FROM order_reviews_dataset

SELECT order_id , 
                  COUNT(*) AS order_id_is_duplicated

FROM order_reviews_dataset
GROUP BY order_id
HAVING COUNT(*) >1



ALTER TABLE order_reviews_dataset
ALTER COLUMN review_creation_date DATE

ALTER TABLE order_reviews_dataset
ALTER COLUMN review_answer_timestamp DATE


ALTER TABLE order_reviews_dataset
DROP COLUMN review_comment_title , review_comment_message









SELECT * FROM orders_dataset

ALTER TABLE orders_dataset
ALTER COLUMN order_purchase_timestamp DATE

ALTER TABLE orders_dataset
ALTER COLUMN order_approved_at DATE

ALTER TABLE orders_dataset
ALTER COLUMN order_delivered_carrier_date DATE

ALTER TABLE orders_dataset
ALTER COLUMN order_delivered_customer_date DATE

ALTER TABLE orders_dataset
ALTER COLUMN order_estimated_delivery_date DATE


SELECT order_id ,
         COUNT (*) AS order_id_duplicated
FROM orders_dataset
GROUP BY order_id
HAVING COUNT(*) >1


SELECT customer_id ,
         COUNT (*) AS order_id_duplicated
FROM orders_dataset
GROUP BY customer_id
HAVING COUNT(*) >1






SELECT * FROM products_dataset

SELECT product_id ,
                     COUNT (*) AS order_id_duplicated
FROM products_dataset
GROUP BY product_id
HAVING COUNT(*) >1


DELETE FROM products_dataset
WHERE product_id = '3'



SELECT 
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_NULL,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS product_category_name_NULL,
    SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) AS product_name_lenght_NULL,
    SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) AS product_description_lenght_NULL,
    SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) AS product_photos_qty_NULL,
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS product_weight_g_NULL,
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS product_length_cm_NULL,
    SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) AS product_height_cm_NULL,
    SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) AS product_width_cm_NULL
FROM products_dataset

UPDATE products_dataset
SET product_category_name ='UNKNOWN'
WHERE product_category_name IS NULL




WITH MedianCalculated AS (
    SELECT DISTINCT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_name_lenght) OVER () AS median_val
    FROM products_dataset
    WHERE product_name_lenght IS NOT NULL
)
UPDATE products_dataset
SET product_name_lenght = (SELECT median_val FROM MedianCalculated)
WHERE product_name_lenght IS NULL;






WITH MedianCalculated AS (
        SELECT DISTINCT 
          PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_description_lenght) OVER() AS Median_Val
        FROM products_dataset
        WHERE product_name_lenght IS NOT NULL
)
UPDATE products_dataset
SET product_description_lenght = (SELECT Median_Val FROM MedianCalculated)
WHERE product_description_lenght IS NULL;





WITH MEDIANCALCULATED AS(
          SELECT DISTINCT 
            PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY product_photos_qty ) OVER() AS MEDIAN_VAL
          FROM products_dataset
          WHERE product_photos_qty IS NOT NULL
)
UPDATE products_dataset
SET product_photos_qty = (SELECT MEDIAN_VAL FROM MEDIANCALCULATED )
WHERE product_photos_qty IS NULL



DELETE FROM products_dataset
WHERE product_weight_g IS NULL
OR product_length_cm IS NULL
OR product_height_cm IS NULL
OR product_width_cm IS NULL 






SELECT * FROM sellers_dataset

SELECT seller_id ,
         COUNT (*) AS order_id_duplicated
FROM sellers_dataset
GROUP BY seller_id
HAVING COUNT(*) >1









SELECT *

FROM customers_dataset C

INNER JOIN orders_dataset O
ON C.customer_id = O.customer_id

INNER JOIN order_items_dataset OI
ON O.order_id = OI.order_id

INNER JOIN products_dataset P
ON P.product_id = OI .product_id

LEFT JOIN order_payments_dataset OP
ON O.order_id = OP .order_id

LEFT JOIN order_reviews_dataset R
ON O.order_id = R.order_id






SELECT * FROM customers_dataset
SELECT * FROM geolocation_dataset
SELECT * FROM order_items_dataset
SELECT * FROM order_payments_dataset
SELECT * FROM order_reviews_dataset
SELECT * FROM orders_dataset
SELECT * FROM products_dataset
SELECT * FROM sellers_dataset




SELECT CAST ( SUM (PRICE) AS DECIMAL (10,2)) AS TOTAL_PRICE FROM order_items_dataset

SELECT CAST ( AVG ( CAST ( PRICE AS FLOAT )) AS DECIMAL(10,2))  AS AVG_PRICE FROM order_items_dataset

SELECT DISTINCT CAST ( PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY PRICE) OVER() AS DECIMAL(10,2))
AS MEDIAN_PRICE FROM order_items_dataset WHERE PRICE IS NOT NULL


SELECT DISTINCT
    (SELECT CAST(MIN(price) AS DECIMAL(10,2)) FROM order_items_dataset) AS MIN_PRICE,
    CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) OVER() AS DECIMAL(10,2)) AS Q1_PRICE,
    CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY price) OVER() AS DECIMAL(10,2)) AS MEDIAN_PRICE,
    CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) OVER() AS DECIMAL(10,2)) AS Q3_PRICE,
    (SELECT CAST(MAX(price) AS DECIMAL(10,2)) FROM order_items_dataset) AS MAX_PRICE,
    (SELECT CAST(STDEV(price) AS DECIMAL(10,2)) FROM order_items_dataset) AS STD_DEV_PRICE
FROM order_items_dataset
WHERE price IS NOT NULL

SELECT 134.90 - 39.90 AS IQR_PRICE
SELECT 39.90 - 1.5 * 95.00 AS LOWER_BOUND_PRICE
SELECT 134.90 + 1.5 * 95.00 AS UPPER_BOUND_PRICE


SELECT
       COUNT(*) AS OUTLIERS_PRICE_COUNT ,
       CAST(COUNT(*) * 100 / (SELECT COUNT(*) FROM order_items_dataset) AS DECIMAL(10,2)) AS OUTLIERS_PRICE_PERCENTAGE
FROM order_items_dataset
WHERE price >277.400

 




SELECT CAST ( SUM (freight_value) AS DECIMAL (10,2)) AS TOTAL_freight_value FROM order_items_dataset

SELECT CAST ( AVG ( CAST ( freight_value AS FLOAT )) AS DECIMAL(10,2))  AS AVG_freight_value FROM order_items_dataset

SELECT DISTINCT CAST ( PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY freight_value) OVER() AS DECIMAL(10,2))
AS MEDIAN_freight_value FROM order_items_dataset WHERE freight_value IS NOT NULL


SELECT DISTINCT 
       ( SELECT CAST( MIN (freight_value) AS DECIMAL(10,2)) FROM order_items_dataset) AS MIN_freight_value ,
       CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value) OVER() AS DECIMAL(10,2)) AS Q1_freight_value,
       CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY freight_value) OVER() AS DECIMAL(10,2)) AS MEDIAN_freight_value,
       CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value) OVER() AS DECIMAL(10,2)) AS Q3_freight_value,
       (SELECT CAST ( MAX (freight_value) AS DECIMAL(10,2)) FROM order_items_dataset) AS MAX_freight_value , 
       (SELECT CAST(STDEV(freight_value) AS DECIMAL(10,2)) FROM order_items_dataset) AS STD_DEV_freight_value
FROM order_items_dataset
WHERE freight_value IS NOT NULL


SELECT 21.15 - 13.08 AS IQR_freight_value
SELECT 13.08 - 1.5 * 8.07 AS LOWER_BOUND_freight_value
SELECT 21.15 + 1.5 * 8.07 AS UPPER_BOUND_freight_value

SELECT 
    COUNT(*) AS OUTLIERS_FREIGHT_COUNT,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_items_dataset) AS DECIMAL(10,2)) AS OUTLIERS_PERCENTAGE
FROM order_items_dataset
WHERE freight_value > 33.255 OR freight_value <0.975






SELECT CAST(SUM (payment_value) AS DECIMAL (10,2)) AS TOTAL_PAYMENT_VALUE FROM order_payments_dataset
SELECT CAST(AVG (payment_value) AS DECIMAL (10,2)) AS AVG_PAYMENT_VALUE FROM order_payments_dataset


SELECT DISTINCT 
       ( SELECT CAST( MIN (payment_value) AS DECIMAL(10,2)) FROM order_payments_dataset) AS MIN_payment_value ,
       CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY payment_value) OVER() AS DECIMAL(10,2)) AS Q1_payment_value,
       CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY payment_value) OVER() AS DECIMAL(10,2)) AS MEDIAN_payment_value,
       CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY payment_value) OVER() AS DECIMAL(10,2)) AS Q3_payment_value,
       (SELECT CAST ( MAX (payment_value) AS DECIMAL(10,2)) FROM order_payments_dataset) AS MAX_payment_value , 
       (SELECT CAST(STDEV(payment_value) AS DECIMAL(10,2)) FROM order_payments_dataset) AS STD_DEV_payment_value
FROM order_payments_dataset
WHERE payment_value IS NOT NULL


SELECT 171.84 - 56.79 AS IQR_payment_value
SELECT 56.79 - 1.5 * 115.05 AS LOWER_BOUND_payment_value
SELECT 171.84 + 1.5 * 115.05 AS UPPER_BOUND_payment_value

SELECT 
    COUNT(*) AS OUTLIERS_payment_value_COUNT,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_payments_dataset) AS DECIMAL(10,2)) AS OUTLIERS_PERCENTAGE_payment_value
FROM order_payments_dataset
WHERE payment_value > 344.415 





SELECT CAST(SUM (payment_installments) AS DECIMAL (10,2)) AS TOTAL_payment_installments FROM order_payments_dataset
SELECT CAST(AVG (payment_installments) AS DECIMAL (10,2)) AS AVG_payment_installments FROM order_payments_dataset

SELECT DISTINCT 
       ( SELECT CAST( MIN (payment_installments) AS DECIMAL(10,2)) FROM order_payments_dataset) AS MIN_payment_installments ,
       CAST(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY payment_installments) OVER() AS DECIMAL(10,2)) AS Q1_payment_installments,
       CAST(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY payment_installments) OVER() AS DECIMAL(10,2)) AS MEDIAN_payment_installments,
       CAST(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY payment_installments) OVER() AS DECIMAL(10,2)) AS Q3_payment_installments,
       (SELECT CAST ( MAX (payment_installments) AS DECIMAL(10,2)) FROM order_payments_dataset) AS MAX_payment_installments , 
       (SELECT CAST(STDEV(payment_installments) AS DECIMAL(10,2)) FROM order_payments_dataset) AS STD_DEV_payment_installments
FROM order_payments_dataset
WHERE payment_installments IS NOT NULL


SELECT 4.00- 1.00 AS IQR_payment_installments
SELECT 1.00- 1.5 * 3.00 AS LOWER_BOUND_payment_installments
SELECT 4.00+ 1.5 * 3.00 AS UPPER_BOUND_payment_installments

SELECT 
    COUNT(*) AS OUTLIERS_payment_installments_COUNT,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_payments_dataset) AS DECIMAL(10,2)) AS OUTLIERS_PERCENTAGE_payment_installments
FROM order_payments_dataset
WHERE payment_installments > 8.500


SELECT CAST ( AVG (review_score) AS DECIMAL(10,2)) AS AVG_REVIEW_SCORE FROM order_reviews_dataset



SELECT * FROM customers_dataset
SELECT * FROM geolocation_dataset
SELECT * FROM order_items_dataset
SELECT * FROM order_payments_dataset
SELECT * FROM order_reviews_dataset
SELECT * FROM orders_dataset
SELECT * FROM products_dataset
SELECT * FROM sellers_dataset


SELECT customer_city ,
                       COUNT(*) AS count_customer_city

FROM customers_dataset
GROUP BY customer_city
ORDER BY count_customer_city DESC





SELECT customer_state ,
                       COUNT(*) AS count_customer_state

FROM customers_dataset
GROUP BY customer_state
ORDER BY count_customer_state DESC





SELECT geolocation_city ,
                           COUNT(*) AS count_geolocation_city

FROM geolocation_dataset
GROUP BY geolocation_city
ORDER BY count_geolocation_city DESC






SELECT geolocation_state ,
                           COUNT(*) AS count_geolocation_state

FROM geolocation_dataset
GROUP BY geolocation_state
ORDER BY count_geolocation_state DESC





SELECT payment_type ,
                           COUNT(*) AS count_payment_type

FROM order_payments_dataset
GROUP BY payment_type
ORDER BY count_payment_type DESC





SELECT review_score ,
                           COUNT(*) AS count_review_score

FROM order_reviews_dataset
GROUP BY review_score
ORDER BY count_review_score DESC




SELECT order_status ,
                           COUNT(*) AS count_order_status

FROM orders_dataset
GROUP BY order_status
ORDER BY count_order_status DESC




SELECT product_category_name ,
                           COUNT(*) AS count_product_category

FROM products_dataset
GROUP BY product_category_name
ORDER BY count_product_category DESC





SELECT seller_city ,
                           COUNT(*) AS count_seller_city

FROM sellers_dataset
GROUP BY seller_city
ORDER BY count_seller_city DESC





SELECT seller_state ,
                           COUNT(*) AS count_seller_state

FROM sellers_dataset
GROUP BY seller_state
ORDER BY count_seller_state DESC







SELECT P.product_category_name , 
                          CAST(SUM(PRICE) AS DECIMAL(10,2)) AS total_price ,
                          CAST(AVG(PRICE) AS DECIMAL(10,2)) AS average_price ,
                          CAST(SUM(freight_value) AS DECIMAL(10,2)) AS total_freight_value ,
                          CAST(AVG(freight_value) AS DECIMAL(10,2)) AS average_freight_value
FROM order_items_dataset OI

INNER JOIN products_dataset P

ON P.product_id = OI .product_id

GROUP BY P.product_category_name
ORDER BY average_price DESC








SELECT C.customer_city , C.customer_state , product_category_name ,
                         
                         COUNT(product_category_name) AS total_products
                          
FROM customers_dataset C

INNER JOIN orders_dataset O
ON C.customer_id = O.customer_id

INNER JOIN order_items_dataset OI
ON O.order_id = OI.order_id

INNER JOIN products_dataset P
ON P.product_id = OI .product_id

GROUP BY C.customer_city , C.customer_state , product_category_name
ORDER BY total_products DESC







SELECT P.product_category_name  ,
                         
                        COUNT(product_category_name) AS total_products ,
                        SUM(review_score) AS total_score ,
                        AVG(review_score) AS avg_score
                          
FROM orders_dataset O

INNER JOIN order_items_dataset OI
ON O.order_id = OI.order_id

INNER JOIN products_dataset P
ON P.product_id = OI .product_id

LEFT JOIN order_payments_dataset OP
ON O.order_id = OP .order_id

LEFT JOIN order_reviews_dataset R
ON O.order_id = R.order_id

GROUP BY P.product_category_name
ORDER BY total_score DESC







SELECT order_id ,
               DATEDIFF(DAY , order_purchase_timestamp , order_delivered_customer_date) AS actual_delivery_time ,

               DATEDIFF(DAY , order_approved_at , order_delivered_carrier_date) AS processing_time ,

               DATEDIFF(DAY , order_delivered_carrier_date , order_delivered_customer_date) AS shipping_duration ,

               DATEDIFF(DAY , order_purchase_timestamp , order_approved_at) AS payment_approved_delay ,

               DATEDIFF(DAY , order_delivered_customer_date , order_estimated_delivery_date) AS delivery_accuracy 
FROM orders_dataset








SELECT payment_type , 
                        CAST ( SUM (payment_value) AS decimal(10,2)) AS total_payment ,
                        CAST ( AVG (payment_value) AS decimal(10,2)) AS avg_payment 
FROM order_payments_dataset
GROUP BY payment_type
ORDER BY avg_payment DESC









WITH MONTHLY_PRICE AS (
                        SELECT MONTH(shipping_limit_date) AS MONTH , 
                                                                      AVG(price) AS Avg_price
                        FROM order_items_dataset
                        GROUP BY MONTH(shipping_limit_date)
                        )
SELECT MONTH , 
       Avg_price ,                                               
       LAG(Avg_price) OVER (                                      
                        ORDER BY MONTH                     
                        ) AS previos_month_price
FROM MONTHLY_PRICE ;

