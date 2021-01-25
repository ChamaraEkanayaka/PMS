/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 10 Jan 2021 01:23:08 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.PatientToken;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILA
 */
public class Token_getNextTokenDetailsServlet extends HttpServlet {

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
            String param_OUTPUT = "";
            int param_CrntVALToken = 0;
            boolean param_haveRESULTS = false;
            boolean param_OnlyHaveSingleRESULT = false;
            Session sess = FactoryManager.getSessionFactory().openSession();

            int FwdBkwd_Status = Integer.valueOf(request.getParameter("FwdBkwd_Status")); //   [ 1= Forward,    0= Backward,    2=Next-Available ]
            int Current_TokenNo = Integer.valueOf(request.getParameter("tokenNo"));
            int Next_TokenNo = Integer.valueOf(request.getParameter("tokenNo"));
            if (FwdBkwd_Status == 1) { // move Forward
                Next_TokenNo += 1;
            } else if (FwdBkwd_Status == 0) { // move Backward
                if (Current_TokenNo == 0) {
                    Next_TokenNo = 1;
                    FwdBkwd_Status = 1;
                } else {
                    Next_TokenNo -= 1;
                }
            }

            //  get COUNT for "Only-Have-Single-Result" param ****************************************
            Criteria crt_ALLTokensCOUNT = sess.createCriteria(PatientToken.class);
            crt_ALLTokensCOUNT.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            crt_ALLTokensCOUNT.add(Restrictions.eq("status", 0)); // pending
            crt_ALLTokensCOUNT.addOrder(Order.asc("tokenNumber"));
            List<PatientToken> ALLTokensCOUNT_List = crt_ALLTokensCOUNT.list();
            if (ALLTokensCOUNT_List.size() == 1) {
                param_OnlyHaveSingleRESULT = true;
            }

            
            
            // +++ BASIC CHECKING & LOAD SELECTED #TOKEN DETAILS +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Criteria crt_token = sess.createCriteria(PatientToken.class);
            if (FwdBkwd_Status != 2) { // when "Forward" or "Backward"  #Token
                crt_token.add(Restrictions.eq("tokenNumber", Next_TokenNo));
            }
            crt_token.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
            crt_token.add(Restrictions.eq("status", 0)); // pending
            crt_token.addOrder(Order.asc("tokenNumber"));
            List<PatientToken> tokens_List = crt_token.list();

            for (PatientToken patientToken_OBJC : tokens_List) {
                param_OUTPUT += patientToken_OBJC.getTokenNumber();
                param_OUTPUT += ":" + patientToken_OBJC.getTokenNumber();
                param_OUTPUT += ":" + patientToken_OBJC.getPatient().getIdpatient();
                param_OUTPUT += ":" + patientToken_OBJC.getPatient().getName();
                param_OUTPUT += ":" + patientToken_OBJC.getPatient().getGender();
                param_OUTPUT += ":" + Utils.CurrentDateNTime.getAge(patientToken_OBJC.getPatient().getBirthDay());
                param_haveRESULTS = true;
                break;
            }

            
            
            // SECONDARY CHECK ANY LAST RESULT EXISTINGS.... ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            if (tokens_List.isEmpty()) {
                if (FwdBkwd_Status == 2) { // when  "Next-Available" #Token
                    param_haveRESULTS = false;
                    param_CrntVALToken = 0;

                } else { // when "Forward" or "Backward"  #Token

                    // GET AVAILABLE TOKENS-LIST COUNT
                    Criteria crt_AvlTokensCOUNT = sess.createCriteria(PatientToken.class);
                    if (FwdBkwd_Status == 1) {
                        crt_AvlTokensCOUNT.add(Restrictions.gt("tokenNumber", Next_TokenNo));
                    } else if (FwdBkwd_Status == 0) {
                        crt_AvlTokensCOUNT.add(Restrictions.lt("tokenNumber", Next_TokenNo));
                    }
                    crt_AvlTokensCOUNT.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
                    crt_AvlTokensCOUNT.add(Restrictions.eq("status", 0)); // pending
                    if (FwdBkwd_Status == 0) {
                        crt_AvlTokensCOUNT.addOrder(Order.desc("tokenNumber"));
                    } else {
                        crt_AvlTokensCOUNT.addOrder(Order.asc("tokenNumber"));
                    }
                    List<PatientToken> AvlTokensCOUNT_List = crt_AvlTokensCOUNT.list();

                    if (AvlTokensCOUNT_List.isEmpty()) {
                        param_haveRESULTS = false;
                        param_CrntVALToken = Next_TokenNo;
                    } else {

                        for (PatientToken AvlTokensCOUNT_OBJC : AvlTokensCOUNT_List) {

                            Next_TokenNo = AvlTokensCOUNT_OBJC.getTokenNumber();

                            Criteria crt_TknScndCheck = sess.createCriteria(PatientToken.class);
                            crt_TknScndCheck.add(Restrictions.eq("tokenNumber", Next_TokenNo));
                            crt_TknScndCheck.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
                            crt_TknScndCheck.add(Restrictions.eq("status", 0)); // pending
                            crt_TknScndCheck.addOrder(Order.asc("tokenNumber"));
                            List<PatientToken> tokensScndCheck_List = crt_TknScndCheck.list();

                            if (!tokensScndCheck_List.isEmpty()) {
                                PatientToken patientTokenScndCheck_OBJC = (PatientToken) tokensScndCheck_List.get(0);
                                param_OUTPUT += patientTokenScndCheck_OBJC.getTokenNumber();
                                param_OUTPUT += ":" + patientTokenScndCheck_OBJC.getTokenNumber();
                                param_OUTPUT += ":" + patientTokenScndCheck_OBJC.getPatient().getIdpatient();
                                param_OUTPUT += ":" + patientTokenScndCheck_OBJC.getPatient().getName();
                                param_OUTPUT += ":" + patientTokenScndCheck_OBJC.getPatient().getGender();
                                param_OUTPUT += ":" + Utils.CurrentDateNTime.getAge(patientTokenScndCheck_OBJC.getPatient().getBirthDay());
                                param_haveRESULTS = true;
                                break;
                            } else {
                                param_haveRESULTS = false;
                                param_CrntVALToken = Next_TokenNo;
                            }
                        }
                    }
                }
            }

            if (!param_haveRESULTS) {
                param_OUTPUT += param_CrntVALToken;
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
                param_OUTPUT += ":" + "N/A";
            }

            // FINALIZE ================================================================================================
            sess.close();
            out.print("success::" + param_haveRESULTS + ":" + param_OnlyHaveSingleRESULT + ":" + param_OUTPUT);

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
