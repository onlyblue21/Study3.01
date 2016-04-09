function letterList($name){
	var data=new Object();
	data.type=$("#searchType").val();
	data.value=$("#searchValue").val();
	var param =JSON.stringify(data);
	console.log(param);
	
	var success = function(json){
		console.log(json);
		if(json.size>0){
			$name.clearGridData();
			$name.jqGrid({
		
		    datatype: "local",
			height: 250,
			colNames:['번호','보낸사람ID', '내용', '받은시각','확인'],
			colModel:[
			          {name:'LETTER_SEQ'},
			          {name:'ID'},
			          {name:'CONTENT'},
			          {name:'INSERT_DATE'},
			          {name:'CHECK_YN'}     
			          ],
			         caption: "LETTER 목록"
			        });
			for(var i=0;i<json.size;i++){
				$name.jqGrid('addRowData',i+1,json.data[i]);
			}
		}
	}
	
	_ajax("post","/letterListSearch","json",param,success);
}


