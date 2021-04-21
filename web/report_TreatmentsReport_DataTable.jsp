<%-- 
    Document   : report_TreatmentsReport_DataTable
    Created on : Jan 26, 2021, 12:05:42 PM
    Author     : AKILA
--%>

<%@page import="java.util.List"%>
<%@page import="POJOS.Doctor"%>
<%@page import="POJOS.Patient"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.text.DecimalFormat"%>
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
        Session ssn_TrmntReport = FactoryManager.getSessionFactory().openSession();

        // **** Set RESULT-SET Params *****************************************************************************************
        boolean chBxOpt_Date = false;
        boolean chBxOpt_PrescNo = false;
        boolean chBxOpt_TokenNo = false;
        boolean chBxOpt_Patient = false;
        boolean chBxOpt_Doctor = false;

        if (request.getParameter("param_ChBxDate") != null) {
            chBxOpt_Date = Boolean.valueOf(request.getParameter("param_ChBxDate"));
        }
        if (request.getParameter("param_ChBxPrescNo") != null) {
            chBxOpt_PrescNo = Boolean.valueOf(request.getParameter("param_ChBxPrescNo"));
        }
        if (request.getParameter("param_ChBxTokenNo") != null) {
            chBxOpt_TokenNo = Boolean.valueOf(request.getParameter("param_ChBxTokenNo"));
        }
        if (request.getParameter("param_ChBxPatient") != null) {
            chBxOpt_Patient = Boolean.valueOf(request.getParameter("param_ChBxPatient"));
        }
        if (request.getParameter("param_ChBxDoctor") != null) {
            chBxOpt_Doctor = Boolean.valueOf(request.getParameter("param_ChBxDoctor"));
        }

        String Val_DateFrom = "";
        String Val_DateTo = "";
        int Val_PrescNo = 0;
        int Val_TokenNo = 0;
        Patient Val_Patient = null;
        Doctor Val_Doctor = null;

        if (request.getParameter("param_DateFrom") != null) {
            Val_DateFrom = String.valueOf(request.getParameter("param_DateFrom"));
        }
        if (request.getParameter("param_DateTo") != null) {
            Val_DateTo = String.valueOf(request.getParameter("param_DateTo"));
        }
        if (request.getParameter("param_PrescNo") != null) {
            Val_PrescNo = Integer.valueOf(request.getParameter("param_PrescNo"));
        }
        if (request.getParameter("param_TokenNo") != null) {
            Val_TokenNo = Integer.valueOf(request.getParameter("param_TokenNo"));
        }
        if (request.getParameter("param_Patient") != null) {
            Val_Patient = (Patient) ssn_TrmntReport.load(Patient.class, Integer.valueOf(request.getParameter("param_Patient")));
        }
        if (request.getParameter("param_Doctor") != null) {
            Val_Doctor = (Doctor) ssn_TrmntReport.load(Doctor.class, Integer.valueOf(request.getParameter("param_Doctor")));
        }
    %>

    <!-- SEARCH_RESULTS -- data.table ======================================================================= -->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h5><span class="label label-warning">&nbsp;Treatment Records&nbsp;</span></h5><br>
                    <span>Search Results On&nbsp;&nbsp;:&nbsp;&nbsp;
                        <%  String searchResultTxt = "";
                            // set CUSTOMIZED SEARCHING OPTIONS....
                            if (chBxOpt_Date) {
                                searchResultTxt = searchResultTxt + " | DATE: " + Val_DateFrom + " - " + Val_DateTo;
                            }
                            if (chBxOpt_PrescNo) {
                                if (Integer.valueOf(request.getParameter("param_PrescNo")) != 0) {
                                    searchResultTxt = searchResultTxt + " | PRESCRIPTION NO: " + Val_PrescNo;
                                } else {
                                    searchResultTxt = searchResultTxt + " | PRESCRIPTION NO: All";
                                }
                            }
                            if (chBxOpt_TokenNo) {
                                if (Integer.valueOf(request.getParameter("param_TokenNo")) != 0) {
                                    searchResultTxt = searchResultTxt + " | TOKEN NO: " + Val_TokenNo;
                                } else {
                                    searchResultTxt = searchResultTxt + " | TOKEN NO: All";
                                }
                            }
                            if (chBxOpt_Patient) {
                                if (Integer.valueOf(request.getParameter("param_Patient")) != 0) {
                                    searchResultTxt = searchResultTxt + " | PATIENT: " + Val_Patient.getName();
                                } else {
                                    searchResultTxt = searchResultTxt + " | PATIENT: All";
                                }
                            }
                            if (chBxOpt_Doctor) {
                                if (Integer.valueOf(request.getParameter("param_Doctor")) != 0) {
                                    searchResultTxt = searchResultTxt + " | DOCTOR: " + Val_Doctor.getName();
                                } else {
                                    searchResultTxt = searchResultTxt + " | DOCTOR: All";
                                }
                            }
                            if (!(chBxOpt_Date || chBxOpt_PrescNo || chBxOpt_TokenNo || chBxOpt_Patient || chBxOpt_Doctor)) {
                                searchResultTxt = searchResultTxt + " All";
                            }
                        %>
                        <%=searchResultTxt%>
                    </span> 


                    <!--  ./start   REPORT.SUM.TILES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  -->
                    <div class="card-block box-list">
                        <div class="row">

                            <div class="col-lg-4">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white" style="height: 165px;">
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
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900;">TOTAL RECEIVABLE AMOUNT&nbsp;&nbsp;&nbsp;</code>
                                            <span style="color: #ffffff;font-size: x-large;margin-left: 20px;" id="RptSUM_RcvblAmount">Rs. 0.00</span>

                                            <code style="margin-left: -1px;margin-top: 5px;font-weight: 900;">TOTAL PAID AMOUNT&nbsp;&nbsp;&nbsp;</code>
                                            <span style="color: #ffffff;font-size: x-large;margin-left: 20px;" id="RptSUM_PaidAmount">Rs. 0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="p-0 z-depth-bottom-1 waves-effect bg-c-blue text-white">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <code style="margin-left: -1px;margin-top: 0px;font-weight: 900; width: 160px;">TOTAL PENDING AMOUNT</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_Pending">Rs. 0.00</span>

                                            <code style="margin-left: -1px;margin-top: 5px;font-weight: 900; width: 160px;">TOTAL NOT-PAID AMOUNT</code>
                                            <span style="color: #ffffff;font-size: medium;font-weight: 600;margin-left: 20px;" id="RptSUM_NotPaid">Rs. 0.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <div class="p-20 z-depth-bottom-1 waves-effect bg-c-blue text-white" style="height: 142px;">
                                    <code style="margin-left: -21px;margin-top: 0px;font-weight: 900;">PROFIT/ LOST AMOUNT</code>
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
                                    <th id="dtTableTH_ORD">#Prescription</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>#Token</th>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Medicine Cost</th>
                                    <th>Doctor Charges</th>
                                    <th>Total Amount</th>
                                    <th>Receivable Amount</th>
                                    <th>Settlement Status</th>
                                    <th>Settlement Details</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Report-Sum Values params
                                    int SumVALUE_TokensCount = 0;
                                    double SumVALUE_MedCost = 0.00;
                                    double SumVALUE_DocCharges = 0.00;
                                    double SumVALUE_RcvblAmount = 0.00;
                                    double SumVALUE_PaidAmount = 0.00;
                                    double SumVALUE_Pending = 0.00;
                                    double SumVALUE_NotPaid = 0.00;

                                    Criteria prescp_Crt = ssn_TrmntReport.createCriteria(Prescription.class);
                                    // set CUSTOMIZED SEARCHING FILTERS....
                                    if (chBxOpt_Date) {
                                        prescp_Crt.add(Restrictions.between("date", Val_DateFrom, Val_DateTo));
                                    }
                                    if (chBxOpt_PrescNo) {
                                        if (Integer.valueOf(request.getParameter("param_PrescNo")) != 0) {
                                            prescp_Crt.add(Restrictions.eq("idprescription", Val_PrescNo));
                                        }
                                    }
                                    if (chBxOpt_Patient) {
                                        if (Integer.valueOf(request.getParameter("param_Patient")) != 0) {
                                            prescp_Crt.add(Restrictions.eq("patient", Val_Patient));
                                        }
                                    }
                                    if (chBxOpt_Doctor) {
                                        if (Integer.valueOf(request.getParameter("param_Doctor")) != 0) {
                                            prescp_Crt.add(Restrictions.eq("doctor", Val_Doctor));
                                        }
                                    }
                                    List<Prescription> prescpList = prescp_Crt.list();
                                    for (Prescription prescp_Objct : prescpList) {
                                        // Token No Filter
                                        boolean flag_eqTknFilter = false;
                                        if (chBxOpt_TokenNo) {
                                            if (Integer.valueOf(request.getParameter("param_TokenNo")) != 0) {
                                                if (prescp_Objct.getPatientToken().getTokenNumber() == Val_TokenNo) {
                                                    flag_eqTknFilter = true;
                                                } else {
                                                    flag_eqTknFilter = false;
                                                }
                                            } else {
                                                flag_eqTknFilter = true;
                                            }
                                        } else {
                                            flag_eqTknFilter = true;
                                        }

                                        if (flag_eqTknFilter) {
                                            // Calculate REPORT-SUM-VALUES...
                                            SumVALUE_TokensCount += 1;
                                            SumVALUE_MedCost += prescp_Objct.getMedicineCost();
                                            SumVALUE_DocCharges += prescp_Objct.getDoctorCharge();
                                            SumVALUE_RcvblAmount += prescp_Objct.getReceivableAmount();
                                %>
                                <tr>
                                    <td><%= new DecimalFormat("0000").format(prescp_Objct.getIdprescription())%></td>
                                    <td><%=prescp_Objct.getDate()%></td>
                                    <td><%=prescp_Objct.getTime()%></td>
                                    <td><%=prescp_Objct.getPatientToken().getTokenNumber()%></td>
                                    <td><%=prescp_Objct.getPatient().getName()%></td>
                                    <td><%=prescp_Objct.getDoctor().getName()%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getMedicineCost())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getDoctorCharge())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getTotalAmount())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getReceivableAmount())%></td>
                                    <td>
                                        <% if (prescp_Objct.getStatus() == 0) { %>
                                        <span class="label label-success">&nbsp;COMPLETED&nbsp;</span>
                                        <%  SumVALUE_PaidAmount += prescp_Objct.getReceivableAmount(); %>

                                        <% } else if (prescp_Objct.getStatus() == 1) { %>
                                        <span class="label label-danger">&nbsp;PENDING&nbsp;</span>      
                                        <%  SumVALUE_Pending += prescp_Objct.getReceivableAmount(); %>

                                        <% } else { %>
                                        <span class="label label-warning">&nbsp;NOT PAID&nbsp;</span>
                                        <%  SumVALUE_NotPaid += prescp_Objct.getReceivableAmount(); %>

                                        <% }%>
                                    </td>
                                    <td>
                                        <% if (prescp_Objct.getStatus() == 0) {%>
                                        <span>
                                            <%="PAYMENT : " + "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getCash()) + " | BALANCE : " + "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getBalance())%><br>
                                            <%="DATE & TIME : " + prescp_Objct.getSettleDate() + " @" + prescp_Objct.getSettleTime()%><br>
                                            <%="USER : " + prescp_Objct.getUser().getName()%>
                                        </span>
                                        <% } else { %>
                                        <span>&nbsp;N/A&nbsp;</span>      
                                        <% }%>
                                    </td>
                                    <td>
                                        <button class="btn btn-primary btn-sm" onclick='show_PrescriptionPrvw_Modal("<%=prescp_Objct.getIdprescription()%>");'><span class="fa fa-file-text" style="display: inline; color: #ffffff;"></span>&nbsp;&nbsp;View Prescription</button>
                                    </td>
                                </tr>
                                <% }
                                    }%>
                            </tbody>
                        </table>
                    </div>

                    <input type="hidden" id="VALSUM_TokensCount" value="<%= SumVALUE_TokensCount%>">      
                    <input type="hidden" id="VALSUM_MedCost" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_MedCost)%>">      
                    <input type="hidden" id="VALSUM_DocCharges" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_DocCharges)%>">      
                    <input type="hidden" id="VALSUM_RcvblAmount" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_RcvblAmount)%>">      
                    <input type="hidden" id="VALSUM_PaidAmount" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_PaidAmount)%>">
                    <input type="hidden" id="VALSUM_Pending" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_Pending)%>">      
                    <input type="hidden" id="VALSUM_NotPaid" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_NotPaid)%>">      
                    <input type="hidden" id="VALSUM_Balance" value="<%="Rs. " + Utils.DecimalFormats.dfPriceValue().format(SumVALUE_PaidAmount - SumVALUE_RcvblAmount)%>">      

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
                document.getElementById("RptSUM_RcvblAmount").innerHTML = document.getElementById("VALSUM_RcvblAmount").value;
                document.getElementById("RptSUM_PaidAmount").innerHTML = document.getElementById("VALSUM_PaidAmount").value;
                document.getElementById("RptSUM_Pending").innerHTML = document.getElementById("VALSUM_Pending").value;
                document.getElementById("RptSUM_NotPaid").innerHTML = document.getElementById("VALSUM_NotPaid").value;
                document.getElementById("RptSUM_Balance").innerHTML = document.getElementById("VALSUM_Balance").value;
            }, 800);
        });
    </script>

    <script type="text/javascript">
        function show_PrescriptionPrvw_Modal(prescriptionNo) {
            $('#Prescription-Modal').modal('show');
            $('#Prescription-Modal-Content').load('prescriptionPreview_Modal.jsp?prescriptionNo=' + prescriptionNo);
        }
    </script>

</div>
