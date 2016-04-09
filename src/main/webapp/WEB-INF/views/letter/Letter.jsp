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
		letterList($("#letterList"));

		$("#search").on("click",function() {
			letterList($("#letterList"));
		});

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