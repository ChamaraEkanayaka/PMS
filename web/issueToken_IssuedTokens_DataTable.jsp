<%-- 
    Document   : issueToken_IssuedTokens_DataTable
    Created on : Jan 25, 2021, 3:37:49 PM
    Author     : AKILA
--%>

<%@page import="org.hibernate.criterion.Order"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="POJOS.PatientToken"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>

<div id="DataTable_Remover">

    <style>
        .subDescText{
            font-size: 13px;
            color: #797878;
            font-weight: 600;
        }
    </style>

    <!-- SEARCH_RESULTS -- data.table ======================================================================= -->
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header">
                    <div class="invoive-info m-b-0 m-t-0">
                        <h6>Issued Tokens List</h6>
                    </div>
                    <div class="card-header-right">
                        <ul class="list-unstyled card-option">
                            <li><i class="feather icon-refresh-cw" onclick='load_IssuedTokensList();'></i></li>
                            <li><i class="feather icon-minus minimize-card"></i></li>
                            <li><i class="feather icon-x close-card"></i></li>
                        </ul>
                    </div>
                </div>

                <div class="card-block">
                    <div class="dt-responsive table-responsive">
                        <table id="datatable" class="table table-striped table-bordered nowrap">
                            <thead style="background-color: #404e67; color: #f4f6fa;">
                                <tr id="ScrollNFocusElem">
                                    <th>#Token No</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  try {
                                        Session ssn_IssuedTokens = FactoryManager.getSessionFactory().openSession();
                                        Criteria issuedTokens_Crt = ssn_IssuedTokens.createCriteria(PatientToken.class);
                                        //  issuedTokens_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
                                        issuedTokens_Crt.add(Restrictions.or(Restrictions.eq("status", 0), Restrictions.eq("status", 2))); // 0-Pending  &  2-Skipped
                                        issuedTokens_Crt.addOrder(Order.desc("idpatientToken"));
                                        List<PatientToken> issuedTokens_List = issuedTokens_Crt.list();
                                        for (PatientToken issuedToken_Objc : issuedTokens_List) {
                                %>
                                <tr style="background-color: white;">
                                    <td class="m-l-10">
                                        <span class="f-20"><%= "# " + issuedToken_Objc.getTokenNumber()%></span><br>
                                        <span class="subDescText">ID<span style="margin-left: 43px;">&nbsp;:&nbsp;</span><%= "# " + issuedToken_Objc.getPatient().getIdpatient()%></span><br>          
                                        <span class="subDescText">Name<span style="margin-left: 19px;">&nbsp;:&nbsp;</span><%=issuedToken_Objc.getPatient().getName()%></span><br>          
                                        <span class="subDescText">Gender<span style="margin-left: 11px;">&nbsp;:&nbsp;</span><%=issuedToken_Objc.getPatient().getGender()%></span><br>          
                                        <span class="subDescText">Age<span style="margin-left: 34px;">&nbsp;:&nbsp;</span><%= Utils.CurrentDateNTime.getAge(issuedToken_Objc.getPatient().getBirthDay()) + " Years"%></span><br>          
                                        <span class="subDescText">#Contact<span style="margin-left: 0px;">&nbsp;:&nbsp;</span><%=issuedToken_Objc.getPatient().getContactNo()%></span><br>          
                                        <span class="subDescText">@<span style="margin-left: 45px;">&nbsp;:&nbsp;</span><%=issuedToken_Objc.getDate() + " _ " + issuedToken_Objc.getTime()%></span>          
                                    </td>
                                    <td><button class="btn btn-danger btn-round m-r-5" onclick='cancel_IssuedToken("<%=issuedToken_Objc.getIdpatientToken()%>");'>Cancel</button></td>
                                </tr>
                                <% }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
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
        // CANCEL selected Token
        function cancel_IssuedToken(param_PatientTokenID) {
            swal({
                title: "Are you sure?",
                text: "You want to cancel this token permanently.",
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Yes, Cancel Now",
                cancelButtonText: "No",
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            }, function (isConfirm) {
                if (isConfirm) {
                    // start >> Cancel process.............................................................................................................................
                    $.post("IssueToken_CancelTokenServlet", "PatientTokenID=" + param_PatientTokenID, function (outputData) {
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                        // Post Actions..
                        setTimeout(function () {
                            if (outputData.split(":")[0] == 'success') {
                                location.replace("issueToken.jsp");
                            }
                        }, 1000);
                    });
                    // end << Cancel process.................................................................................................................................
                }
            });
        }
    </script>

</div>
