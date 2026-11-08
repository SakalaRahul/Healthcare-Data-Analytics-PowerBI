# Data Validation Checklist

| Check ID | Validation Step | Expected Result | Pass/Fail Criteria |
| :--- | :--- | :--- | :--- |
| **VAL-01** | Duplicate Appointment IDs | 0 Duplicates | `COUNT(AppointmentID) == COUNT(DISTINCT AppointmentID)` |
| **VAL-02** | Missing Foreign Keys | 0 Null FKs | `PatientID`, `DoctorID`, `DepartmentID` must not be Null |
| **VAL-03** | Invalid Wait Times | 0 Negative Values | `WaitingTimeMinutes >= 0` |
| **VAL-04** | Invalid Consultation Durations | Range 5 to 180 mins | `ConsultationDuration BETWEEN 5 AND 180` |
| **VAL-05** | Revenue Integrity | Non-Completed = $0 Rev | Revenue accumulated only on `Completed` appointments |
