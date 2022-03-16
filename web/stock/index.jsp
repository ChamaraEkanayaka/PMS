<%-- 
    Document   : issueToken
    Created on : Jan 20, 2021, 7:51:06 AM
    Author     : Mayura Lakshan
--%>

<%@page import="POJOS.User"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //login code and check access please past this code before header of all pages
    String MAIN_NAME = DataHolders.ProjectInfo.getAppTitle();
    String navMenuItem = "token";
    String pagename = "issueToken";
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
                Session sess_UserAccess = FactoryManager.getSessionFactory().openSession();
                User User_AccessOBJECT = (User) sess_UserAccess.load(User.class, USER_ID);
                if (!User_AccessOBJECT.getAd().contains("N")) {
                    response.sendRedirect("index.jsp");
                    return;
                }
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
        <title>Issue Tokens | <%=MAIN_NAME%></title>
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

                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <!-- Page Content Start ----------------------------------------------------------------------------------------------------------------- -->

                                        <div class="page-header">
                                            <div class="row align-items-end">
                                                <div class="col-lg-8">
                                                    <div class="page-header-title">
                                                        <div class="d-inline">
                                                            <h4>ISSUE MEDICINES</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="page-body">
                                            <div class="row">

                                                <div class="col-lg-12">
                                                    <div class="card bg-c-yellow text-white">
                                                        <div class="card-block text-center">

                                                            <!-- Token-Number-->
                                                            <input type="hidden" id="val_TokenNo" value="1">
                                                            <span style="text-align: center; font-size: 65px; margin-left: 10px; margin-right: 10px;" id="lbl_TokenNo">#</span>

                                                            <!-- Patient-Names & Details -->
                                                            <div class="row align-items-left m-t-5">
                                                                <div class="col-lg-6 col-md-12 col-sm-12 col text-left m-b-30">
                                                                    <label class="col-lable f-w-700">#Token | Patient</label>
                                                                    <select class="form-control"
                                                                            required="true"
                                                                            id="patientID"
                                                                            onchange='checkValidations_IssuingForm(); load_SelectedPatientDetails();'
                                                                            onclick='checkValidations_IssuingForm(); load_SelectedPatientDetails();'>
                                                                        <option value="x">Select Here</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="row align-items-left m-b-10">
                                                                <div class="col col-auto text-left"><i class="feather icon-users f-50 text-white"></i></div>
                                                                <div class="col text-left" style="margin-left: -10px;">
                                                                    <h5 class="m-b-5 f-16">ID<span style="margin-left: 52px;">&nbsp;:&nbsp;</span><span id="lbl_PatientID">N/A</span></h5>
                                                                    <h5 class="m-b-5 f-16">Name<span style="margin-left: 23px;">&nbsp;:&nbsp;</span><span id="lbl_Name">N/A</span></h5>
                                                                    <h5 class="m-b-5 f-16">Gender<span style="margin-left: 12px;">&nbsp;:&nbsp;</span><span id="lbl_Gender">N/A</span></h5>
                                                                    <h5 class="m-b-5 f-16">Age<span style="margin-left: 40px;">&nbsp;:&nbsp;</span><span id="lbl_Age">N/A</span></h5>
                                                                    <h5 class="m-b-5 f-16">#Contact<span style="margin-left: 0px;">&nbsp;:&nbsp;</span><span id="lbl_Contact">N/A</span></h5>
                                                                </div>
                                                            </div><br><br>
                                                            <!-- Submit/ Refresh Buttons -->
                                                            <div class="m-b-5">
                                                                <hr class="m-t-0" style="border-top: 2px dashed rgba(248,249,250);">
                                                                <button class="btn btn-light btn-round m-r-5" id="btn_Submit" onclick='show_PrescriptionPrvw_Modal(document.getElementById("patientID").value.split("*")[1]);'>View Prescription</button>
                                                                <a class="btn btn-info btn-round" href="dispensary.jsp">Refresh</a>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                        <!-- Page Content End ----------------------------------------------------------------------------------------------------------------- -->
                                    </div>
                                </div>
                            </div>
                        </div>
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
        <!-- Select2  Script Plugins -->
        <script src="assets/vendor/select2/js/select2.full.min.js" type="text/javascript"></script>

        <script>
        </script>
        <!-- === UTILITY SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            $(document).ready(function () {
                // Initialize Select2
                $('#patientID').select2();

                setTimeout(function () {
                    load_PatientsList();
                }, 800);


                // *** Auto-Select Patient (when Requested) *****************************
            <%  if (request.getParameter("patientID") != null) {%>
                setTimeout(function () {
                    $('#patientID').val("<%=request.getParameter("patientID")%>");
                    $('#patientID').select2().trigger('change');
                }, 1300);
            <% }%>

            });
        </script>

        <script type="text/javascript">
            function show_PrescriptionPrvw_Modal(prescriptionNo) {
                $('#Prescription-Modal').modal('show');
                $('#Prescription-Modal-Content').load('prescriptionPreview_Modal_Medicine.jsp?prescriptionNo=' + prescriptionNo);
            }
            function load_PatientsList() {
                document.getElementById('btn_Submit').disabled = true;  // enable submit
                $.post("Issuemedicine_LoadPrescriptionListServlet", function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("patientID").innerHTML = outputData.split(":")[1];
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }

            function load_SelectedPatientDetails() {
                $.post("IssueToken_LoadSelectedPatientDetailsServlet", "patientID=" + document.getElementById("patientID").value.split("*")[0], function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("lbl_PatientID").innerHTML = outputData.split(":")[1];
                        document.getElementById("lbl_Name").innerHTML = outputData.split(":")[2];
                        document.getElementById("lbl_Gender").innerHTML = outputData.split(":")[3];
                        document.getElementById("lbl_Age").innerHTML = outputData.split(":")[4];
                        document.getElementById("lbl_Contact").innerHTML = outputData.split(":")[5];
                        if (document.getElementById("patientID").value.split("*")[0] !== 'x') {
                            document.getElementById("lbl_TokenNo").innerHTML = "# " + document.getElementById("patientID").value.split("*")[2];
                        } else {
                            document.getElementById("lbl_TokenNo").innerHTML = "# ";

                        }
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }


        </script>

        <script type="text/javascript">
            function checkValidations_IssuingForm() {
                var flagSubmitSts = false;
                if (document.getElementById('val_TokenNo').value < 1) {
                    flagSubmitSts = false;
                } else if (document.getElementById('patientID').value == "x") {
                    flagSubmitSts = false;
                }
                // @ finally all OK
                else {
                    flagSubmitSts = true;
                }
                //  == set submit btn status =================================================
                if (flagSubmitSts) {
                    document.getElementById('btn_Submit').disabled = false;  // enable submit   
                } else {
                    document.getElementById('btn_Submit').disabled = true;  // enable submit
                }
            }
        </script>


    </body>
</html>