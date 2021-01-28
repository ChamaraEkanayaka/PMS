<%-- 
    Document   : patient_PrescriptionsList
    Created on : Jan 28, 2021, 2:00:59 PM
    Author     : AKILA
--%>

<%@page import="POJOS.Patient"%>
<%@page import="POJOS.Prescription"%>
<%@page import="POJOS.User"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //login code and check access please past this code before header of all pages
    String MAIN_NAME = DataHolders.ProjectInfo.getAppTitle();
    String navMenuItem = "patients";
    String pagename = "patientPrescriptionsList";
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
                if (request.getParameter("patientID") != null && !(request.getParameter("patientID").isEmpty())) {
                    //check access code

                    //check access code
                } else {
                    response.sendRedirect("index.jsp");
                    return;
                }
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
        <title>Patient Prescriptions List | <%=MAIN_NAME%></title>
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
    </head>

    <body>
        <%
            Session sess = FactoryManager.getSessionFactory().openSession();
            // set PATIENT Object
            Patient patient_OBJ = (Patient) sess.load(Patient.class, Integer.valueOf(request.getParameter("patientID")));
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
                                                            <h4>Patient Prescriptions List</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Header End -->

                                        <!-- Page Body Start -->
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <h5><span class="label label-warning p-r-20">&nbsp;<span class="fa fa-user"></span>&nbsp;&nbsp;PATIENT :&nbsp;<%=patient_OBJ.getName()%></span></h5><br>
                                                    <div class="card">
                                                        <div class="card-block">
                                                            <div class="dt-responsive table-responsive">
                                                                <table id="datatable" class="table table-striped table-bordered nowrap">
                                                                    <thead>
                                                                        <tr>
                                                                            <th id="dtTableTH_ORD">#Prescription</th>
                                                                            <th>Date</th>
                                                                            <th>Time</th>
                                                                            <th>#Token</th>
                                                                            <th>Doctor</th>
                                                                            <th>Receivable Amount</th>
                                                                            <th>Payments Status</th>
                                                                            <th>Actions</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <%  Criteria prescp_Crt = sess.createCriteria(Prescription.class);
                                                                            prescp_Crt.add(Restrictions.eq("patient", patient_OBJ));
                                                                            List<Prescription> prescpList = prescp_Crt.list();
                                                                            for (Prescription prescp_Objct : prescpList) {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=prescp_Objct.getIdprescription()%></td>
                                                                            <td><%=prescp_Objct.getDate()%></td>
                                                                            <td><%=prescp_Objct.getTime()%></td>
                                                                            <td><%=prescp_Objct.getPatientToken().getTokenNumber()%></td>
                                                                            <td><%=prescp_Objct.getDoctor().getName()%></td>
                                                                            <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getReceivableAmount())%></td>
                                                                            <td>
                                                                                <% if (prescp_Objct.getStatus() == 1) { %>
                                                                                <span class="label label-danger">&nbsp;PENDING&nbsp;</span>      
                                                                                <% } else { %>
                                                                                <span class="label label-success">&nbsp;COMPLETED&nbsp;</span>   
                                                                                <% }%>
                                                                            </td>
                                                                            <td>
                                                                                <button class="btn btn-primary btn-sm" onclick='show_PrescriptionPrvw_Modal("<%=prescp_Objct.getIdprescription()%>");'><span class="fa fa-file-text" style="display: inline; color: #ffffff;"></span>&nbsp;&nbsp;View Prescription</button>
                                                                            </td>
                                                                        </tr>
                                                                        <% }%>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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

        <!-- Prescription-Preview _Modal -->
        <div class="modal fade" tabindex="-1" role="dialog" id="Prescription-Modal">
            <div class="modal-dialog modal-lg" role="document" style="max-width: 80%;">
                <div class="modal-content" id="Prescription-Modal-Content" style="background: #f6f7fb;">
                    <div class="loader-block"><svg id="loader2" viewBox="0 0 100 100"><circle id="circle-loader2" cx="50" cy="50" r="45"></circle></svg></div>
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
        <script>
        </script>
        <!-- === UTILITY SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            $(document).ready(function () {
                // cfg. data-table
                $('#datatable').DataTable();

                setTimeout(function () {
                    document.getElementById("dtTableTH_ORD").click();
                }, 500);
            });
        </script>

        <script type="text/javascript">
            function show_PrescriptionPrvw_Modal(prescriptionNo) {
                $('#Prescription-Modal').modal('show');
                $('#Prescription-Modal-Content').load('prescriptionPreview_Modal.jsp?prescriptionNo=' + prescriptionNo);
            }
        </script>
    </body>
</html>

