<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>利用登録エラー</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>登録情報</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>エラー</h1>

		<hr style="margin-top:1em; margin-bottom:1em;" />

<g:render template="/common/fragment/flashmessages" />

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<button id="topBtn">トップへ戻る</button>
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