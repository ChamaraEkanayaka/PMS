package POJOS;
// Generated Apr 20, 2021 10:27:05 PM by Hibernate Tools 4.3.1



/**
 * DoHoldItem generated by hbm2java
 */
public class DoHoldItem  implements java.io.Serializable {


     private Integer iddoHoldItem;
     private DoItem doItem;
     private HoldInvoiceItem holdInvoiceItem;
     private Double qty;
     private Integer status;

    public DoHoldItem() {
    }

	
    public DoHoldItem(DoItem doItem, HoldInvoiceItem holdInvoiceItem) {
        this.doItem = doItem;
        this.holdInvoiceItem = holdInvoiceItem;
    }
    public DoHoldItem(DoItem doItem, HoldInvoiceItem holdInvoiceItem, Double qty, Integer status) {
       this.doItem = doItem;
       this.holdInvoiceItem = holdInvoiceItem;
       this.qty = qty;
       this.status = status;
    }
   
    public Integer getIddoHoldItem() {
        return this.iddoHoldItem;
    }
    
    public void setIddoHoldItem(Integer iddoHoldItem) {
        this.iddoHoldItem = iddoHoldItem;
    }
    public DoItem getDoItem() {
        return this.doItem;
    }
    
    public void setDoItem(DoItem doItem) {
        this.doItem = doItem;
    }
    public HoldInvoiceItem getHoldInvoiceItem() {
        return this.holdInvoiceItem;
    }
    
    public void setHoldInvoiceItem(HoldInvoiceItem holdInvoiceItem) {
        this.holdInvoiceItem = holdInvoiceItem;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


