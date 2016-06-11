<!DOCTYPE html>
<html lang="ko">
<head>
<script type="text/javascript" >
window.onload = function() {

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
<script src="/js/member/member.js" type="text/javascript" ></script>
<title>Welcome!</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="listItem1">
		<div class="col" style="float: left">
			<a href="/letter">쪽지조회</a>
			<br>
		</div>
	</div>
	<div class="container-fluid">
		<form role="form" name="mainfrm" action="/main/login" method="post"
			class="form-horizontal" onsubmit="return joinvalidate(this);">
			<fieldset>
				<c:choose>
					<c:when test="${LoginResult == 'SUCCESS'}">
					<br>${LOGIN_RESULT}
					<div class="form-group">
					<div class="col-sm-3">
							<input class="btn btn-success" type="button" title="MY PAGE" value="MY PAGE" onclick="mypage();"> 
							<input class="btn btn-cancle" type="button" title="logout" value="로그 아웃" onclick="logout()" />
						</div>
						</div>
						
					</c:when>
					<c:otherwise>
						<!-- 아이디 -->
						<div class="form-group">
							<label class="control-label col-sm-1" for="id">아이디</label>
							<div class="col-sm-3">
								<input type="text" id="id" name="id" placeholder="아이디"
									class="form-control" maxlength="12" minlength="4" required>
							</div>
							<span class="col-sm-3" id="result"></span>
						</div>

						<!-- 비밀번호 -->
						<div class="form-group">
							<label class="control-label col-sm-1" for="password">비밀번호</label>
							<div class="col-sm-3">
								<input type="password" id="password" name="password" 
								placeholder="비밀번호" class="form-control" maxlength="12" minlength="8" required> 
								
								<a href="/memberJoin" title="회원가입">회원가입</a>&nbsp;&nbsp; 
									<a href="#" title="ID/PW찾기">ID/PW 찾기</a>

							</div>
							<div class="col-sm-2">
								<input class="btn btn-cancle" type="submit" value="로그인" title="로그인" />
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</fieldset>
		</form>
	</div>
	<div class="col-sm-3 col-sm-offset-1">
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>
