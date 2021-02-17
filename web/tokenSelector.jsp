<%-- 
    Document   : tokenSelector
    Created on : Jan 4, 2021, 10:46:44 PM
    Author     : AKILA
--%>

<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //login code and check access please past this code before header of all pages
    String MAIN_NAME = DataHolders.ProjectInfo.getAppTitle();
    String navMenuItem = "treatment";
    String pagename = "tokenSelector";
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
                if (!User_AccessOBJECT.getAd().contains("M")) {
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
        <title>Select Next #Token | <%=MAIN_NAME%></title>
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
                                                            <h4>NEXT PATIENT TOKEN NUMBER</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="page-body">
                                            <div class="row">

                                                <div class="col-lg-12">
                                                    <div class="card bg-c-green text-white">
                                                        <div class="card-block text-center">

                                                            <input type="hidden" id="val_TokenNo" value="1">

                                                            <button class="btn btn-light btn-round btn-sm" style="float: left; margin-top: 10px;" id="btn_Backward" onclick='load_NextToken(0);'><span class="fa fa-chevron-left f-30 text-c-green"></span></button>
                                                            <span style="text-align: center; font-size: 50px; margin-left: 10px; margin-right: 10px;" id="lbl_TokenNo">#</span>
                                                            <button class="btn btn-light btn-round btn-sm" style="float: right; margin-top: 10px;" id="btn_Forward" onclick='load_NextToken(1);'><span class="fa fa-chevron-right f-30 text-c-green"></span></button>

                                                            <div class="row align-items-left m-t-20 m-b-50">
                                                                <div class="col col-auto text-left"><i class="feather icon-users f-50 text-white"></i></div>
                                                                <div class="col text-left" style="margin-left: -10px;">
                                                                    <h5 class="m-b-5 f-16">ID<span style="margin-left: 37px;">&nbsp;:&nbsp;</span><span id="lbl_PatientID"></span></h5>
                                                                    <h5 class="m-b-5 f-16">Name<span style="margin-left: 10px;">&nbsp;:&nbsp;</span><span id="lbl_Name"></span></h5>
                                                                    <h5 class="m-b-5 f-16">Gender<span style="margin-left: 0px;">&nbsp;:&nbsp;</span><span id="lbl_Gender"></span></h5>
                                                                    <h5 class="m-b-5 f-16">Age<span style="margin-left: 25px;">&nbsp;:&nbsp;</span><span id="lbl_Age"></span></h5>
                                                                </div>
                                                            </div><br><br>

                                                            <div class="m-b-5">
                                                                <hr class="m-t-0" style="border-top: 2px dashed rgba(248,249,250);">
                                                                <button class="btn btn-light btn-round m-r-5" id="btn_Select" onclick='select_Token(document.getElementById("val_TokenNo").value);'>Select</button>
                                                                <button class="btn btn-danger btn-round m-r-5" id="btn_Skip" onclick='skip_Token(document.getElementById("val_TokenNo").value);'>&nbsp;&nbsp;Skip&nbsp;&nbsp;</button>
                                                                <button class="btn btn-warning btn-round" id="btn_Refresh" onclick='load_NextToken(2);'>Refresh</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Skipped Tokens List  -DATA.TABLE --------------------------------------------------------------------------------------------- -->
                                                <div class="col-lg-12 m-b-10">
                                                    <button class="btn btn-dark btn-mat waves-effect" id="btn_SkippedList" onclick='load_SkippedTokensList();'><span class="fa fa-bookmark-o"></span>&nbsp;&nbsp;SKIPPED TOKENS</button>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div id="DataTable_Includer">
                                                        <div id="DataTable_Remover"></div>
                                                    </div>
                                                </div>

                                                <!-- "Prescription-Corrections" Available List  -DATA.TABLE --------------------------------------------------------------------------------------------- -->
                                                <div class="col-lg-12 m-b-10">
                                                    <button class="btn btn-danger btn-mat waves-effect" id="btn_AvlPrecptnCrctnsList" onclick='load_PrescpCorrectionsList();'><span class="fa fa-edit"></span>&nbsp;&nbsp;PRESCRIPTION-CORRECTIONS</button>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div id="DataTable_Includer2">
                                                        <div id="DataTable_Remover2"></div>
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
                setTimeout(function () {
                    load_NextToken(2);
                }, 800);
            });
        </script>

        <script type="text/javascript">
            function load_NextToken(FwdBkwd_Status) {
                $.post("Token_getNextTokenDetailsServlet", "FwdBkwd_Status=" + FwdBkwd_Status + "&tokenNo=" + document.getElementById("val_TokenNo").value, function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {

                        document.getElementById("val_TokenNo").value = outputData.split(":")[4];
                        document.getElementById("lbl_TokenNo").innerHTML = "# " + outputData.split(":")[5];
                        document.getElementById("lbl_PatientID").innerHTML = "# " + outputData.split(":")[6];
                        document.getElementById("lbl_Name").innerHTML = outputData.split(":")[7];
                        document.getElementById("lbl_Gender").innerHTML = outputData.split(":")[8];
                        document.getElementById("lbl_Age").innerHTML = outputData.split(":")[9] + " Years";

                        document.getElementById("btn_Select").disabled = false;
                        document.getElementById("btn_Skip").disabled = false;
                        document.getElementById("btn_Forward").disabled = false;
                        document.getElementById("btn_Backward").disabled = false;


                        // set Button DISABLES
                        if (outputData.split(":")[2] == 'false') { // ??? ( NOT-Found-More-Results )
                            document.getElementById("btn_Select").disabled = true;
                            document.getElementById("btn_Skip").disabled = true;
                            if (FwdBkwd_Status == '1') {
                                document.getElementById("btn_Forward").disabled = true;
                                document.getElementById("btn_Backward").click();

                            } else if (FwdBkwd_Status == '0') {
                                document.getElementById("btn_Backward").disabled = true;
                                document.getElementById("btn_Forward").click();

                            } else {
                                document.getElementById("btn_Forward").disabled = true;
                                document.getElementById("btn_Backward").disabled = true;
                            }
                        } else {
                            if (outputData.split(":")[3] == 'true') { // ??? ( Found-Only-Single-Result )
                                document.getElementById("btn_Forward").disabled = true;
                                document.getElementById("btn_Backward").disabled = true;
                            }
                        }
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }
        </script>


        <script type="text/javascript">
            function skip_Token(tokenNo) {
                $.post("Token_SkipTokenServlet", "tokenNo=" + tokenNo, function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        if (document.getElementById("btn_Forward").disabled) {
                            document.getElementById("btn_Refresh").click();
                        } else {
                            document.getElementById("btn_Forward").click();
                        }

                        // Refresh-Skipped-List-Table
                        if (document.getElementById("datatable").innerHTML != null) {
                            document.getElementById("btn_SkippedList").click();
                        }
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }

            function select_Token(tokenNo) {
                $.post("Token_SelectTokenServlet", "tokenNo=" + tokenNo, function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        location.replace('prescription.jsp?tokenID=' + outputData.split(":")[1]);
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }

            function load_SkippedTokensList() {
                document.getElementById("DataTable_Remover").outerHTML = "";
                $('#DataTable_Includer').load('tokenSelector_SkippedTokens_DataTable.jsp');
                // Scroll-Down Page
                setTimeout(function () {
                    var scrollDiv = document.getElementById("ScrollNFocusElem").offsetTop;
                    window.scrollTo({top: scrollDiv + 500, behavior: 'smooth'});
                }, 600);
            }
        </script>


        <script type="text/javascript">
            function load_PrescpCorrectionsList() {
                document.getElementById("DataTable_Remover2").outerHTML = "";
                $('#DataTable_Includer2').load('tokenSelector_PrescpCorrections_DataTable.jsp');
                // Scroll-Down Page
                setTimeout(function () {
                    var scrollDiv = document.getElementById("ScrollNFocusElem2").offsetTop;
                    window.scrollTo({top: scrollDiv + 500, behavior: 'smooth'});
                }, 600);
            }
        </script>


    </body>
</html>