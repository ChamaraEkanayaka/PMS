<%-- 
    Document   : prescription
    Created on : Jan 11, 2021, 10:33:11 PM
    Author     : AKILA
--%>

<%@page import="POJOS.BodyMeasurement"%>
<%@page import="POJOS.Doctor"%>
<%@page import="POJOS.PatientToken"%>
<%@page import="POJOS.Prescription"%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //login code and check access please past this code before header of all pages
    String MAIN_NAME = DataHolders.ProjectInfo.getAppTitle();
    String navMenuItem = "patients";
    String pagename = "Patient Registration";
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
                if (!User_AccessOBJECT.getAd().contains("P")) {
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
        <title>Patient Registration | <%=MAIN_NAME%></title>
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
            User User_OBJECT = (User) sess.load(User.class, USER_ID);
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
                                                            <h4>Patient registration form</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="page-header-breadcrumb">
                                                        <ul class="breadcrumb-title">
                                                            <li class="breadcrumb-item">
                                                                <a href="index.jsp"><i class="feather icon-home"></i></a>
                                                            </li>
                                                            <li class="breadcrumb-item"><a href="patient_Register.jsp">#Patient Registration</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Header End -->

                                        <!-- ADD PATIENT DETAILS ---------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card">
                                                        <div class="card-block">
                                                            <div class="row invoive-info m-t-10">
                                                                <div class="col-lg-12 col-md-12 col-sm-12" style="margin-bottom: -40px; display: contents;">
                                                                    <h6>&nbsp;&nbsp;Patient Details</h6>

                                                                    <!-- Name -->
                                                                    <div class="col-lg-12 col-sm-12 m-b-10">
                                                                        <label class="col-lable f-w-700">Name *</label>
                                                                        <input class="form-control"
                                                                               type="text"
                                                                               required="true" 
                                                                               id="name">
                                                                    </div>

                                                                    <!-- Birth Day -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-10">
                                                                        <label class="col-lable f-w-700">Birth Day *</label>
                                                                        <input class="form-control"
                                                                               type="date"
                                                                               required="true" 
                                                                               max=""
                                                                               id="birth_day">
                                                                    </div>

                                                                    <!-- Address -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">Address</label>
                                                                        <input class="form-control"
                                                                               type="text"
                                                                               id="address">
                                                                    </div>    

                                                                    <!-- Blood Group -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-15">
                                                                        <label class="col-lable f-w-700">Blood Group *</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="blood_group">
                                                                            <option value="A+">A+</option>
                                                                            <option value="A-">A-</option>
                                                                            <option value="AB+">AB+</option>
                                                                            <option value="AB-">AB-</option>
                                                                            <option value="B+">B+</option>
                                                                            <option value="B-">B-</option>
                                                                            <option value="O+">O+</option>
                                                                            <option value="O-">O-</option>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Gender -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-15">
                                                                        <label class="col-lable f-w-700">Gender *</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="gender">
                                                                            <option value="Male">Male</option>
                                                                            <option value="Female">Female</option>
                                                                            <option value="Other">Other</option>
                                                                        </select>
                                                                    </div>
                                                                    <!-- Height -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">Height (cm)</label>
                                                                        <input class="form-control"
                                                                               type="number"
                                                                               id="height">
                                                                    </div> 
                                                                    <!-- Weight -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">Weight (kg)</label>
                                                                        <input class="form-control"
                                                                               type="number"
                                                                               id="weight">
                                                                    </div> 
                                                                    <!-- Contact Number -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">Contact Number *</label>
                                                                        <input class="form-control"
                                                                               type="text"
                                                                               id="contact_number">
                                                                    </div> 
                                                                    <!-- NIC -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">NIC</label>
                                                                        <input class="form-control"
                                                                               type="text"
                                                                               id="nic">
                                                                    </div> 

                                                                    <!-- Remark -->
                                                                    <div class="col-lg-12 col-md-12 col-sm-12 m-b-10">
                                                                        <label class="col-lable f-w-700">Remark</label>
                                                                        <textarea rows="5" cols="5" class="form-control"
                                                                                  placeholder="Optional"
                                                                                  id="remark">
                                                                        </textarea>
                                                                    </div>

                                                                    <div class="row col-lg-12 col-md-12 col-sm-12 text-right m-t-10 m-b-0">
                                                                        <div class="col-lg-12 col-md-12 col-sm-6">&nbsp;</div>
                                                                        <div class="col-lg-12 col-md-12 col-sm-6">
                                                                            <button style="font-size: 14px;" class="btn btn-primary btn-sm btn-mat waves-effect"
                                                                                    type="submit"
                                                                                    id="button_save"
                                                                                    >SAVE ONLY
                                                                            </button>
                                                                            <button style="font-size: 14px;" class="btn btn-warning btn-sm btn-mat waves-effect"
                                                                                    type="submit"
                                                                                    id="button_saveAndIssueToken"
                                                                                    >SAVE AND ISSUE TOKEN
                                                                            </button>
                                                                            <label class="col-lable">&nbsp;</label>
                                                                            <a style="font-size: 14px;" class="btn btn-danger btn-sm btn-mat waves-effect"
                                                                               href="patient_Register.jsp">RESET
                                                                            </a>
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 m-b-10">
                                                    <a class="btn btn-dark btn-mat waves-effect" href="patient_list.jsp" ><span class="fa fa-bookmark"></span>&nbsp;&nbsp;SAVED PATIENTS</a>
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
                $('#name').focus();
                $('#button_save').click(function () {
                    savePatient("save");
                });
                $('#button_saveAndIssueToken').click(function () {
                    savePatient("saveToken");
                });

            });
        </script>
        <script type="text/javascript">
            function savePatient(param_saveType) {
                swal({
                    title: "Are you sure?",
                    text: "You want to save this patient.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Yes, Save Now",
                    cancelButtonText: "No",
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true
                }, function (isConfirm) {
                    if (isConfirm) {
                        //name nic contact_number weight height gender blood_group address birth_day remark
                        var params =
                                "userID=" + "<%=User_OBJECT.getIduser()%>" + "&" +
                                "name=" + document.getElementById("name").value + "&" +
                                "nic=" + document.getElementById("nic").value + "&" +
                                "contact_number=" + document.getElementById("contact_number").value + "&" +
                                "weight=" + document.getElementById("weight").value + "&" +
                                "height=" + document.getElementById("height").value + "&" +
                                "gender=" + document.getElementById("gender").value + "&" +
                                "blood_group=" + document.getElementById("blood_group").value + "&" +
                                "remark=" + document.getElementById("remark").value + "&" +
                                "address=" + document.getElementById("address").value + "&" +
                                "birth_day=" + document.getElementById("birth_day").value;

                        $.post("Patient_RegisterServlet", params, function (outputData) {
                            //Post Actions..
                            if (outputData.split(":")[0] == '1') {
                                if (param_saveType == 'save') {
                                    swal("Saved !", 'Patient details saved !', "success");
                                    setTimeout(function () {
                                        window.location.replace("patient_Register.jsp");
                                    }, 700);
                                } else {
                                    swal("Saved !", 'Patient details saved !', "success");
                                    setTimeout(function () {
                                        window.location.replace("issueToken.jsp?patientID=" + outputData.split(":")[1]);
                                    }, 700);
                                }
                            } else {
                                swal('Empty Fields !', 'Please fill all filelds and try agin.', 'error');
                            }

                        });
                    }
                });
            }
        </script>

    </body>
</html>