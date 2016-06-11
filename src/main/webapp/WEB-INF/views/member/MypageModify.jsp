<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mypage Modify</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container-fluid">
		<form role="form" name="memberjoin" action="/memberModify"
			method="post" class="form-horizontal"
			onsubmit="return joinvalidate(this);" enctype="multipart/form-data">
			<fieldset>
				<div id="legend">
					<legend>회원 정보 수정</legend>
				</div>
				
				<!-- 아이디 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="id">아이디</label>
					<div class="col-sm-3">
						<input type="text" id="id" name="id" placeholder="아이디" readonly value="${memberInfo.id}"
							class="form-control" maxlength="12" minlength="8" required>
					</div>
					<span class="col-sm-3" id="result"></span>
				</div>

				<!-- 비밀번호 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="password">비밀번호</label>
					<div class="col-sm-3">
						<input type="password" id="password" name="password" value="${memberInfo.password}"
							placeholder="비밀번호" class="form-control" maxlength="12"
							minlength="8" required>
					</div>
				</div>
				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="password">비밀번호
						확인</label>
					<div class="col-sm-3">
						<input type="password" id="password2" name="password2" value="${memberInfo.password}"
							placeholder="비밀번호" class="form-control" maxlength="12"
							minlength="8" required>
					</div>
					<div class="col-sm-3" id="passwordmsg">입력하세요</div>
				</div>

				<!-- 이름 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="user_name">이름</label>
					<div class="col-sm-3">
						<input type="text" id="user_name" name="user_name" value="${memberInfo.user_name}"
							placeholder="이름" class="form-control" maxlength="8" minlength="2"
							required readonly>
					</div>
				</div>

				<!-- 닉네임 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="nick_name">닉네임</label>
					<div class="col-sm-3">
						<input type="text" id="nick_name" name="nick_name" value="${memberInfo.nick_name}"
							placeholder="닉네임" class="form-control" maxlength="8"
							minlength="4" required>
					</div>
				</div>
				<!-- 이메일 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="email">이메일</label>
					<div class="col-sm-3">
						<input type="text" id="email" name="email" placeholder="이메일" value="${memberInfo.email}"
							class="form-control" maxlength="30" required>
					</div>
				</div>

				<!-- 핸드폰 번호 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="phone_num">핸드폰
						번호</label>
					<div class="col-sm-3">
						<input type="text" id="phone_num" name="phone_num" value="${memberInfo.phone_num}"
							placeholder="핸드폰 번호" class="form-control" minlength="11"
							maxlength="13" required>
					</div>
				</div>

				<!-- 주소 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="address">주소</label>
					<div class="col-sm-3">
						<input type="text" id="address" name="address" placeholder="주소" value="${memberInfo.address}"
							class="form-control" maxlength="32" required>
					</div>
				</div>


				<!-- 프로필 사진 -->
<!-- 				<div class="form-group"> -->
<!-- 					<label class="control-label col-sm-2">프로필 사진</label> -->
<!-- 					<div class="col-sm-3"> -->
<%-- 						<input type="file" name="upload" value="${memberInfo.upload}" /> --%>
<!-- 					</div> -->
<!-- 				</div> -->

				<!-- 거주지역 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="city">거주지역</label>
					<div class="col-sm-3">${memberInfo.city}
						<select name="city" value="${memberInfo.city}">
							<option value="korea">한국</option>
							<option value="japan">일본</option>
						</select>
					</div>
					<div class="col-sm-3"></div>
				</div>

				<!-- 직업 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="job">직업</label>
					<div class="col-sm-3">${memberInfo.job}
						<select name="job" value="${memberInfo.job}">
							<option value="IT">IT</option>
							<option value="의료">의료</option>
							<option value="소방">소방</option>
							<option value="법률">법률</option>
							<option value="미용">미용</option>
							<option value="생산">생산</option>
							<option value="운송">운송</option>
							<option value="유통">유통</option>
							<option value="회사원">회사원</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>

				<!-- 종교 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="religion">종교</label>
					<div class="col-sm-3">
						<select name="religion">
							<option value="불교">불교</option>
							<option value="기독교">기독교</option>
							<option value="천주교">천주교</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>

				<!-- 자기 소개 -->
				<div class="form-group">
					<label class="control-label col-sm-2" for="introduction">자기소개</label>
					<div class="col-sm-3">
						<textarea rows="10" cols="60" name="introduction" maxlength="3000"></textarea>
					</div>
				</div>
				<div class="form-group">
					<!-- Button -->
					<div class="col-sm-3 col-sm-offset-2">
						<input type="submit" value="수정" class="btn btn-success" />
						<input type="button" value="취소" class="btn btn-success" onclick="javascript:history.back()">
					</div>
				</div>
			</fieldset>
		</form>
	</div>
		<div class="col-sm-3 col-sm-offset-2">
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>