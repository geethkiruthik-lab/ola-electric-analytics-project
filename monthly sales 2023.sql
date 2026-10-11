   MONTHLY_SALES_2023

 SELECT
    DATE_TRUNC('month', sale_date)::date AS month,
    SUM(units_sold) AS total_sales
FROM bike_sales_2023
WHERE sale_date >= '2023-01-01'
  AND sale_date < '2024-01-01'
GROUP BY 1
ORDER BY 1;  


    2023_MONTHLY_COMPLAINTS

SELECT *
FROM service_complaints_2023
LIMIT 5;

SELECT
    DATE_TRUNC('month', complaint_date)::date AS month,
    COUNT(*) AS total_complaints
FROM service_complaints_2023
WHERE complaint_date >= '2023-01-01'
  AND complaint_date < '2024-01-01'
GROUP BY 1
ORDER BY 1;