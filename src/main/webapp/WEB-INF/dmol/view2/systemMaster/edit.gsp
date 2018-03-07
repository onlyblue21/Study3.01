<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>システムマスターの更新</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">システムマスター一覧</g:link></li>
			<li>システムマスターの更新</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>システムマスターの更新</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="uploadBtn" class="button"><span class="icon-upload">アップロード</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<g:uploadForm method="post" action="update" name="uploadForm" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="settingfile">設定ファイル:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:settingfile,field:'uniqueId','errors')} ${hasErrors(bean:settingfile,field:'props','errors')}">
								<input type="file" size="40" maxlength="256" id="settingfile" name="settingfile" value=""/>
							</td>
						</tr> 

					</tbody>
				</table>
			</div>
		</g:uploadForm>

	</div>

<g:form method="get" action="list" name="cancelForm"></g:form>
<r:script>
;jQuery(function(){
$("#uploadBtn").click(function() {
	pleaseWait();
	document.uploadForm.submit();
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
