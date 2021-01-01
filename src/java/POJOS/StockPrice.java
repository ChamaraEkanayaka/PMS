package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1



/**
 * StockPrice generated by hbm2java
 */
public class StockPrice  implements java.io.Serializable {


     private Integer idstockPrice;
     private CustomerType customerType;
     private Stock stock;
     private Double price;
     private Integer status;

    public StockPrice() {
    }

	
    public StockPrice(CustomerType customerType, Stock stock) {
        this.customerType = customerType;
        this.stock = stock;
    }
    public StockPrice(CustomerType customerType, Stock stock, Double price, Integer status) {
       this.customerType = customerType;
       this.stock = stock;
       this.price = price;
       this.status = status;
    }
   
    public Integer getIdstockPrice() {
        return this.idstockPrice;
    }
    
    public void setIdstockPrice(Integer idstockPrice) {
        this.idstockPrice = idstockPrice;
    }
    public CustomerType getCustomerType() {
        return this.customerType;
    }
    
    public void setCustomerType(CustomerType customerType) {
        this.customerType = customerType;
    }
    public Stock getStock() {
        return this.stock;
    }
    
    public void setStock(Stock stock) {
        this.stock = stock;
    }
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


