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
        Session ssn_PatientList = FactoryManager.getSessionFactory().openSession();

        // **** Set RESULT-SET Params *****************************************************************************************
        boolean chBxOpt_Date = false;
        boolean chBxOpt_Patient = false;

        if (request.getParameter("param_ChBxDate") != null) {
            chBxOpt_Date = Boolean.valueOf(request.getParameter("param_ChBxDate"));
        }

        if (request.getParameter("param_ChBxPatient") != null) {
            chBxOpt_Patient = Boolean.valueOf(request.getParameter("param_ChBxPatient"));
        }

        String Val_DateFrom = "";
        String Val_DateTo = "";
        Patient Val_Patient = null;

        if (request.getParameter("param_DateFrom") != null) {
            Val_DateFrom = String.valueOf(request.getParameter("param_DateFrom"));
        }
        if (request.getParameter("param_DateTo") != null) {
            Val_DateTo = String.valueOf(request.getParameter("param_DateTo"));
        }
        if (request.getParameter("param_Patient") != null) {
            Val_Patient = (Patient) ssn_PatientList.load(Patient.class, Integer.valueOf(request.getParameter("param_Patient")));
        }
    %>

    <!-- SEARCH_RESULTS -- data.table ======================================================================= -->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h5><span class="label label-warning">&nbsp;Saved Patients Records&nbsp;</span></h5><br>
                    <span>Search Results On&nbsp;&nbsp;:&nbsp;&nbsp;
                        <%  String searchResultTxt = "";
                            // set CUSTOMIZED SEARCHING OPTIONS....
                            if (chBxOpt_Date) {
                                searchResultTxt = searchResultTxt + " | DATE: " + Val_DateFrom + " - " + Val_DateTo;
                            }

                            if (chBxOpt_Patient) {
                                if (Integer.valueOf(request.getParameter("param_Patient")) != 0) {
                                    searchResultTxt = searchResultTxt + " | PATIENT: " + Val_Patient.getName();
                                } else {
                                    searchResultTxt = searchResultTxt + " | PATIENT: All";
                                }
                            }
                            if (!(chBxOpt_Date || chBxOpt_Patient)) {
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
                                    <th id="dtTableTH_ORD">#ID</th>
                                    <th>Name</th>
                                    <th>Contact</th>
                                    <th>NIC</th>
                                    <th>Added&nbsp;Date</th>
                                    <th>Added&nbsp;Time</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  Criteria ptnPATIENT_Crt = ssn_PatientList.createCriteria(Patient.class);
                                    if (chBxOpt_Date) {
                                        ptnPATIENT_Crt.add(Restrictions.between("regDate", Val_DateFrom, Val_DateTo));
                                    }
                                    if (chBxOpt_Patient) {
                                        if (Integer.valueOf(request.getParameter("param_Patient")) != 0) {
                                            ptnPATIENT_Crt.add(Restrictions.eq("idpatient", Val_Patient.getIdpatient()));
                                        }
                                    }
                                    List<Patient> ptnList_List = ptnPATIENT_Crt.list();
                                    for (Patient ptn_Objct : ptnList_List) {
                                %>
                                <tr>
                                    <td><%=ptn_Objct.getIdpatient()%></td>
                                    <td><%=ptn_Objct.getName()%></td>
                                    <td><%=ptn_Objct.getContactNo()%></td>
                                    <td><%=ptn_Objct.getNic()%></td>
                                    <td><%=ptn_Objct.getRegDate()%></td>
                                    <td><%=ptn_Objct.getRegTime()%></td>
                                    <td>
                                        <% if (ptn_Objct.getStatus() == 0) { %>
                                        <span class="label label-warning">&nbsp;DEACTIVATED&nbsp;</span>      
                                        <% } else if (ptn_Objct.getStatus() == 1) { %>
                                        <span class="label label-success">&nbsp;ACTIVE&nbsp;</span>    
                                        <% } %>

                                    </td>
                                    <td>
                                        <!-- Body.Measurements History-View Button -->
                                        <% if (!ptnList_List.isEmpty()) {%>
                                        <button style="font-size: 13px; padding: 4px 10px 4px 10px;" class="btn btn-info btn-sm btn-mat waves-effect m-l-20"
                                                onclick='open_BMHistoryModal("<%=ptn_Objct.getIdpatient()%>");'>
                                            <span class="fa fa-history"></span>&nbsp;B.M. History
                                        </button>
                                        <% }%>

                                        <!-- Prescriptions History View Button -->
                                        <% if (!ptn_Objct.getPrescriptions().isEmpty()) {%>
                                        <button style="font-size: 13px; padding: 4px 10px 4px 10px;" class="btn btn-warning btn-sm btn-mat waves-effect m-l-20"
                                                onclick='window.open("patient_PrescriptionsList.jsp?patientID=<%=ptn_Objct.getIdpatient()%>");'>
                                            <span class="fa fa-file-text"></span>&nbsp;Previous Prescriptions
                                        </button>
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
    <!-- DETAILS-PREVIEW Modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="DetailsPrvw-Modal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" id="DetailsPrvw-Modal-Content">
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
            }, 500);
        });
    </script>
    <!-- === DETAILS-PREVIEW  MODALS  SCRIPTS ==================================================================================================== -->
    <script type="text/javascript">
        function open_BMHistoryModal(param_PatientID) {
            $('#DetailsPrvw-Modal').modal('show');
            $('#DetailsPrvw-Modal-Content').load('prescription_BMHistoryModal.jsp?patientID=' + param_PatientID);
        }
    </script>
</div>
