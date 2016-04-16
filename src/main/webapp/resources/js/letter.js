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
		
			    datatype: "json",
				height: 250,
				colNames:['번호','보낸사람ID', '내용', '받은시각','확인'],
				colModel:[
				          {name:'letter_seq', index:'letter_seq'},
				          {name:'sender_id', index:'sender_id'},
				          {name:'content', index:'content'},
				          {name:'insert_date', index:'insert_date'},
				          {name:'check_yn', index:'check_yn'}
			          ],
			          rowNum:10,
			          rowList:[10,20,30],			          
			          pager : '#pager',
			          caption: "LETTER 목록",
			          onSelectRow: function(letter_seq){
			        	  var value ="letter_seq="+letter_seq;
			        	  letterGetLocation(3, letter_seq);
			          }
			        	
			        });
			for(var i=0;i<json.size;i++){
//				console.log(json.data[i])
				console.log(json.data[i].content);
				$name.jqGrid('addRowData',i+1,json.data[i]);
			}
			$name.jqGrid('navGrid','#pager',{edit:false,add:false,del:false,search:false,refresh:false});
		}
	}
	_ajax("post","/letterListSearch","json",param,success);
}

function letterGetLocation(index, value){
	var url="";
	if(index==1){
		url="/letter"
	}else if(index==2){
		url="/letterWrite";
	}else if(index==3){
		url="/letterContent?letter_seq="+value;
	}
	$(location).attr("href",url);
}



