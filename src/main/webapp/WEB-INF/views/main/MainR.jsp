<!DOCTYPE html>
<html lang="ko">
<head>
<script src="/js/member.js" type="text/javascript">
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
<title>Welcome!</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="listItem1">
		<div class="col" style="float: left">
			<a href="/letter">쪽지조회</a>
		</div>
		<br /> <br />

		<div class="left">
			<div class="login">
				<form name="mainfrm" action="/main/login" method="post">
					<table>
						<tr>
							<td><c:choose>

									<c:when test="${LoginResult == 'SUCCESS'}">
										<tr>
											<td>${LOGIN_RESULT}</td>
										</tr>
										<tr>
											<td><input type="button" title="MY PAGE" value="MY PAGE"
												onclick="mypage();"> <br></td>
										</tr>
										<tr>
											<td><input type="button" title="logout" value="로그 아웃"
												onclick="logout()" /></td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>아이디 : <input type="text" name="id" title="아이디"
												value="" /></td>
											<td rowspan="2"><input type="submit" value="로그인"
												title="로그인" /></td>
										</tr>
										<tr>
											<td>pw : <input type="password" name="password"
												title="비밀번호" value="" /></td>
										</tr>
										<tr>
											<td><a href="/memberJoin" title="회원가입">회원가입</a>&nbsp;&nbsp;
												<a href="#" title="ID/PW찾기">ID/PW 찾기</a></td>
										</tr>
									</c:otherwise>
								</c:choose></td>
						</tr>

					</table>
				</form>
			</div>

			<!-- 광고 배너 링크 추가 -->
		</div>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
