/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 01 Jan 2021 09:27:51 PM By AKILA.
 */
package Servlet;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author AKILA
 */
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("+++ session Created [" + se.getSession().getId() + "]");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("--- session Destroyed [" + se.getSession().getId() + "]");
    }
}
