package POJOS;
// Generated Jan 27, 2021 3:30:14 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * QuotationInvoice generated by hbm2java
 */
public class QuotationInvoice  implements java.io.Serializable {


     private Integer idquotationInvoice;
     private Account account;
     private Branch branch;
     private PaymentType paymentType;
     private User user;
     private String date;
     private Double netTotal;
     private Double descount;
     private Double total;
     private Double transport;
     private Double paid;
     private Double paible;
     private Double returnAmount;
     private Double totalCost;
     private Double totalProfit;
     private String time;
     private Set quotationInvoiceItems = new HashSet(0);

    public QuotationInvoice() {
    }

	
    public QuotationInvoice(Account account, Branch branch, PaymentType paymentType, User user) {
        this.account = account;
        this.branch = branch;
        this.paymentType = paymentType;
        this.user = user;
    }
    public QuotationInvoice(Account account, Branch branch, PaymentType paymentType, User user, String date, Double netTotal, Double descount, Double total, Double transport, Double paid, Double paible, Double returnAmount, Double totalCost, Double totalProfit, String time, Set quotationInvoiceItems) {
       this.account = account;
       this.branch = branch;
       this.paymentType = paymentType;
       this.user = user;
       this.date = date;
       this.netTotal = netTotal;
       this.descount = descount;
       this.total = total;
       this.transport = transport;
       this.paid = paid;
       this.paible = paible;
       this.returnAmount = returnAmount;
       this.totalCost = totalCost;
       this.totalProfit = totalProfit;
       this.time = time;
       this.quotationInvoiceItems = quotationInvoiceItems;
    }
   
    public Integer getIdquotationInvoice() {
        return this.idquotationInvoice;
    }
    
    public void setIdquotationInvoice(Integer idquotationInvoice) {
        this.idquotationInvoice = idquotationInvoice;
    }
    public Account getAccount() {
        return this.account;
    }
    
    public void setAccount(Account account) {
        this.account = account;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public PaymentType getPaymentType() {
        return this.paymentType;
    }
    
    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public Double getNetTotal() {
        return this.netTotal;
    }
    
    public void setNetTotal(Double netTotal) {
        this.netTotal = netTotal;
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
    public Double getTransport() {
        return this.transport;
    }
    
    public void setTransport(Double transport) {
        this.transport = transport;
    }
    public Double getPaid() {
        return this.paid;
    }
    
    public void setPaid(Double paid) {
        this.paid = paid;
    }
    public Double getPaible() {
        return this.paible;
    }
    
    public void setPaible(Double paible) {
        this.paible = paible;
    }
    public Double getReturnAmount() {
        return this.returnAmount;
    }
    
    public void setReturnAmount(Double returnAmount) {
        this.returnAmount = returnAmount;
    }
    public Double getTotalCost() {
        return this.totalCost;
    }
    
    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }
    public Double getTotalProfit() {
        return this.totalProfit;
    }
    
    public void setTotalProfit(Double totalProfit) {
        this.totalProfit = totalProfit;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Set getQuotationInvoiceItems() {
        return this.quotationInvoiceItems;
    }
    
    public void setQuotationInvoiceItems(Set quotationInvoiceItems) {
        this.quotationInvoiceItems = quotationInvoiceItems;
    }




}


