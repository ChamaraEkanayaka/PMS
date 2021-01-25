/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 25 Jan 2021 05:05:22 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.Patient;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author AKILA
 */
public class IssueToken_LoadSelectedPatientDetailsServlet extends HttpServlet {

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

            // param Data & Objects 
            Session ssn = FactoryManager.getSessionFactory().openSession();
            String param_OUTPUT = "";

            if (!request.getParameter("patientID").toString().equals("x")) {
                Patient param_Patient = (Patient) ssn.load(Patient.class, Integer.valueOf(request.getParameter("patientID")));
                param_OUTPUT += "# " + param_Patient.getIdpatient();
                param_OUTPUT += ":" + param_Patient.getName();
                param_OUTPUT += ":" + param_Patient.getGender();
                param_OUTPUT += ":" + Utils.CurrentDateNTime.getAge(param_Patient.getBirthDay()) + " Years";
                param_OUTPUT += ":" + param_Patient.getContactNo();
            } else {
                param_OUTPUT += "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
            }

            out.print("success:" + param_OUTPUT);

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
