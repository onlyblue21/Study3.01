<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>받은쪽지함</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="LetterLefter.jsp" />
	<form id="letterWrite" action="letterWrite" method="post">
		<input type="submit"  id="send"  value="보내기">
		<input type="button"  id="clear"  value="지우기">
		<div id="sendWrapper">
				<table>
						<tr>
							<th>받는사람</th>
								<td><input type="hidden" id="recipient_seq"  name="recipient_seq"  value="2"></td>
								<td><input type="text" id="recipient_id" name="recipient_id"  required="required"></td>
							<td><input type="button" id="recipientLayer" value="주소록" onclick="OpenDialog('#addr',700,350,true)"></td>
						</tr>
						<tr>
							<td colspan="3"><textarea id="content" name="content" rows="10" cols="50">쪽지내용</textarea></td>
						</tr>
				</table>
		</div>
	</form>
	<div id="addr" >
		<label>ID></label>
		<input type="text" id="member_id"  name="member_id"  value="sin">
		<label>이름></label>
		<input type="text" id="member_name" name="member_name"  value="신신호">
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>