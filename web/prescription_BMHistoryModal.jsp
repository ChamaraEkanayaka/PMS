<%-- 
    Document   : prescription_BMHistoryModal
    Created on : Jan 19, 2021, 12:06:25 AM
    Author     : AKILA
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="POJOS.BodyMeasurement"%>
<%@page import="POJOS.Patient"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.util.List"%>
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

<%
    Session ssn_BodyMsrHist = FactoryManager.getSessionFactory().openSession();
    Patient BMHPatient_OBJC = (Patient) ssn_BodyMsrHist.load(Patient.class, Integer.valueOf(request.getParameter("patientID")));

%>

<div>
    <div class="modal-header">
        <h4 class="modal-title">Body Measurement History</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <div class="col-sm-12">
            <div class="form-group">

                <div class="dt-responsive table-responsive">
                    <table id="datatable_BMHistory" class="table table-striped table-bordered nowrap">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Height (Ft./ Inc.)</th>
                                <th>Weight (Kg)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  Criteria prvwBM_Crt = ssn_BodyMsrHist.createCriteria(BodyMeasurement.class);
                                prvwBM_Crt.add(Restrictions.eq("patient", BMHPatient_OBJC));
                                prvwBM_Crt.addOrder(Order.desc("date"));
                                List<BodyMeasurement> prvwBM_CrtList = prvwBM_Crt.list();
                                for (BodyMeasurement prvwBM_OBJC : prvwBM_CrtList) {
                            %>
                            <tr <% if (prvwBM_OBJC.getStatus() == 1) {%> class="f-w-700" <%}%>>
                                <td><%=prvwBM_OBJC.getDate() + " @" + prvwBM_OBJC.getTime()%></td>
                                <td><%=Utils.DecimalFormats.dfDoubleValue().format(prvwBM_OBJC.getHeight())%></td>
                                <td><%=Utils.DecimalFormats.dfDoubleValue().format(prvwBM_OBJC.getWeight())%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
    <div class="modal-footer" style="border-top: 1px dashed #1abc9c;">
        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
    </div>
</div>

<!-- === UTILITY SCRIPTS ==================================================================================================== -->
<script type="text/javascript">
    $(document).ready(function () {
        // cfg. data-table
        // $('#datatable_BMHistory').DataTable();
    });
</script>
