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
<form name="memberjoin" action="/memberjoin_j" method="post" onsubmit="return joinvalidate(this);">
		<table>
			<tr>
				<td>id : <input type="text" name="id" value="" /></td>
			</tr>
			<tr>
				<td>pw : <input type="password" name="pw" value="" /></td>
			</tr>
			<tr>
				<td>이름: <input type="text" name="user_name" value="" /></td>
			</tr>
			<tr>
				<td>nick name : <input type="text" name="nick_name" value="" /></td>
			</tr>
			<tr>
				<td>Email : <input type="text" name="email" value="" /></td>
			</tr>
			<tr>
				<td>Mobile Phone : <input type="text" name="phone_num" value="" /></td>
			</tr>
			<tr>
				<td>address : <input type="text" name="address" value="" /></td>
			</tr>
			<tr>
				<td>
					<p>
						성별: <input type="radio" name="sex" value="man">남자 <input
							type="radio" name="sex" value="woman">여자
					</p>
				</td>
			</tr>
			<tr>
				<td>프로필 사진 :</td>
			</tr>
			<tr>
				<td>국적 : <select name="city"><option value="korea">한국</option>
						<option value="japan">일본</option></select></td>
			</tr>
			<tr>
				<td>직업 : <select name="job"><option value="0">개발자</option>
						<option value="1">의사</option></select></td>
			</tr>
			<tr>
				<td>종교 : <select name="religion"><option value="0">불교</option>
						<option value="1">기독교</option>
						<option value="3">천주교</option></select></td>
			</tr>
			<tr>
				<td>자기 소개란 :</td>
				<td><textarea rows="5" cols="30" name="introduction"></textarea></td>
			</tr>

		</table>
		<input type="submit" value="등록완료">
	</form>

</body>
</html>