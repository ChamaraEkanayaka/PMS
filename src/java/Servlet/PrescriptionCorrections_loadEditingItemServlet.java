/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 24 Feb 2021 10:06:56 PM By AKILA.
 */
package Servlet;

import DataHolders.PRESCRIPTION_ITEMS_DataHolder;
import DataHolders.PRESCRIPTION_ITEM_OBJ;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AKILA
 */
public class PrescriptionCorrections_loadEditingItemServlet extends HttpServlet {

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

            PRESCRIPTION_ITEMS_DataHolder dtHolder = (PRESCRIPTION_ITEMS_DataHolder) request.getSession().getAttribute("PRESCRIPTION_Items");

            // param Data
            int param_StockID = Integer.valueOf(request.getParameter("StockID"));
            String OUTPUT = "";

            // Check & Select Editing-Item  -------------------------------------------------------------------------------------
            PRESCRIPTION_ITEM_OBJ edt_PrscpItemOBJ = null;
            for (PRESCRIPTION_ITEM_OBJ DH_PrscItem_OBJC : dtHolder.getHolder()) {
                if (DH_PrscItem_OBJC.getStock().getStockId() == param_StockID) {
                    edt_PrscpItemOBJ = DH_PrscItem_OBJC;
                    break;
                }
            }

            // Load Item-Details from Data-Holder... -----------------------------------------------------------------------------------
            if (edt_PrscpItemOBJ != null) {
                OUTPUT = "" + edt_PrscpItemOBJ.getStock().getItems().getItemId();
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getDosage();
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getMedicineType().getMedicineTypeId();
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getUseCycle().getIduseCycle();
                OUTPUT = OUTPUT + ":" + Utils.DecimalFormats.dfDoubleValue().format(edt_PrscpItemOBJ.getQty());
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getUseMethod().getIduseMethod();
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getMealType().getIdmealType();
                OUTPUT = OUTPUT + ":" + edt_PrscpItemOBJ.getRemark();

                out.print("success:" + OUTPUT);
            } else {
                out.print("error:Sorry:Operation Faild!");
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
