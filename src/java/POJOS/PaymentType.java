package POJOS;
// Generated Jan 27, 2021 3:30:14 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * PaymentType generated by hbm2java
 */
public class PaymentType  implements java.io.Serializable {


     private Integer idpaymentType;
     private String name;
     private Integer status;
     private Set purchusInvoices = new HashSet(0);
     private Set quotationInvoices = new HashSet(0);
     private Set holdInvoices = new HashSet(0);
     private Set invoiceRecipts = new HashSet(0);
     private Set purchusInvoiceRecipts = new HashSet(0);
     private Set otherTranses = new HashSet(0);
     private Set saleInvoices = new HashSet(0);
     private Set holdRecipts = new HashSet(0);

    public PaymentType() {
    }

    public PaymentType(String name, Integer status, Set purchusInvoices, Set quotationInvoices, Set holdInvoices, Set invoiceRecipts, Set purchusInvoiceRecipts, Set otherTranses, Set saleInvoices, Set holdRecipts) {
       this.name = name;
       this.status = status;
       this.purchusInvoices = purchusInvoices;
       this.quotationInvoices = quotationInvoices;
       this.holdInvoices = holdInvoices;
       this.invoiceRecipts = invoiceRecipts;
       this.purchusInvoiceRecipts = purchusInvoiceRecipts;
       this.otherTranses = otherTranses;
       this.saleInvoices = saleInvoices;
       this.holdRecipts = holdRecipts;
    }
   
    public Integer getIdpaymentType() {
        return this.idpaymentType;
    }
    
    public void setIdpaymentType(Integer idpaymentType) {
        this.idpaymentType = idpaymentType;
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
    public Set getPurchusInvoices() {
        return this.purchusInvoices;
    }
    
    public void setPurchusInvoices(Set purchusInvoices) {
        this.purchusInvoices = purchusInvoices;
    }
    public Set getQuotationInvoices() {
        return this.quotationInvoices;
    }
    
    public void setQuotationInvoices(Set quotationInvoices) {
        this.quotationInvoices = quotationInvoices;
    }
    public Set getHoldInvoices() {
        return this.holdInvoices;
    }
    
    public void setHoldInvoices(Set holdInvoices) {
        this.holdInvoices = holdInvoices;
    }
    public Set getInvoiceRecipts() {
        return this.invoiceRecipts;
    }
    
    public void setInvoiceRecipts(Set invoiceRecipts) {
        this.invoiceRecipts = invoiceRecipts;
    }
    public Set getPurchusInvoiceRecipts() {
        return this.purchusInvoiceRecipts;
    }
    
    public void setPurchusInvoiceRecipts(Set purchusInvoiceRecipts) {
        this.purchusInvoiceRecipts = purchusInvoiceRecipts;
    }
    public Set getOtherTranses() {
        return this.otherTranses;
    }
    
    public void setOtherTranses(Set otherTranses) {
        this.otherTranses = otherTranses;
    }
    public Set getSaleInvoices() {
        return this.saleInvoices;
    }
    
    public void setSaleInvoices(Set saleInvoices) {
        this.saleInvoices = saleInvoices;
    }
    public Set getHoldRecipts() {
        return this.holdRecipts;
    }
    
    public void setHoldRecipts(Set holdRecipts) {
        this.holdRecipts = holdRecipts;
    }




}


