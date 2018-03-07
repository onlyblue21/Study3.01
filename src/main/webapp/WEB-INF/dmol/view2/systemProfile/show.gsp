<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>登録情報確認</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>登録情報確認</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>登録情報確認</h1>

		<div class="buttons">
			<button id="passwdBtn">パスワードの変更</button>
		</div>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<table>
				<tbody>
					<tr class="prop">
						<td class="name">ユーザID</td>
						<td class="value">${userInfo?.email?.encodeAsHTML()}</td>
					</tr>
					<tr class="prop">
						<td class="name">お名前（漢字）</td>
						<td class="value">
							${userInfo?.familyName?.encodeAsHTML()}
							${userInfo?.firstName?.encodeAsHTML()}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

<g:form method="get" name="editForm" action="edit" />
<g:form method="get" name="passwdForm" action="passwd" />
<r:script>
;jQuery(function(){
<sec:ifNotGranted roles="AUTHORITY_JPOST_USER">
$("#editBtn").button().click(function() {
	document.editForm.submit();
	return false;
});
</sec:ifNotGranted>
$("#passwdBtn").button().click(function() {
	document.passwdForm.submit();
	return false;
});
});</r:script>
</body>
</html>