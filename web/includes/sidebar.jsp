
<%@page import="DataHolders.USER_LOGIN_DATA"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="POJOS.User"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%
    USER_LOGIN_DATA LD_SIDE = null;
    int USER_ID_SIDE = 0;
    if (request.getSession().getAttribute("LOGIN_DATA") != null) {
        LD_SIDE = (USER_LOGIN_DATA) request.getSession().getAttribute("LOGIN_DATA");
        USER_ID_SIDE = LD_SIDE.getUser_id();
    }

    if (LD_SIDE != null && USER_ID_SIDE > 0) {
        Session sess = FactoryManager.getSessionFactory().openSession();
        User User_OBJECT_SIDE = (User) sess.load(User.class, USER_ID_SIDE);
%>
<nav class="pcoded-navbar">
    <div class="pcoded-inner-navbar main-menu">
        <div>&nbsp;</div>
        <ul class="pcoded-item pcoded-left-item">

            <li class="<%=(navMenuItem == "home") ? "active pcoded-trigger" : ""%>">
                <a href="index.jsp" id="Btn_INDEXPage">
                    <span class="pcoded-micon"><i class="feather icon-home"></i></span>
                    <span class="pcoded-mtext">Home</span>
                </a>
            </li>
            <% if (User_OBJECT_SIDE.getAd().contains("L")) {%>
            <!-- *** TOKENS **********************************************************************************************************  -->
            <li class="<%=(navMenuItem == "token") ? "active pcoded-trigger" : ""%>">
                <a href="issueToken.jsp">
                    <span class="pcoded-micon"><i class="feather icon-bookmark"></i></span>
                    <span class="pcoded-mtext">Tokens</span>
                </a>
            </li>
            <% } %>
            <% if (User_OBJECT_SIDE.getAd().contains("M")) {%>
            <!-- *** TREATMENT *****************************************************************************************************  -->
            <li class="<%=(navMenuItem == "treatment") ? "active pcoded-trigger" : ""%>">
                <a href="tokenSelector.jsp">
                    <span class="pcoded-micon"><i class="feather icon-heart"></i></span>
                    <span class="pcoded-mtext">Treatment</span>
                </a>
            </li>
            <% } %>
            <% if (User_OBJECT_SIDE.getAd().contains("N")) {%>
            <!-- *** DISPENSARY *****************************************************************************************************  -->
            <li class="<%=(navMenuItem == "dispensary") ? "active pcoded-trigger" : ""%>">
                <a href="dispensary.jsp">
                    <span class="pcoded-micon"><i class="feather icon-plus"></i></span>
                    <span class="pcoded-mtext">Dispensary</span>
                </a>
            </li>
            <% } %>
            <% if (User_OBJECT_SIDE.getAd().contains("P")) {%>
            <!-- *** PATIENTS *****************************************************************************************************  -->
            <li class="<%=(navMenuItem == "patients") ? "active pcoded-trigger" : ""%>">
                <a href="patient_Register.jsp">
                    <span class="pcoded-micon"><i class="feather icon-users"></i></span>
                    <span class="pcoded-mtext">Patients</span>
                </a>
            </li>
            <% } %>
            <% if (User_OBJECT_SIDE.getAd().contains("Q") || User_OBJECT_SIDE.getAd().contains("R") || User_OBJECT_SIDE.getAd().contains("S") || User_OBJECT_SIDE.getAd().contains("T")) {%>
            <!-- *** REPORTS *********************************************************************************************************  -->
            <li class="pcoded-hasmenu <%=(navMenuItem == "reports") ? "active pcoded-trigger" : ""%>">
                <a href="javascript:void(0)">
                    <span class="pcoded-micon"><i class="feather icon-file"></i></span>
                    <span class="pcoded-mtext">Reports</span>
                </a>
                <ul class="pcoded-submenu">
                    <% if (User_OBJECT_SIDE.getAd().contains("Q")) {%>
                    <li class="<%=(pagename == "treatmentsReport") ? "active" : ""%>">
                        <a href="report_TreatmentsReport.jsp">
                            <span class="pcoded-mtext">Treatments Report</span>
                        </a>
                    </li>
                    <% } %>
                    <% if (User_OBJECT_SIDE.getAd().contains("R")) {%>
                    <li class="<%=(pagename == "tokensReport") ? "active" : ""%>">
                        <a href="report_TokensReport.jsp">
                            <span class="pcoded-mtext">Tokens Report</span>
                        </a>
                    </li>
                    <% } %>
                    <% if (User_OBJECT_SIDE.getAd().contains("S")) {%>
                    <li class="<%=(pagename == "medicinesSalesReport") ? "active" : ""%>">
                        <a href="report_MedicinesSalesReport.jsp">
                            <span class="pcoded-mtext">Medicines Sales Report</span>
                        </a>
                    </li>
                    <% } %>
                    <% if (User_OBJECT_SIDE.getAd().contains("T")) {%>
                    <li class="<%=(pagename == "patientlist") ? "active" : ""%>">
                        <a href="patient_list.jsp">
                            <span class="pcoded-mtext">Patient List</span>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </li>
            <% }%>
            <!-- *** SETTINGS *********************************************************************************************************  -->
            <li style="display: none;" class="pcoded-hasmenu <%=(navMenuItem == "settings") ? "active pcoded-trigger" : ""%>">
                <a href="javascript:void(0)">
                    <span class="pcoded-micon"><i class="feather icon-settings"></i></span>
                    <span class="pcoded-mtext">Settings</span>
                </a>
                <ul class="pcoded-submenu">
                    <li class="<%=(pagename == "utilities") ? "active" : ""%>">
                        <a href="index.jsp">
                            <span class="pcoded-mtext">Manage Utilities</span>
                        </a>
                    </li>
                </ul>
            </li>






        </ul>
    </div>
</nav>
<% }%>