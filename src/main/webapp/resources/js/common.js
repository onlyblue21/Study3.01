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