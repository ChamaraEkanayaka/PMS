/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 30 Jan 2021 10:09:30 PM By Mayura Lakshan.
 */
package Servlet;

import Connection.FactoryManager;
import POJOS.Prescription;
import Utils.CurrentDateNTime;
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
 * @author Mayura Lakshan
 */
public class Issuemedicine_LoadPrescriptionListServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            // param Data & Objects
            Session ssn = FactoryManager.getSessionFactory().openSession();
            String param_OUTPUT = "<option value='x'>Select Here</option>";
            
            Criteria patients_Crt = ssn.createCriteria(Prescription.class);
            patients_Crt.add(Restrictions.eq("status", 0));
            patients_Crt.add(Restrictions.between("date",CurrentDateNTime.getCurrentDate(),CurrentDateNTime.getCurrentDate()));
            patients_Crt.addOrder(Order.asc("patientToken"));
            List<Prescription> PatientsList = patients_Crt.list();
            for (Prescription Patients_Objct : PatientsList){
                param_OUTPUT = param_OUTPUT + "<option value='"+Patients_Objct.getPatient().getIdpatient() + "*" + Patients_Objct.getIdprescription() +"*"+Patients_Objct.getPatientToken().getTokenNumber()+ "'>"+"#" + Patients_Objct.getPatientToken().getTokenNumber() + " - " + Patients_Objct.getPatient().getName()  + "</option>";
            }

            out.print("success:" + param_OUTPUT);

        } catch (Exception e) {
            e.printStackTrace();
            out.print("error:Sorry:Operation Faild!");
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
