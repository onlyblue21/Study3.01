<html>
<head>
	<meta name="layout" content="main" />
	<title>退会手続き完了</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1><span class="mB20">退会手続き完了</span></h1>

<!-- commonContents -->
		<div class="commonContents w664">
			<br />
			<br />
			<p class="align_center red size16"><strong>退会手続きが完了しました。</strong></p>
			<p class="align_center">DMファクトリーのご利用ありがとうございました。</p>
			<br />
			<br />

			<div class="align_center">
				<g:link controller="mainMenu" action="index" class="transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></g:link>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->
</body>
</html>