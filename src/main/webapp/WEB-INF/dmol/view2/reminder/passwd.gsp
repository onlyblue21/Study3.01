<html>
<head>
	<meta name="layout" content="main" />
	<title>パスワード再設定</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>新規パスワード登録</h1>
		<div class="bgGradLine"></div>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

<!-- commonContents -->
		<div class="commonContents w664">
			<p>新たに使用するパスワードを入力してください。</p>

			<g:form action="update" id="${userInfo.id}" name="updateForm">
			<input type="hidden" name="tid" value="${params.tid?.encodeAsHTML()}" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB">
				<tr>
					<th width="150">パスワード <span class="red">必須</span></th>
					<td width="510"><input type="password" id="passwd1" name="passwd1" maxlength="16" value="" class="w200" /></td>
				</tr>

				<tr>
					<th>パスワード(確認用) <span class="red">必須</span></th>
					<td><input type="password" id="passwd2" name="passwd2" size="20" maxlength="16" value="" class="w200" /></td>
				</tr>
			</table>

			<div class="align_center">
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_soushinw-off.gif" alt="進む" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<r:script>
;jQuery(function(){
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	rules:{
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
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.updateForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>