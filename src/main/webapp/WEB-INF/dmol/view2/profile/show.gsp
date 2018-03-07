<html>
<head>
	<meta name="layout" content="main" />
	<title>登録情報確認</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>お客さま情報の変更</h1>

<!-- commonContents -->
		<div class="commonContents w664">

			<div class="align_center mB30">
				<input type="image" id="editBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_kihon-off.gif" alt="基本情報の変更" class="mR15" />
				<input type="image" id="passwdBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_passhen-off.gif" alt="パスワードの変更" class="mR15" />
				<input type="image" id="withdrawalBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_taikai-off.gif" alt="退会する" />
			</div>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<h2>現在の登録情報</h2>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w200">メールアドレス</th>
				<td>${userInfo?.email?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>法人区分</th>
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

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" name="editForm" action="edit" />
<g:form method="get" name="passwdForm" action="passwd" />
<g:form method="get" name="withdrawalForm" action="withdrawalConfirm" />
<r:script>
;jQuery(function(){
$("#editBtn").click(function() {
	document.editForm.submit();
	return false;
});
$("#passwdBtn").click(function() {
	document.passwdForm.submit();
	return false;
});
$("#withdrawalBtn").click(function() {
	document.withdrawalForm.submit();
	return false;
});
});</r:script>
</body>
</html>