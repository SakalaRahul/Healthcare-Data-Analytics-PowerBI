import pandas as pd
import numpy as np

def run_validation():
    print("==========================================")
    print("  HEALTHCARE DATA VALIDATION TEST SUITE   ")
    print("==========================================
")
    
    appts = pd.read_csv("data/cleaned/appointments_cleaned.csv")
    patients = pd.read_csv("data/cleaned/patients_cleaned.csv")
    doctors = pd.read_csv("data/cleaned/doctors_cleaned.csv")
    
    # Check 1: Duplicate IDs
    dup_appts = appts["AppointmentID"].duplicated().sum()
    print(f"[CHECK 1] Duplicate Appointment IDs: {dup_appts} -> {'PASS' if dup_appts == 0 else 'FAIL'}")
    
    # Check 2: Invalid Waiting Times
    neg_wait = (appts["WaitingTimeMinutes"] < 0).sum()
    print(f"[CHECK 2] Negative Waiting Times: {neg_wait} -> {'PASS' if neg_wait == 0 else 'FAIL'}")
    
    # Check 3: FK Integrity (Patients)
    orphan_patients = (~appts["PatientID"].isin(patients["PatientID"])).sum()
    print(f"[CHECK 3] Orphan Patient IDs: {orphan_patients} -> {'PASS' if orphan_patients == 0 else 'FAIL'}")
    
    # Check 4: Revenue Audit
    unearned_rev = appts[appts["AppointmentStatus"] != "Completed"]["ConsultationFee"].sum()
    print(f"[CHECK 4] Revenue Integrity Audit -> Raw Unearned Fee Sum: ${unearned_rev:,.2f}")
    
    total_completed_rev = appts[appts["AppointmentStatus"] == "Completed"]["ConsultationFee"].sum()
    print(f"
[SUMMARY] Total Valid Earned Revenue: ${total_completed_rev:,.2f}")
    print("==========================================")

if __name__ == "__main__":
    run_validation()
