# Data Import Instructions for SQL Server / MySQL

## Option A: Using SQL Server Management Studio (SSMS)
1. Right-click `HealthcareAnalyticsDB` database in SSMS Object Explorer.
2. Navigate to **Tasks** -> **Import Flat File...**
3. Select the target CSV files from `data/cleaned/`:
   - `departments_cleaned.csv` -> Map to `DimDepartments`
   - `doctors_cleaned.csv` -> Map to `DimDoctors`
   - `patients_cleaned.csv` -> Map to `DimPatients`
   - `calendar_cleaned.csv` -> Map to `DimDate`
   - `appointments_cleaned.csv` -> Map to `FactAppointments`
4. Confirm data types and primary key assignments.
5. Execute import.

## Option B: Using BULK INSERT (T-SQL)
```sql
BULK INSERT DimDepartments
FROM 'C:\path\to\data\cleaned\departments_cleaned.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

BULK INSERT DimDoctors
FROM 'C:\path\to\data\cleaned\doctors_cleaned.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

BULK INSERT DimPatients
FROM 'C:\path\to\data\cleaned\patients_cleaned.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

BULK INSERT DimDate
FROM 'C:\path\to\data\cleaned\calendar_cleaned.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

BULK INSERT FactAppointments
FROM 'C:\path\to\data\cleaned\appointments_cleaned.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');
```
