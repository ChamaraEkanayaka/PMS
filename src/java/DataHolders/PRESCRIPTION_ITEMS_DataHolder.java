/*
 * Copyright (c) 2021  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 14 Jan 2021 11:24:16 PM By AKILA.
 */
package DataHolders;

import java.util.ArrayList;

/**
 *
 * @author AKILA
 */
public class PRESCRIPTION_ITEMS_DataHolder {

    private ArrayList<PRESCRIPTION_ITEM_OBJ> dataHolder = new ArrayList();

    public ArrayList<PRESCRIPTION_ITEM_OBJ> getHolder() {
        return dataHolder;
    }

    public void clear() {
        this.dataHolder.clear();
    }

}
