# Power BI Dashboard Design Specifications

## Color Palette & Theme
- **Primary Header Fill:** Dark Navy (`#1B365D`)
- **Accent Color:** Teal (`#008080`)
- **Success Indicator:** Soft Green (`#2E7D32`)
- **Warning / Alert:** Amber / Red (`#C62828`)
- **Background:** Crisp Light Neutral (`#F8F9FA`)

---

## Page 1: Executive Overview
*Target Audience: Hospital C-Suite & Operations Directors*

### Visual Layout Grid:
- **Top Bar (KPI Cards):**
  1. Card 1: `Total Appointments`
  2. Card 2: `Total Revenue`
  3. Card 3: `Completed Appointments`
  4. Card 4: `No-Show Rate %` (Formatted as %, Conditional Color < 10% Green, > 15% Red)
- **Middle Left:** Line Chart - `Monthly Appointment Trend` (Axis: `DimDate[MonthYear]`, Values: `Total Appointments`, `Completed Appointments`).
- **Middle Right:** Column Chart - `Monthly Revenue Trend` (Axis: `DimDate[MonthYear]`, Values: `Total Revenue`).
- **Bottom Left:** Donut Chart - `Appointment Status Distribution` (Legend: `AppointmentStatus`, Values: `Total Appointments`).
- **Bottom Right:** Bar Chart - `Department Performance by Revenue` (Y-Axis: `DepartmentName`, X-Axis: `Total Revenue`).
- **Slicers (Top Right):** Dropdown slicers for `Year` and `DepartmentName`.

---

## Page 2: Department Performance
*Target Audience: Department Heads & Medical Directors*

### Visual Layout Grid:
- **Top Row Cards:** `Avg Waiting Time`, `Completion Rate %`, `Total Revenue`.
- **Main Visual 1:** Clustered Column Chart - `Appointments & Completion Rate by Department` (X-Axis: `DepartmentName`, Y-Axis: `Total Appointments`, Line Y-Axis: `Completion Rate %`).
- **Main Visual 2:** Matrix Table - `Doctor Performance Ranking`
  - Rows: `DepartmentName` -> `DoctorName`
  - Values: `Total Appointments`, `Total Revenue`, `Avg Waiting Time`, `Doctor Performance Score`
  - Conditional Formatting: Data bars on Revenue, Color gradient on Performance Score.

---

## Page 3: Patient & Access Insights
*Target Audience: Patient Experience & Access Managers*

### Visual Layout Grid:
- **Top Metrics:** `Unique Patients`, `Appointments per Patient`, `No-Show Rate %`.
- **Visual 1:** Stacked Bar Chart - `Patient Age Group Distribution` (Age binned: `<18`, `18-35`, `36-50`, `51-65`, `65+`).
- **Visual 2:** Donut Chart - `Patient Gender Distribution`.
- **Visual 3:** Heatmap / Matrix - `No-Show Rates by Day of Week & Department`.

---

## Page 4: Operations & Waiting Time Analysis
*Target Audience: Operational Excellence & Quality Teams*

### Visual Layout Grid:
- **Top Cards:** `Avg Waiting Time`, `Median Waiting Time`, `Waiting Time SLA %`.
- **Visual 1:** Scatter Plot - `Consultation Duration vs. Waiting Time` (X: `ConsultationDuration`, Y: `WaitingTimeMinutes`, Details: `DoctorName`).
- **Visual 2:** Gauge Chart - `Waiting Time SLA Achievement` (Target: 85%, Value: `Waiting Time SLA %`).
- **Visual 3:** Horizontal Bar Chart - `Average Waiting Time by Department` (Target Line: 30 Mins).
