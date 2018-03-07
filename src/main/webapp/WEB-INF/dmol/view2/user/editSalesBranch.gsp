<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>ユーザの編集</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
<g:if test="${params.from == 'jpedituser'}">
			<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
</g:if>
<g:else>
			<li><g:link class="list transition" action="list">ユーザ一覧</g:link></li>
</g:else>
			<li>ユーザの編集</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>ユーザの編集</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="updateBtn" class="button"><span class="icon-save">更新</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />
		<g:hasErrors bean="${userInfo}">
			<div class="errors">
					<g:renderErrors bean="${userInfo}" as="list" />
			</div>
		</g:hasErrors>
<g:render template="/common/fragment/validatormessages" />

		<g:form name="updateForm" method="post" action="updateSalesBranch" onsubmit="return false;">
			<input type="hidden" name="id" value="${params.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${params.version?.encodeAsHTML()}" />
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">${fieldNames?.User?.email?.encodeAsHTML()}:</td>
							<td valign="top" class="value">${userInfo.email?.encodeAsHTML()}</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">お名前</td>
							<td valign="top" class="value">${userInfo?.familyName?.encodeAsHTML()}　${userInfo?.firstName?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">ふりがな</td>
							<td valign="top" class="value">${userInfo?.familyNameKana?.encodeAsHTML()}　${userInfo?.firstNameKana?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">法人区分</td>
							<td valign="top" class="value"><g:if test="${userInfo?.corporateUse}">法人</g:if><g:else>個人</g:else></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵便番号</td>
							<td valign="top" class="value">${userInfo?.zipcode?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">都道府県</td>
							<td valign="top" class="value">${userInfo?.addressState}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">市区町村</td>
							<td valign="top" class="value">${userInfo?.address1?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">町域名</td>
							<td valign="top" class="value">${userInfo?.address2?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">丁目・番地等</td>
							<td valign="top" class="value">${userInfo?.address3?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">アパート・ビル・マンション</td>
							<td valign="top" class="value">${userInfo?.address4?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">電話番号</td>
							<td valign="top" class="value">${userInfo?.telno?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">会社名</td>
							<td valign="top" class="value">${userInfo?.corporateName?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">部署名</td>
							<td valign="top" class="value">${userInfo?.departmentName?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">肩書・役職</td>
							<td valign="top" class="value">${userInfo?.businessTitle?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵送でのDM</td>
							<td valign="top" class="value"><g:if test="${userInfo?.optinDmByPosting}">希望する</g:if><g:else>希望しない</g:else></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">eメールでのDM</td>
							<td valign="top" class="value"><g:if test="${userInfo?.optinDmByEmail}">希望する</g:if><g:else>希望しない</g:else></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">ID:</td>
							<td valign="top" class="value">${userInfo?.id?.encodeAsHTML()}</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">営業担当支店ID:</td>
							<td valign="top" class="value">
								<input type="text" name="salesBranchId" size="10" maxlength="6" value="${userInfo?.jpostSalesBranch?.salesBranchId?.encodeAsHTML()}" />
								<span>${userInfo?.jpostSalesBranch?.salesBranchName?.encodeAsHTML()}</span>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">初回登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.dateCreated}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">本登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.registeredDate}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">退会日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.withdrawalDate}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">最終ログイン日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.lastLoginDate}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">削除フラグ:</td>
							<td valign="top" class="value"><g:if test="${userInfo.enabled}">未削除</g:if><g:else>論理削除済</g:else></td>
						</tr>

					</tbody>
				</table>
			</div>
		</g:form>

	</div>

<g:form method="get" action="list" name="cancelForm" />
<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		salesBranchId:{
			required:true,
			digits:true
		}
	},
	messages:{
		salesBranchId:{
			required:"営業担当支店IDを指定してください。",
			digits:"営業担当支店IDは半角数字にて指定してください。"
		}
	}
});
$("#updateBtn").click(function() {
	if (formValidator.form()) {
		document.updateForm.submit();
	}
	return false;
});
<g:if test="${params.from == 'jpedituser'}">
var relayLogin = function(form, title) {
	var params = null;
	$.post("${createLink(controller:'mainMenu', action:'settlementRelayInfo')}", params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				pleaseWait();
				form.relayUserId.value = result.relayUserId;
				form.dtime.value = result.dtime;
				form.clientId.value = result.clientId;
				form.submit();
				return false;
			} else if (result.message) {
				oiyAlert(result.message);
				return false;
			}
		}
		oiyAlert(title + '画面を表示することができませんでした。');
		return false;
	});
	return false;
};
$("#recievedOrderBtn,#cancelBtn").click(function() {
	return relayLogin(document.recievedOrderForm, '受注管理');
});
</g:if>
<g:else>
$('#cancelBtn').click(function() {
	document.cancelForm.submit();
	return false;
});
</g:else>
$("a.transition").click(function() {
	return confirmTransition(this.href);
});
});</r:script>
</body>
</html>
