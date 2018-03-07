<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>パスワード変更</title>
</head>
<body>
	<div class="mainBlock">
		<h1>パスワード変更</h1>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<div style="text-align: left;">
			現在のパスワードと新しいパスワードを入力してください。
		</div>
		<g:if test ="${userInfo?.errors?.hasErrors()}">
		<div class="errors flashmessages">
			<g:renderErrors bean="${userInfo}" as="list" />
		</div>
		</g:if>
		<g:else>
<g:render template="/common/fragment/flashmessages" />
		</g:else>
<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<g:form action="updatePasswd" name="updatePasswdForm">
			<input type="hidden" name="id" value="${userInfo.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${userInfo.version?.encodeAsHTML()}" />
			<table>
				<tbody>
					<tr class="prop">
						<td class="name">現在のパスワード：</td>
						<td class="value">
							<input type="password" size="20" maxlength="16" id="oldpasswd" name="oldpasswd" value="" />
						</td>
					</tr>
					<tr class="prop">
						<td class="name">新しいパスワード：</td>
						<td class="value">
							<input type="password" size="20" maxlength="16" id="newpasswd" name="newpasswd" value="" />
							(半角英数字8～16文字)
						</td>
					</tr>
					<tr class="prop">
						<td class="name">新しいパスワードの再入力：</td>
						<td class="value">
							<input type="password" size="20" maxlength="16" id="newpasswd1" name="newpasswd1" value="" />
							(半角英数字8～16文字)
						</td>
					</tr>
				</tbody>
			</table>
			</g:form>
		</div>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<button id="prevBtn"onclick="location.href='javascript:history.go(-1);'">戻る</button>
		<button id="nextBtn">次へ進む</button><br />
	</div>

<g:form method="get" name="prevForm" action="show" />
<r:script>
;jQuery(function(){
var formValidator = $("#updatePasswdForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	onkeyup:false,
    onclick:false,
    onfocusout:false,
	errorClass: "invalidField",
	rules:{
		oldpasswd:{
			required:true,
			rangelength:[1,16],
			alphanum:true
		},
		newpasswd:{
			required:true,
			passwordCheck:true
		},
		newpasswd1:{
			required:true,
			equalTo:"#newpasswd"
		}
	},
	messages:{
		oldpasswd:{
			required:"現在のパスワードを指定してください。",
			rangelength:"現在のパスワードは半角英数字にて指定してください。",
			alphanum:"現在のパスワードは半角英数字にて指定してください。"
		},
		newpasswd:{
			required:"新しいパスワードを指定してください。",
			passwordCheck:"新しいパスワードは半角英数字混合8～16文字にて指定してください。",
		},
		newpasswd1:{
			required:"新しいパスワード(確認用)を指定してください。",
			equalTo:"新しいパスワードと新しいパスワード(確認用)が一致していません。",
		}
	}
});
$("#prevBtn").button().click(function() {
	document.prevForm.submit();
	return false;
});
$("#nextBtn").button().click(function() {
	if (formValidator.form()) {
		document.updatePasswdForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>