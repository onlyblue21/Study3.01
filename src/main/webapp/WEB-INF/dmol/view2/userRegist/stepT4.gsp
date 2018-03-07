<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>仮登録完了</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_2.gif" width="620" height="54" class="mB20" />			
			<br />
			<br />
			<br />
			<p class="size16 align_center red"><strong><span class="align_center">「仮登録」が完了しました。<br />
				引き続き「本登録」を行ってください。</span></strong></p>

			<p class="align_center">お客さまご登録のメールアドレス、 ${user?.email?.encodeAsHTML()}あてに本登録のご案内を送信いたしました。<br />
					メールをご確認の上、<strong>24時間以内に本登録を行ってください。</strong></p>
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