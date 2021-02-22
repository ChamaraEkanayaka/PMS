/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 17 Feb 2021 10:52:32 AM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.PRESCRIPTION_ITEMS_DataHolder;
import DataHolders.PRESCRIPTION_ITEM_OBJ;
import POJOS.Prescription;
import POJOS.PrescriptionItem;
import POJOS.Stock;
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
public class PrescriptionCorrections_SaveChangesServlet extends HttpServlet {

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

            Prescription prscp_OBJC = (Prescription) sess.load(Prescription.class, Integer.valueOf(request.getParameter("prescriptionID")));
            double param_MedicineCost = Double.valueOf(request.getParameter("medicineCost"));
            double param_DoctorCharges = Double.valueOf(request.getParameter("doctorCharge"));
            double param_TotalAmount = Double.valueOf(request.getParameter("totalAmount"));
            double param_ReceivableAmount = Double.valueOf(request.getParameter("receivableAmount"));
            String param_PrescpNote = String.valueOf(request.getParameter("note"));
            PRESCRIPTION_ITEMS_DataHolder dtHolder = (PRESCRIPTION_ITEMS_DataHolder) request.getSession().getAttribute("PRESCRIPTION_Items");

            // [ 01 ] UPDATE  "PRESCRIPTION  --INFO" --------------------------------------------------------------------------------
            prscp_OBJC.setMedicineCost(param_MedicineCost);
            prscp_OBJC.setDoctorCharge(param_DoctorCharges);
            prscp_OBJC.setTotalAmount(param_TotalAmount);
            prscp_OBJC.setReceivableAmount(param_ReceivableAmount);
            prscp_OBJC.setNote(param_PrescpNote);
            sess.update(prscp_OBJC);

            Criteria upd_PrscpItems_Crt = sess.createCriteria(PrescriptionItem.class);
            upd_PrscpItems_Crt.add(Restrictions.eq("prescription", prscp_OBJC));
            List<PrescriptionItem> updPrscpITEM_LIST = upd_PrscpItems_Crt.list();
            for (PrescriptionItem Upd_PrscpItem_OBJ : updPrscpITEM_LIST) {

                // [ 02 ] UPDATE  "STOCK  >> QTY" ( INCREASE+++ ) --------------------------------------------------------------------------
                Stock upd_Stock = (Stock) sess.load(Stock.class, Upd_PrscpItem_OBJ.getStock().getStockId());
                upd_Stock.setQty(upd_Stock.getQty() + Upd_PrscpItem_OBJ.getQty());
                sess.update(upd_Stock);

                // [ 03 ] DELETE  "PRESCRIPTION -ITEMs"   from  DB--------------------------------------------------------------------------------
                sess.delete(Upd_PrscpItem_OBJ);
            }

            for (PRESCRIPTION_ITEM_OBJ prscpItem_OBJ : dtHolder.getHolder()) {
                // [ 04 ] SAVE  "PRESCRIPTION  >>ITEMS" -----------------------------------------------------------------------------------------
                PrescriptionItem prescpItem = new PrescriptionItem();
                prescpItem.setPrescription(prscp_OBJC);
                prescpItem.setStock(prscpItem_OBJ.getStock());
                prescpItem.setMedicineType(prscpItem_OBJ.getMedicineType());
                prescpItem.setDosage(prscpItem_OBJ.getDosage());
                prescpItem.setDuration(prscpItem_OBJ.getDuration());
                prescpItem.setUseCycle(prscpItem_OBJ.getUseCycle());
                prescpItem.setUseMethod(prscpItem_OBJ.getUseMethod());
                prescpItem.setMealType(prscpItem_OBJ.getMealType());
                prescpItem.setQty(prscpItem_OBJ.getQty());
                prescpItem.setUnitCost(prscpItem_OBJ.getUnitCost());
                prescpItem.setTotalCost(prscpItem_OBJ.getTotalCost());
                prescpItem.setUnitPrice(prscpItem_OBJ.getUnitPrice());
                prescpItem.setTotalPrice(prscpItem_OBJ.getTotalPrice());
                prescpItem.setRemark(prscpItem_OBJ.getRemark());
                prescpItem.setStatus(1);
                sess.save(prescpItem);

                // [ 05 ] UPDATE  "STOCK  >> QTY" ( DESCREASE--- ) -----------------------------------------------------------------------
                Stock stk = (Stock) sess.load(Stock.class, prscpItem_OBJ.getStock().getStockId());
                stk.setQty(stk.getQty() - prescpItem.getQty());
                sess.update(stk);
            }

            // [ 06 ] CLEAR DATA-HOLDER -----------------------------------------------------------------------------------------
            dtHolder.clear();
            request.getSession().removeAttribute("PRESCRIPTION_Items");

            // FINALIZE ==================================================================================================
            tr.commit();
            sess.close();
            out.print("success:Corrections Save Successful!:");

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
