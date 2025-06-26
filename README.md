# 📊 Logistics Performance Analysis: SQL + Tableau Project

This project explores delivery performance for a fictional logistics startup based in Bishkek, using MySQL for data analysis and Tableau for visual storytelling.

---

## 🗂️ Data Sources

All data is fictional and created for the purpose of analysis.

- **MySQL Database** (simulated):
  - Delivery status, shipment details, and employee management
- **Exported SQL Results:**
  - 9 CSVs located in the `/data/` folder used to build Tableau dashboards

---

## 🎯 Project Objectives

- Analyze delivery efficiency (average, min, max delivery time)
- Identify fastest and slowest deliveries
- Compare Express vs Regular shipments
- Group delivery times into buckets
- Track undelivered shipment percentages
- Visualize all findings using Tableau

---

## 🧠 SQL Analysis Highlights

📄 SQL queries are saved in [`sql/shipment_performance.sql`](./sql/shipment_performance.sql)

**Key Findings:**

| Metric                  | Value       |
| ----------------------- | ----------- |
| Total Shipments         | 214         |
| Avg Delivery Time       | 109.62 days |
| Min Delivery Time       | 1 day       |
| Max Delivery Time       | 290 days    |
| Std Deviation           | 83.66 days  |
| Delivered Shipments     | 51.4%       |
| Not Delivered Shipments | 48.6%       |

**Extremely Delayed Shipments (> 270 days):**

- 3 shipments experienced extreme delays and may indicate operational or external issues.

**Shipment Type Analysis:**

- Express Avg Time: 87.58 days
- Regular Avg Time: 107.00 days
- Both have ~48% non-delivery rate

---

## 📈 Tableau Dashboard

The Tableau dashboard visualizes:

- 📌 KPIs (total, average, min/max delivery time)
- 📦 Delivery buckets: 0–30, 31–90, 91–180, etc.
- 🚚 Fastest & slowest deliveries
- ❗ Extreme delays
- 📉 Non-delivery % by shipment type

> ⚠️ _Employee delivery performance was excluded in Tableau._

📷 **Dashboard Preview:**

https://github.com/Ramilia3110/logistics-performance-sql-tableau/blob/main/tableau/dashboard.png

---

## 📁 Folder Structure

logistics-performance-sql-tableau/
├── sql/
│ └── shipment_performance.sql
│ ├── create_tables.sql
├── data/
│ ├── kpi_summary.csv
│ ├── fastest_deliveries.csv
│ ├── slowest_deliveries.csv
│ ├── delivery_buckets.csv
│ ├── extreme_delays.csv
│ ├── shipment_type_avg.csv
│ ├── delivery_status_percentage.csv
│ ├── shipment_type_failure.csv
│ └── (and others...)
├── tableau/
│ └── dashboardpng
├── README.md

## ▶️ How to Reproduce

1. Clone the project:
   ```bash
   git clone https://github.com/Ramilia3110/logistics-performance-sql-tableau.git
   ```
2. Import the SQL script:

   Run sql/shipment_performance.sql in MySQL Workbench or any SQL client

3. Use Tableau:

   Open Tableau and connect to the 9 CSVs in /data/

   Rebuild or explore the dashboard layout

👤 Author
Ramilia Imankulova
Aspiring Data Analyst | Based in Bishkek
GitHub
