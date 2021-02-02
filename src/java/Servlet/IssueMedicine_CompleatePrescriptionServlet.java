/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 02 Feb 2021 03:36:05 PM By Mayura Lakshan.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.USER_LOGIN_DATA;
import POJOS.Prescription;
import POJOS.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Mayura Lakshan
 */
public class IssueMedicine_CompleatePrescriptionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("id") != null && !request.getParameter("id").equals("")
                    && request.getParameter("cash") != null && !request.getParameter("cash").equals("")) {
                int USER_ID = 0;
                if (request.getSession().getAttribute("LOGIN_DATA") != null) {
                    USER_LOGIN_DATA LD = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
                    USER_ID = LD.getUser_id();
                }
                Session ssn_Presc = FactoryManager.getSessionFactory().openSession();
                Prescription PRESC_OBJC = (Prescription) ssn_Presc.load(Prescription.class, Integer.valueOf(request.getParameter("id")));
                User User_OBJECT = (User) ssn_Presc.load(User.class, USER_ID);

                double cash = Double.parseDouble(request.getParameter("cash"));
                double total = PRESC_OBJC.getReceivableAmount();
                if (cash >= PRESC_OBJC.getReceivableAmount()) {
                    Transaction tr = ssn_Presc.beginTransaction();
                    PRESC_OBJC.setCash(cash);
                    PRESC_OBJC.setBalance(cash - total);
                    PRESC_OBJC.setStatus(0);
                    PRESC_OBJC.setUser(User_OBJECT);
                    PRESC_OBJC.setSettleTime(Utils.CurrentDateNTime.getCurrentTime());
                    PRESC_OBJC.setSettleDate(Utils.CurrentDateNTime.getCurrentDate());
                    ssn_Presc.update(PRESC_OBJC);
                    tr.commit();
                    out.print("1:Completed !");
                } else {
                    out.print("0:Enter correct cash value and retry.");
                }

            } else {
                out.print("0:Enter correct value and retry.");
            }
        } catch (Exception e) {
            out.print("0:Please refresh page and retry.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
