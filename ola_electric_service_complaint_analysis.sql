SALES ANALYSIS

SELECT 
    COUNT(*) AS total_sales_records,
    SUM(units_sold) AS total_units_sold
FROM bike_sales;


SALES BY YEAR 2024

SELECT
    EXTRACT(YEAR FROM sale_date) AS sales_year,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY EXTRACT(YEAR FROM sale_date)
ORDER BY sales_year;

MONTHLY SALES TREND


SELECT
    EXTRACT(MONTH FROM sale_date) AS sales_month,
    TO_CHAR(sale_date, 'Month') AS month_name,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    EXTRACT(MONTH FROM sale_date),
    TO_CHAR(sale_date, 'Month')
ORDER BY sales_month;

SALES BY SATATE

SELECT
    state,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY state
ORDER BY total_units_sold DESC;


TOP 10 CITIES

SELECT
    city,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY city
ORDER BY total_units_sold DESC
LIMIT 10;

MODEL WISE SALES

SELECT
    model,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY model
ORDER BY total_units_sold DESC;

DEALER TYPE ANALTSIS

SELECT
    dealer_type,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY dealer_type
ORDER BY total_units_sold DESC;

BOOKING CHANNEL ANALYSIS

SELECT
    booking_channel,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY booking_channel
ORDER BY total_units_sold DESC;


AVERAGE SELLING PRICE MODEL

SELECT
    model,
    ROUND(AVG(avg_selling_price_inr), 2) AS average_selling_price
FROM bike_sales
GROUP BY model
ORDER BY average_selling_price DESC;

ESTIMATED SALES VALUE BY MODEL

SELECT
    model,
    SUM(units_sold) AS total_units_sold,
    ROUND(AVG(avg_selling_price_inr), 2) AS average_selling_price,
    ROUND(SUM(units_sold * avg_selling_price_inr), 2) AS estimated_sales_value
FROM bike_sales
GROUP BY model
ORDER BY estimated_sales_value DESC;

OVER ALL ESTIMATED SALES VALUE

SELECT
    SUM(units_sold) AS total_units_sold,
    ROUND(AVG(avg_selling_price_inr), 2) AS overall_average_selling_price,
    ROUND(SUM(units_sold * avg_selling_price_inr), 2) AS total_estimated_sales_value
FROM bike_sales;

SALES BY DEALER TYPE AND BOOKING CHANNEL

SELECT
    dealer_type,
    booking_channel,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    dealer_type,
    booking_channel
ORDER BY total_units_sold DESC;

MODEL AND BOOKING CHANNEL

SELECT
    model,
    booking_channel,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    model,
    booking_channel
ORDER BY
    model,
    total_units_sold DESC;


	MODEL AND DEALER TYPE

	SELECT
    model,
    dealer_type,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    model,
    dealer_type
ORDER BY
    model,
    total_units_sold DESC;

	SALES BY DEALER TYPE AND MODEL BY %

	SELECT
    model,
    dealer_type,
    SUM(units_sold) AS total_units_sold,
    ROUND(
        SUM(units_sold) * 100.0 /
        SUM(SUM(units_sold)) OVER (PARTITION BY model),
        2
    ) AS sales_percentage
FROM bike_sales
GROUP BY
    model,
    dealer_type
ORDER BY
    model,
    total_units_sold DESC;


	SALES BY STATE AND MODEL

	SELECT
    state,
    model,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    state,
    model
ORDER BY
    state,
    total_units_sold DESC;

	MONTHLY SALES BY MODEL

	SELECT
    EXTRACT(MONTH FROM sale_date) AS sales_month,
    TO_CHAR(sale_date, 'Month') AS month_name,
    model,
    SUM(units_sold) AS total_units_sold
FROM bike_sales
GROUP BY
    EXTRACT(MONTH FROM sale_date),
    TO_CHAR(sale_date, 'Month'),
    model
ORDER BY
    sales_month,
    total_units_sold DESC;

	TOTAL SERVICE COMPLAINTS 2023

	SELECT
    COUNT(*) AS total_complaints_2023
FROM service_complaints_2023;

TOTAL SERVICE COMPLAINTS 2024

SELECT
    COUNT(*) AS total_complaints_2024
FROM service_complaints_2024;

MONTHLY COMPLAINTS IN 2024

SELECT
    EXTRACT(MONTH FROM complaint_date) AS complaint_month,
    TO_CHAR(complaint_date, 'Month') AS month_name,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
GROUP BY
    EXTRACT(MONTH FROM complaint_date),


	COMPLAINT CATEGORY ANALYSIS 2024

ORDER BY complaint_month;

SELECT
    EXTRACT(MONTH FROM complaint_date) AS complaint_month,
    TO_CHAR(complaint_date, 'Month') AS month_name,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
