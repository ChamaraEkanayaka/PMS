package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * User generated by hbm2java
 */
public class User  implements java.io.Serializable {


     private Integer iduser;
     private Branch branch;
     private String name;
     private String contact;
     private String username;
     private String password;
     private Integer status;
     private Integer level;
     private String ac;
     private String cr;
     private String ad;
     private String inv;
     private String st;
     private String acc;
     private String ch;
     private String ot;
     private String re;
     private Set doctors = new HashSet(0);
     private Set prescriptions = new HashSet(0);
     private Set stockTransfersForAcceptedUser = new HashSet(0);
     private Set stockReturns = new HashSet(0);
     private Set stockTransfersForRequestUser = new HashSet(0);
     private Set purchusInvoiceRecipts = new HashSet(0);
     private Set saleInvoices = new HashSet(0);
     private Set quotationInvoices = new HashSet(0);
     private Set salesReturns = new HashSet(0);
     private Set expencessAccounts = new HashSet(0);
     private Set patients = new HashSet(0);
     private Set payExpencesses = new HashSet(0);
     private Set dayStarts = new HashSet(0);
     private Set holdInvoices = new HashSet(0);
     private Set holdReturns = new HashSet(0);
     private Set invoiceRecipts = new HashSet(0);
     private Set shortcuts = new HashSet(0);
     private Set purchusInvoices = new HashSet(0);
     private Set holdRecipts = new HashSet(0);
     private Set payEmployees = new HashSet(0);
     private Set purchaseInvoiceOrders = new HashSet(0);
     private Set employeeAccounts = new HashSet(0);
     private Set otherTranses = new HashSet(0);

    public User() {
    }

	
    public User(Branch branch) {
        this.branch = branch;
    }
    public User(Branch branch, String name, String contact, String username, String password, Integer status, Integer level, String ac, String cr, String ad, String inv, String st, String acc, String ch, String ot, String re, Set doctors, Set prescriptions, Set stockTransfersForAcceptedUser, Set stockReturns, Set stockTransfersForRequestUser, Set purchusInvoiceRecipts, Set saleInvoices, Set quotationInvoices, Set salesReturns, Set expencessAccounts, Set patients, Set payExpencesses, Set dayStarts, Set holdInvoices, Set holdReturns, Set invoiceRecipts, Set shortcuts, Set purchusInvoices, Set holdRecipts, Set payEmployees, Set purchaseInvoiceOrders, Set employeeAccounts, Set otherTranses) {
       this.branch = branch;
       this.name = name;
       this.contact = contact;
       this.username = username;
       this.password = password;
       this.status = status;
       this.level = level;
       this.ac = ac;
       this.cr = cr;
       this.ad = ad;
       this.inv = inv;
       this.st = st;
       this.acc = acc;
       this.ch = ch;
       this.ot = ot;
       this.re = re;
       this.doctors = doctors;
       this.prescriptions = prescriptions;
       this.stockTransfersForAcceptedUser = stockTransfersForAcceptedUser;
       this.stockReturns = stockReturns;
       this.stockTransfersForRequestUser = stockTransfersForRequestUser;
       this.purchusInvoiceRecipts = purchusInvoiceRecipts;
       this.saleInvoices = saleInvoices;
       this.quotationInvoices = quotationInvoices;
       this.salesReturns = salesReturns;
       this.expencessAccounts = expencessAccounts;
       this.patients = patients;
       this.payExpencesses = payExpencesses;
       this.dayStarts = dayStarts;
       this.holdInvoices = holdInvoices;
       this.holdReturns = holdReturns;
       this.invoiceRecipts = invoiceRecipts;
       this.shortcuts = shortcuts;
       this.purchusInvoices = purchusInvoices;
       this.holdRecipts = holdRecipts;
       this.payEmployees = payEmployees;
       this.purchaseInvoiceOrders = purchaseInvoiceOrders;
       this.employeeAccounts = employeeAccounts;
       this.otherTranses = otherTranses;
    }
   
    public Integer getIduser() {
        return this.iduser;
    }
    
