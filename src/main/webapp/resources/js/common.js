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

function addMember(data){
	var success=function(json){
		if(json.size>0){
			console.log(json);
		}
	}
	_ajax("post","/addMember","json",data,success);
}

$.fn.serializeFormJSON = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
};