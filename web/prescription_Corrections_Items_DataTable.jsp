<%-- 
    Document   : prescription_Corrections_Items_DataTable
    Created on : Feb 24, 2021, 9:17:14 PM
    Author     : AKILA
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="DataHolders.PRESCRIPTION_ITEM_OBJ"%>
<%@page import="DataHolders.PRESCRIPTION_ITEMS_DataHolder"%>
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.ArrayList"%>

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
        PRESCRIPTION_ITEMS_DataHolder dtHolder;

        // ***** GET/ SET Prescription-Items IN SESSION.DATA.HOLDER [ when NEW ] *********************************************
        if (session.getAttribute("PRESCRIPTION_Items") != null) {
            dtHolder = (PRESCRIPTION_ITEMS_DataHolder) session.getAttribute("PRESCRIPTION_Items");
        } else {
            dtHolder = new PRESCRIPTION_ITEMS_DataHolder();
            request.getSession().setAttribute("PRESCRIPTION_Items", dtHolder);
        }
        // ***************************************************************************************************************************
    %>

    <div class="table-responsive">
        <table class="table invoice-detail-table">
            <thead>
                <tr class="thead-default">
                    <th>Medicine/ Item</th>
                    <th>Dosage</th>
                    <th>Use-Cycle</th>
                    <th>Quantity</th>
                    <th>Use-Method</th>
                    <th>Meal-Type</th>
                    <th>Remark</th>
                    <th>Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%  ArrayList<PRESCRIPTION_ITEM_OBJ> PrescItemsArray = dtHolder.getHolder();
                    if (dtHolder.getHolder().size() != 0) {
                        for (PRESCRIPTION_ITEM_OBJ PrescItems : PrescItemsArray) {
                %>
                <tr>
                    <td>
                        <h6>#&nbsp;<%=PrescItems.getStock().getItems().getName()%></h6>
                    </td>
                    <td><%=PrescItems.getDosage() + " " + PrescItems.getMedicineType().getName()%></td>
                    <td><%=PrescItems.getUseCycle().getName()%></td>
                    <td><%=Utils.DecimalFormats.dfDoubleValue().format(PrescItems.getQty())%></td>
                    <td><%=PrescItems.getUseMethod().getName()%></td>
                    <td><%=PrescItems.getMealType().getName()%></td>
                    <td><%=PrescItems.getRemark()%></td>
                    <td><%=Utils.DecimalFormats.dfDoubleValue().format(PrescItems.getTotalPrice())%></td>
                    <td>
                        <button class="btn btn-primary btn-round btn-sm" onclick='load_SelectedItemFromListFunc("<%=PrescItems.getStock().getStockId()%>");'>
                            <span class="fa fa-edit text-white f-14"></span>
                        </button>
                        <button class="btn btn-danger btn-round btn-sm" onclick='remove_ItemFromListFunc("<%=PrescItems.getStock().getStockId()%>");'>
                            <span class="fa fa-close text-white f-14"></span>
                        </button>
                    </td>
                </tr>
                <% }
                    }%>
            </tbody>
        </table>
    </div>
</div>


<script>
</script>             


<!--  LOAD SELECTED ITEM FROM  Prescription_Items.LIST -->
<script type="text/javascript">
    function load_SelectedItemFromListFunc(param) {
        $.post("PrescriptionCorrections_loadEditingItemServlet", "StockID=" + param, function (outputData) {
            // Post Actions...
            if (outputData.split(":")[0] == 'success') {
                $('#addItem_Item').val(outputData.split(":")[1]);
                $('#addItem_Item').select2().trigger('change');
                document.getElementById("addItem_Dosage").value = outputData.split(":")[2];
                $('#addItem_MedicineType').val(outputData.split(":")[3]);
                $('#addItem_MedicineType').select2().trigger('change');
                $('#addItem_UseCycle').val(outputData.split(":")[4]);
                $('#addItem_UseCycle').select2().trigger('change');
                document.getElementById("addItem_Qty").value = outputData.split(":")[5];
                $('#addItem_UseMethod').val(outputData.split(":")[6]);
                $('#addItem_UseMethod').select2().trigger('change');
                $('#addItem_MealType').val(outputData.split(":")[7]);
                $('#addItem_MealType').select2().trigger('change');
                document.getElementById("addItem_Remark").value = outputData.split(":")[8];

                remove_ItemFromListFunc(param);
            } else {
                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                document.getElementById("btn_SubmitForm").disabled = true; // disable submit-Form
            }
        });
    }
</script>

<!--  REMOVE SELECTED ITEM FROM  Prescription_Items.LIST -->
<script type="text/javascript">
    function remove_ItemFromListFunc(param) {
        $.post("Prescription_RemoveItemServlet", "StockID=" + param, function (outputData) {
            // Post Actions..
            if (outputData.split(":")[0] == 'success') {
                load_MEDICINEITEMS_DataTable();
            } else {
                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                document.getElementById("btn_SubmitForm").disabled = true; // disable submit-Form
            }
        });
    }
</script>