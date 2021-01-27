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
    String navMenuItem = "treatment";
    String pagename = "prescription";
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
                if (request.getParameter("tokenID") != null && !(request.getParameter("tokenID").isEmpty())) {
                    //check access code

                    //check access code
                } else {
                    response.sendRedirect("tokenSelector.jsp");
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
        <title>Prescription | <%=MAIN_NAME%></title>
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

            // Destroy Prescription-Items  DH-SESSION @Page-Load
            if (session.getAttribute("PRESCRIPTION_Items") != null) {
                request.getSession().removeAttribute("PRESCRIPTION_Items");
            }

            // Set TOKEN Object
            PatientToken Token_OBJECT = (PatientToken) sess.load(PatientToken.class, Integer.valueOf(request.getParameter("tokenID")));

            // Set DOCTOR Object
            User User_OBJECT = (User) sess.load(User.class, USER_ID);
            Criteria doctor_Crt = sess.createCriteria(Doctor.class);
            doctor_Crt.add(Restrictions.eq("user", User_OBJECT));
            List<Doctor> DoctorsList = doctor_Crt.list();
            Doctor Doctor_OBJECT = (Doctor) DoctorsList.get(0);

            // Gen. Prescription-ID...
            int param_PrescriptionID = 0;
            Criteria maxPrscNo_Crt = sess.createCriteria(Prescription.class);
            maxPrscNo_Crt.setProjection(Projections.max("idprescription"));
            List maxPrscNoList = maxPrscNo_Crt.list();
            if (maxPrscNoList.get(0) != null) {
                param_PrescriptionID = Integer.valueOf(maxPrscNoList.get(0).toString()) + 1;
            } else {
                param_PrescriptionID = 1;
            }
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
                                                            <h4>The Prescription</h4>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="page-header-breadcrumb">
                                                        <ul class="breadcrumb-title">
                                                            <li class="breadcrumb-item">
                                                                <a href="index.jsp"><i class="feather icon-home"></i></a>
                                                            </li>
                                                            <li class="breadcrumb-item"><a href="tokenSelector.jsp">#Token Selector</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Header End -->

                                        <!-- Page Body Start -->
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card">
                                                        <div class="card-header" style="padding-bottom: 5px;">
                                                            <label class="f-16 f-w-700 color-info text-white p-l-10 p-r-10" style="margin-left: -20px;"><label class="p-l-5 m-b-0"><% out.print("# " + new DecimalFormat("0000").format(param_PrescriptionID));%></label></label><br>
                                                            <input type="hidden" id="val_PrescriptionID" value="<%=param_PrescriptionID%>">
                                                        </div>
                                                        <div class="card-block">

                                                            <!-- PATIENT INFO --------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                                            <div class="row invoive-info m-t-10">
                                                                <div class="col-lg-12 col-md-12 col-sm-12" style="margin-bottom: -40px;">
                                                                    <h6><span class="fa fa-user"></span>&nbsp;&nbsp;Patient Information</h6>
                                                                    <table class="table table-responsive invoice-table invoice-order table-borderless">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th>Token No<span style="margin-left: 27px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%="# " + Token_OBJECT.getTokenNumber()%></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Name<span style="margin-left: 52px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Token_OBJECT.getPatient().getName()%></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Gender<span style="margin-left: 41px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Token_OBJECT.getPatient().getGender()%></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Age<span style="margin-left: 64px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Utils.CurrentDateNTime.getAge(Token_OBJECT.getPatient().getBirthDay()) + " Years"%></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Blood Group<span style="margin-left: 5px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Token_OBJECT.getPatient().getBloodGroup()%></td>
                                                                            </tr>
                                                                            <%
                                                                                Criteria BodyMsrmnt_Crt = sess.createCriteria(BodyMeasurement.class);
                                                                                BodyMsrmnt_Crt.add(Restrictions.eq("patient", Token_OBJECT.getPatient()));
                                                                                BodyMsrmnt_Crt.add(Restrictions.eq("status", 1));
                                                                                List<BodyMeasurement> BodyMsrmntList = BodyMsrmnt_Crt.list();
                                                                                for (BodyMeasurement BodyMsrmnt_OBJC : BodyMsrmntList) {
                                                                            %>
                                                                            <tr>
                                                                                <th>Height<span style="margin-left: 46px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Utils.DecimalFormats.dfDoubleValue().format(BodyMsrmnt_OBJC.getHeight()) + " Ft./ Inc."%></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Wight<span style="margin-left: 51px"></span>:&nbsp;&nbsp;</th>
                                                                                <td><%=Utils.DecimalFormats.dfDoubleValue().format(BodyMsrmnt_OBJC.getWeight()) + " Kg"%>

                                                                                    <button style="font-size: 13px; padding: 3px 8px 3px 8px;" class="btn btn-warning btn-sm btn-mat waves-effect m-l-20"
                                                                                            onclick='open_BMHistoryModal("<%=Token_OBJECT.getPatient().getIdpatient()%>");'
                                                                                            ><span class="fa fa-history"></span>&nbsp;View History
                                                                                    </button>
                                                                                </td>
                                                                            </tr>
                                                                            <% }%>
                                                                            <tr>
                                                                                <th>Note<span style="margin-left: 59px"></span>:&nbsp;&nbsp;</th>
                                                                                <td style="width: 100%;">
                                                                                    <textarea rows="5" cols="5" class="form-control" style="border: 1px solid #e9ecef;background: #ffffff; height: 85px;" readonly="true" id="lbl_PatientNote">
                                                                                        <%=Token_OBJECT.getPatient().getNote()%>
                                                                                    </textarea>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Body End --> 


                                        <!-- ADD MEDICINE-ITEMS ---------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card">
                                                        <div class="card-block">
                                                            <div class="row invoive-info m-t-10">
                                                                <div class="col-lg-12 col-md-12 col-sm-12" style="margin-bottom: -40px; display: contents;">
                                                                    <h6><span class="fa fa-plus-square-o"></span>&nbsp;&nbsp;Add Medicines</h6>

                                                                    <!-- Item -->
                                                                    <div class="col-lg-12 col-sm-12 m-b-10">
                                                                        <label class="col-lable f-w-700">Item</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="addItem_Item"
                                                                                onchange='loadSelectedITEM_Details(); checkValidations_addItemToList();'
                                                                                onclick='checkValidations_addItemToList(); loadSelectedITEM_Details();'
                                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_Dosage");'>
                                                                            <option value="x">Select an Item</option>
                                                                        </select>
                                                                        <p id="addItem_ItemDesc" style="color: grey; margin-top: 5px;"></p>
                                                                    </div>

                                                                    <!-- Dosage -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-10">
                                                                        <label class="col-lable f-w-700">Dosage</label>
                                                                        <input class="form-control"
                                                                               type="number"
                                                                               required="true" 
                                                                               maxlength="9"
                                                                               step="0.25"
                                                                               min="0.00"
                                                                               id="addItem_Dosage" 
                                                                               onblur='formatCurrencyValue(this); checkValidations_addItemToList();'
                                                                               onkeyup='checkValidations_addItemToList();'
                                                                               onkeydown='setElementFocus_addItemToList(event, "addItem_Duration");'>
                                                                    </div>

                                                                    <!-- Duration -->
                                                                    <div class="col-lg-6 col-md-5 col-sm-6 m-b-20">
                                                                        <label class="col-lable f-w-700">Duration (Days)</label>
                                                                        <input class="form-control"
                                                                               type="number"
                                                                               required="true" 
                                                                               maxlength="9"
                                                                               step="1"
                                                                               min="0.00"
                                                                               id="addItem_Duration" 
                                                                               onblur='formatCurrencyValue(this); checkValidations_addItemToList();'
                                                                               onkeyup='checkValidations_addItemToList();'
                                                                               onkeydown='setElementFocus_addItemToList(event, "addItem_UseCycle");'>
                                                                    </div>    

                                                                    <!-- Use-Cycle -->
                                                                    <div class="col-lg-6 col-md-4 col-sm-4 m-b-15">
                                                                        <label class="col-lable f-w-700">Use Cycle</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="addItem_UseCycle"
                                                                                onchange='checkValidations_addItemToList();'
                                                                                onclick='checkValidations_addItemToList();'
                                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_UseMethod");'>
                                                                            <option value="x">Select Here</option>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Use-Method -->
                                                                    <div class="col-lg-6 col-md-4 col-sm-4 m-b-15">
                                                                        <label class="col-lable f-w-700">Use Method</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="addItem_UseMethod"
                                                                                onchange='checkValidations_addItemToList();'
                                                                                onclick='checkValidations_addItemToList();'
                                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_MealType");'>
                                                                            <option value="x">Select Here</option>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Meal-Type -->
                                                                    <div class="col-lg-6 col-md-4 col-sm-4 m-b-20">
                                                                        <label class="col-lable f-w-700">Meal Type</label>
                                                                        <select class="form-control"
                                                                                required="true"
                                                                                id="addItem_MealType"
                                                                                onchange='checkValidations_addItemToList();'
                                                                                onclick='checkValidations_addItemToList();'
                                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_Remark");'>
                                                                            <option value="x">Select Here</option>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Remark -->
                                                                    <div class="col-lg-12 col-md-12 col-sm-12 m-b-10">
                                                                        <label class="col-lable f-w-700">Remark</label>
                                                                        <textarea rows="5" cols="5" class="form-control"
                                                                                  placeholder="Optional"
                                                                                  id="addItem_Remark">
                                                                        </textarea>
                                                                    </div>

                                                                    <div class="row col-lg-12 col-md-12 col-sm-12 text-right m-t-10 m-b-0">
                                                                        <div class="col-lg-12 col-md-12 col-sm-6">&nbsp;</div>
                                                                        <div class="col-lg-12 col-md-12 col-sm-6">
                                                                            <button style="font-size: 14px;" class="btn btn-primary btn-sm btn-mat waves-effect"
                                                                                    type="submit"
                                                                                    disabled="true"
                                                                                    id="button_addItemToList"
                                                                                    onmouseover='checkValidations_addItemToList();'
                                                                                    onclick='add_ItemToListFunc();'
                                                                                    >ADD TO LIST
                                                                            </button>
                                                                            <label class="col-lable">&nbsp;</label>
                                                                            <button style="font-size: 14px;" class="btn btn-danger btn-sm btn-mat waves-effect"
                                                                                    type="submit"
                                                                                    onclick='resetAll_addItemToList();'
                                                                                    >RESET
                                                                            </button>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Page Body End --> 

                                        <!-- Page Body Start -->
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card">
                                                        <!-- MEDICINE ITEMS TABLE ---------------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                                        <div class="card-header">
                                                            <div class="invoive-info m-b-0 m-t-0">
                                                                <h6><span class="fa fa-medkit" style="display: inline;"></span>&nbsp;&nbsp;Medicine Items</h6>
                                                            </div>
                                                            <div class="card-header-right">
                                                                <ul class="list-unstyled card-option">
                                                                    <li><i class="feather icon-maximize full-card"></i></li>
                                                                    <li><i class="feather icon-minus minimize-card"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="card-block">
                                                            <div id="DataTable_Includer">
                                                                <%@include file="prescription_Items_DataTable.jsp"%>
                                                            </div>
                                                        </div><br>

                                                        <!--  PRESCRIPTION-NOTE --------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                                        <div class="col-lg-12 col-md-12 col-sm-12">
                                                            <table class="table table-responsive invoice-table invoice-order table-borderless">
                                                                <tbody>
                                                                    <tr>
                                                                        <th>
                                                                            <div class="invoive-info m-b-0 m-t-0">
                                                                                <h6><span class="fa fa-edit" style="display: inline;"></span>&nbsp;&nbsp;Prescription Note</h6>
                                                                            </div>
                                                                        </th>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="width: 100%;">
                                                                            <textarea rows="5" cols="5" class="form-control" style="margin-top: -15px;"
                                                                                      placeholder="Optional"
                                                                                      id="val_Note">
                                                                            </textarea>
                                                                        </th>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>    

                                                        <div class="card-footer">
                                                            <!--  PRESCRIPTION-CHARGES ---------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                                            <div class="row">
                                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                                    <table class="table table-responsive invoice-table invoice-total" style="padding-bottom: 0px; margin-bottom: -5px;">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th>Medicine Cost :</th>
                                                                                <td>
                                                                                    <input class="form-control text-right m-b-20"
                                                                                           type="number"
                                                                                           required="true" 
                                                                                           readonly="true"
                                                                                           maxlength="9"
                                                                                           id="val_MedicineCost">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Doctor Charges :</th>
                                                                                <td>
                                                                                    <input class="form-control text-right m-b-10"
                                                                                           type="number"
                                                                                           required="true" 
                                                                                           maxlength="9"
                                                                                           min="0.00"
                                                                                           step="1"
                                                                                           id="val_DoctorCharges" 
                                                                                           onblur='formatCurrencyValue(this); calc_RECEIVABLEAMOUNT(); checkValidations_PrescForm();'
                                                                                           onkeyup='checkValidations_PrescForm();'
                                                                                           onkeydown='setElementFocus_PrescForm(event, "val_ReceivableAmount");'>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                    <hr class="m-t-0" style="border-top: 2px dashed rgb(156 156 156); margin-top: 0px; margin-bottom: 0px;"> 
                                                                    <table class="table table-responsive invoice-table invoice-total" style="padding-top: 5px; margin-top: 0px;">
                                                                        <tbody>
                                                                            <tr>
                                                                                <th class="f-18">Total Amount :</th>
                                                                                <td>
                                                                                    <span class="f-w-700 f-18 text-right m-r-25" id="val_TotalAmount">0.00</span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th style="padding-top: 20px;">Receivable Amount :</th>
                                                                                <td>
                                                                                    <input class="form-control text-right m-b-20 m-t-10"
                                                                                           type="number"
                                                                                           required="true" 
                                                                                           maxlength="9"
                                                                                           min="0.00"
                                                                                           step="1"
                                                                                           id="val_ReceivableAmount" 
                                                                                           onblur='formatCurrencyValue(this); checkValidations_PrescForm();'
                                                                                           onkeyup='checkValidations_PrescForm();'
                                                                                           onkeydown='setElementFocus_PrescForm(event, "btn_SubmitForm");'>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                            <!-- SUBMIT/ CANCEL OPTIONs --------------------------------------------------------------------------------------------------------------------------------------------- -->
                                                            <div class="row">
                                                                <div class="col-sm-12 text-right">
                                                                    <button type="submit" class="btn btn-success btn-mat waves-effect btn-out-dashed m-r-10"
                                                                            disabled="true"
                                                                            id="btn_SubmitForm"
                                                                            onmouseover='checkValidations_PrescForm();'
                                                                            onclick='submit_PrescriptionFORM();'>Submit Now
                                                                    </button>
                                                                    <button type="submit" class="btn btn-danger btn-mat waves-effect" onclick='close_PrescriptionFORM();'>Cancel</button>
                                                                </div>
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


        <!-- DETAILS-PREVIEW Modal -->
        <div class="modal fade" tabindex="-1" role="dialog" id="DetailsPrvw-Modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="DetailsPrvw-Modal-Content">
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
                // Reset-Form-Fields
                var txt_patientNote = "<%=Token_OBJECT.getPatient().getNote()%>";
                document.getElementById("lbl_PatientNote").innerHTML = '';
                document.getElementById("lbl_PatientNote").innerHTML = txt_patientNote;
                document.getElementById("val_Note").innerHTML = '';
                document.getElementById("val_MedicineCost").value = '0.00';
                document.getElementById("val_DoctorCharges").value = '0.00';
                document.getElementById("val_ReceivableAmount").value = '0.00';
                document.getElementById("val_TotalAmount").innerHTML = '0.00';

                // Initialize Select2
                $('#addItem_Item').select2();
                $('#addItem_UseCycle').select2();
                $('#addItem_UseMethod').select2();
                $('#addItem_MealType').select2();

                resetAll_addItemToList();
                load_MEDICINEITEMS_DataTable();
                calc_RECEIVABLEAMOUNT();

                document.getElementById('button_addItemToList').disabled = false; // enable submit

            });
        </script>

        <!-- === ADD-ITEMS-TO-LIST SECTION  SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            // LOAD DROPDOWNs-ITEMS +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            function loadAdding_ITEMS() {
                $.post("Prescription_LoadAddingItemsServlet", function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("addItem_Item").innerHTML = outputData.split(":")[3];
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }
            function loadAdding_USECYCLES() {
                $.post("Prescription_LoadAddingUseCyclesServlet", function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("addItem_UseCycle").innerHTML = outputData.split(":")[3];
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }
            function loadAdding_USEMETHODS() {
                $.post("Prescription_LoadAddingUseMethodsServlet", function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("addItem_UseMethod").innerHTML = outputData.split(":")[3];
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }
            function loadAdding_MEALTYPES() {
                $.post("Prescription_LoadAddingMealTypesServlet", function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("addItem_MealType").innerHTML = outputData.split(":")[3];
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    }
                });
            }
            // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            // RESET ELEMENTS & VALUES
            function resetAll_addItemToList() {
                loadAdding_ITEMS();
                loadAdding_USECYCLES();
                loadAdding_USEMETHODS();
                loadAdding_MEALTYPES();

                $('#addItem_Item').val("x");
                $('#addItem_Item').select2().trigger('change');
                document.getElementById("addItem_Dosage").value = "0.00";
                document.getElementById("addItem_Duration").value = "0.00";
                $('#addItem_UseCycle').val("x");
                $('#addItem_UseCycle').select2().trigger('change');
                $('#addItem_UseMethod').val("x");
                $('#addItem_UseMethod').select2().trigger('change');
                $('#addItem_MealType').val("x");
                $('#addItem_MealType').select2().trigger('change');
                document.getElementById("addItem_Remark").value = "";
                document.getElementById("button_addItemToList").disabled = true; // disable submit --ADD_ITEMS
            }

            // SET FOCUS TO ELEMENT
            function setElementFocus_addItemToList(event, fcsElement) {
                if (event.keyCode == 13) { // @Enter Key
                    document.getElementById('button_addItemToList').disabled = true;  // disable submit
                    document.getElementById(fcsElement).focus();
                    document.getElementById('button_addItemToList').disabled = false; // enable submit
                }
            }

            // CHECK ELEMENTs VALUEs
            function checkValidations_addItemToList() {
                var flagSubmitSts = false;
                // check Validations ----ITEM
                if (document.getElementById('addItem_Item').value == "x") {
                    flagSubmitSts = false;
                }
                // check Validations ----Dosage
                else if (document.getElementById('addItem_Dosage').value.toString().trim().length == 0) {
                    flagSubmitSts = false;
                } else if (document.getElementById('addItem_Dosage').value.toString().trim() == "NaN") {
                    document.getElementById("addItem_Dosage").value = "0.00";
                    flagSubmitSts = false;
                } else if (document.getElementById('addItem_Dosage').value < 0.01) {
                    flagSubmitSts = false;
                }
                // check Validations ----Duration
                else if (document.getElementById('addItem_Duration').value.toString().trim().length == 0) {
                    flagSubmitSts = false;
                } else if (document.getElementById('addItem_Duration').value.toString().trim() == "NaN") {
                    document.getElementById("addItem_Duration").value = "0.00";
                    flagSubmitSts = false;
                } else if (document.getElementById('addItem_Duration').value < 0.01) {
                    flagSubmitSts = false;
                }
                // check Validations ----USE-CYCLE
                else if (document.getElementById('addItem_UseCycle').value == "x") {
                    flagSubmitSts = false;
                }
                // check Validations ----USE-METHOD
                else if (document.getElementById('addItem_UseMethod').value == "x") {
                    flagSubmitSts = false;
                }
                // check Validations ----MEAL-TYPE
                else if (document.getElementById('addItem_MealType').value == "x") {
                    flagSubmitSts = false;
                }
                // @ finally all OK
                else {
                    flagSubmitSts = true;
                }
                //  == set submit btn status =================================================
                if (flagSubmitSts) {
                    document.getElementById('button_addItemToList').disabled = false;  // enable submit
                } else {
                    document.getElementById('button_addItemToList').disabled = true;  // disable submit
                }
            }

            // Check-Availability & Load Selected Medicine-Item's Details...
            function loadSelectedITEM_Details() {
                if (document.getElementById("addItem_Item").value != 'x') {
                    $.post("Prescription_LoadSelectedItemDetailsServlet", "itemID=" + document.getElementById("addItem_Item").value, function (outputData) {
                        // Post Actions..
                        if (outputData.split(":")[0] == 'success') {
                            if (outputData.split(":")[3] == 'true') {
                                document.getElementById('button_addItemToList').disabled = false;  // enable submit
                            } else {
                                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                                document.getElementById('button_addItemToList').disabled = true;  // disable submit
                                $('#addItem_Item').val("x");
                                $('#addItem_Item').select2().trigger('change');
                            }
                        } else {
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                            document.getElementById('button_addItemToList').disabled = true;  // disable submit
                            $('#addItem_Item').val("x");
                            $('#addItem_Item').select2().trigger('change');
                        }
                    });
                } else {
                    document.getElementById('button_addItemToList').disabled = true;  // disable submit
                }
            }

            // Add Medicine-Item to DataHolder....
            function add_ItemToListFunc() {
                var params =
                        "addItem_Item=" + document.getElementById("addItem_Item").value + "&" +
                        "addItem_Dosage=" + document.getElementById("addItem_Dosage").value + "&" +
                        "addItem_Duration=" + document.getElementById("addItem_Duration").value + "&" +
                        "addItem_UseCycle=" + document.getElementById("addItem_UseCycle").value + "&" +
                        "addItem_UseMethod=" + document.getElementById("addItem_UseMethod").value + "&" +
                        "addItem_MealType=" + document.getElementById("addItem_MealType").value + "&" +
                        "addItem_Remark=" + document.getElementById("addItem_Remark").value;

                $.post("Prescription_AddItemServlet", params, function (outputData) {
                    // Post Actions..
                    if (outputData.split(":")[0] == 'success') {
                        load_MEDICINEITEMS_DataTable();
                        calc_RECEIVABLEAMOUNT();
                        resetAll_addItemToList();
                        document.getElementById("addItem_Item").focus();
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                        document.getElementById("btn_SubmitForm").disabled = true; // disable submit-Form
                    }
                });
            }
        </script>


        <!-- === PRESCRIPTION-FORM  SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            // FORMAT & VALIDATE CURRENCY VALUE for 2 DecimalPoints
            function formatCurrencyValue(field) {
                field.value = parseFloat(field.value).toFixed(2)
            }

            // SET FOCUS TO ELEMENT
            function setElementFocus_PrescForm(event, fcsElement) {
                if (event.keyCode == 13) { // @Enter Key
                    document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                    document.getElementById(fcsElement).focus();
                    document.getElementById('btn_SubmitForm').disabled = false; // enable submit
                }
            }

            // CHECK ELEMENTs VALUEs
            function checkValidations_PrescForm() {
                var flagSubmitSts = false;

                // check Validations ----Doctor_Charges
                if (document.getElementById('val_DoctorCharges').value.toString().trim().length == 0) {
                    flagSubmitSts = false;
                } else if (document.getElementById('val_DoctorCharges').value.toString().trim() == "NaN") {
                    document.getElementById("val_DoctorCharges").value = "0.00";
                    flagSubmitSts = false;
                } else if (document.getElementById('val_DoctorCharges').value < 0.00) {
                    flagSubmitSts = false;
                }

                // check Validations ----Receivable_Amount
                else if (document.getElementById('val_ReceivableAmount').value.toString().trim().length == 0) {
                    flagSubmitSts = false;
                } else if (document.getElementById('val_ReceivableAmount').value.toString().trim() == "NaN") {
                    document.getElementById("val_ReceivableAmount").value = "0.00";
                    flagSubmitSts = false;
                } else if (document.getElementById('val_ReceivableAmount').value < 0.00) {
                    flagSubmitSts = false;
                }
                // @ finally all OK
                else {
                    flagSubmitSts = true;
                }
                //  == set submit btn status =================================================
                if (flagSubmitSts) {
                    document.getElementById('btn_SubmitForm').disabled = false;  // enable submit
                } else {
                    document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                }
            }

            // LOAD Medicine-Items-List   --DataTable
            function load_MEDICINEITEMS_DataTable() {
                document.getElementById("DataTable_Remover").outerHTML = "";
                $('#DataTable_Includer').load('prescription_Items_DataTable.jsp');

                // Calc. MEDICINE-COST value of "Prescription-Medicine-Items"
                setTimeout(function () {
                    $.post("Prescription_CalcMedicineCostServlet", function (outputData) {
                        // Post Actions..
                        if (outputData.split(":")[0] == 'success') {
                            document.getElementById("val_MedicineCost").value = outputData.split(":")[1];
                            calc_RECEIVABLEAMOUNT();

                            // set FORM-SUBMIT Button Enable/ Disable
                            if (outputData.split(":")[2] == 'true') {
                                // document.getElementById('btn_SubmitForm').disabled = false;  // enable submit
                            } else {
                                //  document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                            }
                        } else {
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                            document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                        }
                    });
                }, 800);
            }

            // CALCULATE PRESCIPTION-FORM RECEIVABLE-AMOUNT
            function calc_RECEIVABLEAMOUNT() {
                var params = "medicineCost=" + document.getElementById("val_MedicineCost").value +
                        "&doctorCharges=" + document.getElementById("val_DoctorCharges").value +
                        "&receivableAmount=" + document.getElementById("val_ReceivableAmount").value;

                $.post("Prescription_CalcReceivableAmountServlet", params, function (outputData) {
                    // Post Actions...
                    if (outputData.split(":")[0] == 'success') {
                        document.getElementById("val_DoctorCharges").value = outputData.split(":")[1];
                        document.getElementById("val_TotalAmount").innerHTML = outputData.split(":")[2];
                        document.getElementById("val_ReceivableAmount").value = outputData.split(":")[3];
                        document.getElementById('btn_SubmitForm').disabled = false;  // enable submit
                    } else {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                        document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                    }
                });
            }


            // SAVE THE-PRESCRIPTION FORM
            function submit_PrescriptionFORM() {
                swal({
                    title: "Are you sure?",
                    text: "You want to submit this prescription now.",
                    type: "info",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Yes, Submit Now",
                    cancelButtonText: "Not Now",
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true
                }, function (isConfirm) {
                    if (isConfirm) {
                        // start >> Save process.............................................................................................................................
                        var params =
                                "userID=" + "<%=User_OBJECT.getIduser()%>" + "&" +
                                "tokenID=" + "<%=Token_OBJECT.getIdpatientToken()%>" + "&" +
                                "patientID=" + "<%=Token_OBJECT.getPatient().getIdpatient()%>" + "&" +
                                "doctorID=" + "<%=Doctor_OBJECT.getIddoctor()%>" + "&" +
                                "medicineCost=" + document.getElementById("val_MedicineCost").value + "&" +
                                "doctorCharge=" + document.getElementById("val_DoctorCharges").value + "&" +
                                "totalAmount=" + document.getElementById("val_TotalAmount").innerHTML + "&" +
                                "receivableAmount=" + document.getElementById("val_ReceivableAmount").value + "&" +
                                "note=" + document.getElementById("val_Note").value;

                        $.post("Prescription_SaveServlet", params, function (outputData) {
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                            // Post Actions..
                            setTimeout(function () {
                                if (outputData.split(":")[0] == 'success') {
                                    location.replace("tokenSelector.jsp");
                                } else {
                                    document.getElementById('btn_SubmitForm').disabled = true;  // disable submit
                                }
                            }, 1000);
                        });
                        // end << Save process.................................................................................................................................
                    }
                });
            }

            // CLOSE THE-PRESCRIPTION FORM
            function close_PrescriptionFORM() {
                swal({
                    title: "Are you sure?",
                    text: "You want to cancel this prescription.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Yes, Cancel Now",
                    cancelButtonText: "No",
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true
                }, function (isConfirm) {
                    if (isConfirm) {
                        // start >> Close process.............................................................................................................................
                        location.replace("tokenSelector.jsp");
                        // end << Close process.................................................................................................................................
                    }
                });
            }
        </script>


        <!-- === DETAILS-PREVIEW  MODALS  SCRIPTS ==================================================================================================== -->
        <script type="text/javascript">
            function open_BMHistoryModal(param_PatientID) {
                $('#DetailsPrvw-Modal').modal('show');
                $('#DetailsPrvw-Modal-Content').load('prescription_BMHistoryModal.jsp?patientID=' + param_PatientID);
            }
        </script>

    </body>
</html>