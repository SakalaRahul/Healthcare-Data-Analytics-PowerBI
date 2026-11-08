# Healthcare Data Analytics & Performance Dashboard

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

An end-to-end enterprise business intelligence and data analytics project analyzing hospital operations, patient attendance, appointment outcomes, waiting times, and revenue performance across 12,000+ appointment records.

---

## 📌 Project Architecture & Star Schema
The project uses a clean **Star Schema** data model for optimized DAX performance in Power BI Desktop:
- **Fact Table:** `FactAppointments` (12,000 records)
- **Dimension Tables:** `DimPatients`, `DimDoctors`, `DimDepartments`, `DimDate`

---

## 🛠️ Key Technical Features
1. **SQL Database:** Production SQL creation scripts, analytical queries, and views for C-suite KPI reporting.
2. **Power Query (M):** Automated ETL pipeline handling text cleaning, casing standardization, outlier suppression, and null handling.
3. **DAX Measures:** 21+ measures including MoM Revenue Growth %, YTD Revenue, Waiting Time SLA Achievement %, and custom Doctor Performance Scores.
4. **Multi-Page Power BI Dashboard:**
   - Page 1: Executive Overview
   - Page 2: Department Performance
   - Page 3: Patient & Access Insights
   - Page 4: Operations & Waiting Time Analysis

---

## 🚀 Quick Setup & Usage Instructions
1. **Clone Repository:** `git clone https://github.com/SakalaRahul/Healthcare-Data-Analytics-PowerBI.git`
2. **Execute SQL Scripts:** Run `sql/01_create_database.sql` and `sql/02_create_tables.sql` in SSMS or MySQL Workbench.
3. **Load Cleaned Data:** Import CSVs from `data/cleaned/` into the SQL database.
4. **Open Power BI Desktop:** Connect to SQL Server or load the CSV files directly, apply DAX measures from `dax/measures.dax`, and build visuals as specified in `powerbi/dashboard_design.md`.

---

## 📊 Sample Screenshots
*(Add dashboard visual screenshots here after importing into Power BI)*
- `screenshots/01_Executive_Overview.png`
- `screenshots/02_Department_Performance.png`

---
**Author:** Sakala Rahul  
**Contact:** sakalarahul438@gmail.com | [LinkedIn](https://www.linkedin.com/in/24rahul/)
