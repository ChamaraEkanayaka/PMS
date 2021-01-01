package POJOS;
// Generated Jan 1, 2021 9:25:22 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * ThirdCategory generated by hbm2java
 */
public class ThirdCategory  implements java.io.Serializable {


     private Integer thirdcategoryId;
     private SubCategory subCategory;
     private String name;
     private Integer status;
     private Set itemThirds = new HashSet(0);

    public ThirdCategory() {
    }

	
    public ThirdCategory(SubCategory subCategory) {
        this.subCategory = subCategory;
    }
    public ThirdCategory(SubCategory subCategory, String name, Integer status, Set itemThirds) {
       this.subCategory = subCategory;
       this.name = name;
       this.status = status;
       this.itemThirds = itemThirds;
    }
   
    public Integer getThirdcategoryId() {
        return this.thirdcategoryId;
    }
    
    public void setThirdcategoryId(Integer thirdcategoryId) {
        this.thirdcategoryId = thirdcategoryId;
    }
    public SubCategory getSubCategory() {
        return this.subCategory;
    }
    
    public void setSubCategory(SubCategory subCategory) {
        this.subCategory = subCategory;
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
    public Set getItemThirds() {
        return this.itemThirds;
    }
    
    public void setItemThirds(Set itemThirds) {
        this.itemThirds = itemThirds;
    }




}


