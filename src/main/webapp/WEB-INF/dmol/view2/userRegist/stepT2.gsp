<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>仮登録</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_2.gif" width="620" height="54" class="mB20" />
			<h2>メールアドレス・パスワードの設定</h2>
			<p>ご入力のメールアドレスに利用登録用の電子メールを送信いたします。<br />
				パスワードは任意のものを設定してください。<br />
			</p>

			<g:if test ="${userRegistCmd?.errors?.hasErrors()}">
			<div class="errors flashmessages">
				<g:renderErrors bean="${userRegistCmd}" as="list" />
			</div>
			</g:if>
			<g:else>
<g:render template="/common/fragment/flashmessages" />
			</g:else>
<g:render template="/common/fragment/validatormessages" />

			<g:form action="stepT2save" name="userRegistForm">
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB">
			<tr>
				<th>メールアドレス</th>
				<td>
					<input type="text" id="email" name="email" class="w300" maxlength="128" value="${userRegistCmd?.email?.encodeAsHTML()}" />
					<span class="size10">(半角英数字)</span>
				</td>
			</tr>
			<tr>
			<th>パスワード</th>
				<td>
					<input type="password" id="passwd1" name="passwd1" class="w150" maxlength="16" value="" />
					<span class="size10">(半角英数字8～16文字)</span>
				</td>
			</tr>
			<tr>
				<th>パスワード(確認用)</th>
				<td>
					<input type="password" id="passwd2" name="passwd2" class="w150" maxlength="16" value="" />
					<span class="size10">(半角英数字8～16文字)</span>
				</td>
			</tr>
			</table>

			<p class="align_center red size12">※入力されたメールアドレスは次回以降ログインする際のIDとなります。<br />
			※入力されたパスワードはログインの際の暗証番号となります。</p>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<g:form method="get" name="prevForm" action="stepT1" />
<r:script>
;jQuery(function(){
var formValidator = $("#userRegistForm").validate({
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
			nozenkaku:true,
			noktaiemail:true
		},
		passwd1:{
			required:true,
			rangelength:[8,16],
			alphanum:true
		},
		passwd2:{
			required:true,
			rangelength:[8,16],
			equalTo:"#passwd1",
			alphanum:true
		}
	},
	messages:{
		email:{
			required:"メールアドレスを指定してください。",
			email:"メールアドレスが正しくありません。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。",
			noktaiemail:"携帯メールアドレスでの登録は出来ません"
		},
		passwd1:{
			required:"パスワードを指定してください。",
			rangelength:"パスワードは半角英数字8～16文字にて指定してください。",
			alphanum:"パスワードは半角英数字8～16文字にて指定してください。"
		},
		passwd2:{
			required:"パスワード(確認用)を指定してください。",
			rangelength:"パスワード(確認用)は半角英数字8～16文字にて指定してください。",
			alphanum:"パスワード(確認用)は半角英数字8～16文字にて指定してください。",
			equalTo:"パスワードとパスワード(確認用)が一致していません。"
		}
	}
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.userRegistForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>