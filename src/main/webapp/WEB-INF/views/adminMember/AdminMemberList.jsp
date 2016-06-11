<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="/js/admin.js"  type="text/javascript"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
 	<form  class="form-inline" name="searchForm" action="/adminMember" method="post" onsubmit="return searchCheck(this);" > 
 	  	<div class="form-group">
	 		<select name="searchType" class="form-control"> 
	 			<option value="ALL" selected="selected">전체검색</option> 
	 			<option value="ID" <c:if test="${member.searchType eq '아이디'}">selected="selected"</c:if>>아이디</option> 
	 			<option value="USER_NAME" <c:if test="${member.searchType eq '이름'}">selected="selected"</c:if>>이름</option> 
	 			<option value="NICK_NAME" <c:if test="${member.searchType eq '닉네임'}">selected="selected"</c:if>>닉네임</option> 
	 		</select>
  		</div>
  	  	<div class="form-group">
 	 		<input type="text"  class="form-control" name="searchValue" value="<c:out value="${member.searchValue}" />" /> 
  		</div>
  	  	<div class="form-group">
	 		<input type="submit"   class="btn btn-default" value="검색" /> 
 		</div>
  	</form> 

	<c:out value = "${totalCount}" /> 
	<div class="adminMember">
	<form id="AdminMemberform" action="/adminMemberList" method="post">
	<table  class="table" summary="회원 목록"> 
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
  				<th><input type="checkbox" id="checkAll" title="전체체크" onclick="CheckAll(this)"></th> 
 				<th>번호</th>
 				<th>아이디</th> 
 				<th>이름</th> 
 				<th>닉네임</th> 
 				<th>이메일</th> 
 				<th>성별</th>
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
	 				<td><input type = "checkbox" class="m_chkbox" name = "memberSeqs" value= "${member.member_seq}" title="체크"/></td>
	 			    <td><c:out value="${status.count}" /></td>
	 				<td><c:out value="${member.id}" /></td>
	 				<td><c:out value="${member.user_name}" /></td>
	 				<td><c:out value="${member.nick_name}" /></td>
	 				<td><c:out value="${member.email}" /></td>
	 				<td><c:out value="${member.sex}" /></td>
 			    </tr>
			    </c:forEach>
 			</c:otherwise>
 			 </c:choose>
		</tbody>
 	</table>
 	
	</form>
	
	<span class="button gray"><a href="#noaction" onclick="deleteSvc();">삭제</a></span>
 	
	<c:forEach var="page" begin="1" end="${lastPage}"> 
 	   <a href="/adminMember?page=${page}"><c:out value = "${page}" /></a>
	</c:forEach> 
	
	</div>
</body>
</html>