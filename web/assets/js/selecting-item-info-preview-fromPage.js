/* 
 * Copyright (c) 2020  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 27 Oct 2020 10:25:38 AM By AKILA.
 */

// Open Seleted Item's Info Preview Modal  --FROM PAGE
function open_ITEMInfoPreviewModal(param_ItemID) {
    $('#itemInfo-View-Modal').modal('show');
    $('#itemInfo-View-Modal-Content').load('itemInfo_PreviewModal.jsp?itemID=' + param_ItemID);
}
    