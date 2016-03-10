<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/js/Ob21.js" type="text/javascript"></script>
<script src="/js/jquery-1.11.2.js" type="text/javascript"></script>
<title>Insert title here</title>
</head>
<body>
<h1>
회원 가입 화면
</h1>
test = ${test}
<form name="memberjoin" action="/memberjoin_j" method="post" onsubmit="return joinvalidate(this);" >
<table>
	<tr>
		<td>id : <input type="text" name="id" value="" /></td>
	</tr>
	<tr>
		<td>pw : <input type="password"  name="pw" value="" /></td>
	</tr>
	<tr>
		<td>nick name : <input type="text" name="nick_name" value="" /></td>
	</tr>
	<tr>
		<td>Email : <input type="text" name="email" value="" /></td>
	</tr>
</table>
<input type="submit" value="등록완료">
</form>
</body>
</html>