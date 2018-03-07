<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>本登録確認</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_3.gif" width="620" height="54" class="mB20" />
			<h2>登録内容の確認</h2>
			<p>入力した内容を確認して「進む」ボタンを押してください。<br />
修正する場合は、「戻る」ボタンを押してください。</p>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
<g:if test="${false}">
			<tr>
				<th class="w200">メールアドレス</th>
				<td>${userInfo?.email?.encodeAsHTML()}</td>
			</tr>
</g:if>
			<tr>
				<th class="w200">法人区分</th>
				<td><g:if test="${userInfo?.corporateUse}">法人</g:if><g:else>個人</g:else></td>
			</tr>
			<tr>
				<th>お名前（漢字）</th>
				<td>
					${userInfo?.familyName?.encodeAsHTML()}
					${userInfo?.firstName?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>お名前（ふりがな）</th>
				<td>
					${userInfo?.familyNameKana?.encodeAsHTML()}
					${userInfo?.firstNameKana?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>郵便番号</th>
				<td>
<g:set var="zipcode3" value="${(userInfo?.zipcode?.size() > 3) ? (userInfo.zipcode.substring(0,3)) : (userInfo?.zipcode)}" />
<g:set var="zipcode4" value="${(userInfo?.zipcode?.size() > 3) ? (userInfo.zipcode.substring(3)) : ''}" />
					${zipcode3?.encodeAsHTML()}-${zipcode4?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>都道府県</th>
				<td>${userInfo?.addressState?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>市区町村</th>
				<td>${userInfo?.address1?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>町域名</th>
				<td>${userInfo?.address2?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>${userInfo?.address3?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>${userInfo?.address4?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>電話番号</th>
				<td>${userInfo?.telno?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>${userInfo?.corporateName?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>部署名</th>
				<td>${userInfo?.departmentName?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>肩書・役職</th>
				<td>${userInfo?.businessTitle?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th>秘密の質問</th>
				<td>${userInfo?.secretQuestion?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>秘密の質問の答え</th>
				<td>●●●●●●</td>
			</tr>
			<tr>
				<th>郵送でのDM送付</th>
				<td><g:if test="${userInfo?.optinDmByPosting}">希望する</g:if><g:else>希望しない</g:else></td>
			</tr>
			<tr>
				<th>eメールでのDM送付</th>
				<td><g:if test="${userInfo?.optinDmByEmail}">希望する</g:if><g:else>希望しない</g:else></td>
			</tr>
			</table>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form name="userRegistForm" action="stepR3save" onsubmit="return false;">
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

<g:form name="prevForm" action="stepR2back" onsubmit="return false;">
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
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
$("#nextBtn").click(function() {
	document.userRegistForm.submit();
	return false;
});
});</r:script>
</body>
</html>