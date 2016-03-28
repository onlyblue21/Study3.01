var _ajax = function(type,url,dataType,data,success,beforeSend,complete,error){
	$.ajax({
		type:type,
		url:url,
		dataType:dataType,
		data:data,
		success:success,
		error:error,
		beforeSend:beforeSend,
		complete:complete
	});
};