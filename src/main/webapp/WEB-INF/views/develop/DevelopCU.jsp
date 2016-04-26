<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개발자 게시판 글작성</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<form:form commandName="developVo" method="POST">
		<table>
			<colgroup>
				<col style="width:10%"><col style="width:auto"/>			
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td><form:input path="title"/></td>
				</tr>
				<tr>
					<td colspan="2"><form:textarea path="content" rows="10" maxlength ="4000" title="내용"/></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" value="등록"/>
		<a href="/develop/">취소</a>
	</form:form>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>