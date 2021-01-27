package POJOS;
// Generated Jan 27, 2021 12:48:16 PM by Hibernate Tools 4.3.1



/**
 * QuotationInvoiceItem generated by hbm2java
 */
public class QuotationInvoiceItem  implements java.io.Serializable {


     private Integer idsaleInvoiceItem;
     private Items items;
     private QuotationInvoice quotationInvoice;
     private Stock stock;
     private Double qtt;
     private Double unitPrice;
     private Double descountRate;
     private Double descount;
     private Double total;
     private Double netTotal;
     private Integer status;
     private Double cost;
     private String nowType;
     private String originalType;
     private Double originalCostPerItem;
     private Double originalQtt;
     private String location;
     private Double profit;

    public QuotationInvoiceItem() {
    }

	
    public QuotationInvoiceItem(Items items, QuotationInvoice quotationInvoice, Stock stock) {
        this.items = items;
        this.quotationInvoice = quotationInvoice;
        this.stock = stock;
    }
    public QuotationInvoiceItem(Items items, QuotationInvoice quotationInvoice, Stock stock, Double qtt, Double unitPrice, Double descountRate, Double descount, Double total, Double netTotal, Integer status, Double cost, String nowType, String originalType, Double originalCostPerItem, Double originalQtt, String location, Double profit) {
       this.items = items;
       this.quotationInvoice = quotationInvoice;
       this.stock = stock;
       this.qtt = qtt;
       this.unitPrice = unitPrice;
       this.descountRate = descountRate;
       this.descount = descount;
       this.total = total;
       this.netTotal = netTotal;
       this.status = status;
       this.cost = cost;
       this.nowType = nowType;
       this.originalType = originalType;
       this.originalCostPerItem = originalCostPerItem;
       this.originalQtt = originalQtt;
       this.location = location;
       this.profit = profit;
    }
   
    public Integer getIdsaleInvoiceItem() {
        return this.idsaleInvoiceItem;
    }
    
    public void setIdsaleInvoiceItem(Integer idsaleInvoiceItem) {
        this.idsaleInvoiceItem = idsaleInvoiceItem;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public QuotationInvoice getQuotationInvoice() {
        return this.quotationInvoice;
    }
    
    public void setQuotationInvoice(QuotationInvoice quotationInvoice) {
        this.quotationInvoice = quotationInvoice;
    }
    public Stock getStock() {
        return this.stock;
    }
    
    public void setStock(Stock stock) {
        this.stock = stock;
    }
    public Double getQtt() {
        return this.qtt;
    }
    
    public void setQtt(Double qtt) {
        this.qtt = qtt;
    }
    public Double getUnitPrice() {
        return this.unitPrice;
    }
    
    public void setUnitPrice(Double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public Double getDescountRate() {
        return this.descountRate;
    }
    
    public void setDescountRate(Double descountRate) {
        this.descountRate = descountRate;
    }
    public Double getDescount() {
        return this.descount;
    }
    
    public void setDescount(Double descount) {
        this.descount = descount;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Double getNetTotal() {
        return this.netTotal;
    }
    
    public void setNetTotal(Double netTotal) {
        this.netTotal = netTotal;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public String getNowType() {
        return this.nowType;
    }
    
    public void setNowType(String nowType) {
        this.nowType = nowType;
    }
    public String getOriginalType() {
        return this.originalType;
    }
    
    public void setOriginalType(String originalType) {
        this.originalType = originalType;
    }
    public Double getOriginalCostPerItem() {
        return this.originalCostPerItem;
    }
    
    public void setOriginalCostPerItem(Double originalCostPerItem) {
        this.originalCostPerItem = originalCostPerItem;
    }
    public Double getOriginalQtt() {
        return this.originalQtt;
    }
    
    public void setOriginalQtt(Double originalQtt) {
        this.originalQtt = originalQtt;
    }
    public String getLocation() {
        return this.location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    public Double getProfit() {
        return this.profit;
    }
    
    public void setProfit(Double profit) {
        this.profit = profit;
    }




}


