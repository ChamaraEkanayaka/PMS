/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 25 Jan 2021 08:27:04 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.Patient;
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
public class IssueToken_IssueNSaveTokenServlet extends HttpServlet {

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

            Patient param_patient = (Patient) sess.load(Patient.class, Integer.valueOf(request.getParameter("patientID")));

            // Save PatientToken Info..
            PatientToken patientToken_OBJC = new PatientToken();
            patientToken_OBJC.setTokenNumber(Integer.valueOf(request.getParameter("tokenNo")));
            patientToken_OBJC.setDate(Utils.CurrentDateNTime.getCurrentDate());
            patientToken_OBJC.setTime(Utils.CurrentDateNTime.getCurrentTime());
            patientToken_OBJC.setPatient(param_patient);
            patientToken_OBJC.setStatus(0);
            sess.save(patientToken_OBJC);

            // UPDATE current  "MAX" PatientToken No..
            Criteria maxTokenNo_Crt = sess.createCriteria(PatientTokenMax.class);
            maxTokenNo_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            List maxPrscNoList = maxTokenNo_Crt.list();
            PatientTokenMax patientTokenMAX_OBJC = (PatientTokenMax) maxPrscNoList.get(0);
            patientTokenMAX_OBJC.setTokenNumber(Integer.valueOf(request.getParameter("tokenNo")));
            sess.update(patientTokenMAX_OBJC);

            // FINALIZE ================================================================================================
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
