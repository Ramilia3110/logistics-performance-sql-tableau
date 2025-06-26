USE logistics_analysis;

-- 📌 1. Delivery Time Statistics
-- Average, minimum, maximum, and standard deviation of delivery durations

SELECT 
    ROUND(AVG(DATEDIFF(delivery_date, sent_date)), 2) AS avg_delivery_days,
    MIN(DATEDIFF(delivery_date, sent_date)) AS min_days,
    MAX(DATEDIFF(delivery_date, sent_date)) AS max_days,
    ROUND(STDDEV(DATEDIFF(delivery_date, sent_date)), 2) AS std_dev_days
FROM status
WHERE delivery_date IS NOT NULL AND sent_date <= delivery_date;
-- Output: avg=109.62 | min=1 | max=290 | std_dev=83.66

-- 📊 1.a Delivery Time Buckets
-- Categorizing delivery durations into ranges

SELECT 
    CASE
        WHEN DATEDIFF(delivery_date, sent_date) <= 30 THEN '0–30 days'
        WHEN DATEDIFF(delivery_date, sent_date) <= 90 THEN '31–90 days'
        WHEN DATEDIFF(delivery_date, sent_date) <= 180 THEN '91–180 days'
        WHEN DATEDIFF(delivery_date, sent_date) <= 270 THEN '181–270 days'
        ELSE '271+ days'
    END AS delivery_bucket,
    COUNT(*) AS shipment_count
FROM status
WHERE delivery_date IS NOT NULL AND sent_date <= delivery_date
GROUP BY delivery_bucket
ORDER BY delivery_bucket;

-- 📌 1.b Outlier Detection: Extremely Delayed Shipments (> 270 days)

SELECT 
    shipment_status_id,
    DATEDIFF(delivery_date, sent_date) AS delivery_days
FROM status
WHERE DATEDIFF(delivery_date, sent_date) > 270;

-- 🔍 Business Insight: Shipments taking more than 270 days (3 examples found) may indicate serious issues like customs delay, misrouting, or operational failure.

-- 📈 1.c Delivery Time Distribution Using Percentile Ranking

SELECT 
    shipment_status_id,
    DATEDIFF(delivery_date, sent_date) AS delivery_days,
    PERCENT_RANK() OVER (ORDER BY DATEDIFF(delivery_date, sent_date)) AS percentile
FROM status
WHERE delivery_date IS NOT NULL AND sent_date <= delivery_date;

-- 🟢 Top 10% Fastest Deliveries

SELECT * FROM (
    SELECT 
        shipment_status_id,
        DATEDIFF(delivery_date, sent_date) AS delivery_days,
        PERCENT_RANK() OVER (ORDER BY DATEDIFF(delivery_date, sent_date)) AS percentile
    FROM status
    WHERE delivery_date IS NOT NULL AND sent_date <= delivery_date
) AS ranked
WHERE percentile <= 0.1;

-- 🔴 Bottom 10% Slowest Deliveries

SELECT * FROM (
    SELECT 
        shipment_status_id,
        DATEDIFF(delivery_date, sent_date) AS delivery_days,
        PERCENT_RANK() OVER (ORDER BY DATEDIFF(delivery_date, sent_date)) AS percentile
    FROM status
    WHERE delivery_date IS NOT NULL AND sent_date <= delivery_date
) AS ranked
WHERE percentile >= 0.9;

-- 📌 2. Average Delivery Time by Shipment Type

SELECT 
    s.shipment_type,
    ROUND(AVG(DATEDIFF(st.delivery_date, st.sent_date)), 2) AS avg_delivery_days
FROM shipment_details s
JOIN status st ON s.shipment_id = st.shipment_status_id
WHERE st.delivery_date IS NOT NULL AND st.sent_date <= st.delivery_date
GROUP BY s.shipment_type;
-- Output: Express: 87.58 | Regular: 107.00

-- 📌 3. Delivery Rate Overview

SELECT 
    current_status,
    COUNT(*) AS total_shipments,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM status), 2) AS percentage
FROM status
GROUP BY current_status;
-- Output: DELIVERED 51.40% | NOT DELIVERED 48.60%

-- 📌 4. Delivery Performance by Employee

SELECT 
    ems.Emp_ID,
    COUNT(*) AS total_shipments,
    SUM(CASE WHEN st.current_status = 'DELIVERED' THEN 1 ELSE 0 END) AS delivered,
    ROUND(SUM(CASE WHEN st.current_status = 'DELIVERED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS delivery_rate
FROM employee_manages_shipment ems
JOIN status st ON ems.shipment_status_id = st.shipment_status_id
GROUP BY ems.Emp_ID
ORDER BY total_shipments DESC;

-- 📌 4.a Employees Managing More than One Shipment

SELECT 
    Emp_ID, COUNT(*) AS num_shipments
FROM employee_manages_shipment
GROUP BY Emp_ID
HAVING COUNT(*) > 1;

-- 📌 5. Non-Delivery Rate by Shipment Type

SELECT 
    s.shipment_type,
    COUNT(*) AS total,
    SUM(CASE WHEN st.current_status != 'DELIVERED' THEN 1 ELSE 0 END) AS not_delivered,
    ROUND(SUM(CASE WHEN st.current_status != 'DELIVERED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS not_delivered_pct
FROM shipment_details s
JOIN status st ON s.shipment_id = st.shipment_status_id
GROUP BY s.shipment_type;

-- Output:
-- Express: 48.70% not delivered
-- Regular: 48.48% not delivered

-- 📌 6. Average Charges: Delivered vs Not Delivered Shipments

SELECT 
    st.current_status,
    ROUND(AVG(sd.shipment_charges), 2) AS avg_charges
FROM status st
JOIN shipment_details sd ON st.shipment_status_id = sd.shipment_id
GROUP BY st.current_status;

-- Output:
-- Delivered: $945.57
-- Not Delivered: $947.56

-- 📌 7. Total Shipments Count for Reference

SELECT COUNT(*) AS total_shipments FROM shipment_details;
-- Output: 214


                            -- SUMMARY--

-- Average delivery time: ~110 days with a high deviation (84 days)

-- Only 51.4% deliveries succeeded, which needs immediate attention

-- Almost 49% of shipments failed, regardless of type (Express or Regular)

-- Fastest 10% of shipments arrived in under 5 days; slowest took 231+ days

-- Extremely delayed shipments (over 270 days) should be investigated

-- Delivery performance per employee helps pinpoint responsibility and reward efficiency