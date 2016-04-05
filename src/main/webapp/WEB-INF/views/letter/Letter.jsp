<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>받은쪽지함</title>
<script src="resources/js/jquery-1.12.1.js" type="text/javascript"></script>
<script src="resources/js/jquery.jqGrid.js" type="text/javascript"></script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/letter.js" type="text/javascript"></script>

</head>
<body>
<jsp:include page="LetterLefter.jsp" />
<script type="text/javascript">
	$(function() {
		letterList();
	
		$("#search").on("click",function() {
			letterList();
		});
		function letterList(){
			var data=new Object();
			data.type=$("#searchType").val();
			data.value=$("#searchValue").val();
//			console.log(data);
			var param =JSON.stringify(data);
			var success=function(json){
				if(json.size>0){
						$("#letterList").clearGridData();
				        $("#letterList").jqGrid({
				            //로컬그리드이용
				            datatype: "local",
				            //그리드 높이
				            height: 250,
				            //컬럼명들
				            colNames:['번호','보낸사람ID', '내용', '받은시각','확인'],
				            //컬럼모델
				            colModel:[
				                {name:'LETTER_SEQ'},
				                {name:'ID'},
				                {name:'CONTENT'},
				                {name:'INSERT_DATE'},
				                {name:'CHECK_YN'}     
				            ],
				            //그리드타이틀
				            caption: "LETTER 목록"
				        });
				        // 스크립트 변수에 담겨있는 json데이터의 길이만큼 
				        for(var i=0;i<json.size;i++){
				                //jqgrid의 addRowData를 이용하여 각각의 row에 gridData변수의 데이터를 add한다
				        	$("#letterList").jqGrid('addRowData',i+1,json.data[i]);
				        }
				}
			}
			_ajax("post","/letterListSearch","json",param,success);
		}
	});
</script>	
	<div id="searchWrapper">
		<div>
			<select id="searchType">
				<option value="id" selected="selected">아이디</option>
				<option value="content">내용</option>
			</select>
		</div>							
		<div>
			<input type="text"  id="searchValue">
			<input type="button"  id="search" value="검색">			
		</div>						
	</div>
	<div id="listWrapper">
		<table id="letterList">
		</table>
	</div>
</body>
</html>