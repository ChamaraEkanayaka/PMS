/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 21 Feb 2021 02:43:57 PM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.PRESCRIPTION_ITEMS_DataHolder;
import DataHolders.PRESCRIPTION_ITEM_OBJ;
import POJOS.Prescription;
import POJOS.PrescriptionItem;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;
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
public class PrescriptionCorrections_LoadItemsToDHServlet extends HttpServlet {

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
            Session sess = FactoryManager.getSessionFactory().openSession();
            Transaction tr = sess.beginTransaction();

            // Params & Objects ======================================================
            Prescription modifPRESC_OBJC = (Prescription) sess.load(Prescription.class, Integer.valueOf(request.getParameter("prescriptionNo")));
            PRESCRIPTION_ITEMS_DataHolder dtHolder = (PRESCRIPTION_ITEMS_DataHolder) request.getSession().getAttribute("PRESCRIPTION_Items");

            // ADD  "PRESCRIPTION -ITEMS"   to DATA-HOLDER --------------------------------------------------------------------------------
            Set<PrescriptionItem> PrescpItems_SET = modifPRESC_OBJC.getPrescriptionItems();
            for (PrescriptionItem PrescpItem_OBJ : PrescpItems_SET) {
                PRESCRIPTION_ITEM_OBJ newPrscp_Item = new PRESCRIPTION_ITEM_OBJ();
                newPrscp_Item.setStock(PrescpItem_OBJ.getStock());
                newPrscp_Item.setDosage(PrescpItem_OBJ.getDosage());
                newPrscp_Item.setDuration(PrescpItem_OBJ.getDuration());
                newPrscp_Item.setMedicineType(PrescpItem_OBJ.getMedicineType());
                newPrscp_Item.setUseCycle(PrescpItem_OBJ.getUseCycle());
                newPrscp_Item.setUseMethod(PrescpItem_OBJ.getUseMethod());
                newPrscp_Item.setMealType(PrescpItem_OBJ.getMealType());
                newPrscp_Item.setQty(PrescpItem_OBJ.getQty());
                newPrscp_Item.setUnitCost(PrescpItem_OBJ.getUnitCost());
                newPrscp_Item.setTotalCost(PrescpItem_OBJ.getTotalCost());
                newPrscp_Item.setUnitPrice(PrescpItem_OBJ.getUnitPrice());
                newPrscp_Item.setTotalPrice(PrescpItem_OBJ.getTotalPrice());
                newPrscp_Item.setRemark(PrescpItem_OBJ.getRemark());
                dtHolder.getHolder().add(newPrscp_Item);
            }
            request.getSession().setAttribute("PRESCRIPTION_Items", dtHolder);

            
            
            // FINALIZE ==================================================================================================
            tr.commit();
            out.print("success:Done!:");

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
