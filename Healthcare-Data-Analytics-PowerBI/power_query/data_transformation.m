// Power Query M Transformation Script for FactAppointments & DimPatients
// Paste in Advanced Editor in Power BI Desktop

// ==========================================
// 1. FactAppointments Transformation
// ==========================================
let
    Source = Csv.Document(File.Contents("C:\HealthcareProject\data\raw\appointments_raw.csv"),[Delimiter=",", Columns=11, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Removed Duplicates" = Table.Distinct(#"Promoted Headers", {"AppointmentID"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Duplicates",{
        {"AppointmentID", Int64.Type}, {"PatientID", Int64.Type}, {"DoctorID", Int64.Type}, 
        {"DepartmentID", Int64.Type}, {"AppointmentDate", type date}, {"AppointmentTime", type time}, 
        {"AppointmentStatus", type text}, {"ConsultationDuration", Int64.Type}, 
        {"WaitingTimeMinutes", Int64.Type}, {"ConsultationFee", Currency.Type}, {"PaymentStatus", type text}
    }),
    #"Cleaned Status Casing" = Table.TransformColumns(#"Changed Type", {{"AppointmentStatus", Text.Clean, type text}, {"AppointmentStatus", Text.Proper, type text}}),
    #"Filtered Invalid Wait Time" = Table.ReplaceValue(#"Cleaned Status Casing", lambda_val => if lambda_val < 0 then 0 else lambda_val, Replacer.ReplaceValue, {"WaitingTimeMinutes"}),
    #"Replaced Duration Outliers" = Table.ReplaceValue(#"Filtered Invalid Wait Time", lambda_val => if lambda_val > 180 then 60 else lambda_val, Replacer.ReplaceValue, {"ConsultationDuration"})
in
    #"Replaced Duration Outliers"

// ==========================================
// 2. DimPatients Transformation
// ==========================================
let
    Source = Csv.Document(File.Contents("C:\HealthcareProject\data\raw\patients_raw.csv"),[Delimiter=",", Columns=6, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Trimmed Patient Name" = Table.TransformColumns(#"Promoted Headers", {{"PatientName", Text.Trim, type text}}),
    #"Standardized Gender" = Table.ReplaceValue(#"Trimmed Patient Name","M","Male",Replacer.ReplaceText,{"Gender"}),
    #"Standardized Gender F" = Table.ReplaceValue(#"Standardized Gender","F","Female",Replacer.ReplaceText,{"Gender"}),
    #"Standardized Gender Lower" = Table.ReplaceValue(#"Standardized Gender F","female","Female",Replacer.ReplaceText,{"Gender"}),
    #"Replaced Null City" = Table.ReplaceValue(#"Standardized Gender Lower",null,"Unknown",Replacer.ReplaceValue,{"City"}),
    #"Changed Types" = Table.TransformColumnTypes(#"Replaced Null City",{{"PatientID", Int64.Type}, {"Age", Int64.Type}, {"RegistrationDate", type date}})
in
    #"Changed Types"
