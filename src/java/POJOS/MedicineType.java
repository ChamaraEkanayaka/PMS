package POJOS;
// Generated Jan 30, 2021 12:28:20 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * MedicineType generated by hbm2java
 */
public class MedicineType  implements java.io.Serializable {


     private Integer medicineTypeId;
     private String name;
     private Integer status;
     private Set prescriptionItems = new HashSet(0);

    public MedicineType() {
    }

    public MedicineType(String name, Integer status, Set prescriptionItems) {
       this.name = name;
       this.status = status;
       this.prescriptionItems = prescriptionItems;
    }
   
    public Integer getMedicineTypeId() {
        return this.medicineTypeId;
    }
    
    public void setMedicineTypeId(Integer medicineTypeId) {
        this.medicineTypeId = medicineTypeId;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
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

