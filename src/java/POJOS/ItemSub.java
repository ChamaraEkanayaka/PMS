package POJOS;
// Generated Feb 11, 2021 2:55:44 PM by Hibernate Tools 4.3.1



/**
 * ItemSub generated by hbm2java
 */
public class ItemSub  implements java.io.Serializable {


     private Integer iditemSub;
     private Items items;
     private SubCategory subCategory;

    public ItemSub() {
    }

    public ItemSub(Items items, SubCategory subCategory) {
       this.items = items;
       this.subCategory = subCategory;
    }
   
    public Integer getIditemSub() {
        return this.iditemSub;
    }
    
    public void setIditemSub(Integer iditemSub) {
        this.iditemSub = iditemSub;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public SubCategory getSubCategory() {
        return this.subCategory;
    }
    
    public void setSubCategory(SubCategory subCategory) {
        this.subCategory = subCategory;
    }




}


