package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Prescription generated by hbm2java
 */
public class Prescription  implements java.io.Serializable {


     private Integer idprescription;
     private Doctor doctor;
     private Patient patient;
     private PatientToken patientToken;
     private User user;
     private String date;
     private String time;
     private Double medicineCost;
     private Double doctorCharge;
     private Double receivableAmount;
     private Double paidAmount;
     private String note;
     private Double cash;
     private Double balance;
     private String settleDate;
     private String settleTime;
     private Integer status;
     private Set prescriptionItems = new HashSet(0);

    public Prescription() {
    }

	
    public Prescription(Doctor doctor, Patient patient, PatientToken patientToken, User user) {
        this.doctor = doctor;
        this.patient = patient;
        this.patientToken = patientToken;
        this.user = user;
    }
    public Prescription(Doctor doctor, Patient patient, PatientToken patientToken, User user, String date, String time, Double medicineCost, Double doctorCharge, Double receivableAmount, Double paidAmount, String note, Double cash, Double balance, String settleDate, String settleTime, Integer status, Set prescriptionItems) {
       this.doctor = doctor;
       this.patient = patient;
       this.patientToken = patientToken;
       this.user = user;
       this.date = date;
       this.time = time;
       this.medicineCost = medicineCost;
       this.doctorCharge = doctorCharge;
       this.receivableAmount = receivableAmount;
       this.paidAmount = paidAmount;
       this.note = note;
       this.cash = cash;
       this.balance = balance;
       this.settleDate = settleDate;
       this.settleTime = settleTime;
       this.status = status;
       this.prescriptionItems = prescriptionItems;
    }
   
    public Integer getIdprescription() {
        return this.idprescription;
    }
    
    public void setIdprescription(Integer idprescription) {
        this.idprescription = idprescription;
    }
    public Doctor getDoctor() {
        return this.doctor;
    }
    
    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
    public Patient getPatient() {
        return this.patient;
    }
    
    public void setPatient(Patient patient) {
        this.patient = patient;
    }
    public PatientToken getPatientToken() {
        return this.patientToken;
    }
    
    public void setPatientToken(PatientToken patientToken) {
        this.patientToken = patientToken;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Double getMedicineCost() {
        return this.medicineCost;
    }
    
    public void setMedicineCost(Double medicineCost) {
        this.medicineCost = medicineCost;
    }
    public Double getDoctorCharge() {
        return this.doctorCharge;
    }
    
    public void setDoctorCharge(Double doctorCharge) {
        this.doctorCharge = doctorCharge;
    }
    public Double getReceivableAmount() {
        return this.receivableAmount;
    }
    
    public void setReceivableAmount(Double receivableAmount) {
        this.receivableAmount = receivableAmount;
    }
    public Double getPaidAmount() {
        return this.paidAmount;
    }
    
    public void setPaidAmount(Double paidAmount) {
        this.paidAmount = paidAmount;
    }
    public String getNote() {
        return this.note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    public Double getCash() {
        return this.cash;
    }
    
    public void setCash(Double cash) {
        this.cash = cash;
    }
    public Double getBalance() {
        return this.balance;
    }
    
    public void setBalance(Double balance) {
        this.balance = balance;
    }
    public String getSettleDate() {
        return this.settleDate;
    }
    
    public void setSettleDate(String settleDate) {
        this.settleDate = settleDate;
    }
    public String getSettleTime() {
        return this.settleTime;
    }
    
    public void setSettleTime(String settleTime) {
        this.settleTime = settleTime;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getPrescriptionItems() {
        return this.prescriptionItems;
    }
    
    public void setPrescriptionItems(Set prescriptionItems) {
        this.prescriptionItems = prescriptionItems;
    }




}


