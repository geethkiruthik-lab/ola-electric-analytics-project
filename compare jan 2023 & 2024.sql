SELECT
    CASE
        WHEN d.full_date >= '2024-01-01'
         AND d.full_date < '2024-02-01' THEN 'January 2024'
        WHEN d.full_date >= '2024-10-01'
         AND d.full_date < '2024-11-01' THEN 'October 2024'
    END AS month_period,

    COUNT(*) AS complaint_count,

    ROUND(AVG(f.tat_days), 2) AS mean_tat,

    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY f.tat_days) AS median_tat

FROM public.fact_complaints f
JOIN public.dim_date d
    ON f.date_key = d.date_key

WHERE
    (d.full_date >= '2024-01-01' AND d.full_date < '2024-02-01')
    OR
    (d.full_date >= '2024-10-01' AND d.full_date < '2024-11-01')

GROUP BY 1
ORDER BY 1;