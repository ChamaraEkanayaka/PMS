package POJOS;
// Generated Jan 27, 2021 12:48:16 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Brand generated by hbm2java
 */
public class Brand  implements java.io.Serializable {


     private Integer idbrand;
     private String name;
     private Integer status;
     private Set itemses = new HashSet(0);

    public Brand() {
    }

    public Brand(String name, Integer status, Set itemses) {
       this.name = name;
       this.status = status;
       this.itemses = itemses;
    }
   
    public Integer getIdbrand() {
        return this.idbrand;
    }
    
    public void setIdbrand(Integer idbrand) {
        this.idbrand = idbrand;
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
    public Set getItemses() {
        return this.itemses;
    }
    
    public void setItemses(Set itemses) {
        this.itemses = itemses;
    }




}


