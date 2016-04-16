function _ajax(type,url,dataType,data,success,$name){
	$.ajax({
		type:type,
		url:url,
		dataType:dataType,
		data:data,
		success:success,
		contentType : 'application/json;charset=UTF-8'
	});
};

function OpenDialog(which,iWidth,iHeight,isModal){
    var dialog = $( which ).dialog({
        autoOpen: false,
        height: iHeight,
        width: iWidth,
        modal: isModal,
        zIndex: 9000,
        resizable: false,
        });
    dialog.dialog( "open" );
}