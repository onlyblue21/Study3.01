<html>
<head>
	<meta name="layout" content="main" />
	<title>パスワード変更</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>パスワードの変更</h1>

<!-- commonContents -->
		<div class="commonContents w664">

			<h2>パスワードの再登録</h2>
			<p>内容を入力して、「進む」ボタンを押してください。</p>

			<g:if test ="${userInfo?.errors?.hasErrors()}">
			<div class="errors flashmessages">
				<g:renderErrors bean="${userInfo}" as="list" />
			</div>
			</g:if>
			<g:else>
<g:render template="/common/fragment/flashmessages" />
			</g:else>
<g:render template="/common/fragment/validatormessages" />

			<g:form action="updatePasswd" name="updatePasswdForm">
			<input type="hidden" name="id" value="${userInfo.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${userInfo.version?.encodeAsHTML()}" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th>現在のパスワード　<span class="red">必須</span></th>
				<td><input type="password" class="w200" maxlength="16" id="oldpasswd" name="oldpasswd" value="" />　<span class="size10">(半角英数字8～16文字)</span></td>
			</tr>
			<tr>
				<th>新しいパスワード　<span class="red">必須</span></th>
				<td><input type="password" class="w200" maxlength="16" id="newpasswd" name="newpasswd" value="" />　<span class="size10">(半角英数字8～16文字)</span></td>
			</tr>
			<tr>
				<th>新しいパスワード（確認用）　<span class="red">必須</span></th>
				<td><input type="password" class="w200" maxlength="16" id="newpasswd1" name="newpasswd1" value="" />　<span class="size10">(半角英数字8～16文字)</span></td>
			</tr>
			</table>
			<p class="align_center red size12">※現在のパスワードがわからない場合には<g:link controller="reminder" action="index">パスワード問い合わせ</g:link>を行ってください。</p>

			<div class="align_center">
				<g:link controller="myPage" action="index" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></g:link>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
			</g:form>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<r:script>
;jQuery(function(){
var formValidator = $("#updatePasswdForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	rules:{
		oldpasswd:{
			required:true,
			rangelength:[8,16],
			alphanum:true
		},
		newpasswd:{
			required:true,
			rangelength:[8,16],
			alphanum:true
		},
		newpasswd1:{
			required:true,
			rangelength:[8,16],
			equalTo:"#newpasswd",
			alphanum:true
		}
	},
	messages:{
		oldpasswd:{
			required:"現在のパスワードを指定してください。",
			rangelength:"現在のパスワードは半角英数字8～16文字にて指定してください。",
			alphanum:"現在のパスワードは半角英数字8～16文字にて指定してください。"
		},
		newpasswd:{
			required:"新しいパスワードを指定してください。",
			rangelength:"新しいパスワードは半角英数字8～16文字にて指定してください。",
			alphanum:"新しいパスワードは半角英数字8～16文字にて指定してください。"
		},
		newpasswd1:{
			required:"新しいパスワード(確認用)を指定してください。",
			rangelength:"新しいパスワード(確認用)は半角英数字8～16文字にて指定してください。",
			alphanum:"新しいパスワード(確認用)は半角英数字8～16文字にて指定してください。",
			equalTo:"新しいパスワードと新しいパスワード(確認用)が一致していません。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.updatePasswdForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>