package POJOS;
// Generated Apr 20, 2021 10:27:05 PM by Hibernate Tools 4.3.1



/**
 * CustomerBranch generated by hbm2java
 */
public class CustomerBranch  implements java.io.Serializable {


     private Integer idcustomerBranch;
     private Account account;
     private Branch branch;

    public CustomerBranch() {
    }

    public CustomerBranch(Account account, Branch branch) {
       this.account = account;
       this.branch = branch;
    }
   
    public Integer getIdcustomerBranch() {
        return this.idcustomerBranch;
    }
    
    public void setIdcustomerBranch(Integer idcustomerBranch) {
        this.idcustomerBranch = idcustomerBranch;
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




}


