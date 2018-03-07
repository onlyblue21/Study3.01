<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>基本情報登録完了</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<br />
			<br />
			<p class="align_center red size16"><strong>基本情報の登録が完了しました。</strong></p>
			<p class="align_center">引き続き、DMファクトリーをご利用の場合、<br />下の「マイページに戻る」ボタンよりお進みください。</p>
			<br />
			<br />

			<div class="align_center">
				<g:link controller="myPage" action="index" class="transition mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_back_mypageB.gif" alt="マイページに戻る" /></g:link>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->
</body>
</html>