<%-- 
    Document   : login
    Created on : Jan 03, 2021, 8:30:10 PM
    Author     : AKILA
--%>

<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <script>
            addEventListener("load", function () {
                setTimeout(hideURLbar, 0);
            }, false);
            function hideURLbar() {
                window.scrollTo(0, 1);
            }
        </script>

        <!-- Meta tags -->
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />

        <!-- Bootstrap-CSS -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <!-- Main-CSS -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/icon/feather/css/feather.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/jquery.mCustomScrollbar.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600" rel="stylesheet">
        <!-- Sweet.Alert CSS -->
        <link rel="stylesheet" type="text/css" href="assets/vendor/sweetalert/css/sweetalert.css">

        <link href="assets/css/loginstylesheet.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    </head>

    <body style="padding-top: 30px;">
        <%
            String PAGE_NAME = "Login | " + DataHolders.ProjectInfo.getAppTitle();
            String USERNAME = "";
            if (request.getParameter("user") != null && !request.getParameter("user").equals("")) {
                USERNAME = request.getParameter("user");
            }
        %>
        <title><%=PAGE_NAME%></title>
        <div class="w3layouts-two-grids">
            <div class="mid-class">
                <div class="txt-left-side" style="background: #3d3a40;">
                    <p style="margin-bottom: 0px; margin-top: -2em;"><img src="assets/images/company_logo/login_logo_256x150_alt.png" class="img-fluid" alt="" style="height: 6em;"></p>

                    <div class="form-left-to-w3l">
                        <span class="fa fa-user" aria-hidden="true"></span>
                        <input type="text" name="un" id="un" placeholder="UserName" required="">
                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l ">
                        <span class="fa fa-lock" aria-hidden="true"></span>
                        <input type="password" name="pw" id="pw" placeholder="Password" required="">
                        <div class="clear"></div>
                    </div>
                    <div class="btnn">
                        <button type="button" id="login" style="background-color:  #27ae60;" >Login </button>
                    </div>

                </div>
                <div class="img-right-side" style="background-color: #fbfbfd;">
                    <img src="assets/images/splash.png" class="img-fluid" alt="">
                </div>
            </div>
        </div>
        <footer class="copyrigh-wthree">
            <p><%=DataHolders.ProjectInfo.getCopyrightText()%></p>
        </footer>


        <!--  Core Script Pugins -->
        <script src="assets/vendor/jquery/js/jquery.min.js" type="text/javascript"></script>
        <script src="assets/vendor/jquery-ui/js/jquery-ui.min.js" type="text/javascript"></script>
        <script src="assets/vendor/popper.js/js/popper.min.js" type="text/javascript"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/vendor/jquery-slimscroll/js/jquery.slimscroll.js" type="text/javascript"></script>
        <script src="assets/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
        <script src="assets/js/pcoded.min.js" type="text/javascript"></script>
        <script src="assets/js/vartical-layout.min.js" type="text/javascript"></script>
        <script src="assets/js/script.min.js" type="text/javascript"></script>
        <script src="assets/js/modalEffects.js" type="text/javascript"></script>
        <!-- Sweet.Alert  Script Plugins -->
        <script src="assets/vendor/sweetalert/js/sweetalert.min.js" type="text/javascript"></script>

        <script>
            $('#un').focus();
            $('#un').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#pw').focus();
                }
            });
            $('#pw').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    getLogin();
                }
            });
            $("#login").click(function () {
                getLogin();

            });

            function getLogin() {
                $.ajax({
                    url: 'User_LoginServlet',
                    data: {
                        un: $('input[name="un"]').val(),
                        pw: $('input[name="pw"]').val()
                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if (data.split(":")[0] === "1") {
                            swal("Welcome", data.split(":")[1], "success");
                            setTimeout(function () {
                                window.location.replace("index.jsp");
                            }, 700);
                        } else if (data.split(":")[0] === "0") {
                            swal("All Fields Are Required", "Please Insert UserName & Password.", "warning");
                        } else if (data.split(":")[0] === "2") {
                            swal("Invalid Login", "Please Insert Valid UserName & Password.", "error");
                        }
                    },
                    error: function () {
                        swal("Something Went Wrong !", "Login Operation Faild", "error");
                    }
                });
            }
        </script>

    </body>
</html>