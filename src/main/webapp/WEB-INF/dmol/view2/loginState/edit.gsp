<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>メンテナンス状態設定</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list" action="list">ログインユーザ一覧</g:link></li>
			<li><g:link class="show transition" action="show">メンテナンス状態表示</g:link></li>
			<li>メンテナンス状態設定</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>メンテナンス状態設定</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="updateBtn" class="button"><span class="icon-save">メンテナンス状態設定</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>
		<g:hasErrors bean="${shutdownInfo}">
		<div class="errors">
			<g:renderErrors bean="${shutdownInfo}" as="list" />
		</div>
		</g:hasErrors>

		<g:form method="post" action="update" name="updateForm" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">メンテナンスレベル:</td>
							<td valign="top" class="value">
								<g:radio name="scheduled" id="scheduledOn" value="true" checked="${shutdownInfo?.scheduled}" />
								<label for="scheduledOn" style="margin-right: 2em;">ログイン停止</label>
								<g:radio name="scheduled" id="scheduledOff" value="false" checked="${!shutdownInfo?.scheduled}" />
								<label for="scheduledOff">ログイン停止＋ログイン中ユーザに警告</label>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">ログイン画面メッセージ:</td>
							<td valign="top" class="value"><input type="text" size="40" maxlength="128" id="loginmsg" name="loginmsg" value="${shutdownInfo?.loginmsg?.encodeAsHTML()}"/></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">アラート表示メッセージ:</td>
							<td valign="top" class="value"><input type="text" size="40" maxlength="128" id="alertmsg" name="alertmsg" value="${shutdownInfo?.alertmsg?.encodeAsHTML()}"/></td>
						</tr>

					</tbody>
				</table>
			</div>
		</g:form>

	</div>

<g:form method="get" action="show" name="cancelForm"></g:form>
<r:script>
;jQuery(function(){
$("#updateBtn").click(function() {
	pleaseWait();
	document.updateForm.submit();
	return false;
});
$('#cancelBtn').click(function() {
	document.cancelForm.submit();
	return false;
});
$("a.transition").click(function() {
	return confirmTransition(this.href);
});
});</r:script>
</body>
</html>
