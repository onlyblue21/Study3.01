<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>会員参照</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<g:if test="${params.from == 's3s13'}">
				<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
			</g:if>
			<g:else>
				<g:if test="${params.from == 'p3p13'}">
					<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
				</g:if>
				<g:else>
					<g:if test="${params.from == 'jpedituser'}">
						<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
					</g:if>
					<g:else>
						<li><g:link class="list transition" action="list">会員一覧</g:link></li>
					</g:else>
				</g:else>
			</g:else>
			<li>会員参照</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>会員の参照</h1>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<table>
				<tbody>

					<tr class="prop">
						<td valign="top" class="name">${fieldNames?.User?.email?.encodeAsHTML()}:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo.email?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">お名前:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.familyName?.encodeAsHTML()}　${userInfo?.firstName?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">ふりがな:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.familyNameKana?.encodeAsHTML()}　${userInfo?.firstNameKana?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">法人区分:</td>
						<td valign="top" class="value"><g:if test="${userInfo?.corporateUse}">法人</g:if><g:else>個人</g:else></td>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">郵便番号:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.zipcode?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">都道府県:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.addressState}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">市区町村:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.address1?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">町域名:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.address2?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">丁目・番地等:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.address3?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">アパート・ビル・マンション:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.address4?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">電話番号:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.telno?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">会社名:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.corporateName?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">部署名:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.departmentName?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">肩書・役職:</td>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">**********</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value">${userInfo?.businessTitle?.encodeAsHTML()}</td>
						</sec:ifAnyGranted>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">郵送でのDM:</td>
						<td valign="top" class="value"><g:if test="${userInfo?.optinDmByPosting}">希望する</g:if><g:else>希望しない</g:else></td>
					</tr>
					<tr class="prop">
						<td valign="top" class="name">eメールでのDM:</td>
						<td valign="top" class="value"><g:if test="${userInfo?.optinDmByEmail}">希望する</g:if><g:else>希望しない</g:else></td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">ID:</td>
						<td valign="top" class="value">${userInfo?.id?.encodeAsHTML()}</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">営業担当支店ID:</td>
						<td valign="top" class="value">${userInfo?.jpostSalesBranch?.salesBranchId?.encodeAsHTML()} <span>${userInfo?.jpostSalesBranch?.salesBranchName?.encodeAsHTML()}</span></td>
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

	</div>

<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
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
$("#recievedOrderBtn").click(function() {
	return relayLogin(document.recievedOrderForm, '受注管理');
});
});</r:script>
</body>
</html>