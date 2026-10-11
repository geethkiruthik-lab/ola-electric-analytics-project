ALTER TABLE archived_sales_legacy
RENAME COLUMN txn_dt TO sale_date;

ALTER TABLE archived_sales_legacy
RENAME COLUMN cty TO city;

ALTER TABLE archived_sales_legacy
RENAME COLUMN mdl_cd TO model;

ALTER TABLE archived_sales_legacy
RENAME COLUMN qty TO units_sold;

ALTER TABLE archived_sales_legacy
RENAME COLUMN rev_inr_lakh TO revenue;


SELECT DISTINCT model
FROM archived_sales_legacy
ORDER BY model;


SELECT DISTINCT model
FROM bike_sales_combined
ORDER BY model;


SELECT
    model,
    SUM(units_sold) AS total_units_sold,
    SUM(revenue) AS total_revenue_lakh,
    ROUND(AVG(revenue), 2) AS avg_revenue_lakh
FROM archived_sales_legacy
GROUP BY model
ORDER BY total_units_sold DESC;