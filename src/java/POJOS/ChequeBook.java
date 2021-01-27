package POJOS;
// Generated Jan 27, 2021 3:30:14 PM by Hibernate Tools 4.3.1



/**
 * ChequeBook generated by hbm2java
 */
public class ChequeBook  implements java.io.Serializable {


     private Integer idchequeBook;
     private Account account;
     private String chequeNumber;
     private String remarks;
     private String date;
     private String time;
     private Integer status;

    public ChequeBook() {
    }

	
    public ChequeBook(Account account) {
        this.account = account;
    }
    public ChequeBook(Account account, String chequeNumber, String remarks, String date, String time, Integer status) {
       this.account = account;
       this.chequeNumber = chequeNumber;
       this.remarks = remarks;
       this.date = date;
       this.time = time;
       this.status = status;
    }
   
    public Integer getIdchequeBook() {
        return this.idchequeBook;
    }
    
    public void setIdchequeBook(Integer idchequeBook) {
        this.idchequeBook = idchequeBook;
    }
    public Account getAccount() {
        return this.account;
    }
    
    public void setAccount(Account account) {
        this.account = account;
    }
    public String getChequeNumber() {
        return this.chequeNumber;
    }
    
    public void setChequeNumber(String chequeNumber) {
        this.chequeNumber = chequeNumber;
    }
    public String getRemarks() {
        return this.remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
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
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


