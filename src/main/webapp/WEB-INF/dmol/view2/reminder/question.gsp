<html>
<head>
	<meta name="layout" content="main" />
	<title>パスワード再設定</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

	<div class="popBox">
		<div id="window_B">
<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />
			<div class="topB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_top.gif" width="536" height="6" alt="" /></div>
			<div class="inB ">
			<g:form action="answer" name="answerForm">

				<p class="wtitle">秘密の質問の答え入力</p>
				<div class="bodr_B"></div>
				<p class="betuWin">ご登録時に設定された秘密の質問に回答してください。<br />回答が正しい場合、ご登録のメールアドレスへパスワード再設定のご案内メールを送信します。</p>
				<ul>
					<li class="size12 w150 align_right"><strong>${userInfo?.secretQuestion?.encodeAsHTML()}</strong></li>
					<li class="m0a mL10"><input type="text" id="secretAnswer" name="secretAnswer" size="50" maxlength="256" value="" class="w250" /></li>
				</ul>
				<div class="clearboth"></div>

				<div class="align_center mB15 mT20">
					<a href="javascript:void(0)" id="prevBtn" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoruB.gif" alt="戻る" /></a>
					<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_soushin-off.gif" alt="送信する" />
				</div>            

				<div class="btomB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_btom.gif" width="536" height="5" alt="" /></div>   
			</g:form>
			</div>
		</div>
	</div>

<g:form method="get" name="prevForm" controller="reminder" action="index" />
<r:script>
;jQuery(function(){
var formValidator = $("#answerForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	rules:{
		secretAnswer:{
			required:true
		}
	},
	messages:{
		secretAnswer:{
			required:"秘密の質問の答えを入力してください。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.answerForm.submit();
	}
	return false;
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>