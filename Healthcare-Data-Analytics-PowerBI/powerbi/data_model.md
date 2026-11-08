# Power BI Star Schema Data Model

The data architecture follows a **Star Schema** centered around the `FactAppointments` fact table, connected to four dimension tables.

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

## Relationships Specification
1. **FactAppointments [PatientID] -> DimPatients [PatientID]**
   - Cardinality: Many to One (`* : 1`)
   - Cross filter direction: Single (DimPatients filters FactAppointments)
2. **FactAppointments [DoctorID] -> DimDoctors [DoctorID]**
   - Cardinality: Many to One (`* : 1`)
   - Cross filter direction: Single (DimDoctors filters FactAppointments)
3. **FactAppointments [DepartmentID] -> DimDepartments [DepartmentID]**
   - Cardinality: Many to One (`* : 1`)
   - Cross filter direction: Single (DimDepartments filters FactAppointments)
4. **FactAppointments [AppointmentDate] -> DimDate [Date]**
   - Cardinality: Many to One (`* : 1`)
   - Cross filter direction: Single (DimDate filters FactAppointments)
5. **DimDoctors [DepartmentID] -> DimDepartments [DepartmentID]**
   - Cardinality: Many to One (`* : 1`)
   - Cross filter direction: Single
