<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>パスワード変更</title>
</head>
<body>
	<div class="mainBlock">
		<h1>パスワード変更</h1>

		<div>
			パスワードの変更が完了しました。
		</div>

		<button id="topBtn">メインメニュー</button>
	</div>

<g:form method="get" name="topForm" controller="mainMenu" action="index" />
<r:script>
;jQuery(function(){
$("#topBtn").button().click(function() {
	document.topForm.submit();
	return false;
});
});</r:script>
</body>
</html>