package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1



/**
 * Mess generated by hbm2java
 */
public class Mess  implements java.io.Serializable {


     private Integer idmess;
     private Account accountByEmployee;
     private Account accountByCustomer;
     private Integer status;
     private String date;
     private String remarks;

    public Mess() {
    }

	
    public Mess(Account accountByEmployee, Account accountByCustomer) {
        this.accountByEmployee = accountByEmployee;
        this.accountByCustomer = accountByCustomer;
    }
    public Mess(Account accountByEmployee, Account accountByCustomer, Integer status, String date, String remarks) {
       this.accountByEmployee = accountByEmployee;
       this.accountByCustomer = accountByCustomer;
       this.status = status;
       this.date = date;
       this.remarks = remarks;
    }
   
    public Integer getIdmess() {
        return this.idmess;
    }
    
    public void setIdmess(Integer idmess) {
        this.idmess = idmess;
    }
    public Account getAccountByEmployee() {
        return this.accountByEmployee;
    }
    
    public void setAccountByEmployee(Account accountByEmployee) {
        this.accountByEmployee = accountByEmployee;
    }
    public Account getAccountByCustomer() {
        return this.accountByCustomer;
    }
    
    public void setAccountByCustomer(Account accountByCustomer) {
        this.accountByCustomer = accountByCustomer;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getRemarks() {
        return this.remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }




}


