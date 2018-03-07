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
			<g:form action="email" name="mailaddressForm">

				<p class="wtitle">メールアドレス入力</p>
				<div class="bodr_B"></div>
				<p class="betuWin">ご登録のメールアドレスを入力し「進む」ボタンを押してください。<br />ご登録のメールアドレスにメールを送信します。</p>
				<ul>
					<li class="size12 w150 align_right"><strong>メールアドレス</strong></li>
					<li class="m0a mL10"><input type="text" id="email" name="email" maxlength="128" value="${params.email?.encodeAsHTML()}" class="w200" /></li>
				</ul>
				<div class="clearboth"></div>
				<p class="coment "><span class="iconB">登録したメールアドレスを忘れた方は、再度<g:link controller="userRegist" action="stepT1">新規利用登録</g:link>を行ってください。</span></p>

				<div class="align_center mB15">
					<a href="javascript:void(0)" id="prevBtn" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoruB.gif" alt="戻る" /></a>
					<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
				</div>            

				<div class="btomB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_btom.gif" width="536" height="5" alt="" /></div>   
			</g:form>
			</div>
		</div>
	</div>

<g:form method="get" name="prevForm" controller="login" action="auth" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var formValidator = $("#mailaddressForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	rules:{
		email:{
			required:true,
			email:true,
			nozenkaku:true
		}
	},
	messages:{
		email:{
			required:"メールアドレスを指定してください。",
			email:"メールアドレスが正しくありません。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.mailaddressForm.submit();
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