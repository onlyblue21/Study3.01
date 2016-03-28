var search = {
		searchType:"",
		searchValue:""
};

function letterList(data){
	var success=function(json){
		if(json.size>0){
			console.log(json);
		}
	}
	console.log(data);
	_ajax("post","/letterList","json",data,success);
}