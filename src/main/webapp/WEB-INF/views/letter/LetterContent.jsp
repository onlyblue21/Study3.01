<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>받은쪽지함</title>
</head>
<body>
<jsp:include page="LetterLefter.jsp" />
	<div id="searchWrapper">
		<div>
			<select id="searchType">
				<option value="receive"></option>
				<option value="receive">아이디</option>
				<option value="receive">내용</option>
			</select>
		</div>							
		<div>
			<input type="text"  id="searchValue">
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