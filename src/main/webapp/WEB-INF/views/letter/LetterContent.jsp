<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:set var="letterVo" value="${letterVo }"/>
<title>${letterVo.content}</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="LetterLefter.jsp" />
<div>
	<input type="submit"  id="delete"  value="삭제" >
	<input type="button"  id="goList"  value="목록" onclick="letterGetLocation(1)">
	<input type="button"  id="prev"  value="<이전">
	<input type="button"  id="next"  value="다음>">	
</div>
		<div>
				<table>
						<tr>
							<th><span>${letterVo.sender_id}님이 보낸 쪽지</span><span>받은시간 : ${letterVo.insert_date}</span></th>
						</tr>
						<tr>
							<td colspan="3"><textarea id="content" name="content" rows="10" cols="50">${letterVo.content}</textarea></td>
						</tr>				
				</table>
		</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>