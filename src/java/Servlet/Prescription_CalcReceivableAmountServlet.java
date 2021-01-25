/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 17 Jan 2021 10:50:11 AM By AKILA.
 */
package Servlet;

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
public class Prescription_CalcReceivableAmountServlet extends HttpServlet {

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

            // params & Objects
            double param_MedicineCost = Double.valueOf(request.getParameter("medicineCost"));
            double val_DoctorCharges = 0.00;
            double val_TotalAmount = 0.00;
            double val_ReceivableAmount = 0.00;

            // Format/ Assign Param Values  
            if (request.getParameter("doctorCharges").isEmpty()) {
                val_DoctorCharges = 0.00;
            } else {
                val_DoctorCharges = Double.valueOf(request.getParameter("doctorCharges"));
            }
            if (request.getParameter("receivableAmount").isEmpty()) {
                val_ReceivableAmount = 0.00;
            } else {
                val_ReceivableAmount = Double.valueOf(request.getParameter("receivableAmount"));
            }

            // Calc. & Set TOTAL-AMOUNT +++++++++++++++++++++++++++++++++++++++++++++++
            val_TotalAmount = param_MedicineCost + val_DoctorCharges;
            val_ReceivableAmount = val_TotalAmount;

            out.print("success:" + Utils.DecimalFormats.dfDoubleValue().format(val_DoctorCharges) + ":" + Utils.DecimalFormats.dfDoubleValue().format(val_TotalAmount) + ":" + Utils.DecimalFormats.dfDoubleValue().format(val_ReceivableAmount));

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
