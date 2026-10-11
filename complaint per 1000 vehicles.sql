SELECT *
FROM public.fact_sales
LIMIT 5;

SELECT *
FROM public.vehicle_registrations_2023
LIMIT 5;


   MONTHLY VEHICLE REGITRATION 2023


SELECT
    DATE_TRUNC('month', reg_date)::date AS month,
    SUM(registrations) AS total_vehicles
FROM public.vehicle_registrations_2023
WHERE reg_date >= '2023-01-01'
  AND reg_date < '2024-01-01'
GROUP BY 1
ORDER BY 1;

 


   MONTHLY VEHICLE REGISTRATION 2024

  
  SELECT
    DATE_TRUNC('month', reg_date)::date AS month,
    SUM(registrations) AS total_vehicles
FROM public.vehicle_registrations_2024
WHERE reg_date >= '2024-01-01'
  AND reg_date < '2025-01-01'
GROUP BY 1
ORDER BY 1;

      COMPLAINT PER 1000 VEHICLES 2023

WITH monthly_complaints AS (
    SELECT
        DATE_TRUNC('month', complaint_date)::date AS month,
        COUNT(*) AS total_complaints
    FROM service_complaints_2023
    GROUP BY 1
),

monthly_vehicles AS (
    SELECT
        DATE_TRUNC('month', reg_date)::date AS month,
        SUM(registrations) AS total_vehicles
    FROM public.vehicle_registrations_2023
    GROUP BY 1
)

SELECT
    c.month,
    c.total_complaints,
    v.total_vehicles,
    ROUND(
        (c.total_complaints::numeric / NULLIF(v.total_vehicles, 0)) * 1000,
        2
    ) AS complaints_per_1000_vehicles
FROM monthly_complaints c
JOIN monthly_vehicles v
    ON c.month = v.month
ORDER BY c.month;


    COMPLAINT PER 1000 VEHICLES 2024


SELECT
    MIN(reg_date) AS first_date,
    MAX(reg_date) AS last_date,
    COUNT(*) AS total_rows
FROM vehicle_registrations_2023;



WITH monthly_complaints AS (
    SELECT
        DATE_TRUNC('month', complaint_date)::date AS month,
        COUNT(*) AS total_complaints
    FROM service_complaints_2024
    GROUP BY 1
),

monthly_vehicles AS (
    SELECT
        DATE_TRUNC('month', reg_date)::date AS month,
        SUM(registrations) AS total_vehicles
    FROM vehicle_registrations_2023
    WHERE reg_date >= '2024-01-01'
      AND reg_date < '2025-01-01'
    GROUP BY 1
)

SELECT
    c.month,
    c.total_complaints,
    v.total_vehicles,
    ROUND(
        (c.total_complaints::numeric /
         NULLIF(v.total_vehicles, 0)) * 1000,
        2
    ) AS complaints_per_1000_vehicles
FROM monthly_complaints c
JOIN monthly_vehicles v
    ON c.month = v.month
ORDER BY c.month;


SELECT *
FROM public.service_centers_master
LIMIT 5;


WITH monthly_vehicles AS (
    SELECT
        DATE_TRUNC('month', reg_date)::date AS month,
        SUM(registrations) AS total_vehicles
    FROM public.vehicle_registrations_2023
    WHERE reg_date >= '2023-01-01'
      AND reg_date < '2025-01-01'
    GROUP BY 1
),

monthly_active_centers AS (
    SELECT
        v.month,
        COUNT(s.center_id) AS active_service_centers
    FROM monthly_vehicles v
    JOIN public.service_centers_master s
        ON s.opened_date <= v.month
    GROUP BY v.month
)

SELECT
    v.month,
    v.total_vehicles,
    a.active_service_centers,
    ROUND(
        v.total_vehicles::numeric /
        NULLIF(a.active_service_centers, 0),
        2
    ) AS vehicles_per_active_service_center
FROM monthly_vehicles v
JOIN monthly_active_centers a
    ON v.month = a.month
ORDER BY v.month;


SELECT
    d.full_date AS sale_date,
    SUM(fs.quantity) AS daily_sales
FROM public.fact_sales fs
JOIN public.dim_date d
    ON fs.date_key = d.date_key
WHERE d.full_date >= '2024-01-01'
  AND d.full_date < '2025-01-01'
GROUP BY d.full_date
ORDER BY d.full_date;
