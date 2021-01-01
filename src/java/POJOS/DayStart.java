package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1



/**
 * DayStart generated by hbm2java
 */
public class DayStart  implements java.io.Serializable {


     private Integer idday;
     private Branch branch;
     private User user;
     private String date;
     private String time;
     private Double startAmount;

    public DayStart() {
    }

	
    public DayStart(Branch branch, User user) {
        this.branch = branch;
        this.user = user;
    }
    public DayStart(Branch branch, User user, String date, String time, Double startAmount) {
       this.branch = branch;
       this.user = user;
       this.date = date;
       this.time = time;
       this.startAmount = startAmount;
    }
   
    public Integer getIdday() {
        return this.idday;
    }
    
    public void setIdday(Integer idday) {
        this.idday = idday;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
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
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Double getStartAmount() {
        return this.startAmount;
    }
    
    public void setStartAmount(Double startAmount) {
        this.startAmount = startAmount;
    }




}

