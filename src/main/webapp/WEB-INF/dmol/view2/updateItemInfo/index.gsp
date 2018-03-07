<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテムの更新</title>
</head>

<body>

<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>アイテム（テンプレート）の更新</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>アイテムの更新</h1>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<div style="padding:4px; line-height:1.7em;">
			アイテム（テンプレート）の情報（ページ数／ページサイズ／有効期限／サムネイル(大)）を更新します。<br />
			毎日深夜（午前3時頃）に自動実行していますので基本的に手動で実行する必要はありません。<br />
			テンプレートプロバイダの状態を即時に反映したい場合に更新処理を開始してください。<br />
			自動実行する場合はbackstage側で更新されている場合のみ更新します。<br />
			このボタンから実行した場合にはすべてのアイテム情報を更新しますのでご注意ください。<br />
			<button id="updateItemInfoBtn">更新処理を開始する</button>
		</div>

	</div>
<g:form action="update" name="updateForm"></g:form>
<r:script>
;jQuery(function(){
$("#updateItemInfoBtn").button().click(function(){
	pleaseWait();
	document.updateForm.submit();
	return false;
});
});</r:script>
</body>
</html>