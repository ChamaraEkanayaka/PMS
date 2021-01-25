/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 15 Jan 2021 07:52:22 PM By AKILA.
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
public class Prescription_RemoveItemServlet extends HttpServlet {

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

            // Check & Select Removing-Item  -------------------------------------------------------------------------------------
            PRESCRIPTION_ITEM_OBJ removing_PrscpItemOBJ = null;
            for (PRESCRIPTION_ITEM_OBJ DH_PrscItem_OBJC : dtHolder.getHolder()) {
                if (DH_PrscItem_OBJC.getStock().getStockId() == param_StockID) {
                    removing_PrscpItemOBJ = DH_PrscItem_OBJC;
                    break;
                }
            }

            // Remove Item from Data-Holder... -----------------------------------------------------------------------------------
            if (removing_PrscpItemOBJ != null) {
                dtHolder.getHolder().remove(removing_PrscpItemOBJ);
            }
            request.getSession().setAttribute("PRESCRIPTION_Items", dtHolder);

            out.print("success::Done!");
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
