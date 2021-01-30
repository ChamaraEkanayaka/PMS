<%-- 
    Document   : report_MedicinesSalesReport
    Created on : Jan 29, 2021, 11:59:57 PM
    Author     : AKILA
--%>

<%@page import="POJOS.Items"%>
<%@page import="POJOS.User"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //login code and check access please past this code before header of all pages
    String MAIN_NAME = DataHolders.ProjectInfo.getAppTitle();
    String navMenuItem = "reports";
    String pagename = "medicinesSalesReport";
    String STAFF_NAME = "";
    String USER_NAME = "";
    String BRANCH_NAME = "";
    int USER_ID = 0;
    int BRANCH_ID = 0;
    try {
        if (request.getSession().getAttribute("LOGIN_DATA") != null) {
            USER_LOGIN_DATA LD = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
            STAFF_NAME = LD.getName();
            USER_NAME = LD.getUsername();
            BRANCH_NAME = LD.getBranchName();
            USER_ID = LD.getUser_id();
            BRANCH_ID = LD.getBranch_id();
            if (!STAFF_NAME.equals("") && !USER_NAME.equals("") && !BRANCH_NAME.equals("") && USER_ID > 0 && BRANCH_ID > 0) {
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

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Medicines Sales Report | <%=MAIN_NAME%></title>
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="description" content="#">
        <meta name="keywords" content="#">
        <meta name="author" content="APK HUB">
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">

        <!-- Bootstrap-CSS -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <!-- Datatable-CSS -->
        <link href="assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/vendor/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
        <!-- Main-CSS -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/icon/feather/css/feather.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.mCustomScrollbar.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600" rel="stylesheet">
        <!-- Sweet.Alert CSS-->
        <link rel="stylesheet" type="text/css" href="assets/vendor/sweetalert/css/sweetalert.css">
        <!-- Select2 -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/select2/css/select2.min.css">
        <!-- Select2 Custom Styles -->
        <style>
            .select2-container--default .select2-selection--single .select2-selection__rendered {
                color: #444;
                line-height: 26px;
                background: none;
                padding: 3px 30px 8px 20px;
            }
            .select2-container--default .select2-selection--single {
                height: 35px;
            }
        </style>
    </head>

    <body>
        <%
            Session sess = FactoryManager.getSessionFactory().openSession();
        %>

        <!-- Preloader Start-->
        <%@include file="includes/preloader.jsp"%>
        <!-- Preloader End -->

        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">
                <!-- Header Start-->
                <%@include file="includes/header.jsp"%>
                <!-- Header End -->

                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">
                        <!-- Sidebar Start -->
                        <%@include file="includes/sidebar.jsp"%>
                        <!-- Sidebar End -->

                        <!-- Page Content Start -->
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">

                                        <!-- Page Header Start -->
                                        <div class="page-header">
                                            <div class="row align-items-end">
                                                <div class="col-lg-8">
                                                    <div class="page-header-title">
                                                        <div class="d-inline">
                                                            <h4>Medicines Sales Report</h4>
                                                            <span>Search, View Medicines Sales Records & Details.</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="page-header-breadcrumb">
                                                        <ul class="breadcrumb-title">
                                                            <li class="breadcrumb-item">
                                                                <a href="index.jsp"> <i class="feather icon-home"></i> </a>
                                                            </li>
                                                            <li class="breadcrumb-item"><a href="report_MedicinesSalesReport.jsp">Medicines Sales Report</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Header End -->
                                        <!-- Page Body Start -->
                                        <div class="page-body">
                                            <div class="row">

                                                <!-- RESULTS FILTERING OPTIONS ======================================================================================================== -->
                                                <div class="col-sm-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <span class="label label-primary col-md-2">SEARCH BY</span>
                                                        </div>
                                                        <div class="card-block" style="margin-bottom: -30px;">
                                                            <div class="row invoive-info">

                                                                <!-- DATE-RANGE  SELECTOR  -->
                                                                <div class="col-lg-4 col-md-4 col-sm-6">
                                                                    <table class="table table-responsive invoice-table invoice-order table-borderless">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th>
                                                                                    <div class="chk-option">
                                                                                        <div class="checkbox-fade fade-in-primary">
                                                                                            <label class="check-task">Date-From
                                                                                                <input type="checkbox" checked="true" id="chBox_Date">
                                                                                                <span class="cr"><i class="cr-icon feather icon-check txt-default"></i></span>
                                                                                            </label>
                                                                                        </div>
                                                                                    </div>
                                                                                </th>
                                                                                <td>&nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th style="width: 100%;">
                                                                                    <input type="date" class="form-control" id="DateFrom" value="<%=Utils.CurrentDateNTime.getCurrentDate()%>">
                                                                                </th>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>                         
                                                                <div class="col-lg-4 col-md-4 col-sm-6">
                                                                    <table class="table table-responsive invoice-table invoice-order table-borderless">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th>Date-To</th>
                                                                                <td>&nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th style="width: 100%; padding-top: 10px;">
                                                                                    <input type="date" class="form-control" id="DateTo" value="<%=Utils.CurrentDateNTime.getCurrentDate()%>">
                                                                                </th>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div> 

                                                                <!-- MEDICINE-ITEM  SELECTOR -->
                                                                <div class="col-lg-6 col-md-6 col-sm-6">
                                                                    <table class="table table-responsive invoice-table invoice-order table-borderless">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th>
                                                                                    <div class="chk-option">
                                                                                        <div class="checkbox-fade fade-in-primary">
                                                                                            <label class="check-task">Medicine/ Item
                                                                                                <input type="checkbox" id="chBox_MedicItem">
                                                                                                <span class="cr"><i class="cr-icon feather icon-check txt-default"></i></span>
                                                                                            </label>
                                                                                        </div>
                                                                                    </div>
                                                                                </th>
                                                                                <td>&nbsp;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th style="width: 100%;">
                                                                                    <select class="form-control" id="MedicItem">
                                                                                        <option value="0">ALL</option>
                                                                                        <%  Criteria cr_MedicItems = sess.createCriteria(Items.class);
                                                                                            cr_MedicItems.add(Restrictions.eq("status", 1));
                                                                                            cr_MedicItems.addOrder(Order.asc("name"));
                                                                                            List<Items> medicItems_List = cr_MedicItems.list();
                                                                                            for (Items MedicItems_OBJ : medicItems_List) {
                                                                                                if (!MedicItems_OBJ.getStocks().isEmpty()) {
                                                                                        %>
                                                                                        <option value="<%=MedicItems_OBJ.getItemId()%>"><%=MedicItems_OBJ.getName()%></option>
                                                                                        <% }
                                                                                            }%>
                                                                                    </select>
                                                                                </th>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>

                                                                <div class="col-md-12 col-sm-12">
                                                                    <button type="submit" class="btn btn-primary" style="float: right;" onclick='load_SearchResults_DataTable();'><span class="fa fa-search" style="display: inline; color: #ffffff;"></span>&nbsp;SEARCH</button>
                                                                </div> 

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>                                           
                                            </div>
                                            <!-- TREATMENT-RECORDS --Data-Tables Start ===================================== -->
                                            <div id="DataTable_Includer">
                                                <div id="DataTable_Remover"></div>
                                            </div>
                                            <!-- TREATMENT-RECORDS --Data-Tables End ====================================== -->
                                        </div>
                                        <!-- Page Body End -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Page Content End -->
                    </div>
                </div>
            </div>
        </div>

        <!--  Core Script Pugins -->
        <script src="assets/vendor/jquery/js/jquery.min.js" type="text/javascript"></script>
        <script src="assets/vendor/jquery-ui/js/jquery-ui.min.js" type="text/javascript"></script>
        <script src="assets/vendor/popper.js/js/popper.min.js" type="text/javascript"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/vendor/jquery-slimscroll/js/jquery.slimscroll.js" type="text/javascript"></script>
        <script src="assets/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
        <script src="assets/js/pcoded.min.js" type="text/javascript"></script>
        <script src="assets/js/vartical-layout.min.js" type="text/javascript"></script>
        <script src="assets/js/script.min.js" type="text/javascript"></script>
        <script src="assets/js/modalEffects.js" type="text/javascript"></script>
        <!-- Sweet.Alert  Script Plugins -->
        <script src="assets/vendor/sweetalert/js/sweetalert.min.js" type="text/javascript"></script>
        <!-- Datatable Script Plugins -->
        <script src="assets/vendor/datatables.net/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/vendor/datatables.net-bs4/js/dataTables.bootstrap4.min.js" type="text/javascript"></script>
        <script src="assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>
        <script src="assets/vendor/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js" type="text/javascript"></script>
        <!-- Select2  Script Plugins -->
        <script src="assets/vendor/select2/js/select2.full.min.js" type="text/javascript"></script>
        <script>
        </script>
        <!-- === UTILITY SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            $(document).ready(function () {
                // cfg. data-table
                $('#datatable').DataTable();

                // cfg. Select2 Elements
                $('#MedicItem').select2();
                load_SearchResults_DataTable();
            });
        </script>

        <!-- === Load SEARCH-RESULTS _Data.Tables ================================================================= -->
        <script type="text/javascript">
            function load_SearchResults_DataTable() {
                var param_ChBxDate = document.getElementById("chBox_Date").checked;
                var param_ChMedicItem = document.getElementById("chBox_MedicItem").checked;

                var param_DateFrom = document.getElementById("DateFrom").value;
                var param_DateTo = document.getElementById("DateTo").value;
                var param_MedicItem = document.getElementById("MedicItem").value;

                document.getElementById("DataTable_Remover").outerHTML = "";
                $('#DataTable_Includer').load('report_MedicinesSalesReport_DataTable.jsp?' +
                        'param_ChBxDate=' + param_ChBxDate + "&param_ChMedicItem=" + param_ChMedicItem +
                        "&param_DateFrom=" + param_DateFrom + "&param_DateTo=" + param_DateTo + "&param_MedicItem=" + param_MedicItem);
            }
        </script>
    </body>
</html>

