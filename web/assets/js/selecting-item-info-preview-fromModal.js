/* 
 * Copyright (c) 2020  APK HUB Software Solution (Pvt.) Ltd
 * All rights reserved.
 * 27 Oct 2020 02:14:03 PM By AKILA.
 */


// Open Seleted Item's Info Preview Modal  --FROM MAIN_MODAL
function open_ITEMInfoPreviewModal(param_ItemID) {
    $('#itemInfo-View-Modal').modal('show');
    $('#itemInfo-View-Modal-Content').load('itemInfo_PreviewModal.jsp?itemID=' + param_ItemID);
    $("#itemInfo-View-Modal").css("margin-top", document.querySelector('#ItemInfoBtn_' + param_ItemID).getBoundingClientRect().top);
}