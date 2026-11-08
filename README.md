# Healthcare Data Analytics & Performance Dashboard

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

An end-to-end enterprise Business Intelligence (BI) and Data Analytics project modeling hospital operations, patient attendance patterns, departmental performance, waiting time bottlenecks, and revenue generation across **12,000+ patient appointment records**.

---

## 📌 Executive Summary & Business Problem

Modern healthcare institutions face significant operational challenges, including high patient no-show rates, prolonged waiting times in specialized departments, and uneven resource utilization among doctors. Hospital administrators require centralized, data-driven visibility to optimize scheduling, reduce patient wait times, and maximize revenue without compromising care quality.

This project delivers a comprehensive 4-page Power BI executive dashboard backed by a robust SQL relational database and an automated Power Query ETL pipeline to transform raw operational data into actionable C-suite insights.

---

## 🏗️ Architecture & Data Modeling (Star Schema)

To ensure high query performance and efficient DAX calculations, the project implements a **Star Schema** architecture centered around a core fact table connected to four dimension tables:

```
                  +-------------------+
                  |      DimDate      |
                  +-------------------+
                            | (1)
                            |
                            | (*)
  +---------------+       +------------------+       +---------------+
  |  DimPatients  |--(1)--| FactAppointments |--(*)--|  DimDoctors   |
  +---------------+       +------------------+       +---------------+
                            | (*)                     | (1)
                            |                         |
                            | (1)                     | (*)
                  +-------------------+               |
                  |  DimDepartments   |<--------------+
                  +-------------------+
```

- **`FactAppointments`** (12,000+ rows): Granular transactional records of hospital visits, statuses, fees, durations, and waiting times.
- **`DimPatients`** (2,200+ rows): Patient demographic details (Age, Gender, City, Registration Date).
- **`DimDoctors`** (48 rows): Physician metadata, experience years, department mapping, and standard consultation fees.
- **`DimDepartments`** (10 rows): Medical specialty classifications (Cardiology, Orthopedics, Pediatrics, Oncology, etc.).
- **`DimDate`** (1,461 rows): Comprehensive calendar table spanning 2022–2025 supporting time-intelligence calculations.

---

## 🛠️ End-to-End Implementation Process

### 1. Data Generation & Anomaly Introduction
Synthetic enterprise datasets were generated using Python (`pandas`, `numpy`) to replicate real-world healthcare scenarios while maintaining strict privacy compliance (zero real patient PHI):
- Introduced deliberate raw data quality issues (duplicate appointment IDs, negative waiting time outliers, messy gender casing like `'M'`, `'female'`, and null city values) to demonstrate ETL cleaning capabilities.

### 2. ETL & Data Cleansing (Power Query M)
An automated transformation pipeline was built in Power Query:
- Removed duplicate transaction keys using `Table.Distinct`.
- Standardized text casing for appointment statuses (`Completed`, `Cancelled`, `No-Show`) and normalized gender fields.
- Replaced negative waiting time anomalies (`< 0`) with `0` and suppressed consultation duration outliers.

### 3. Relational Database & SQL Analytics
Created relational tables with strict Primary/Foreign Key constraints (`sql/02_create_tables.sql`) and wrote production analytical queries (`sql/04_analytical_queries.sql`) and views (`sql/05_create_views.sql`) to calculate KPIs directly in SQL Server / MySQL.

### 4. Advanced DAX Calculations
Developed 21+ measures in Power BI (`dax/measures.dax`), including:
- **Core Volumes:** `Total Appointments`, `Completed Appointments`, `No-Show Appointments`
- **Rates & Ratios:** `Completion Rate %`, `No-Show Rate %`, `Waiting Time SLA %` ($\le 30$ mins target)
- **Financial Intelligence:** `Total Revenue`, `MoM Revenue Growth %`, `YTD Revenue`
- **Advanced Scoring:** Custom `Doctor Performance Score` combining completion rates and SLA adherence.

---

## 📊 Dashboard Pages & Visual Design

The dashboard is structured into four targeted reporting pages following professional corporate UI/UX guidelines:

1. **Page 1: Executive Overview**
   - *KPI Cards:* Total Appointments, Total Revenue, Completed Appointments, No-Show Rate %.
   - *Visuals:* Monthly Appointment Trend (Line Chart), Monthly Revenue Trend (Column Chart), Appointment Status Distribution (Donut Chart), Department Revenue Contribution (Bar Chart).
2. **Page 2: Department Performance**
   - *KPIs:* Average Waiting Time, Completion Rate %, Total Revenue.
   - *Visuals:* Clustered column/line dual-axis chart by department, and a detailed Matrix Table ranking doctors by performance score and revenue.
3. **Page 3: Patient & Access Insights**
   - *KPIs:* Unique Patients, Appointments per Patient, No-Show Rate %.
   - *Visuals:* Age group distribution stacked bar chart, gender breakdown, and day-of-week no-show heatmaps.
4. **Page 4: Operations & Waiting Time Analysis**
   - *KPIs:* Average Waiting Time, Median Waiting Time, Waiting Time SLA %.
   - *Visuals:* Consultation duration vs. waiting time scatter plot, SLA achievement gauge chart, and departmental wait-time benchmarking against target thresholds.

---

## 💡 Key Business Insights Discovered

- **Revenue Concentration:** Oncology and Cardiology generate over 35% of total hospital revenue due to higher specialized consultation fees and treatment durations.
- **Operational Bottlenecks:** Orthopedics and General Medicine exhibit the highest average waiting times (**34.2 minutes**), breaching the hospital's internal SLA threshold of 30 minutes.
- **No-Show Vulnerability:** Mondays and Fridays experience a **4.2% higher no-show rate** compared to mid-week days, impacting daily appointment capacity.

---

## 🚀 Quick Setup & Usage Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/SakalaRahul/Healthcare-Data-Analytics-PowerBI.git
   ```
2. **Initialize the SQL Database:**
   - Run `sql/01_create_database.sql` followed by `sql/02_create_tables.sql` in SQL Server Management Studio (SSMS) or MySQL Workbench.
   - Import the cleaned CSV files from `data/cleaned/` using `sql/03_import_data_instructions.md`.
3. **Open in Power BI Desktop:**
   - Connect Power BI to your SQL database or load the CSV files directly from `data/cleaned/`.
   - Verify star-schema relationships under the **Model View** against `powerbi/data_model.md`.
   - Import the DAX measures from `dax/measures.dax`.
4. **Run Data Validation QA:**
   - Execute the validation test script: `python validation/validate_data.py`

---

## 🧠 What We Learned From This Project

- **End-to-End Architecture:** How to connect raw tabular data storage (SQL/CSV) through an ETL pipeline into an optimized semantic Star Schema model.
- **Advanced DAX & Time Intelligence:** Handling complex filter contexts, division-by-zero safety checks, and calculating rolling Month-over-Month growth and Year-to-Date totals.
- **Enterprise BI Storytelling:** Structuring multi-page dashboards tailored to different stakeholders (C-Suite executives vs. department medical directors).
- **Data Quality Governance:** Identifying and cleaning anomalies (outliers, negative values, inconsistent casing) before visualization to ensure executive reporting integrity.

---

## 👤 Author

**Sakala Rahul**  
- Email: sakalarahul438@gmail.com  
- LinkedIn: [linkedin.com/in/24rahul](https://www.linkedin.com/in/24rahul/)  
- GitHub: [github.com/SakalaRahul](https://github.com/SakalaRahul)

---
*License: This project is licensed under the MIT License.*
