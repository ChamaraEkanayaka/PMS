<%-- 
    Document   : tokenSelector_SkippedTokens_DataTable
    Created on : Jan 11, 2021, 7:46:24 PM
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
                        <h6>Skipped Tokens List</h6>
                    </div>
                    <div class="card-header-right">
                        <ul class="list-unstyled card-option">
                            <li><i class="feather icon-refresh-cw" onclick='load_SkippedTokensList();'></i></li>
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
                                        Session ssn_SkpTokens = FactoryManager.getSessionFactory().openSession();
                                        Criteria skpTokens_Crt = ssn_SkpTokens.createCriteria(PatientToken.class);
                                        skpTokens_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
                                        skpTokens_Crt.add(Restrictions.eq("status", 2));
                                        skpTokens_Crt.addOrder(Order.asc("tokenNumber"));
                                        List<PatientToken> skpTokens_List = skpTokens_Crt.list();
                                        for (PatientToken skpToken_Objc : skpTokens_List) {
                                %>
                                <tr style="background-color: white;">
                                    <td class="m-l-10">
                                        <span class="f-20"><%= "# " + skpToken_Objc.getTokenNumber()%></span><br>
                                        <span class="subDescText">ID<span style="margin-left: 31px;">&nbsp;:&nbsp;</span><%= "# " + skpToken_Objc.getPatient().getIdpatient()%></span><br>          
                                        <span class="subDescText">Name<span style="margin-left: 10px;">&nbsp;:&nbsp;</span><%=skpToken_Objc.getPatient().getName()%></span><br>          
                                        <span class="subDescText">Gender<span style="margin-left: 0px;">&nbsp;:&nbsp;</span><%=skpToken_Objc.getPatient().getGender()%></span><br>          
                                        <span class="subDescText">Age<span style="margin-left: 20px;">&nbsp;:&nbsp;</span><%= Utils.CurrentDateNTime.getAge(skpToken_Objc.getPatient().getBirthDay()) + " Years"%></span>
                                    </td>
                                    <td><button class="btn btn-info btn-round m-r-5" onclick='select_Token(<%=skpToken_Objc.getTokenNumber()%>);'>Select</button></td>
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


</div>