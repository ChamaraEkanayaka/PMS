package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1



/**
 * StockHistory generated by hbm2java
 */
public class StockHistory  implements java.io.Serializable {


     private Integer idstockHistory;
     private Branch branch;
     private Items items;
     private Double qty;
     private Double beforeT;
     private Double afterT;
     private String date;
     private String time;
     private String details;
     private Integer status;

    public StockHistory() {
    }

	
    public StockHistory(Branch branch, Items items) {
        this.branch = branch;
        this.items = items;
    }
    public StockHistory(Branch branch, Items items, Double qty, Double beforeT, Double afterT, String date, String time, String details, Integer status) {
       this.branch = branch;
       this.items = items;
       this.qty = qty;
       this.beforeT = beforeT;
       this.afterT = afterT;
       this.date = date;
       this.time = time;
       this.details = details;
       this.status = status;
    }
   
    public Integer getIdstockHistory() {
        return this.idstockHistory;
    }
    
    public void setIdstockHistory(Integer idstockHistory) {
        this.idstockHistory = idstockHistory;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Double getBeforeT() {
        return this.beforeT;
    }
    
    public void setBeforeT(Double beforeT) {
        this.beforeT = beforeT;
    }
    public Double getAfterT() {
        return this.afterT;
    }
    
    public void setAfterT(Double afterT) {
        this.afterT = afterT;
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
    public String getDetails() {
        return this.details;
    }
    
    public void setDetails(String details) {
        this.details = details;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}

