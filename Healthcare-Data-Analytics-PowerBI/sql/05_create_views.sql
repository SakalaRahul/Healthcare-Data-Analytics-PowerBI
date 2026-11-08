-- ===============================================================================
-- Script: 05_create_views.sql
-- Description: Production Database Views for Power BI Reporting Integration
-- Author: Rahul Sakala
-- ===============================================================================

USE HealthcareAnalyticsDB;
GO

-- 1. View for Executive KPI Summary
CREATE VIEW vw_ExecutiveKPISummary AS
SELECT 
    a.AppointmentID,
    a.AppointmentDate,
    d.Year,
    d.MonthYear,
    d.Quarter,
    dept.DepartmentName,
    doc.DoctorName,
    p.Gender,
    p.Age,
    a.AppointmentStatus,
    a.ConsultationFee,
    a.WaitingTimeMinutes,
    a.ConsultationDuration,
    CASE WHEN a.AppointmentStatus = 'Completed' THEN a.ConsultationFee ELSE 0 END AS Revenue
FROM FactAppointments a
JOIN DimDate d ON a.AppointmentDate = d.Date
JOIN DimDepartments dept ON a.DepartmentID = dept.DepartmentID
JOIN DimDoctors doc ON a.DoctorID = doc.DoctorID
JOIN DimPatients p ON a.PatientID = p.PatientID;
GO

-- 2. View for Department Performance Summary
CREATE VIEW vw_DepartmentPerformance AS
SELECT 
    dept.DepartmentName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedCount,
    SUM(CASE WHEN a.AppointmentStatus = 'No-Show' THEN 1 ELSE 0 END) AS NoShowCount,
    SUM(CASE WHEN a.AppointmentStatus = 'Completed' THEN a.ConsultationFee ELSE 0 END) AS TotalRevenue,
    AVG(a.WaitingTimeMinutes) AS AvgWaitingTime
FROM FactAppointments a
JOIN DimDepartments dept ON a.DepartmentID = dept.DepartmentID
GROUP BY dept.DepartmentName;
GO