GROUP BY
    EXTRACT(MONTH FROM complaint_date),
    TO_CHAR(complaint_date, 'Month')
ORDER BY complaint_month;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'service_complaints_2024'
ORDER BY ordinal_position;

SELECT
    component_tag,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
GROUP BY component_tag
ORDER BY total_complaints DESC;

SEVERITY WISE COMPLAINTS

SELECT
    severity,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
GROUP BY severity
ORDER BY total_complaints DESC;

COMPLAINT STATUS ANALYSIS

SELECT
    status,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
GROUP BY status
ORDER BY total_complaints DESC;

   CLOMPLAINT RESOLUTION RATE

SELECT
    COUNT(*) AS resolved_closed_complaints,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM service_complaints_2024),
        2
    ) AS resolution_rate_percentage
FROM service_complaints_2024
WHERE status IN ('RESOLVED', 'CLOSED');

COMPLAINT STATUS BREAKDOWN

SELECT
    status,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM service_complaints_2024),
        2
    ) AS status_percentage
FROM service_complaints_2024
GROUP BY status
ORDER BY complaint_count DESC;

ESCALATION ANALYSIS

SELECT
    city,
    COUNT(*) AS escalated_complaints
FROM service_complaints_2024
WHERE status = 'ESCALATED'
GROUP BY city
ORDER BY escalated_complaints DESC
LIMIT 10;

AVERAGE RESOLUTION TIME(TAT_)

SELECT *
FROM service_complaints_2024
LIMIT 5;


SELECT
    COUNT(*) AS negative_tat_records
FROM service_complaints_2024
WHERE tat_days < 0;

SELECT
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    MIN(tat_days) AS minimum_tat_days,
    MAX(tat_days) AS maximum_tat_days
FROM service_complaints_2024
WHERE resolution_date IS NOT NULL
  AND tat_days >= 0;

    TAT BY SEVERITY

	SELECT
    severity,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days
FROM service_complaints_2024
WHERE resolution_date IS NOT NULL
  AND tat_days >= 0
GROUP BY severity
ORDER BY average_tat_days DESC;

COMPONENT WISE COMPLAINTS

SELECT
    component_tag,
    COUNT(*) AS complaint_count
FROM service_complaints_2024
GROUP BY component_tag
ORDER BY complaint_count DESC
LIMIT 10;

  CUSTOMER SATISFACTION ANALYSIS (CSAT)

 SELECT
    ROUND(AVG(csat_score), 2) AS average_csat,
    MIN(csat_score) AS minimum_csat,
    MAX(csat_score) AS maximum_csat
FROM service_complaints_2024
WHERE csat_score IS NOT NULL;

  CSAT  BY STATUS

SELECT
    status,
    COUNT(csat_score) AS rated_complaints,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE csat_score IS NOT NULL
GROUP BY status
ORDER BY average_csat DESC; 

  CSAT BY COMPLAINT CHANNEL

  SELECT
    channel,
    COUNT(csat_score) AS rated_complaints,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE csat_score IS NOT NULL
GROUP BY channel
ORDER BY average_csat DESC;

  COMPLAINT SEVERITY DISTRIBUTION

  SELECT
    severity,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM service_complaints_2024),
        2
    ) AS percentage
FROM service_complaints_2024
GROUP BY severity
ORDER BY complaint_count DESC;


   COMPONENT SEVERITY ANALYSIS

   SELECT
    component_tag,
    severity,
    COUNT(*) AS complaint_count
FROM service_complaints_2024
GROUP BY component_tag, severity
ORDER BY complaint_count DESC
LIMIT 15;


   SERVICE CENTER PERFORMANCE

   SELECT
    assigned_center_id,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE assigned_center_id IS NOT NULL
GROUP BY assigned_center_id
ORDER BY complaint_count DESC
LIMIT 10;


   UNDER PERFORMING SERVICE CENTERS
   
  SELECT
    assigned_center_id,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE assigned_center_id IS NOT NULL
  AND tat_days >= 0
  AND csat_score IS NOT NULL
GROUP BY assigned_center_id
HAVING COUNT(*) >= 50
ORDER BY average_tat_days DESC, average_csat ASC
LIMIT 10; 

  COMPONENT WISE TAT & CSAT

  SELECT
    component_tag,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE component_tag IS NOT NULL
  AND tat_days >= 0
  AND csat_score IS NOT NULL
GROUP BY component_tag
ORDER BY complaint_count DESC

  MONTHLY COMPLAINT TREND

  SELECT
    DATE_TRUNC('month', complaint_date)::date AS complaint_month,
    COUNT(*) AS complaint_count
FROM service_complaints_2024
GROUP BY complaint_month
ORDER BY complaint_month;


   PEAK COMPLAINT MONTH

   SELECT
    DATE_TRUNC('month', complaint_date)::date AS complaint_month,
    COUNT(*) AS complaint_count
