<%-- 
    Document   : report_TokensReport_DataTable
    Created on : Jan 27, 2021, 9:13:36 PM
    Author     : AKILA
--%>

<%@page import="POJOS.PatientToken"%>
<%@page import="POJOS.Patient"%>
<%@page import="java.util.List"%>
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
        Session ssn_TokensReport = FactoryManager.getSessionFactory().openSession();

        // **** Set RESULT-SET Params *****************************************************************************************
        boolean chBxOpt_Date = false;
        boolean chBxOpt_TokenNo = false;
        boolean chBxOpt_Patient = false;

        if (request.getParameter("param_ChBxDate") != null) {
            chBxOpt_Date = Boolean.valueOf(request.getParameter("param_ChBxDate"));
        }
        if (request.getParameter("param_ChBxTokenNo") != null) {
            chBxOpt_TokenNo = Boolean.valueOf(request.getParameter("param_ChBxTokenNo"));
        }
        if (request.getParameter("param_ChBxPatient") != null) {
            chBxOpt_Patient = Boolean.valueOf(request.getParameter("param_ChBxPatient"));
        }

        String Val_DateFrom = "";
        String Val_DateTo = "";
        int Val_TokenNo = 0;
        Patient Val_Patient = null;

        if (request.getParameter("param_DateFrom") != null) {
            Val_DateFrom = String.valueOf(request.getParameter("param_DateFrom"));
        }
        if (request.getParameter("param_DateTo") != null) {
            Val_DateTo = String.valueOf(request.getParameter("param_DateTo"));
        }
        if (request.getParameter("param_TokenNo") != null) {
            Val_TokenNo = Integer.valueOf(request.getParameter("param_TokenNo"));
        }
        if (request.getParameter("param_Patient") != null) {
            Val_Patient = (Patient) ssn_TokensReport.load(Patient.class, Integer.valueOf(request.getParameter("param_Patient")));
        }
    %>

    <!-- SEARCH_RESULTS -- data.table ======================================================================= -->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h5><span class="label label-warning">&nbsp;Issued Tokens Records&nbsp;</span></h5><br>
                    <span>Search Results On&nbsp;&nbsp;:&nbsp;&nbsp;
                        <%  String searchResultTxt = "";
                            // set CUSTOMIZED SEARCHING OPTIONS....
                            if (chBxOpt_Date) {
                                searchResultTxt = searchResultTxt + " | DATE: " + Val_DateFrom + " - " + Val_DateTo;
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
                            if (!(chBxOpt_Date || chBxOpt_TokenNo || chBxOpt_Patient)) {
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
                                    <th id="dtTableTH_ORD">#Token</th>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  Criteria ptnTOKENS_Crt = ssn_TokensReport.createCriteria(PatientToken.class);
                                    // set CUSTOMIZED SEARCHING FILTERS....
                                    if (chBxOpt_Date) {
                                        ptnTOKENS_Crt.add(Restrictions.between("date", Val_DateFrom, Val_DateTo));
                                    }
                                    if (chBxOpt_TokenNo) {
                                        if (Integer.valueOf(request.getParameter("param_TokenNo")) != 0) {
                                            ptnTOKENS_Crt.add(Restrictions.eq("tokenNumber", Val_TokenNo));
                                        }
                                    }
                                    if (chBxOpt_Patient) {
                                        if (Integer.valueOf(request.getParameter("param_Patient")) != 0) {
                                            ptnTOKENS_Crt.add(Restrictions.eq("patient", Val_Patient));
                                        }
                                    }
                                    List<PatientToken> ptnTOKENS_List = ptnTOKENS_Crt.list();
                                    for (PatientToken ptnTOKENS_Objct : ptnTOKENS_List) {
                                %>
                                <tr>
                                    <td><%=ptnTOKENS_Objct.getTokenNumber()%></td>
                                    <td><%=ptnTOKENS_Objct.getPatient().getName()%></td>
                                    <td><%=ptnTOKENS_Objct.getDate()%></td>
                                    <td><%=ptnTOKENS_Objct.getTime()%></td>
                                    <td>
                                        <% if (ptnTOKENS_Objct.getStatus() == 0) { %>
                                        <span class="label label-warning">&nbsp;PENDING&nbsp;</span>      
                                        <% } else if (ptnTOKENS_Objct.getStatus() == 1) { %>
                                        <span class="label label-success">&nbsp;COMPLETED&nbsp;</span>    
                                        <% } else if (ptnTOKENS_Objct.getStatus() == 2) { %>
                                        <span class="label label-primary">&nbsp;SKIPPED&nbsp;</span>    
                                        <% } else if (ptnTOKENS_Objct.getStatus() == 3) { %>
                                        <span class="label label-danger">&nbsp;CANCELED&nbsp;</span>   
                                        <% }%>
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
