<html>
<head>
	<meta name="layout" content="main" />
	<title>パスワード再設定</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

	<div class="popBox">
		<div id="window_B">
			<div class="topB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_top.gif" width="536" height="6" alt="" /></div>
			<div class="inB ">
			<g:form action="answer" name="answerForm">

				<p class="wtitle">メール送信完了</p>
				<div class="bodr_B"></div>
				<br />
				<p class=" align_center red size14"><strong>パスワードの問い合わせを受け付けました。</strong></p>
				<br />
				<p class="align_center mB15 mT10">ご登録のメールアドレスに送信されたメールから、パスワードの変更手続きを行ってください。</p>

				<div class="align_center mB15 mT15">
					<a href="${normalTopPath}" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="戻る" /></a>
				</div>

				<div class="btomB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_btom.gif" width="536" height="5" alt="" /></div>   
			</g:form>
			</div>
		</div>
	</div>

</body>
</html>