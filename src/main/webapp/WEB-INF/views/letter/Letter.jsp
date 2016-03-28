<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>받은쪽지함</title>
<script src="resources/js/jquery-1.12.1.js" type="text/javascript"></script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/letter.js" type="text/javascript"></script>

</head>
<body>
<jsp:include page="LetterLefter.jsp" />
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			search.searchType = $("#searchType option:selected").val();
			search.searchValue=$("#searchValue").val().trim();
			letterList(search);
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
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>보낸사람ID</th>
					<th>내용</th>
					<th>받은시간</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>