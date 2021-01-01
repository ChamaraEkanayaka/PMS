/*
 * Copyright (c) 2020  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 27 Dec 2020 03:19:46 PM By AKILA.
 */
package Utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author AKILA
 */
public class DateFormatUtils {

    public String getDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        return dateFormat.format(cal.getTime());
    }

    public String getTime() {
        DateFormat datetime = new SimpleDateFormat("HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        return datetime.format(cal.getTime());
    }
}
