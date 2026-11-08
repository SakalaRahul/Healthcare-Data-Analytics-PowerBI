-- ===============================================================================
-- Script: 02_create_tables.sql
-- Description: Schema definition for Healthcare Analytics Star Schema
-- Author: Rahul Sakala
-- ===============================================================================

USE HealthcareAnalyticsDB;
GO

-- 1. DimDepartments
CREATE TABLE DimDepartments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- 2. DimDoctors
CREATE TABLE DimDoctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(150) NOT NULL,
    DepartmentID INT NOT NULL,
    ExperienceYears INT CHECK (ExperienceYears >= 0),
    ConsultationFee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DimDepartments(DepartmentID)
);

-- 3. DimPatients
CREATE TABLE DimPatients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(150) NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    Age INT CHECK (Age >= 0 AND Age <= 120),
    City VARCHAR(100),
    RegistrationDate DATE NOT NULL
);

-- 4. DimDate
CREATE TABLE DimDate (
    Date DATE PRIMARY KEY,
    Year INT NOT NULL,
    Quarter VARCHAR(5) NOT NULL,
    Month VARCHAR(20) NOT NULL,
    MonthNumber INT NOT NULL,
    MonthYear VARCHAR(15) NOT NULL,
    Day INT NOT NULL,
    DayOfWeek VARCHAR(15) NOT NULL
);

-- 5. FactAppointments
CREATE TABLE FactAppointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    DepartmentID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    AppointmentStatus VARCHAR(30) NOT NULL,
    ConsultationDuration INT CHECK (ConsultationDuration >= 0),
    WaitingTimeMinutes INT CHECK (WaitingTimeMinutes >= 0),
    ConsultationFee DECIMAL(10, 2) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES DimPatients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DimDoctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES DimDepartments(DepartmentID),
    FOREIGN KEY (AppointmentDate) REFERENCES DimDate(Date)
);
