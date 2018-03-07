<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>メンテナンス状態表示</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list" action="list">ログインユーザ一覧</g:link></li>
			<li>メンテナンス状態表示</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>メンテナンス状態表示</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="editBtn" class="button"><span class="icon-edit">メンテナンス状態設定</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="deleteBtn" class="button"><span class="icon-delete">メンテナンス状態解除</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<div class="dialog">
			<table>
				<tbody>

					<tr class="prop">
						<td valign="top" class="name">メンテナンス状態:</td>
						<td valign="top" class="value">
							<g:if test="${shutdown}">メンテナンス中</g:if><g:else>通常運用</g:else>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">メンテナンスレベル:</td>
						<td valign="top" class="value">
							<g:if test="${shutdown}"><g:if test="${scheduled}">ログイン停止</g:if><g:else>ログイン停止＋ログイン中ユーザに警告</g:else></g:if>
						</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">ログイン画面メッセージ:</td>
						<td valign="top" class="value">${loginmsg?.encodeAsHTML()}</td>
					</tr>

					<tr class="prop">
						<td valign="top" class="name">アラート表示メッセージ:</td>
						<td valign="top" class="value">${alertmsg?.encodeAsHTML()}</td>
					</tr>

				</tbody>
			</table>
		</div>

	</div>

<g:form action="edit" name="editForm"></g:form>
<g:form action="delete" name="deleteForm"></g:form>
<r:script>
;jQuery(function(){
$("#editBtn").click(function() {
	document.editForm.submit();
	return false;
});
$("#deleteBtn").click(function() {
	return confirmRemove(document.deleteForm, "メンテナンス状態を解除しますか？");
});
});</r:script>
</body>
</html>
