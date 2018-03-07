<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>本登録完了</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_4.gif" width="620" height="54" class="mB20" /><br />
			<br />
			<br />
			<p class="size16 align_center red"><strong>お客さまの会員登録手続きが完了しました。<br />
			ご登録ありがとうございました。</strong></p>
			<p class="align_center">引き続き、DMファクトリーをご利用の場合は、<br />下の「ホームに戻る」ボタンよりお進みください。</p>
			<br />
			<br />

			<div class="align_center">
				<a href="${normalTopPath}" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></a>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->
</body>
</html>