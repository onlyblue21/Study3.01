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
	<div>
		<input type="button"  id="send"  value="보내기">
		<input type="button"  id="clear"  value="지우기">
	</div>						
	<div id="sendWrapper">
		<table>
				<tr>
					<th>받는사람</th>
					<td><input type="text" id="receiver"></td>
					<td><input type="button" id="receiverLayer" value="주소록"></td>					
				</tr>
				<tr>
					<td colspan="3"><textarea id="content" rows="10" cols="50">쪽지내용</textarea></td>
				</tr>				
		</table>
	</div>
</body>
</html>