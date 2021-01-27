package POJOS;
// Generated Jan 27, 2021 3:30:14 PM by Hibernate Tools 4.3.1



/**
 * PayExpencess generated by hbm2java
 */
public class PayExpencess  implements java.io.Serializable {


     private Integer idpayExpencess;
     private ExpencessAccount expencessAccount;
     private User user;
     private Double amount;
     private Integer status;
     private String addedDate;
     private String addedTime;
     private String remark;

    public PayExpencess() {
    }

	
    public PayExpencess(ExpencessAccount expencessAccount, User user) {
        this.expencessAccount = expencessAccount;
        this.user = user;
    }
    public PayExpencess(ExpencessAccount expencessAccount, User user, Double amount, Integer status, String addedDate, String addedTime, String remark) {
       this.expencessAccount = expencessAccount;
       this.user = user;
       this.amount = amount;
       this.status = status;
       this.addedDate = addedDate;
       this.addedTime = addedTime;
       this.remark = remark;
    }
   
    public Integer getIdpayExpencess() {
        return this.idpayExpencess;
    }
    
    public void setIdpayExpencess(Integer idpayExpencess) {
        this.idpayExpencess = idpayExpencess;
    }
    public ExpencessAccount getExpencessAccount() {
        return this.expencessAccount;
    }
    
    public void setExpencessAccount(ExpencessAccount expencessAccount) {
        this.expencessAccount = expencessAccount;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Double getAmount() {
        return this.amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
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
    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }




}