FROM service_complaints_2024
GROUP BY complaint_month
ORDER BY complaint_count DESC
LIMIT 1;


  MONTH OVER MONTH TREND

SELECT
    DATE_TRUNC('month', complaint_date)::date AS complaint_month,
    COUNT(*) AS complaint_count,
    LAG(COUNT(*)) OVER (
        ORDER BY DATE_TRUNC('month', complaint_date)
    ) AS previous_month_count,
    COUNT(*) -
    LAG(COUNT(*)) OVER (
        ORDER BY DATE_TRUNC('month', complaint_date)
    ) AS change_from_previous_month
FROM service_complaints_2024
GROUP BY DATE_TRUNC('month', complaint_date)
ORDER BY complaint_month;


   VALIDATE 2024 DATE RANGE

   SELECT
    MIN(complaint_date) AS earliest_complaint_date,
    MAX(complaint_date) AS latest_complaint_date,
    COUNT(*) AS total_records
FROM service_complaints_2024;


SELECT
    DATE_TRUNC('month', complaint_date)::date AS complaint_month,
    COUNT(*) AS complaint_count
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
GROUP BY complaint_month
ORDER BY complaint_month;


   COMPLAINT VOLUME BY CHANNEL

  SELECT
    channel,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM service_complaints_2024
         WHERE complaint_date >= '2024-01-01'
           AND complaint_date < '2025-01-01'),
        2
    ) AS percentage
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
GROUP BY channel
ORDER BY complaint_count DESC; 


   CITY WISE COMPLAINT ANALYSIS

   SELECT
    channel,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM service_complaints_2024
         WHERE complaint_date >= '2024-01-01'
           AND complaint_date < '2025-01-01'),
        2
    ) AS percentage
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
GROUP BY channel
ORDER BY complaint_count DESC;


   CITY WISE COMPLAINT ANALYSIS

   SELECT
    city,
    COUNT(*) AS complaint_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM service_complaints_2024
         WHERE complaint_date >= '2024-01-01'
           AND complaint_date < '2025-01-01'),
        2
    ) AS percentage
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
GROUP BY city
ORDER BY complaint_count DESC
LIMIT 15;

  

   CITY WISE TAT & CSAT ANALYSIS

   SELECT
    city,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
  AND tat_days >= 0
  AND csat_score IS NOT NULL
GROUP BY city
HAVING COUNT(*) >= 100
ORDER BY average_tat_days DESC, average_csat ASC
LIMIT 15;

  HIGH VOLUME  & HIGH TAT PROBLEM AREAS

  SELECT
    city,
    COUNT(*) AS complaint_count,
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    ROUND(AVG(csat_score), 2) AS average_csat
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
  AND tat_days >= 0
  AND csat_score IS NOT NULL
GROUP BY city
HAVING COUNT(*) >= 500
ORDER BY complaint_count DESC, average_tat_days DESC
LIMIT 15;

    Open & Escalated Complaint Backlog by City

	SELECT
    city,
    COUNT(*) AS unresolved_complaints,
    SUM(CASE WHEN status = 'OPEN' THEN 1 ELSE 0 END) AS open_complaints,
    SUM(CASE WHEN status = 'IN_PROGRESS' THEN 1 ELSE 0 END) AS in_progress_complaints,
    SUM(CASE WHEN status = 'ESCALATED' THEN 1 ELSE 0 END) AS escalated_complaints
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
  AND status IN ('OPEN', 'IN_PROGRESS', 'ESCALATED')
GROUP BY city
ORDER BY unresolved_complaints DESC
LIMIT 15;


   FINAL COMPLAINT  KPI SUMMARY

   SELECT
    COUNT(*) AS total_complaints,

    SUM(CASE
        WHEN status IN ('RESOLVED', 'CLOSED') THEN 1
        ELSE 0
    END) AS resolved_closed,

    SUM(CASE
        WHEN status IN ('OPEN', 'IN_PROGRESS', 'ESCALATED') THEN 1
        ELSE 0
    END) AS unresolved_backlog,

    ROUND(
        SUM(CASE
            WHEN status IN ('RESOLVED', 'CLOSED') THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS resolution_rate,

    ROUND(AVG(tat_days) FILTER (WHERE tat_days >= 0), 2)
        AS average_tat_days,

    ROUND(AVG(csat_score), 2)
        AS average_csat,

    SUM(CASE WHEN severity = 'P1' THEN 1 ELSE 0 END)
        AS critical_p1_complaints

FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01';



SELECT
    ROUND(AVG(tat_days), 2) AS average_tat_days,
    MIN(tat_days) AS minimum_tat_days,
    MAX(tat_days) AS maximum_tat_days
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
  AND resolution_date IS NOT NULL
  AND tat_days >= 0;
  