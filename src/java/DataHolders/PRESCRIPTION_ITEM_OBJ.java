/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 14 Jan 2021 11:23:44 PM By AKILA.
 */
package DataHolders;

import POJOS.MealType;
import POJOS.MedicineType;
import POJOS.Stock;
import POJOS.UseCycle;
import POJOS.UseMethod;

/**
 *
 * @author AKILA
 */
public class PRESCRIPTION_ITEM_OBJ {

    private Stock stock;
    private double dosage;
    private double duration;
    private MedicineType medicineType;
    private UseCycle useCycle;
    private UseMethod useMethod;
    private MealType mealType;
    private double qty;
    private double unitCost;
    private double totalCost;
    private double unitPrice;
    private double totalPrice;
    private String remark;

    public Stock getStock() {
        return stock;
    }

    public void setStock(Stock stock) {
        this.stock = stock;
    }

    public double getDosage() {
        return dosage;
    }

    public void setDosage(double dosage) {
        this.dosage = dosage;
    }

    public double getDuration() {
        return duration;
    }

    public void setDuration(double duration) {
        this.duration = duration;
    }

    public MedicineType getMedicineType() {
        return medicineType;
    }

    public void setMedicineType(MedicineType medicineType) {
        this.medicineType = medicineType;
    }

    public UseCycle getUseCycle() {
        return useCycle;
    }

    public void setUseCycle(UseCycle useCycle) {
        this.useCycle = useCycle;
    }

    public UseMethod getUseMethod() {
        return useMethod;
    }

    public void setUseMethod(UseMethod useMethod) {
        this.useMethod = useMethod;
    }

    public MealType getMealType() {
        return mealType;
    }

    public void setMealType(MealType mealType) {
        this.mealType = mealType;
    }

    public double getQty() {
        return qty;
    }

    public void setQty(double qty) {
        this.qty = qty;
    }

    public double getUnitCost() {
        return unitCost;
    }

    public void setUnitCost(double unitCost) {
        this.unitCost = unitCost;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

}
