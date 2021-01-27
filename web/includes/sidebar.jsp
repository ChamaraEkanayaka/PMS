
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="POJOS.User"%>
<%@page import="Connection.FactoryManager"%>
<%@page import="org.hibernate.Session"%>

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

            <!-- *** TOKENS **********************************************************************************************************  -->
            <li class="<%=(navMenuItem == "token") ? "active pcoded-trigger" : ""%>">
                <a href="issueToken.jsp">
                    <span class="pcoded-micon"><i class="feather icon-bookmark"></i></span>
                    <span class="pcoded-mtext">Tokens</span>
                </a>
            </li>

            <!-- *** TREATMENT *****************************************************************************************************  -->
            <li class="<%=(navMenuItem == "treatment") ? "active pcoded-trigger" : ""%>">
                <a href="tokenSelector.jsp">
                    <span class="pcoded-micon"><i class="feather icon-heart"></i></span>
                    <span class="pcoded-mtext">Treatment</span>
                </a>
            </li>

            <!-- *** PATIENTS *****************************************************************************************************  -->
            <li class="<%=(navMenuItem == "patients") ? "active pcoded-trigger" : ""%>">
                <a href="index.jsp">
                    <span class="pcoded-micon"><i class="feather icon-users"></i></span>
                    <span class="pcoded-mtext">Patients</span>
                </a>
            </li>

            <!-- *** REPORTS *********************************************************************************************************  -->
            <li class="pcoded-hasmenu <%=(navMenuItem == "reports") ? "active pcoded-trigger" : ""%>">
                <a href="javascript:void(0)">
                    <span class="pcoded-micon"><i class="feather icon-file"></i></span>
                    <span class="pcoded-mtext">Reports</span>
                </a>
                <ul class="pcoded-submenu">
                    <li class="<%=(pagename == "treatmentsReport") ? "active" : ""%>">
                        <a href="report_TreatmentsReport.jsp">
                            <span class="pcoded-mtext">Treatments Report</span>
                        </a>
                    </li>
                    <li class="<%=(pagename == "tokensReport") ? "active" : ""%>">
                        <a href="report_TokensReport.jsp">
                            <span class="pcoded-mtext">Tokens Report</span>
                        </a>
                    </li>

                </ul>
            </li>








        </ul>
    </div>
</nav>