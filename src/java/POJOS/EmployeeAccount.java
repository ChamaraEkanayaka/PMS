package POJOS;
// Generated Jan 27, 2021 3:30:14 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * EmployeeAccount generated by hbm2java
 */
public class EmployeeAccount  implements java.io.Serializable {


     private Integer idemployeeAccount;
     private Branch branch;
     private User user;
     private String name;
     private String addedDate;
     private String addedTime;
     private Integer status;
     private Set payEmployees = new HashSet(0);

    public EmployeeAccount() {
    }

	
    public EmployeeAccount(Branch branch, User user) {
        this.branch = branch;
        this.user = user;
    }
    public EmployeeAccount(Branch branch, User user, String name, String addedDate, String addedTime, Integer status, Set payEmployees) {
       this.branch = branch;
       this.user = user;
       this.name = name;
       this.addedDate = addedDate;
       this.addedTime = addedTime;
       this.status = status;
       this.payEmployees = payEmployees;
    }
   
    public Integer getIdemployeeAccount() {
        return this.idemployeeAccount;
    }
    
    public void setIdemployeeAccount(Integer idemployeeAccount) {
        this.idemployeeAccount = idemployeeAccount;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getAddedDate() {
        return this.addedDate;
    }
    
    public void setAddedDate(String addedDate) {
        this.addedDate = addedDate;
    }
    public String getAddedTime() {
        return this.addedTime;
    }
    
    public void setAddedTime(String addedTime) {
        this.addedTime = addedTime;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getPayEmployees() {
        return this.payEmployees;
    }
    
    public void setPayEmployees(Set payEmployees) {
        this.payEmployees = payEmployees;
    }




}


