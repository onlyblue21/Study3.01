<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="/js/Ob21.js" type="text/javascript"></script>
<script src="/js/jquery-1.11.2.js" type="text/javascript">
	// $(document).ready(function(){
	// 	alert('테스트');
	// });

	window.onloda = function check() {
		var check = "${login}";
		var membercheck = "${member}";

		if (check) {
			alert(check);
			return false;
		}

		if (membercheck) {
			alert("로그인 되었습니다.");
			return false;
		}
	}
</script>
<title>메인화면</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="listItem1">
		<div class="col" style="float: left">
			<a href="/letter/">쪽지조회</a>
			<!-- 테스트 -->
<!-- 			<h2>공지사항</h2> -->

			<%-- 	<div class="mainTblList">
				<table>
					<colgroup>
						<col style="width: 300px">
						<col style="width: 100px">
					</colgroup>
					<thead>
						<tr style="display: none;">
							<th>글제목</th>
							<th>등록일자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Develop 게시물 작성 방법</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>가입 시 공지사항</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>안녕하십니까!</td>
							<td>2016-01-01</td>
						</tr>
					</tbody>
				</table>
			</div> --%>

		</div>
		<%-- <div class="col" style="float: left">
			<h2>Develop</h2>
			<div class="mainTblList">
				<table>
					<colgroup>
						<col style="width: 300px">
						<col style="width: 100px">
					</colgroup>
					<thead>
						<tr style="display: none;">
							<th>글제목</th>
							<th>등록일자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Develop 글1</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>Develop 글2</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>Develop 글3</td>
							<td>2016-01-01</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		 --%>

		<%-- </div>
	<div class="listItem2">
		<div class="col" style="float: left">
			<h2>중고거래</h2>
			<div class="mainTblList">
				<table>
					<colgroup>
						<col style="width: 300px">
						<col style="width: 100px">
					</colgroup>
					<thead>
						<tr style="display: none;">
							<th>글제목</th>
							<th>등록일자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>중고거래 글1</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>중고거래 글2</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>중고거래 글3</td>
							<td>2016-01-01</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="col" style="float: left">
			<h2>갤러리</h2>
			<div class="mainTblList">
				<table>
					<colgroup>
						<col style="width: 300px">
						<col style="width: 100px">
					</colgroup>
					<thead>
						<tr style="display: none;">
							<th>글제목</th>
							<th>등록일자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>갤러리 글1</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>갤러리 글2</td>
							<td>2016-01-01</td>
						</tr>
						<tr>
							<td>갤러리 글3</td>
							<td>2016-01-01</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	 --%>
</div>
	<br/>
	<br/>

		<div class="left">
			<div class="login">
				<form name="mainfrm" action="/login" method="post">
					<table>
						<tr>
							<td>
								<c:choose>
									<c:when test="${LoginResult == 'SUCCESS'}">
											<tr>
												<td>test = ${test} 로그인 여부  = ${LOGIN_RESULT}</td>
											</tr>
											<tr>
												<td>
													<input type="button" title="프로필 생성" value="프로필 생성" onclick="profile();"> <br>
													<!-- <a href="#" title="회원가입">회원가입</a>&nbsp;&nbsp;  -->
													<!-- <a href="#" title="ID/PW찾기">ID/PW 찾기</a> --> 
												</td>
											</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>아이디 : <input type="text" name="id" title="아이디" value="" /></td>
										</tr>
										<tr>
											<td>pw : <input type="password" name="pw" title="비밀번호" value="" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
						<tr>
							<td>
								 <input type="submit" value="로그인" title="로그인" /> 
							     <input type="button" value="회원가입" title="회원가입" onclick="memberJoin();"> 
							
								</td>
						</tr>
					</table>
				</form>
			</div>

			<!-- 광고 배너 링크 추가 -->
		</div>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
