/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 15 Jan 2021 10:59:47 AM By AKILA.
 */
package Servlet;

import Connection.FactoryManager;
import DataHolders.USER_LOGIN_DATA;
import POJOS.Branch;
import POJOS.Items;
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
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILA
 */
public class Prescription_LoadAddingItemsServlet extends HttpServlet {

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
            USER_LOGIN_DATA userLOGDATA = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
            Branch branchOBJC = (Branch) ssn.load(Branch.class, Integer.valueOf(userLOGDATA.getBranch_id()));

            String param_OUTPUT = "<option value='x'>Select an Item</option>";

            // Collect Available ITEMS set...
            Criteria Items_Crt = ssn.createCriteria(Items.class);
            Items_Crt.add(Restrictions.eq("status", 1));
            Items_Crt.addOrder(Order.asc("name"));
            List<Items> ItemsList = Items_Crt.list();
            for (Items Item_Objct : ItemsList) {

                // Check ITEM's Stock Availability.. 
                Criteria stock_Crt = ssn.createCriteria(Stock.class);
                stock_Crt.add(Restrictions.eq("items", Item_Objct));
                stock_Crt.add(Restrictions.eq("branch", branchOBJC));
                stock_Crt.add(Restrictions.eq("status", 1));
                stock_Crt.add(Restrictions.gt("qty", 0.00));
                List<Stock> StockList = stock_Crt.list();

                if (!StockList.isEmpty()) {
                    param_OUTPUT = param_OUTPUT + "<option value='" + Item_Objct.getItemId() + "'>" + Item_Objct.getName() + "</option>";
                }
            }

            out.print("success::Done!:" + param_OUTPUT);

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
