EDA Summary

SELECT
    COUNT(*) AS total_records,
    SUM(qty) AS total_quantity,
    ROUND(SUM(rev_inr_lakh), 2) AS total_revenue_lakh,
    ROUND(AVG(qty), 2) AS avg_quantity,
    ROUND(AVG(rev_inr_lakh), 2) AS avg_revenue_lakh
FROM public.archived_sales_legacy;


Monthly Sales Trend

SELECT
    DATE_TRUNC('month', txn_dt)::date AS month,
    SUM(qty) AS total_quantity,
    ROUND(SUM(rev_inr_lakh), 2) AS total_revenue_lakh
FROM public.archived_sales_legacy
GROUP BY DATE_TRUNC('month', txn_dt)
ORDER BY month;


City wise sales

SELECT
    cty AS city,
    SUM(qty) AS total_quantity,
    ROUND(SUM(rev_inr_lakh), 2) AS total_revenue_lakh
FROM public.archived_sales_legacy
GROUP BY cty
ORDER BY total_revenue_lakh DESC;


Model 

