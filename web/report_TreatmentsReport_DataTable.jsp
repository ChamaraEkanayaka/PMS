<%-- 
    Document   : report_TreatmentsReport_DataTable
    Created on : Jan 26, 2021, 12:05:42 PM
    Author     : AKILA
--%>

<%@page import="java.util.List"%>
<%@page import="POJOS.Prescription"%>
<%@page import="POJOS.Doctor"%>
<%@page import="POJOS.Patient"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.text.DecimalFormat"%>
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
                                    <th>Receivable Amount</th>
                                    <th>Payments Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  Criteria prescp_Crt = ssn_TrmntReport.createCriteria(Prescription.class);
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
                                %>
                                <tr>
                                    <td><%=prescp_Objct.getIdprescription()%></td>
                                    <td><%=prescp_Objct.getDate()%></td>
                                    <td><%=prescp_Objct.getTime()%></td>
                                    <td><%=prescp_Objct.getPatientToken().getTokenNumber()%></td>
                                    <td><%=prescp_Objct.getPatient().getName()%></td>
                                    <td><%=prescp_Objct.getDoctor().getName()%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(prescp_Objct.getReceivableAmount())%></td>
                                    <td>
                                        <% if (prescp_Objct.getStatus() == 1) { %>
                                        <span class="label label-danger">&nbsp;PENDING&nbsp;</span>      
                                        <% } else { %>
                                        <span class="label label-success">&nbsp;COMPLETED&nbsp;</span>   
                                        <% } %>
                                    </td>
                                    <td>
                                        <button class="btn btn-primary btn-sm" onclick=''><span class="fa fa-file-text" style="display: inline; color: #ffffff;"></span>&nbsp;&nbsp;View Prescription</button>
                                    </td>
                                </tr>
                                <% }
                                    }%>
                            </tbody>
                        </table>
                    </div>
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
            }, 500);
        });
    </script>

</div>
