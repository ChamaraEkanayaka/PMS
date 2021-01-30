<%-- 
    Document   : report_MedicinesSalesReport_DataTable
    Created on : Jan 30, 2021, 12:00:15 AM
    Author     : AKILA
--%>

<%@page import="java.util.Set"%>
<%@page import="POJOS.PrescriptionItem"%>
<%@page import="POJOS.Stock"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="POJOS.Items"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="POJOS.Prescription"%>
<%@page import="org.hibernate.transform.Transformers"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>

<%
    //login code and check access please past this code before header of all pages
    int USER_ID_sub = 0;
    int BRANCH_ID_sub = 0;
    try {
        if (request.getSession().getAttribute("LOGIN_DATA") != null) {
            USER_LOGIN_DATA LD_sub = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
            USER_ID_sub = LD_sub.getUser_id();
            BRANCH_ID_sub = LD_sub.getBranch_id();
            if (USER_ID_sub > 0 && BRANCH_ID_sub > 0) {
                //check access code

                //check access code
            } else {
                response.sendRedirect("login.jsp");
                return;
            }
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
    } catch (Exception e) {
        response.sendRedirect("login.jsp");
        return;
    }
    //login code and check access plase past this code before header of all pages
%>


<div id="DataTable_Remover">
    <%
        Session ssn_MedicSalesReport = FactoryManager.getSessionFactory().openSession();

        // **** Set RESULT-SET Params *****************************************************************************************
        boolean chBxOpt_Date = false;
        boolean chBxOpt_MedicItem = false;

        if (request.getParameter("param_ChBxDate") != null) {
            chBxOpt_Date = Boolean.valueOf(request.getParameter("param_ChBxDate"));
        }
        if (request.getParameter("param_ChMedicItem") != null) {
            chBxOpt_MedicItem = Boolean.valueOf(request.getParameter("param_ChMedicItem"));
        }

        String Val_DateFrom = "";
        String Val_DateTo = "";
        Items Val_MedicItem = null;

        if (request.getParameter("param_DateFrom") != null) {
            Val_DateFrom = String.valueOf(request.getParameter("param_DateFrom"));
        }
        if (request.getParameter("param_DateTo") != null) {
            Val_DateTo = String.valueOf(request.getParameter("param_DateTo"));
        }
        if (request.getParameter("param_MedicItem") != null) {
            Val_MedicItem = (Items) ssn_MedicSalesReport.load(Items.class, Integer.valueOf(request.getParameter("param_MedicItem")));
        }
    %>

    <!-- SEARCH_RESULTS -- data.table ======================================================================= -->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h5><span class="label label-warning">&nbsp;Medicines Sales Records&nbsp;</span></h5><br>
                    <span>Search Results On&nbsp;&nbsp;:&nbsp;&nbsp;
                        <%  String searchResultTxt = "";
                            // set CUSTOMIZED SEARCHING OPTIONS....
                            if (chBxOpt_Date) {
                                searchResultTxt = searchResultTxt + " | DATE: " + Val_DateFrom + " - " + Val_DateTo;
                            }
                            if (chBxOpt_MedicItem) {
                                if (Integer.valueOf(request.getParameter("param_MedicItem")) != 0) {
                                    searchResultTxt = searchResultTxt + " | MEDICINE/ ITEM: " + Val_MedicItem;
                                } else {
                                    searchResultTxt = searchResultTxt + " | MEDICINE/ ITEM: All";
                                }
                            }
                            if (!(chBxOpt_Date || chBxOpt_MedicItem)) {
                                searchResultTxt = searchResultTxt + " All";
                            }
                        %>
                        <%=searchResultTxt%>
                    </span> 


                    <!--  ./start   REPORT.SUM.TILES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  -->
                    <div class="card-block box-list">
                        <div class="row">

                            <div class="col-lg-3">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white" style="height: 142px;">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">TOTAL SALES ITEMS</code>
                                    <h4 class="text-sm-center f-30" id="RptSUM_SalesItems">0</h4>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white" style="height: 142px;">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">TOTAL SALES QTY</code>
                                    <h4 class="text-sm-center f-30" id="RptSUM_SalesQty">0</h4>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="p-0 z-depth-bottom-1 waves-effect bg-c-blue text-white">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900;">TOTAL COST</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_TotalCost">Rs. 0.00</span>

                                            <code style="margin-left: -1px;margin-top: 5px;font-weight: 900;">TOTAL SALES AMOUNT</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_TotalSalesAmount">Rs. 0.00</span>
                                        </div>
                                        <div class="col-lg-6">
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900;">PROFIT&nbsp;&nbsp;&nbsp;</code>
                                            <span style="color: #ffffff;font-size: x-large;margin-left: 20px;" id="RptSUM_Profit">Rs. 0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--  ./end  REPORT.SUM.TILES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  -->

                    <div class="card-header-right">
                        <ul class="list-unstyled card-option">
                            <li><i class="feather icon-maximize full-card"></i></li>
                            <li><i class="feather icon-minus minimize-card"></i></li>
                        </ul>
                    </div>
                </div>
                <div class="card-block">
                    <div class="dt-responsive table-responsive">
                        <table id="datatable" class="table table-striped table-bordered nowrap">
                            <thead>
                                <tr>
                                    <th>#Medicine/ Item</th>
                                    <th>Sales Qty</th>
                                    <th>Unit Cost</th>
                                    <th>Unit Sales Price</th>
                                    <th>Total Cost</th>
                                    <th>Total Sales Amount</th>
                                    <th>Profit</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Report-Sum Values params
                                    int SumVALUE_SalesItems = 0;
                                    double SumVALUE_SalesQty = 0.00;
                                    double SumVALUE_TotalCost = 0.00;
                                    double SumVALUE_TotalSalesAmount = 0.00;

                                    // COLLECT  Item-Names LIST... ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                    boolean flag_ItemNameExist = false;
                                    boolean flag_readyToADDLIST = false;

                                    Criteria Items_Crt = ssn_MedicSalesReport.createCriteria(Items.class);
                                    if (chBxOpt_MedicItem) { // set Custom-Search Opt.
                                        if (Integer.valueOf(request.getParameter("param_MedicItem")) != 0) {
                                            Items_Crt.add(Restrictions.eq("name", Val_MedicItem.getName()));
                                        }
                                    }
                                    Items_Crt.addOrder(Order.asc("name"));
                                    List<Items> itemsList = Items_Crt.list();
                                    for (Items items_OBJECT : itemsList) {
                                        flag_ItemNameExist = false;
                                        if (!items_OBJECT.getStocks().isEmpty()) {

                                            Criteria stock_Crt = ssn_MedicSalesReport.createCriteria(Stock.class);
                                            stock_Crt.add(Restrictions.eq("items", items_OBJECT));
                                            stock_Crt.add(Restrictions.eq("status", 1));
                                            List<Stock> Stock_LIST = stock_Crt.list();
                                            for (Stock Stock_OBJECT : Stock_LIST) {
                                                Set<PrescriptionItem> PrescItems_SET = Stock_OBJECT.getPrescriptionItems();

                                                // COLLECT  Prescription-Items  LIST.. ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
                                                for (PrescriptionItem PrescItems_OBJECT : PrescItems_SET) {
                                                    flag_readyToADDLIST = false;

                                                    // CHECK ON  Prescription .. ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
                                                    Criteria Prescp_Crt = ssn_MedicSalesReport.createCriteria(Prescription.class);
                                                    Prescp_Crt.add(Restrictions.eq("idprescription", PrescItems_OBJECT.getPrescription().getIdprescription()));
                                                    // Prescp_Crt.add(Restrictions.eq("status", 1)); //  >> @NOW get all   Prescriptions-Items
                                                    if (chBxOpt_Date) { // set Custom-Search Opt.
                                                        Prescp_Crt.add(Restrictions.between("date", Val_DateFrom, Val_DateTo));
                                                    }
                                                    List<Prescription> Prescp_LIST = Prescp_Crt.list();
                                                    if (!Prescp_LIST.isEmpty()) {
                                                        flag_readyToADDLIST = true;
                                                    }
                                                    if (flag_readyToADDLIST) {
                                                        if (!flag_ItemNameExist) {
                                                            flag_ItemNameExist = true;
                                                            SumVALUE_SalesItems += 1;
                                %>
                                <tr style="background-color: #a5d6a7;">
                                    <td><%= Stock_OBJECT.getItems().getName()%></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <% }%>    
                                <tr>
                                    <td style="color: transparent; font-size: 0px;"><%= Stock_OBJECT.getItems().getName()%></td>
                                    <td><%= Utils.DecimalFormats.dfDoubleValue().format(PrescItems_OBJECT.getQty())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(PrescItems_OBJECT.getUnitCost())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(PrescItems_OBJECT.getUnitPrice())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(PrescItems_OBJECT.getTotalCost())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(PrescItems_OBJECT.getTotalPrice())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(PrescItems_OBJECT.getTotalPrice() - PrescItems_OBJECT.getTotalCost())%></td>
                                    <td><%= PrescItems_OBJECT.getPrescription().getDate()%></td>
                                    <td><%= PrescItems_OBJECT.getPrescription().getTime()%></td>
                                </tr>
                                <%
                                                        // Calculate SUM-VALUES
                                                        SumVALUE_SalesQty += PrescItems_OBJECT.getQty();
                                                        SumVALUE_TotalCost += PrescItems_OBJECT.getTotalCost();
                                                        SumVALUE_TotalSalesAmount += PrescItems_OBJECT.getTotalPrice();

                                                    }
                                                }
                                            }
                                        }
                                    }

                                %>
                            </tbody>
                        </table>
                    </div>

                    <input type="hidden" id="VALSUM_SalesItems" value="<%= SumVALUE_SalesItems%>">      
                    <input type="hidden" id="VALSUM_SalesQty" value="<%=Utils.DecimalFormats.dfDoubleValue().format(SumVALUE_SalesQty)%>">      
                    <input type="hidden" id="VALSUM_TotalCost" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_TotalCost)%>">      
                    <input type="hidden" id="VALSUM_TotalSalesAmount" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_TotalSalesAmount)%>">      
                    <input type="hidden" id="VALSUM_Profit" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_TotalSalesAmount - SumVALUE_TotalCost)%>">      

                </div>
            </div>
        </div>
    </div>

    <!--  Core Script Pugins -->   
    <script src="assets/js/script.min.js" type="text/javascript"></script>
    <script src="assets/js/modalEffects.js" type="text/javascript"></script>
    <script>
    </script>

    <!-- === UTILITY SCRIPTS ==================================================================================================== -->
    <script type="text/javascript">
        $(document).ready(function () {
            // cfg. data-table
            $('#datatable').DataTable();

            setTimeout(function () {
                // set  REPORT.SUM.TILES.VALUES
                document.getElementById("RptSUM_SalesItems").innerHTML = document.getElementById("VALSUM_SalesItems").value;
                document.getElementById("RptSUM_SalesQty").innerHTML = document.getElementById("VALSUM_SalesQty").value;
                document.getElementById("RptSUM_TotalCost").innerHTML = document.getElementById("VALSUM_TotalCost").value;
                document.getElementById("RptSUM_TotalSalesAmount").innerHTML = document.getElementById("VALSUM_TotalSalesAmount").value;
                document.getElementById("RptSUM_Profit").innerHTML = document.getElementById("VALSUM_Profit").value;
            }, 800);
        });
    </script>
</div>