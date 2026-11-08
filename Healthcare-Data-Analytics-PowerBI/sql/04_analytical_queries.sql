-- ===============================================================================
-- Script: 04_analytical_queries.sql
-- Description: Key Analytical SQL Queries for Healthcare KPI Metrics
-- Author: Rahul Sakala
-- ===============================================================================

USE HealthcareAnalyticsDB;
GO

-- 1. Total, Completed, Cancelled, and No-Show Appointment Counts
SELECT 
    COUNT(AppointmentID) AS TotalAppointments,
    SUM(CASE WHEN AppointmentStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedAppointments,
    SUM(CASE WHEN AppointmentStatus = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledAppointments,
    SUM(CASE WHEN AppointmentStatus = 'No-Show' THEN 1 ELSE 0 END) AS NoShowAppointments,
    ROUND(SUM(CASE WHEN AppointmentStatus = 'No-Show' THEN 1.0 ELSE 0 END) / COUNT(AppointmentID) * 100, 2) AS NoShowPercentage
FROM FactAppointments;

-- 2. Monthly Appointment Trends
SELECT 
    d.Year,
    d.MonthNumber,
    d.MonthYear,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN a.ConsultationFee ELSE 0 END) AS TotalRevenue
FROM FactAppointments a
JOIN DimDate d ON a.AppointmentDate = d.Date
GROUP BY d.Year, d.MonthNumber, d.MonthYear
ORDER BY d.Year, d.MonthNumber;

-- 3. Department-wise Appointment and Revenue Performance
SELECT 
    dept.DepartmentName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedAppointments,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN a.ConsultationFee ELSE 0 END) AS TotalRevenue,
    ROUND(AVG(a.WaitingTimeMinutes), 2) AS AvgWaitingTimeMinutes
FROM FactAppointments a
JOIN DimDepartments dept ON a.DepartmentID = dept.DepartmentID
GROUP BY dept.DepartmentName
ORDER BY TotalRevenue DESC;

-- 4. Doctor Performance Ranking
SELECT 
    doc.DoctorName,
    dept.DepartmentName,
    doc.ExperienceYears,
    COUNT(a.AppointmentID) AS TotalAppointmentsHandled,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN a.ConsultationFee ELSE 0 END) AS TotalRevenueGenerated,
    ROUND(AVG(a.WaitingTimeMinutes), 2) AS AvgPatientWaitMinutes
FROM FactAppointments a
JOIN DimDoctors doc ON a.DoctorID = doc.DoctorID
JOIN DimDepartments dept ON doc.DepartmentID = dept.DepartmentID
GROUP BY doc.DoctorName, dept.DepartmentName, doc.ExperienceYears
ORDER BY TotalRevenueGenerated DESC;

-- 5. Patient Attendance Frequency Analysis
SELECT 
    PatientID,
    COUNT(AppointmentID) AS TimesVisited,
    SUM(CASE WHEN AppointmentStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedVisits,
    SUM(CASE WHEN AppointmentStatus = 'No-Show' THEN 1 ELSE 0 END) AS NoShowCount
FROM FactAppointments
GROUP BY PatientID
HAVING COUNT(AppointmentID) >= 5
ORDER BY TimesVisited DESC;
