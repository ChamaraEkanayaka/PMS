/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 03 Jan 2021 08:52:04 PM By AKILA.
 */
package Servlet;

import DataHolders.USER_LOGIN_DATA;
import POJOS.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
@WebServlet(name = "User_LoginServlet", urlPatterns = {"/User_LoginServlet"})
public class User_LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("un") != null && !request.getParameter("un").equals("")
                    && request.getParameter("pw") != null && !request.getParameter("pw").equals("")) {

                String UERSNAME = request.getParameter("un");
                String PASSWORD = request.getParameter("pw");

                Session sess = Connection.FactoryManager.getSessionFactory().openSession();
                Criteria crt = sess.createCriteria(User.class);
                crt.add(Restrictions.eq("status", 1));
                crt.add(Restrictions.eq("username", UERSNAME));
                crt.add(Restrictions.eq("password", PASSWORD));
                User userOBJC = (User) crt.uniqueResult();
                if (userOBJC != null) {

                    USER_LOGIN_DATA user_data = new USER_LOGIN_DATA();
                    int branch_id = 0;
                    String branch_name = "";
                    if (userOBJC.getBranch().getStatus() == 1) {
                        branch_id = userOBJC.getBranch().getIdbranch();
                        branch_name = userOBJC.getBranch().getName();
                    }

                    if (branch_id > 0 && !branch_name.equals("")) {
                        user_data.setBranch_id(branch_id);
                        user_data.setBranchName(branch_name);
                        user_data.setName(userOBJC.getName());
                        user_data.setUser_id(userOBJC.getIduser());
                        user_data.setUsername(userOBJC.getUsername());
                        request.getSession().setAttribute("LOGIN_DATA", user_data);
                        sess.flush();
                        sess.close();
                        out.print("1:" + userOBJC.getName());

                    } else {
                        out.print("2:");
                    }

                } else {
                    out.print("2:");
                }

            } else {
                out.print("0:");
            }
        } catch (Exception e) {
            out.print("0:");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

}
