package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1



/**
 * Me generated by hbm2java
 */
public class Me  implements java.io.Serializable {


     private Integer idme;
     private String cname;
     private String user;
     private int status;

    public Me() {
    }

    public Me(String cname, String user, int status) {
       this.cname = cname;
       this.user = user;
       this.status = status;
    }
   
    public Integer getIdme() {
        return this.idme;
    }
    
    public void setIdme(Integer idme) {
        this.idme = idme;
    }
    public String getCname() {
        return this.cname;
    }
    
    public void setCname(String cname) {
        this.cname = cname;
    }
    public String getUser() {
        return this.user;
    }
    
    public void setUser(String user) {
        this.user = user;
    }
    public int getStatus() {
        return this.status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }




}


