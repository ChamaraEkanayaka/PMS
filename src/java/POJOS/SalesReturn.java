package POJOS;
// Generated Jan 27, 2021 12:48:16 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * SalesReturn generated by hbm2java
 */
public class SalesReturn  implements java.io.Serializable {


     private Integer idsalesReturn;
     private User user;
     private Double amount;
     private String date;
     private String remark;
     private Integer status;
     private String time;
     private Set salesReturnItemses = new HashSet(0);

    public SalesReturn() {
    }

	
    public SalesReturn(User user) {
        this.user = user;
    }
    public SalesReturn(User user, Double amount, String date, String remark, Integer status, String time, Set salesReturnItemses) {
       this.user = user;
       this.amount = amount;
       this.date = date;
       this.remark = remark;
       this.status = status;
       this.time = time;
       this.salesReturnItemses = salesReturnItemses;
    }
   
    public Integer getIdsalesReturn() {
        return this.idsalesReturn;
    }
    
    public void setIdsalesReturn(Integer idsalesReturn) {
        this.idsalesReturn = idsalesReturn;
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
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Set getSalesReturnItemses() {
        return this.salesReturnItemses;
    }
    
    public void setSalesReturnItemses(Set salesReturnItemses) {
        this.salesReturnItemses = salesReturnItemses;
    }




}


