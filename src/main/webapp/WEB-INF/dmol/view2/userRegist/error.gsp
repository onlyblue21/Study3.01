<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録エラー</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>利用登録エラー</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">

			<div style="margin-bottom: 2em;">
<g:render template="/common/fragment/flashmessages" />
			</div>

			<div class="align_center">
				<g:link controller="mainMenu" action="index" class="transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></g:link>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->
</body>
</html>