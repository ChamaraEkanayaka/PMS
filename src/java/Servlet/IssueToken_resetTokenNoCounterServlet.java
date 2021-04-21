/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 20 Apr 2021 11:52:50 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.PatientToken;
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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILA
 */
public class IssueToken_resetTokenNoCounterServlet extends HttpServlet {

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

            
            
            // UPDATE PatientToken -Info Status    >>>  all "Pending" tokens as "Cancelled" tokens
            Criteria PendingTokens_Crt = sess.createCriteria(PatientToken.class);
            PendingTokens_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            PendingTokens_Crt.add(Restrictions.eq("status", 0)); // pending
            List<PatientToken> PendingTokens_LIST = PendingTokens_Crt.list();
            for (PatientToken PendingTokens_OBJC : PendingTokens_LIST) {
                PendingTokens_OBJC.setStatus(3);
                sess.update(PendingTokens_OBJC);
            }

            
            // RESET current  MAX-PatientToken-No.  to Beginning ( start with #1 )
            Criteria maxTokenNo_Crt = sess.createCriteria(PatientTokenMax.class);
            maxTokenNo_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            List maxPrscNoList = maxTokenNo_Crt.list();
            PatientTokenMax patientTokenMAX_OBJC = (PatientTokenMax) maxPrscNoList.get(0);
            patientTokenMAX_OBJC.setTokenNumber(0);
            sess.update(patientTokenMAX_OBJC);

            // FINALIZE ===============================================================================================
            tr.commit();
            sess.close();
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
