SELECT pid, usename, datname, application_name, state
FROM pg_stat_activity
WHERE datname = 'ola_sales';

CREATE TABLE job_cards_2024 (
    jobcard_id VARCHAR(50),
    center_id VARCHAR(50),
    chassis_no VARCHAR(100),
    mobile_hash VARCHAR(100),
    open_date DATE,
    close_date DATE,
    issue_category VARCHAR(100),
    parts_replaced VARCHAR(255),
    parts_cost_inr NUMERIC(12,2),
    labour_cost_inr NUMERIC(12,2),
    technician_id VARCHAR(50),
    status VARCHAR(50),
    linked_ticket_id VARCHAR(50)
);


SELECT jobcard_id, COUNT(*)
FROM job_cards_2024
GROUP BY jobcard_id
HAVING COUNT(*) > 1;


UPDATE job_cards_2024
SET
    jobcard_id = TRIM(jobcard_id),
    center_id = TRIM(center_id),
    chassis_no = TRIM(chassis_no),
    mobile_hash = TRIM(mobile_hash),
    issue_category = TRIM(issue_category),
    parts_replaced = TRIM(parts_replaced),
    technician_id = TRIM(technician_id),
    status = TRIM(status),
    linked_ticket_id = TRIM(linked_ticket_id);