<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>登録情報変更</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="transition" action="show">登録情報確認</g:link></li>
			<li>登録情報変更確認</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>登録情報変更確認</h1>

		<div style="text-align: left;">
			内容を確認して、「次へ進む」ボタンを押してください。
		</div>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<g:form name="userRegistForm" action="update" onsubmit="return false;">
			<input type="hidden" name="id" value="${userInfo.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${userInfo.version?.encodeAsHTML()}" />
			<input type="hidden" name="email" value="${userInfo.email?.encodeAsHTML()}" />
			<input type="hidden" name="kyokusyoCd" value="${userInfo.kyokusyoCd?.encodeAsHTML()}" />
			<input type="hidden" name="corporateUse" value="${userInfo.corporateUse?.encodeAsHTML()}" />
			<input type="hidden" name="familyName" value="${userInfo.familyName?.encodeAsHTML()}" />
			<input type="hidden" name="firstName" value="${userInfo.firstName?.encodeAsHTML()}" />
			<input type="hidden" name="familyNameKana" value="${userInfo.familyNameKana?.encodeAsHTML()}" />
			<input type="hidden" name="firstNameKana" value="${userInfo.firstNameKana?.encodeAsHTML()}" />
			<input type="hidden" name="zipcode" value="${userInfo.zipcode?.encodeAsHTML()}" />
			<input type="hidden" name="addressState" value="${userInfo.addressState?.encodeAsHTML()}" />
			<input type="hidden" name="address1" value="${userInfo.address1?.encodeAsHTML()}" />
			<input type="hidden" name="address2" value="${userInfo.address2?.encodeAsHTML()}" />
			<input type="hidden" name="address3" value="${userInfo.address3?.encodeAsHTML()}" />
			<input type="hidden" name="address4" value="${userInfo.address4?.encodeAsHTML()}" />
			<input type="hidden" name="telno" value="${userInfo.telno?.encodeAsHTML()}" />
			<input type="hidden" name="corporateName" value="${userInfo.corporateName?.encodeAsHTML()}" />
			<input type="hidden" name="departmentName" value="${userInfo.departmentName?.encodeAsHTML()}" />
			<input type="hidden" name="businessTitle" value="${userInfo.businessTitle?.encodeAsHTML()}" />
			<input type="hidden" name="secretQuestion" value="${userInfo.secretQuestion?.encodeAsHTML()}" />
			<input type="hidden" name="secretAnswer" value="${userInfo.secretAnswer?.encodeAsHTML()}" />
			<input type="hidden" name="optinDmByPosting" value="${userInfo.optinDmByPosting?.encodeAsHTML()}" />
			<input type="hidden" name="optinDmByEmail" value="${userInfo.optinDmByEmail?.encodeAsHTML()}" />
			<table>
				<tbody>
					<tr class="prop">
						<td class="name">ユーザID</td>
						<td class="value">${userInfo?.userId?.encodeAsHTML()}</td>
					</tr>
					<tr class="prop">
						<td class="name">メールアドレス</td>
						<td class="value">${userInfo?.email?.encodeAsHTML()}</td>
					</tr>
					<tr class="prop">
						<td class="name">お名前（漢字角）</td>
						<td class="value">
							${userInfo?.familyName?.encodeAsHTML()}
							${userInfo?.firstName?.encodeAsHTML()}
						</td>
					</tr>
<g:if test="${userInfo.jpostUser}">
					<tr class="prop">
						<td class="name">局所コード</td>
						<td class="value">${userInfo?.kyokusyoCd?.encodeAsHTML()}</td>
					</tr>
</g:if>
				</tbody>
			</table>
			<div style="margin: 4px;">
				<button id="prevBtn">戻る</button>
				<button id="nextBtn">次へ進む</button>
			</div>
		</g:form>
		</div>

	</div>

<g:form name="prevForm" action="reedit" onsubmit="return false;">
<input type="hidden" name="email" value="${userInfo.email?.encodeAsHTML()}" />
<input type="hidden" name="kyokusyoCd" value="${userInfo.kyokusyoCd?.encodeAsHTML()}" />
<input type="hidden" name="corporateUse" value="${userInfo.corporateUse?.encodeAsHTML()}" />
<input type="hidden" name="familyName" value="${userInfo.familyName?.encodeAsHTML()}" />
<input type="hidden" name="firstName" value="${userInfo.firstName?.encodeAsHTML()}" />
<input type="hidden" name="familyNameKana" value="${userInfo.familyNameKana?.encodeAsHTML()}" />
<input type="hidden" name="firstNameKana" value="${userInfo.firstNameKana?.encodeAsHTML()}" />
<input type="hidden" name="zipcode" value="${userInfo.zipcode?.encodeAsHTML()}" />
<input type="hidden" name="addressState" value="${userInfo.addressState?.encodeAsHTML()}" />
<input type="hidden" name="address1" value="${userInfo.address1?.encodeAsHTML()}" />
<input type="hidden" name="address2" value="${userInfo.address2?.encodeAsHTML()}" />
<input type="hidden" name="address3" value="${userInfo.address3?.encodeAsHTML()}" />
<input type="hidden" name="address4" value="${userInfo.address4?.encodeAsHTML()}" />
<input type="hidden" name="telno" value="${userInfo.telno?.encodeAsHTML()}" />
<input type="hidden" name="corporateName" value="${userInfo.corporateName?.encodeAsHTML()}" />
<input type="hidden" name="departmentName" value="${userInfo.departmentName?.encodeAsHTML()}" />
<input type="hidden" name="businessTitle" value="${userInfo.businessTitle?.encodeAsHTML()}" />
<input type="hidden" name="secretQuestion" value="${userInfo.secretQuestion?.encodeAsHTML()}" />
<input type="hidden" name="secretAnswer" value="${userInfo.secretAnswer?.encodeAsHTML()}" />
<input type="hidden" name="optinDmByPosting" value="${userInfo.optinDmByPosting?.encodeAsHTML()}" />
<input type="hidden" name="optinDmByEmail" value="${userInfo.optinDmByEmail?.encodeAsHTML()}" />
</g:form>
<r:script>
;jQuery(function(){
$("#prevBtn").button().click(function() {
	document.prevForm.submit();
	return false;
});
$("#nextBtn").button().click(function() {
	document.userRegistForm.submit();
	return false;
});
});</r:script>
</body>
</html>