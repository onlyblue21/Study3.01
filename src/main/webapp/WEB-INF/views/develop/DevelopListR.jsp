<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>개발자 게시판</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<form name="developForm">
		<table>
			<colgroup>
				<col style="width:5%"><col style="width:auto"/><col style="width:10%"/><col style="width:10%"/><col style="width:5%"/>				
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>게시글명</th>
					<th>등록자</th>
					<th>등록일자</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty developList}">
						<tr>
							<td colspan="6">검색 결과가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="developVo" items="${developList}" varStatus="status">
							<tr>
								<td>${developVo.status}</td>
								<td>${developVo.title}</td>
								<td>${developVo.memberSeq}</td>
								<td>${developVo.regDate}</td>
								<td>${developVo.readCount}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>