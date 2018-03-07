<html>
<head>
	<meta name="layout" content="login" />
	<title>ログイン</title>
</head>
<body class="myPage myHome">
<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents w850 loginPage">
			<div class="leftBlock">
				<div class="box417 mB15">
					<h2><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/login_tit1.gif" alt="会員登録しないで利用する" /></h2>
					<div class="h150">
						<div class="align_center mB10 pT20">
							<input type="image" id="justNowBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_login_non-off.gif" alt="会員登録しないで利用する" />
						</div>
						<p class="size12 w380 m0a">DMファクトリーは、会員登録不要でデザインの編集から印刷発注までご利用いただけます。<br />
							（会員サービスは、ご利用いただけません。）<br />
						</p>
					</div>
					<div class="bottom"></div>
				</div>
			</div>
			<div class="rightBlock">
				<div class="box417 mB15">
					<h2><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/login_tit2.gif" alt="会員の方はこちら" /></h2>
					<div class="h150">

						<g:if test="${flash.message}">
						<div class="login_message">${flash.message?.encodeAsHTML()}</div>
						</g:if>

						<form action="${authURL}" method="post" id="loginForm" name="loginForm">
						<table cellpadding="0" cellspacing="0" class="mB10 mT10">
							<tr>
								<th><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/login_text1.gif" alt="メールアドレス" /></th>
								<td><input type="text" class="w200" name="j_username" id="j_username" maxlength="128" /> <span class="size10">(半角英数字)</span></td>
							</tr>
							<tr>
								<th><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/login_text2.gif" alt="パスワード" /></th>
								<td><input type="password" class="w150" name="j_password" id="j_password" maxlength="16" /> <span class="size10">(半角英数字8～16文字)</span></td>
							</tr>
							<tr>
								<th>&nbsp;</th>
								<td class="align_left"><g:link controller="reminder" action="index" class="list-orange">パスワードを忘れた方は(パスワード再設定)</g:link></td>
							</tr>
						</table>
					
						<div class="align_center pB10">
							<input type="image" id="loginBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_login-off.gif" alt="ログイン" />
						</div>
						</form>

					</div>

					<div class="bottom"></div>
				</div>
			</div>
			<div class="clear"></div>

			<div class="loginBox850">
				<h2 class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/login_tit3.gif" alt="新規会員登録（無料）する" /></h2>
				
				<div class="align_center pB10 pT10">
					<g:link controller="userRegist" action="stepT1"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_login_shinki-off.gif" alt="新規会員登録" /></g:link>
				</div>

				<p class="size12 mB10 align_center">会員登録（無料）をしていただくと、基本のサービスに加えて、充実した便利な機能をお使いいただけます。</p>

				<div class="align_center">
					<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/login_img2.gif" alt="会員のメリット" />
				</div>
		
				<div class="bottom"></div>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="post" controller="justNow" action="start" name="justNowForm">
<input type="hidden" name="top" value="${params.top?.encodeAsHTML()}" />
</g:form>
<g:form method="get" controller="mainMenu" action="index" name="topForm" />
<r:script>
;jQuery(function(){
$("#j_username").focus();
$("#justNowBtn").click(function() {
	document.justNowForm.submit();
	return false;
});
$("#loginBtn").click(function() {
	document.loginForm.submit();
	return false;
});
$("#topBtn").click(function() {
	document.topForm.submit();
	return false;
});
});</r:script>
</body>
</html>
