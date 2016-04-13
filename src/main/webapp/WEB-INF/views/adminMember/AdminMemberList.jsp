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

 	<form name="searchForm" action="/adminMember" method="post" onsubmit="return searchCheck(this);" > 
 	<p> 
 		<select name="searchType"> 
 			<option value="ALL" selected="selected">전체검색</option> 
 			<option value="ID" <c:if test="${member.searchType eq '아이디'}">selected="selected"</c:if>>아이디</option> 
 			<option value="USER_NAME" <c:if test="${member.searchType eq '이름'}">selected="selected"</c:if>>이름</option> 
 			<option value="NICK_NAME" <c:if test="${member.searchType eq '닉네임'}">selected="selected"</c:if>>닉네임</option> 
 		</select> 
 		<input type="text" name="searchValue" value="<c:out value="${member.searchValue}" />" /> 
 		<input type="submit" value="검색" /> 
 	</p> 
 	</form> 

	<c:out value = "${totalCount}" /> 
	<div class="adminMember">
	<form name="AdminMemberform" action="/adminMemberList" method="post">
	<table border="1" summary="회원 목록"> 
 		<caption>회원 목록</caption> 
 		<colgroup> 
 			<col width="50" /> 
 			<col width="300" /> 
 			<col width="80" /> 
 			<col width="100" /> 
 			<col width="70" /> 
 		</colgroup> 
 		<thead> 
 			<tr> 
 				<th>번호</th>
 				<th>아이디</th> 
 				<th>이름</th> 
 				<th>닉네임</th> 
 				<th>이메일</th> 
 				<th>성별</th>
 				<th>선택</th>  
 			</tr> 
 		</thead> 
		<tbody>
			<c:choose> 
 			<c:when test="${totalCount == 0}"> 
 			<tr>
 				<td align="center" colspan="5">등록된 회원이 없습니다.</td> 
 			</tr> 
 			</c:when>  	
 			<c:otherwise> 
 				<c:forEach var="member" items="${memberList}" varStatus="status"> 
 			    <tr> 
 			    <td align="center"><c:out value="${status.count}" /></td> 
 				<td align="center"><c:out value="${member.id}" /></td> 
 				<td align="center"><c:out value="${member.user_name}" /></td> 
 				<td align="center"><c:out value="${member.nick_name}" /></td> 
 				<td align="center"><c:out value="${member.email}" /></td> 
 				<td align="center"><c:out value="${member.sex}" /></td> 
 				<td align="center"><input type = "checkbox" name = "check" value=""/></td>
 			    </tr> 
			    </c:forEach> 
 			</c:otherwise> 
 			</c:choose> 	
		</tbody>
 	</table>
	<c:forEach var="page" begin="1" end="${lastPage}"> 
 	   <a href="/adminMember?page=${page}"><c:out value = "${page}" /></a>
	</c:forEach> 

	</form>
	</div>
</body>
</html>