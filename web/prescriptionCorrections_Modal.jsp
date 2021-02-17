<%-- 
    Document   : prescriptionCorrections_Modal
    Created on : Feb 16, 2021, 10:06:22 PM
    Author     : AKILA
--%>

<%@page import="POJOS.PrescriptionItem"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="POJOS.Prescription"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>

<%
    //login code and check access please past this code before header of all pages
    int USER_ID_subModal = 0;
    int BRANCH_ID_subModal = 0;
    try {
        if (request.getSession().getAttribute("LOGIN_DATA") != null) {
            USER_LOGIN_DATA LD_subModal = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
            USER_ID_subModal = LD_subModal.getUser_id();
            BRANCH_ID_subModal = LD_subModal.getBranch_id();
            if (USER_ID_subModal > 0 && BRANCH_ID_subModal > 0) {
                if (request.getParameter("prescriptionNo") != null && !(request.getParameter("prescriptionNo").isEmpty())) {
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

<%
    Session ssn_PrescptnPrvw = FactoryManager.getSessionFactory().openSession();
    Prescription modifPRESC_OBJC = (Prescription) ssn_PrescptnPrvw.load(Prescription.class, Integer.valueOf(request.getParameter("prescriptionNo")));
%>

<div>
    <div class="modal-header">
        <h4 class="modal-title">Prescription-Corrections</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <div class="col-sm-12">
            <div class="form-group">

                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-footer" style="background: #f3f3f3;">
                                    <div class="card-header" style="padding-bottom: 5px; padding-top: 0px;">
                                        <label class="f-16 f-w-700 color-info text-white p-l-10 p-r-10" style="margin-left: -40px;"><label class="m-b-0"><% out.print("Prescription No : # " + new DecimalFormat("0000").format(modifPRESC_OBJC.getIdprescription()));%></label></label><br>
                                    </div>

                                    <!--  PRESCRIPTION  --CHARGES/ AMOUNTS ---------------------------------------------------------------------------------------------------------------------------------------------------- -->
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12">
                                            <table class="table table-responsive invoice-table invoice-total" style="padding-bottom: 0px; margin-bottom: -5px;">
                                                <tbody>
                                                    <tr>
                                                        <th>Medicine Cost :</th>
                                                        <td>
                                                            <input class="form-control text-right m-b-20"
                                                                   style="width: 170px;"
                                                                   type="number"
                                                                   readonly="true"
                                                                   id="val_MedicineCost"
                                                                   value="<%=Utils.DecimalFormats.dfDoubleValue().format(modifPRESC_OBJC.getMedicineCost())%>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th class="f-16">Doctor Charges :</th>
                                                        <td>
                                                            <input class="form-control text-right m-b-20 f-w-700 f-18"
                                                                   style="width: 170px;"
                                                                   type="number"
                                                                   required="true" 
                                                                   maxlength="9"
                                                                   min="0.00"
                                                                   step="1"
                                                                   id="val_DoctorCharges"
                                                                   value="<%=Utils.DecimalFormats.dfDoubleValue().format(modifPRESC_OBJC.getDoctorCharge())%>"
                                                                   onfocus='document.getElementById("val_DoctorCharges").value = "";'
                                                                   onblur='formatCurrencyValue(this); calc_RECEIVABLEAMOUNT(); checkValidations_SubmitForm();'
                                                                   onkeyup='checkValidations_SubmitForm();'
                                                                   onkeydown='set_NexElementFocus(event, "val_ReceivableAmount");'>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <hr class="m-t-0" style="border-top: 2px dashed rgb(156 156 156); margin-top: 0px; margin-bottom: 0px;"> 
                                            <table class="table table-responsive invoice-table invoice-total" style="padding-top: 5px; margin-top: 0px;">
                                                <tbody>
                                                    <tr>
                                                        <th>Total Amount :</th>
                                                        <td>
                                                            <input class="form-control text-right m-b-20"
                                                                   style="width: 170px;"
                                                                   type="number"
                                                                   readonly="true"
                                                                   id="val_TotalAmount"
                                                                   value="<%=Utils.DecimalFormats.dfDoubleValue().format(modifPRESC_OBJC.getTotalAmount())%>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th class="f-16">Receivable Amount :</th>
                                                        <td>
                                                            <input class="form-control text-right m-b-20 f-w-700 f-18"
                                                                   style="width: 170px;"
                                                                   type="number"
                                                                   required="true" 
                                                                   maxlength="9"
                                                                   min="0.00"
                                                                   step="1"
                                                                   id="val_ReceivableAmount"
                                                                   value="<%=Utils.DecimalFormats.dfDoubleValue().format(modifPRESC_OBJC.getReceivableAmount())%>"
                                                                   onfocus='document.getElementById("val_ReceivableAmount").value = "";'
                                                                   onblur='formatCurrencyValue(this); checkValidations_SubmitForm();'
                                                                   onkeyup='checkValidations_SubmitForm();'
                                                                   onkeydown='set_NexElementFocus(event, "btn_SaveChanges");'>
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

            </div>
        </div>
    </div>
    <div class="modal-footer" style="border-top: 1px dashed #1abc9c;">
        <button type="button" class="btn btn-danger btn-mat waves-effect m-r-20"
                disabled="true"
                id="btn_SaveChanges"
                onmouseover='checkValidations_SubmitForm();'
                onclick='save_CorrectionsForm();'>Save Corrections
        </button>
        <button type="button" class="btn btn-info btn-mat waves-effect" data-dismiss="modal" onclick="fade_SweetAlert(); show_MainModal();">Cancel</button>
    </div>
</div>

<!-- === UTILITY SCRIPTS ====================================================================================================== -->
<script type="text/javascript">
    // FORMAT & VALIDATE CURRENCY VALUE for 2 DecimalPoints
    function formatCurrencyValue(field) {
        field.value = parseFloat(field.value).toFixed(2)
    }

    // SET FOCUS TO ELEMENT
    function set_NexElementFocus(event, fcsElement) {
        if (event.keyCode == 13) { // @Enter Key
            document.getElementById('btn_SaveChanges').disabled = true;  // disable submit
            document.getElementById(fcsElement).focus();
            document.getElementById('btn_SaveChanges').disabled = false; // enable submit
        }
    }

    // CHECK ELEMENTs VALUEs
    function checkValidations_SubmitForm() {
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
            document.getElementById('btn_SaveChanges').disabled = false;  // enable submit
        } else {
            document.getElementById('btn_SaveChanges').disabled = true;  // disable submit
        }
    }

    // CALCULATE SUBMIT-FORM  .RECEIVABLE-AMOUNT
    function calc_RECEIVABLEAMOUNT() {
        var params = "medicineCost=" + document.getElementById("val_MedicineCost").value +
                "&doctorCharges=" + document.getElementById("val_DoctorCharges").value +
                "&receivableAmount=" + document.getElementById("val_ReceivableAmount").value;
        $.post("Prescription_CalcReceivableAmountServlet", params, function (outputData) {
            // Post Actions...
            if (outputData.split(":")[0] == 'success') {
                document.getElementById("val_DoctorCharges").value = outputData.split(":")[1];
                document.getElementById("val_TotalAmount").value = outputData.split(":")[2];
                document.getElementById("val_ReceivableAmount").value = outputData.split(":")[3];
                document.getElementById('btn_SaveChanges').disabled = false;  // enable submit
            } else {
                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                document.getElementById('btn_SaveChanges').disabled = true;  // disable submit
            }
        });
    }
</script>


<script type="text/javascript">
    function save_CorrectionsForm() {
        fade_MainModal();
        swal({
            title: "Are you sure",
            text: "You want to save these changes now?",
            type: "info",
            showCancelButton: true,
            confirmButtonClass: "btn-danger",
            confirmButtonText: "Yes, Save Now",
            cancelButtonText: "Not Now",
            closeOnConfirm: false,
            showLoaderOnConfirm: true
        }, function (isConfirm) {
            if (isConfirm) {
                // start >> Save process..............................................................................................................................
                var params = "prescriptionID=" + "<%=modifPRESC_OBJC.getIdprescription()%>" + "&" +
                        "doctorCharge=" + document.getElementById("val_DoctorCharges").value + "&" +
                        "totalAmount=" + document.getElementById("val_TotalAmount").value + "&" +
                        "receivableAmount=" + document.getElementById("val_ReceivableAmount").value;

                $.post("Prescription_SaveCorrectionsServlet", params, function (outputData) {
                    swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    // Post Actions..
                    setTimeout(function () {
                        if (outputData.split(":")[0] == 'success') {
                            location.replace("tokenSelector.jsp");
                        } else {
                            fade_SweetAlert();
                            show_MainModal();
                            document.getElementById('btn_SaveChanges').disabled = true;  // disable submit
                        }
                    }, 1000);
                });
                // end << Save process.................................................................................................................................
            } else {
                fade_SweetAlert();
                show_MainModal();
            }
        });
    }
</script>                                                    

<script>
    function fade_MainModal() {
        document.getElementById("PrscpCorrections-Modal").removeAttribute('style');
        document.getElementById("PrscpCorrections-Modal").setAttribute('style', 'display: none;');
    }

    function show_MainModal() {
        document.getElementById("PrscpCorrections-Modal").removeAttribute('style');
        document.getElementById("PrscpCorrections-Modal").setAttribute('style', 'display: block;');
    }
    function fade_SweetAlert() {
        var swAlt_list, swAlt_index;
        swAlt_list = document.getElementsByClassName("sweet-alert");
        for (swAlt_index = 0; swAlt_index < swAlt_list.length; ++swAlt_index) {
            swAlt_list[swAlt_index].removeAttribute('style');
            swAlt_list[swAlt_index].setAttribute('style', 'display: none;');
        }
        var swOvl_list, swOvl_index;
        swOvl_list = document.getElementsByClassName("sweet-overlay");
        for (swOvl_index = 0; swOvl_index < swOvl_list.length; ++swOvl_index) {
            swOvl_list[swOvl_index].removeAttribute('style');
            swOvl_list[swOvl_index].setAttribute('style', 'display: none;');
        }
    }
</script>