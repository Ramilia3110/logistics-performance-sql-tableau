CREATE DATABASE IF NOT EXISTS logistics_analysis;
USE logistics_analysis;

-- 1. Employee Table
-- CREATE TABLE employee_details (
--     Emp_ID  INT PRIMARY KEY,
--     Emp_NAME VARCHAR(30),
--    Emp_DESIGNATION  VARCHAR(40),
--     Emp_ADDR  VARCHAR(100),
--     Emp_BRANCH  VARCHAR(15),
--    Emp_CONT_NO VARCHAR(20)
-- );

-- -- 2. Membership Table
-- CREATE TABLE membership (
--     membership_id INT PRIMARY KEY,
--     start_date DATE,
--     end_date DATE
-- );

-- -- 3. Customer Table
-- CREATE TABLE customer (
--     customer_id INT PRIMARY KEY,
--     customer_name VARCHAR(30),
--     customer_email VARCHAR(50),
--     customer_phone VARCHAR(20),
--     customer_address VARCHAR(100),
--     customer_type VARCHAR(30),
--     membership_id INT,
--     FOREIGN KEY (membership_id) REFERENCES membership(membership_id)
-- );

-- -- 4. Shipment Details Table
-- CREATE TABLE shipment_details (
--     shipment_id INT PRIMARY KEY,
--     shipment_content VARCHAR(40),
--     shipment_domain VARCHAR(15),
--     shipment_type VARCHAR(15),
--     shipment_weight VARCHAR(10),
--     shipment_charges INT,
--     source_address VARCHAR(100),
--     destination_address VARCHAR(100),
--     customer_id INT,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
-- );

-- -- 5. Status Table
CREATE TABLE status (
    shipment_status_id INT PRIMARY KEY,
    current_status VARCHAR(20),
    sent_date DATE,
    delivery_date DATE
   
);

-- -- 6. Payment Details Table
-- CREATE TABLE payment_details (
--     payment_id VARCHAR(100) PRIMARY KEY,
--     amount INT,
--     payment_status VARCHAR(10),
--     payment_date DATE,
--     payment_mode VARCHAR(25),
--     shipment_id INT,
--     customer_id INT,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
--     FOREIGN KEY (shipment_id) REFERENCES shipment_details(shipment_id)
-- );

-- -- 7. Employee Manages Shipment Table
-- CREATE TABLE employee_manages_shipment (
--     employee_id INT,
--     shipment_id INT,
--     shipment_status_id INT,
--     FOREIGN KEY (employee_id) REFERENCES employee_details(employee_id),
--     FOREIGN KEY (shipment_id) REFERENCES shipment_details(shipment_id),
--     FOREIGN KEY (shipment_status_id) REFERENCES status(shipment_id)
-- );

select * from employee_details


-- DROP TABLE IF EXISTS employee_manages_shipment;
-- DROP TABLE IF EXISTS payment_details;
-- DROP TABLE IF EXISTS status;
-- DROP TABLE IF EXISTS shipment_details;
-- DROP TABLE IF EXISTS customer;
-- DROP TABLE IF EXISTS membership;
-- DROP TABLE IF EXISTS employee_details;
