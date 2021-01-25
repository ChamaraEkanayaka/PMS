/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 15 Jan 2021 08:05:29 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.PRESCRIPTION_ITEMS_DataHolder;
import DataHolders.PRESCRIPTION_ITEM_OBJ;
import POJOS.Items;
import POJOS.MealType;
import POJOS.Stock;
import POJOS.UseCycle;
import POJOS.UseMethod;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILA
 */
public class Prescription_AddItemServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        try {

            Session sess = FactoryManager.getSessionFactory().openSession();
            PRESCRIPTION_ITEMS_DataHolder dtHolder = (PRESCRIPTION_ITEMS_DataHolder) request.getSession().getAttribute("PRESCRIPTION_Items");

            // param Data
            Items param_ItemOBJC = (Items) sess.load(Items.class, Integer.valueOf(request.getParameter("addItem_Item")));
            double param_Dosage = Double.valueOf(request.getParameter("addItem_Dosage"));
            double param_Duration = Double.valueOf(request.getParameter("addItem_Duration"));
            UseCycle param_UseCycle = (UseCycle) sess.load(UseCycle.class, Integer.valueOf(request.getParameter("addItem_UseCycle")));
            UseMethod param_UseMethod = (UseMethod) sess.load(UseMethod.class, Integer.valueOf(request.getParameter("addItem_UseMethod")));
            MealType param_MealType = (MealType) sess.load(MealType.class, Integer.valueOf(request.getParameter("addItem_MealType")));
            String param_Remark = String.valueOf(request.getParameter("addItem_Remark"));

            // Check & Get Available Stock-Object ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Criteria stock_Crt = sess.createCriteria(Stock.class);
            stock_Crt.add(Restrictions.eq("items", param_ItemOBJC));
            stock_Crt.add(Restrictions.eq("status", 1));
            stock_Crt.add(Restrictions.gt("qty", 0.00));
            List<Stock> StockList = stock_Crt.list();
            if (!StockList.isEmpty()) {

                Stock param_Stock = (Stock) StockList.get(0);
                boolean flag_StockAvailable = false;
                double AvlStockQty = param_Stock.getQty();
                double param_RequestingQty = param_Dosage * param_UseCycle.getTabsPerDate() * param_Duration;

                // --- Check Already Existings on DH -------------------------------------------------------------------------------------------------
                PRESCRIPTION_ITEM_OBJ existing_PrscpItem = null;
                for (PRESCRIPTION_ITEM_OBJ DHPrscpItem_OBJC : dtHolder.getHolder()) {
                    if (DHPrscpItem_OBJC.getStock().getStockId() == param_Stock.getStockId()) { //  [ check eqality on  StockID  ]
                        existing_PrscpItem = DHPrscpItem_OBJC;
                        break;
                    }
                }

                // UPDATE New-Data-Set  !! ( when Duplicate ITEM FOUND ) ++++++++++++++++++++++++++++++
                if (existing_PrscpItem != null) {

                    if (param_RequestingQty < AvlStockQty) {
                        existing_PrscpItem.setDosage(param_Dosage);
                        existing_PrscpItem.setDuration(param_Duration);
                        existing_PrscpItem.setUseCycle(param_UseCycle);
                        existing_PrscpItem.setUseMethod(param_UseMethod);
                        existing_PrscpItem.setMealType(param_MealType);
                        existing_PrscpItem.setQty(param_RequestingQty);
                        existing_PrscpItem.setCostPerItem(param_Stock.getCost());
                        existing_PrscpItem.setTotalCost(param_Stock.getCost() * param_RequestingQty);
                        existing_PrscpItem.setRemark(param_Remark);

                        flag_StockAvailable = true;
                    } else {
                        flag_StockAvailable = false;
                    }

                } else { // ADD as NEW ITEM !! +++++++++++++++++++++++++++++++++++++++

                    if (param_RequestingQty < AvlStockQty) {

                        PRESCRIPTION_ITEM_OBJ newPrscp_Item = new PRESCRIPTION_ITEM_OBJ();
                        newPrscp_Item.setStock(param_Stock);
                        newPrscp_Item.setDosage(param_Dosage);
                        newPrscp_Item.setDuration(param_Duration);
                        newPrscp_Item.setUseCycle(param_UseCycle);
                        newPrscp_Item.setUseMethod(param_UseMethod);
                        newPrscp_Item.setMealType(param_MealType);
                        newPrscp_Item.setQty(param_RequestingQty);
                        newPrscp_Item.setCostPerItem(param_Stock.getCost());
                        newPrscp_Item.setTotalCost(param_Stock.getCost() * param_RequestingQty);
                        newPrscp_Item.setRemark(param_Remark);
                        dtHolder.getHolder().add(newPrscp_Item);
                        flag_StockAvailable = true;

                    } else {
                        flag_StockAvailable = false;
                    }
                }

                if (flag_StockAvailable) {
                    // Update Data-Holder Container Session
                    request.getSession().setAttribute("PRESCRIPTION_Items", dtHolder);
                    out.print("success::Done!");
                } else {
                    out.print("warning:Stock Not Necessary For Requested Qty:");
                }

            } else {
                out.print("warning:Empty Stock:");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error:Sorry:Operation Faild!");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
