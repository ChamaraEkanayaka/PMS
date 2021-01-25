/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 17 Jan 2021 12:29:51 PM By AKILA.
 */
package Utils;

import java.text.DecimalFormat;

/**
 *
 * @author AKILA
 */
public class DecimalFormats {

    public static DecimalFormat dfDoubleValue() {
        DecimalFormat df = new DecimalFormat("0.00");
        return df;
    }

    public static DecimalFormat dfPriceValue() {
        DecimalFormat df = new DecimalFormat("#,##0.00");
        return df;
    }

}
