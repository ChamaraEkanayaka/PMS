package POJOS;
// Generated Apr 20, 2021 10:27:05 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Deo generated by hbm2java
 */
public class Deo  implements java.io.Serializable {


     private Integer iddo;
     private String date;
     private String time;
     private String remark;
     private Integer status;
     private Set doItems = new HashSet(0);

    public Deo() {
    }

    public Deo(String date, String time, String remark, Integer status, Set doItems) {
       this.date = date;
       this.time = time;
       this.remark = remark;
       this.status = status;
       this.doItems = doItems;
    }
   
    public Integer getIddo() {
        return this.iddo;
    }
    
    public void setIddo(Integer iddo) {
        this.iddo = iddo;
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
    public Set getDoItems() {
        return this.doItems;
    }
    
    public void setDoItems(Set doItems) {
        this.doItems = doItems;
    }




}


