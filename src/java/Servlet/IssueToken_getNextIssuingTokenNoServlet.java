/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 25 Jan 2021 03:26:43 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.PatientTokenMax;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILA
 */
public class IssueToken_getNextIssuingTokenNoServlet extends HttpServlet {

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
            // PARAMS & OBJECTS =======================================================================================
            Session sess = FactoryManager.getSessionFactory().openSession();
            Transaction tr = sess.beginTransaction();
            int param_NextTOKEN_NO = 0;

            Criteria maxTokenNo_Crt = sess.createCriteria(PatientTokenMax.class);
            maxTokenNo_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            maxTokenNo_Crt.setProjection(Projections.max("tokenNumber"));
            List maxPrscNoList = maxTokenNo_Crt.list();
            if (maxPrscNoList.get(0) != null) {
                param_NextTOKEN_NO = Integer.valueOf(maxPrscNoList.get(0).toString()) + 1;

            } else {
                param_NextTOKEN_NO = 1;
                // Save only one-time , each day >> MAX-PatientToken No..
                PatientTokenMax patientTokenMAX_OBJC = new PatientTokenMax();
                patientTokenMAX_OBJC.setTokenNumber(0);
                patientTokenMAX_OBJC.setDate(Utils.CurrentDateNTime.getCurrentDate());
                sess.save(patientTokenMAX_OBJC);
                tr.commit();
            }

            // FINALIZE ================================================================================================
            sess.close();
            out.print("success:" + param_NextTOKEN_NO);

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
