/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 27 Jan 2021 09:29:59 PM By Mayura Lakshan.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.BodyMeasurement;
import POJOS.Patient;
import POJOS.User;
import Utils.CurrentDateNTime;
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
public class Patient_RegisterServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("userID") != null && !request.getParameter("userID").equals("")
                    && request.getParameter("name") != null && !request.getParameter("name").equals("")) {
                
                Session sess = FactoryManager.getSessionFactory().openSession();
                int User_Id = Integer.parseInt(request.getParameter("userID"));
                
                String NIC = "N/A";
                double Weight = 0.0;
                double Height = 0.0;
                String Remark = "N/A";
                String Address = "N/A";
                
                String Birth_Day = "N/A";
                String Blood_Group = "N/A";
                String Gender = "N/A";
                String Contact_Number = "N/A";
                
                
                
                
                User User_OBJECT = (User) sess.load(User.class, User_Id);
                
                String Name = request.getParameter("name");
                
                if (request.getParameter("patient_age") != null && !request.getParameter("patient_age").equals("")) {
                    String Age = request.getParameter("patient_age");
                    Birth_Day = CurrentDateNTime.getBirthDay(Integer.parseInt(Age)); 
                }
                if (request.getParameter("birth_day") != null && !request.getParameter("birth_day").equals("")) {
                    Birth_Day = request.getParameter("birth_day");
                }
                if (request.getParameter("blood_group") != null && !request.getParameter("blood_group").equals("")) {
                    Blood_Group = request.getParameter("blood_group");
                }
                if (request.getParameter("gender") != null && !request.getParameter("gender").equals("")) {
                    Gender = request.getParameter("gender");
                }
                if (request.getParameter("contact_number") != null && !request.getParameter("contact_number").equals("")) {
                    Contact_Number = request.getParameter("contact_number");
                }
                if (request.getParameter("nic") != null && !request.getParameter("nic").equals("")) {
                    NIC = request.getParameter("nic");
                }
                if (request.getParameter("weight") != null && !request.getParameter("weight").equals("")) {
                    Weight = Double.parseDouble(request.getParameter("weight"));
                }
                if (request.getParameter("height") != null && !request.getParameter("height").equals("")) {
                    Height = Double.parseDouble(request.getParameter("height"));
                }
                if (request.getParameter("remark") != null && !request.getParameter("remark").equals("")) {
                    Remark = request.getParameter("remark");
                }
                if (request.getParameter("address") != null && !request.getParameter("address").equals("")) {
                    Address = request.getParameter("address");
                }
                
                Transaction tr = sess.beginTransaction();
                Patient pt = new Patient();
                pt.setName(Name);
                pt.setBirthDay(Birth_Day);
                pt.setGender(Gender);
                pt.setBloodGroup(Blood_Group);
                pt.setAddress(Address);
                pt.setContactNo(Contact_Number);
                pt.setNic(NIC);
                pt.setRegDate(CurrentDateNTime.getCurrentDate());
                pt.setRegTime(CurrentDateNTime.getCurrentTime());
                pt.setNote(Remark);
                pt.setLastUpdateDate(CurrentDateNTime.getCurrentDate());
                pt.setLastUpdateTime(CurrentDateNTime.getCurrentTime());
                pt.setStatus(1);
                pt.setUser(User_OBJECT);
                sess.save(pt);
                
                if (Height > 0 || Weight > 0) {
                    BodyMeasurement bm = new BodyMeasurement();
                    bm.setPatient(pt);
                    bm.setHeight(Height);
                    bm.setWeight(Weight);
                    bm.setDate(CurrentDateNTime.getCurrentDate());
                    bm.setTime(CurrentDateNTime.getCurrentTime());
                    bm.setStatus(1);
                    sess.save(bm);
                }
                
                tr.commit();
                out.print("1:" + pt.getIdpatient());
                
            } else {
                out.print("0:0");
            }
        } catch (Exception E) {
            out.print("0:0");
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
