<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>本登録開始</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_3.gif" width="620" height="54" class="mB20" />
			<h2>ログイン</h2>
			<p>仮登録の際に入力したメールアドレスとパスワードを入力し、「ログイン」ボタンを押してください。</p>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<g:form action="stepR1auth" name="userRegistForm">
			<input type="hidden" name="id" value="${params.id?.encodeAsHTML()}" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB">
			<tr>
				<th>メールアドレス</th>
				<td>
					<input type="text" id="email" name="email" class="w250" maxlength="128" value="${userRegistCmd?.email?.encodeAsHTML()}" />
					<span class="size10">(半角英数字)</span>
				</td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td>
					<input type="password" id="passwd" name="passwd" class="w150" maxlength="16" value="" />
					<span class="size10">(半角英数字8～16文字)</span>
				</td>
			</tr>
			</table>

			<p class="align_center red size12">※パスワードを忘れた方は、再度 <g:link action="stepT1">新規登録</g:link>を行ってください。</p>

			<div class="align_center">
				<input type="image" class="mR15" id="loginBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_login-off.gif" alt="ログイン" width="112" height="33" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
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
		passwd:{
			required:true,
			rangelength:[8,16],
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
		passwd:{
			required:"パスワードを指定してください。",
			rangelength:"パスワードは半角英数字8～16文字にて指定してください。",
			alphanum:"パスワードは半角英数字8～16文字にて指定してください。"
		}
	}
});
$("#loginBtn").click(function() {
	if (formValidator.form()) {
		document.userRegistForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>