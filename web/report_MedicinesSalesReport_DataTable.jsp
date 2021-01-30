<%-- 
    Document   : report_MedicinesSalesReport_DataTable
    Created on : Jan 30, 2021, 12:00:15 AM
    Author     : AKILA
--%>

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

                            <div class="col-lg-4">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white" style="height: 142px;">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">TOKENS COUNT</code>
                                    <h4 class="text-sm-center f-40" id="RptSUM_TokensCount">0</h4>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <div class="p-0 z-depth-bottom-1 waves-effect bg-c-blue text-white">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900;">TOTAL MEDICINE COST</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_MedCost">Rs. 0.00</span>

                                            <code style="margin-left: -1px;margin-top: 5px;font-weight: 900;">TOTAL DOCTOR CHARGES</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_DocCharges">Rs. 0.00</span>
                                        </div>
                                        <div class="col-lg-6">
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900;">TOTAL AMOUNT&nbsp;&nbsp;&nbsp;</code>
                                            <span style="color: #ffffff;font-size: x-large;margin-left: 20px;" id="RptSUM_TotAmount">Rs. 0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">TOTAL RECEIVABLE AMOUNT</code>
                                    <h4 class="text-sm-center" id="RptSUM_RcvblAmount">Rs. 0.00</h4>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">BALANCE</code>
                                    <h4 class="text-sm-center" id="RptSUM_Balance">Rs. 0.00</h4>
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
                                    <th id="dtTableTH_ORD">#Medicine/ Item</th>
                                    <th>Sales Qty</th>
                                    <th>Unit Cost</th>
                                    <th>Total Cost</th>
                                    <th>Unit Sales Price</th>
                                    <th>Total Sales Amount</th>
                                    <th>Balance</th>
                                    <th>Date & Time</th>
                                </tr>
                            </thead>
                             <tbody>
                                <%
                                    // Report-Sum Values params
                                    int SumVALUE_TokensCount = 0;
                                    double SumVALUE_MedCost = 0.00;
                                    double SumVALUE_DocCharges = 0.00;
                                    double SumVALUE_TotAmount = 0.00;
                                    double SumVALUE_RcvblAmount = 0.00;
                                    
                                   
                                   %>
                            </tbody>
                        </table>
                    </div>

                    <input type="hidden" id="VALSUM_TokensCount" value="<%= SumVALUE_TokensCount%>">      
                    <input type="hidden" id="VALSUM_MedCost" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_MedCost)%>">      
                    <input type="hidden" id="VALSUM_DocCharges" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_DocCharges)%>">      
                    <input type="hidden" id="VALSUM_TotAmount" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_TotAmount)%>">      
                    <input type="hidden" id="VALSUM_RcvblAmount" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_RcvblAmount)%>">      
                    <input type="hidden" id="VALSUM_Balance" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_RcvblAmount - SumVALUE_TotAmount)%>">      

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
                document.getElementById("dtTableTH_ORD").click();

                // set  REPORT.SUM.TILES.VALUES
                document.getElementById("RptSUM_TokensCount").innerHTML = document.getElementById("VALSUM_TokensCount").value;
                document.getElementById("RptSUM_MedCost").innerHTML = document.getElementById("VALSUM_MedCost").value;
                document.getElementById("RptSUM_DocCharges").innerHTML = document.getElementById("VALSUM_DocCharges").value;
                document.getElementById("RptSUM_TotAmount").innerHTML = document.getElementById("VALSUM_TotAmount").value;
                document.getElementById("RptSUM_RcvblAmount").innerHTML = document.getElementById("VALSUM_RcvblAmount").value;
                document.getElementById("RptSUM_Balance").innerHTML = document.getElementById("VALSUM_Balance").value;
            }, 800);
        });
    </script>
</div>