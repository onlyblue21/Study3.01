<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=deviec-width, initial-scale=1">
	<title>개발자 게시판</title>
	
	<script type="http://ajax.googleapis.com/ajax/libs/jqurey/1.11.3/jquery.min.js"></script>
	<script type="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
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
								<td>1</td>
								<td><a href="/develop/${developVo.develop_seq}">${developVo.title}</a></td>
								<td>${developVo.member_seq}</td>
								<td><fmt:formatDate value="${developVo.reg_date}" pattern="yyyy-MM-dd"/></td>
								<td>${developVo.read_count}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	
	<a href="/develop/insert">글쓰기</a>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>