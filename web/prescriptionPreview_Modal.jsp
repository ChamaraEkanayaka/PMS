<%-- 
    Document   : prescriptionPreview_Modal
    Created on : Jan 27, 2021, 12:11:02 PM
    Author     : AKILA
--%>

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
    Session ssn_PrescPrvw = FactoryManager.getSessionFactory().openSession();
    Prescription prvwPRESC_OBJC = (Prescription) ssn_PrescPrvw.load(Prescription.class, Integer.valueOf(request.getParameter("prescriptionNo")));
%>

<div>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <div class="col-sm-12">
            <div class="form-group">

                <div class="card">
                    <div class="card-header" style="padding-bottom: 5px;">
                        <label class="f-16 f-w-700 color-info text-white p-l-10 p-r-10" style="margin-left: -20px;"><label class="p-l-5 m-b-0"><% out.print("# " + new DecimalFormat("0000").format(prvwPRESC_OBJC.getIdprescription()));%></label></label><br>
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
                                            <td><%="# " + prvwPRESC_OBJC.getPatientToken().getTokenNumber()%></td>
                                        </tr>
                                        <tr>
                                            <th>Name<span style="margin-left: 52px"></span>:&nbsp;&nbsp;</th>
                                            <td><%=prvwPRESC_OBJC.getPatient().getName()%></td>
                                        </tr>
                                        <tr>
                                            <th>Gender<span style="margin-left: 41px"></span>:&nbsp;&nbsp;</th>
                                            <td><%=prvwPRESC_OBJC.getPatient().getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th>Age<span style="margin-left: 64px"></span>:&nbsp;&nbsp;</th>
                                            <td><%=Utils.CurrentDateNTime.getAge(prvwPRESC_OBJC.getPatient().getBirthDay()) + " Years"%></td>
                                        </tr>
                                        <tr>
                                            <th>Blood Group<span style="margin-left: 5px"></span>:&nbsp;&nbsp;</th>
                                            <td><%=prvwPRESC_OBJC.getPatient().getBloodGroup()%></td>
                                        </tr>





                                        <tr>
                                            <th>Note<span style="margin-left: 59px"></span>:&nbsp;&nbsp;</th>
                                            <td style="width: 100%;">
                                                <textarea rows="5" cols="5" class="form-control" style="border: 1px solid #e9ecef;background: #ffffff; height: 85px;" readonly="true">
                                                    <%=prvwPRESC_OBJC.getPatient().getNote()%>
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
    <div class="modal-footer" style="border-top: 1px dashed #1abc9c;">
        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
    </div>
</div>
