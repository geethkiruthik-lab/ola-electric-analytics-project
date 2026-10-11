SELECT
    DATE_TRUNC('month', complaint_date)::date AS month,
    COUNT(*) AS total_complaints
FROM service_complaints_2024
WHERE complaint_date >= '2024-01-01'
  AND complaint_date < '2025-01-01'
GROUP BY 1
ORDER BY 1;