    public void setIduser(Integer iduser) {
        this.iduser = iduser;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getContact() {
        return this.contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Integer getLevel() {
        return this.level;
    }
    
    public void setLevel(Integer level) {
        this.level = level;
    }
    public String getAc() {
        return this.ac;
    }
    
    public void setAc(String ac) {
        this.ac = ac;
    }
    public String getCr() {
        return this.cr;
    }
    
    public void setCr(String cr) {
        this.cr = cr;
    }
    public String getAd() {
        return this.ad;
    }
    
    public void setAd(String ad) {
        this.ad = ad;
    }
    public String getInv() {
        return this.inv;
    }
    
    public void setInv(String inv) {
        this.inv = inv;
    }
    public String getSt() {
        return this.st;
    }
    
    public void setSt(String st) {
        this.st = st;
    }
    public String getAcc() {
        return this.acc;
    }
    
    public void setAcc(String acc) {
        this.acc = acc;
    }
    public String getCh() {
        return this.ch;
    }
    
    public void setCh(String ch) {
        this.ch = ch;
    }
    public String getOt() {
        return this.ot;
    }
    
    public void setOt(String ot) {
        this.ot = ot;
    }
    public String getRe() {
        return this.re;
    }
    
    public void setRe(String re) {
        this.re = re;
    }
    public Set getDoctors() {
        return this.doctors;
    }
    
    public void setDoctors(Set doctors) {
        this.doctors = doctors;
    }
    public Set getPrescriptions() {
        return this.prescriptions;
    }
    
    public void setPrescriptions(Set prescriptions) {
        this.prescriptions = prescriptions;
    }
    public Set getStockTransfersForAcceptedUser() {
        return this.stockTransfersForAcceptedUser;
    }
    
    public void setStockTransfersForAcceptedUser(Set stockTransfersForAcceptedUser) {
        this.stockTransfersForAcceptedUser = stockTransfersForAcceptedUser;
    }
    public Set getStockReturns() {
        return this.stockReturns;
    }
    
    public void setStockReturns(Set stockReturns) {
        this.stockReturns = stockReturns;
    }
    public Set getStockTransfersForRequestUser() {
        return this.stockTransfersForRequestUser;
    }
    
    public void setStockTransfersForRequestUser(Set stockTransfersForRequestUser) {
        this.stockTransfersForRequestUser = stockTransfersForRequestUser;
    }
    public Set getPurchusInvoiceRecipts() {
        return this.purchusInvoiceRecipts;
    }
    
    public void setPurchusInvoiceRecipts(Set purchusInvoiceRecipts) {
        this.purchusInvoiceRecipts = purchusInvoiceRecipts;
    }
    public Set getSaleInvoices() {
        return this.saleInvoices;
    }
    
    public void setSaleInvoices(Set saleInvoices) {
        this.saleInvoices = saleInvoices;
    }
    public Set getQuotationInvoices() {
        return this.quotationInvoices;
    }
    
    public void setQuotationInvoices(Set quotationInvoices) {
        this.quotationInvoices = quotationInvoices;
    }
    public Set getSalesReturns() {
        return this.salesReturns;
    }
    
    public void setSalesReturns(Set salesReturns) {
        this.salesReturns = salesReturns;
    }
    public Set getExpencessAccounts() {
        return this.expencessAccounts;
    }
    
    public void setExpencessAccounts(Set expencessAccounts) {
        this.expencessAccounts = expencessAccounts;
    }
    public Set getPatients() {
        return this.patients;
    }
    
    public void setPatients(Set patients) {
        this.patients = patients;
    }
    public Set getPayExpencesses() {
        return this.payExpencesses;
    }
    
    public void setPayExpencesses(Set payExpencesses) {
        this.payExpencesses = payExpencesses;
    }
    public Set getDayStarts() {
        return this.dayStarts;
    }
    
    public void setDayStarts(Set dayStarts) {
        this.dayStarts = dayStarts;
    }
    public Set getHoldInvoices() {
        return this.holdInvoices;
    }
    
    public void setHoldInvoices(Set holdInvoices) {
        this.holdInvoices = holdInvoices;
    }
    public Set getHoldReturns() {
        return this.holdReturns;
    }
    
    public void setHoldReturns(Set holdReturns) {
        this.holdReturns = holdReturns;
    }
    public Set getInvoiceRecipts() {
        return this.invoiceRecipts;
    }
    
    public void setInvoiceRecipts(Set invoiceRecipts) {
        this.invoiceRecipts = invoiceRecipts;
    }
    public Set getShortcuts() {
        return this.shortcuts;
    }
    
    public void setShortcuts(Set shortcuts) {
        this.shortcuts = shortcuts;
    }
    public Set getPurchusInvoices() {
        return this.purchusInvoices;
    }
    
    public void setPurchusInvoices(Set purchusInvoices) {
        this.purchusInvoices = purchusInvoices;
    }
    public Set getHoldRecipts() {
        return this.holdRecipts;
    }
    
    public void setHoldRecipts(Set holdRecipts) {
        this.holdRecipts = holdRecipts;
    }
    public Set getPayEmployees() {
        return this.payEmployees;
    }
    
    public void setPayEmployees(Set payEmployees) {
        this.payEmployees = payEmployees;
    }
    public Set getPurchaseInvoiceOrders() {
        return this.purchaseInvoiceOrders;
    }
    
    public void setPurchaseInvoiceOrders(Set purchaseInvoiceOrders) {
        this.purchaseInvoiceOrders = purchaseInvoiceOrders;
    }
    public Set getEmployeeAccounts() {
        return this.employeeAccounts;
    }
    
    public void setEmployeeAccounts(Set employeeAccounts) {
        this.employeeAccounts = employeeAccounts;
    }
    public Set getOtherTranses() {
        return this.otherTranses;
    }
    
    public void setOtherTranses(Set otherTranses) {
        this.otherTranses = otherTranses;
    }




}


