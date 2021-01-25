/*
 * Copyright (c) 2020  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 27 Dec 2020 03:19:46 PM By AKILA.
 */
package Utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author AKILA
 */
public class CurrentDateNTime {

    public static String getCurrentDate() {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calnd = Calendar.getInstance();
        return df.format(calnd.getTime());
    }

    public static String getCurrentTime() {
        DateFormat df = new SimpleDateFormat("HH:mm:ss");
        Calendar calnd = Calendar.getInstance();
        return df.format(calnd.getTime());
    }

    public static int getAge(String Birthday) {
        int age = 0;
        try {
            age = Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date())) - Integer.valueOf(Birthday.split("-")[0]);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (sdf.parse(new SimpleDateFormat("yyyy").format(new Date()) + "-" + Birthday.split("-")[1] + "-" + Birthday.split("-")[2]).after(new Date())) {
                age = age - 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return age;
    }

}
