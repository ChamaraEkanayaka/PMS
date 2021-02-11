package POJOS;
// Generated Feb 11, 2021 2:55:44 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * CustomerType generated by hbm2java
 */
public class CustomerType  implements java.io.Serializable {


     private Integer customerTypeId;
     private String name;
     private Integer status;
     private Set customerTypeCustomers = new HashSet(0);
     private Set stockPrices = new HashSet(0);

    public CustomerType() {
    }

    public CustomerType(String name, Integer status, Set customerTypeCustomers, Set stockPrices) {
       this.name = name;
       this.status = status;
       this.customerTypeCustomers = customerTypeCustomers;
       this.stockPrices = stockPrices;
    }
   
    public Integer getCustomerTypeId() {
        return this.customerTypeId;
    }
    
    public void setCustomerTypeId(Integer customerTypeId) {
        this.customerTypeId = customerTypeId;
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
    public Set getCustomerTypeCustomers() {
        return this.customerTypeCustomers;
    }
    
    public void setCustomerTypeCustomers(Set customerTypeCustomers) {
        this.customerTypeCustomers = customerTypeCustomers;
    }
    public Set getStockPrices() {
        return this.stockPrices;
    }
    
    public void setStockPrices(Set stockPrices) {
        this.stockPrices = stockPrices;
    }




}


