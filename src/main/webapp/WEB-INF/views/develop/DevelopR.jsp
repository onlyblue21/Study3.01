<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개발자 게시판 상세조회</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<table>
		<colgroup>
			<col style="width:10%"><col style="width:auto"/>			
		</colgroup>
		<tbody>
			<tr>
				<th>제목</th>
				<td><c:out value="${developVo.title}"/></td>
			</tr>
			<tr>
				<td colspan="2"><c:out value="${developVo.content}"/></td>
			</tr>
		</tbody>
	</table>
	
	<form:form id="submitForm" action="/develop/${developVo.develop_seq}/delete" method="POST">
		<a href="/develop/${developVo.develop_seq}/update">수정</a>
		<input type="submit" value="삭제" onclick="return confirm('삭제하시겠습니까?')"/>
		<a href="/develop">목록</a>
	</form:form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>