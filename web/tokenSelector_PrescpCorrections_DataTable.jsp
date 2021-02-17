<%-- 
    Document   : tokenSelector_PrescpCorrections_DataTable
    Created on : Feb 16, 2021, 8:43:26 PM
    Author     : AKILA
--%>

<%@page import="POJOS.Prescription"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="POJOS.PatientToken"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>

<div id="DataTable_Remover2">
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
                        <h6>Prescription-Corrections Available List</h6>
                    </div>
                    <div class="card-header-right">
                        <ul class="list-unstyled card-option">
                            <li><i class="feather icon-refresh-cw" onclick='load_PrescpCorrectionsList();'></i></li>
                            <li><i class="feather icon-minus minimize-card"></i></li>
                            <li><i class="feather icon-x close-card"></i></li>
                        </ul>
                    </div>
                </div>

                <div class="card-block">
                    <div class="dt-responsive table-responsive">
                        <table id="datatable" class="table table-striped table-bordered nowrap">
                            <thead style="background-color: #404e67; color: #f4f6fa;">
                                <tr id="ScrollNFocusElem2">
                                    <th>#Prescription No</th>
                                    <th>#Token No</th>
                                    <th>Medicine Cost</th>
                                    <th>Doctor Charge</th>
                                    <th>Total Amount</th>
                                    <th>Receivable Amount</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  try {
                                        // Check on PatientTokens ( Availability )...
                                        Session ssn_PrcpCorrctn = FactoryManager.getSessionFactory().openSession();
                                        Criteria prcpCorrctn_Crt = ssn_PrcpCorrctn.createCriteria(PatientToken.class);
                                        prcpCorrctn_Crt.add(Restrictions.eq("date", Utils.CurrentDateNTime.getCurrentDate()));
                                        prcpCorrctn_Crt.add(Restrictions.eq("status", 1));
                                        prcpCorrctn_Crt.addOrder(Order.desc("tokenNumber"));
                                        List<PatientToken> prcpCorrctn_List = prcpCorrctn_Crt.list();
                                        for (PatientToken prcpCorrections_Objc : prcpCorrctn_List) {
                                            // Check on Prescription ( Availability )...
                                            Criteria tknPrescp_Crt = ssn_PrcpCorrctn.createCriteria(Prescription.class);
                                            tknPrescp_Crt.add(Restrictions.eq("patientToken", prcpCorrections_Objc));
                                            tknPrescp_Crt.add(Restrictions.eq("status", 1));
                                            List<Prescription> tknPrescp_List = tknPrescp_Crt.list();
                                            if (!tknPrescp_List.isEmpty()) {
                                                Prescription tknPrescpOBJC = (Prescription) tknPrescp_List.get(0);
                                %>

                                <tr style="background-color: white;">
                                    <td><%= "# " + new DecimalFormat("0000").format(tknPrescpOBJC.getIdprescription())%></td>
                                    <td><%= "# " + prcpCorrections_Objc.getTokenNumber()%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(tknPrescpOBJC.getMedicineCost())%></td>
                                    <td class="f-w-700"><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(tknPrescpOBJC.getDoctorCharge())%></td>
                                    <td><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(tknPrescpOBJC.getTotalAmount())%></td>
                                    <td class="f-w-700"><%= "Rs. " + Utils.DecimalFormats.dfPriceValue().format(tknPrescpOBJC.getReceivableAmount())%></td>
                                    <td>
                                        <button class="btn btn-primary btn-sm m-r-15" onclick='show_PrescriptionPrvw_Modal("<%=tknPrescpOBJC.getIdprescription()%>");'><span class="fa fa-file-text" style="display: inline; color: #ffffff;"></span>&nbsp;&nbsp;View Prescription</button>
                                        <button class="btn btn-danger btn-sm" onclick='show_PrescriptionCorrections_Modal("<%=tknPrescpOBJC.getIdprescription()%>");'><span class="fa fa-edit" style="display: inline; color: #ffffff;"></span>&nbsp;&nbsp;Do Corrections</button>
                                    </td>
                                </tr>
                                <% }
                                        }
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


    <!-- Prescription-Preview _Modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="Prescription-Modal">
        <div class="modal-dialog modal-lg" role="document" style="max-width: 80%;">
            <div class="modal-content" id="Prescription-Modal-Content" style="background: #f6f7fb;">
                <div class="loader-block"><svg id="loader2" viewBox="0 0 100 100"><circle id="circle-loader2" cx="50" cy="50" r="45"></circle></svg></div>
            </div>
        </div>
    </div>

    <!-- Prescription-Corrections _Modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="PrscpCorrections-Modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="PrscpCorrections-Modal-Content" style="background: #f6f7fb;">
                <div class="loader-block"><svg id="loader2" viewBox="0 0 100 100"><circle id="circle-loader2" cx="50" cy="50" r="45"></circle></svg></div>
            </div>
        </div>
    </div>


    <!--  Core Script Pugins -->   
    <script src="assets/js/script.min.js" type="text/javascript"></script>
    <script src="assets/js/modalEffects.js" type="text/javascript"></script>
    <script>
    </script>

    <!-- === UTILITY SCRIPTS ===================================================================================================== -->
    <script type="text/javascript">
        function show_PrescriptionPrvw_Modal(prescriptionNo) {
            $('#Prescription-Modal').modal('show');
            $('#Prescription-Modal-Content').load('prescriptionPreview_Modal.jsp?prescriptionNo=' + prescriptionNo);
        }
    </script>

    <script type="text/javascript">
        function show_PrescriptionCorrections_Modal(prescriptionNo) {
            $('#PrscpCorrections-Modal').modal('show');
            $('#PrscpCorrections-Modal-Content').load('prescriptionCorrections_Modal.jsp?prescriptionNo=' + prescriptionNo);
        }
    </script>

</div>