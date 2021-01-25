<nav class="navbar header-navbar pcoded-header">
    <div class="navbar-wrapper">
        <div class="navbar-logo">
            <a class="mobile-menu" id="mobile-collapse" href="#">
                <i class="feather icon-menu icon-toggle-right"></i>
            </a>
            <a href="index.jsp">
                <span style="font-family: 'impact';font-size: 18px;color: #fe8a7d;"><%=DataHolders.ProjectInfo.getAppTitle() %></span>
            </a>
            <a class="mobile-options">
                <i class="feather icon-more-horizontal"></i>
            </a>
        </div>
        <div class="navbar-container container-fluid">
            <ul class="nav-right">

                <!--                <li class="header-notification">
                                    <div class="dropdown-primary dropdown">
                                        <div class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="feather icon-bell"></i>
                                            <span class="badge bg-c-pink">0</span>
                                        </div>
                                        <ul class="show-notification notification-view dropdown-menu" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut">
                                            <li>
                                                <h6>Notifications</h6>
                                                <label class="label label-danger">New</label>
                                            </li>
                                            <li>
                                                <div class="media">
                                                    <img class="d-flex align-self-center img-radius" src="assets/images/avatar-4.jpg" alt="Generic placeholder image">
                                                    <div class="media-body">
                                                        <h5 class="notification-user">APK HUB</h5>
                                                        <p class="notification-msg">Step one released.</p>
                                                        <span class="notification-time">1 Day ago</span>
                                                    </div>
                                                </div>
                                            </li>
                
                                        </ul>
                                    </div>
                                </li>-->

                <li class="user-profile header-notification">
                    <div class="dropdown-primary dropdown">
                        <div class="dropdown-toggle" data-toggle="dropdown">
                            <img src="assets/images/user-profile/user_img.png" class="img-radius" alt="User-Profile-Image">
                            <span><%=STAFF_NAME%></span>
                            <i class="feather icon-chevron-down"></i>
                        </div>
                        <ul class="show-notification profile-notification dropdown-menu" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut">
                            <li>
                                <a href="tutorialVideos.jsp">
                                    <i class="feather icon-play-circle"></i>Watch Tutorial Videos
                                </a>
                            </li>
                            <li>
                                <a href="user_Profile.jsp">
                                    <i class="feather icon-user"></i>My Profile
                                </a>
                            </li>
                            <li>
                                <a href="User_LogoutServlet">
                                    <i class="feather icon-log-out"></i>Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>