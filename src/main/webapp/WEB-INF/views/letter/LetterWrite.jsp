<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����������</title>
</head>
<body>
<jsp:include page="LetterLefter.jsp" />
	<div>
		<input type="button"  id="send"  value="������">
		<input type="button"  id="clear"  value="�����">
	</div>						
	<div id="sendWrapper">
		<table>
				<tr>
					<th>�޴»��</th>
					<td><input type="text" id="receiver"></td>
					<td><input type="button" id="receiverLayer" value="�ּҷ�"></td>					
				</tr>
				<tr>
					<td colspan="3"><textarea id="content" rows="10" cols="50">��������</textarea></td>
				</tr>				
		</table>
	</div>
</body>
</html>