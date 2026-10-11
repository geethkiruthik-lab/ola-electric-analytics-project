CREATE TABLE competitor_incidents (
    incident_id VARCHAR(20) PRIMARY KEY,
    oem VARCHAR(50),
    date TIMESTAMP,
    incident_type VARCHAR(50),
    units_affected INTEGER,
    resolution_days INTEGER,
    source VARCHAR(50)
);


CREATE TABLE service_complaints_2024 (
    ticket_id VARCHAR(50),
    customer_id VARCHAR(50),
    vehicle_reg_no VARCHAR(30),
    city VARCHAR(50),
    complaint_date DATE,
    channel VARCHAR(50),
    complaint_text TEXT,
    component_tag VARCHAR(100),
    severity VARCHAR(20),
    status VARCHAR(30),
    resolution_date DATE,
    tat_days INTEGER,
    csat_score NUMERIC(5,2),
    assigned_center_id VARCHAR(50)
);




CREATE TABLE service_complaints_2023 (
    ticket_id VARCHAR(50),
    customer_id VARCHAR(50),
    vehicle_reg_no VARCHAR(30),
    city VARCHAR(50),
    complaint_date DATE,
    channel VARCHAR(50),
    complaint_text TEXT,
    component_tag VARCHAR(100),
    severity VARCHAR(20),
    status VARCHAR(30),
    resolution_date DATE,
    tat_days INTEGER,
    csat_score NUMERIC(5,2),
    assigned_center_id VARCHAR(50)
);


CREATE TABLE warranty_claims (
    claim_id VARCHAR(50),
    chassis_no VARCHAR(50),
    vehicle_reg_no VARCHAR(30),
    claim_date DATE,
    component VARCHAR(100),
    claim_amount NUMERIC(12,2),
    currency VARCHAR(10),
    km_at_claim INTEGER,
    approved_flag VARCHAR(10),
    dealer_center_id VARCHAR(50)
);



SELECT * FROM warranty_claims;

SELECT * FROM spare_parts_consumption;