/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 17 Jan 2021 10:45:14 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.PRESCRIPTION_ITEMS_DataHolder;
import DataHolders.PRESCRIPTION_ITEM_OBJ;
import POJOS.Doctor;
import POJOS.Patient;
import POJOS.PatientToken;
import POJOS.Prescription;
import POJOS.PrescriptionItem;
import POJOS.Stock;
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
 * @author AKILA
 */
public class Prescription_SaveServlet extends HttpServlet {

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

            User param_User = (User) sess.load(User.class, Integer.valueOf(request.getParameter("userID")));
            PatientToken param_Token = (PatientToken) sess.load(PatientToken.class, Integer.valueOf(request.getParameter("tokenID")));
            Patient param_Patient = (Patient) sess.load(Patient.class, Integer.valueOf(request.getParameter("patientID")));
            Doctor param_Doctor = (Doctor) sess.load(Doctor.class, Integer.valueOf(request.getParameter("doctorID")));
            double param_MedicineCost = Double.valueOf(request.getParameter("medicineCost"));
            double param_DoctorCharges = Double.valueOf(request.getParameter("doctorCharge"));
            double param_TotalAmount = Double.valueOf(request.getParameter("totalAmount"));
            double param_ReceivableAmount = Double.valueOf(request.getParameter("receivableAmount"));
            String param_Note = String.valueOf(request.getParameter("note")).trim();
            PRESCRIPTION_ITEMS_DataHolder dtHolder = (PRESCRIPTION_ITEMS_DataHolder) request.getSession().getAttribute("PRESCRIPTION_Items");

            // [ 01 ] SAVE  "PRESCRIPTION  --INFO" -----------------------------------------------------------------------------
            Prescription prescp = new Prescription();
            prescp.setPatient(param_Patient);
            prescp.setPatientToken(param_Token);
            prescp.setDoctor(param_Doctor);
            prescp.setDate(Utils.CurrentDateNTime.getCurrentDate());
            prescp.setTime(Utils.CurrentDateNTime.getCurrentTime());
            prescp.setMedicineCost(param_MedicineCost);
            prescp.setDoctorCharge(param_DoctorCharges);
            prescp.setReceivableAmount(param_ReceivableAmount);
            prescp.setTotalAmount(param_TotalAmount);
            prescp.setNote(param_Note);
            prescp.setCash(0.00);
            prescp.setBalance(0.00);
            prescp.setUser(param_User);
            prescp.setStatus(1); // set as Unpaid
            sess.save(prescp);

            // [ 02_1 ] SAVE  "PRESCRIPTION  >>ITEMS" ---------------------------------------------------------------------------
            for (PRESCRIPTION_ITEM_OBJ prscpItem_OBJ : dtHolder.getHolder()) {
                PrescriptionItem prescpItem = new PrescriptionItem();
                prescpItem.setPrescription(prescp);
                prescpItem.setStock(prscpItem_OBJ.getStock());
                prescpItem.setDosage(prscpItem_OBJ.getDosage());
                prescpItem.setDuration(prscpItem_OBJ.getDuration());
                prescpItem.setUseCycle(prscpItem_OBJ.getUseCycle());
                prescpItem.setUseMethod(prscpItem_OBJ.getUseMethod());
                prescpItem.setMealType(prscpItem_OBJ.getMealType());
                prescpItem.setQty(prscpItem_OBJ.getQty());
                prescpItem.setCostPerItem(prscpItem_OBJ.getCostPerItem());
                prescpItem.setTotalCost(prscpItem_OBJ.getTotalCost());
                prescpItem.setRemark(prscpItem_OBJ.getRemark());
                prescpItem.setStatus(1);
                sess.save(prescpItem);

                // [ 02_2 ] UPDATE  "STOCK  >> QTY" -----------------------------------------------------------------------
                Stock stk = (Stock) sess.load(Stock.class, prscpItem_OBJ.getStock().getStockId());
                stk.setQty(stk.getQty() - prescpItem.getQty());
                sess.update(stk);
            }

            // [ 03 ] UPDATE  "PATIENT-TOKEN" -STATUS ----------------------------------------------------------------------
            param_Token.setStatus(1);
            sess.update(param_Token);

            // [ 04 ] CLEAR DATA-HOLDER -----------------------------------------------------------------------------------------
            dtHolder.clear();
            request.getSession().removeAttribute("PRESCRIPTION_Items");

            // FINALIZE ==================================================================================================
            tr.commit();
            sess.close();
            out.print("success:Submit Successful!:");

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
