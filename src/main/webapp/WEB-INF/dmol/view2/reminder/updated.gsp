<html>
<head>
	<meta name="layout" content="main" />
	<title>パスワード再設定</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>パスワード再設定完了</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<br />
			<br />
			<p class="align_center red"><strong>パスワードを再設定しました。</strong></p>
			<br />
			<br />

			<div class="align_center">
				<a href="${normalTopPath}" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="戻る" /></a>
			</div>
		</div>
<!-- commonContents END -->
	</div>
<!-- /mainBlock END -->
</body>
</html>