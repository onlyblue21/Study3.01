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
			<li>登録情報変更</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>登録情報変更</h1>

		<div>
			基本情報の変更が完了しました。<br />
			引き続き、DMオンラインサービスをご利用の場合は、<br />
			下の「メインメニューに戻る」ボタンよりお進みください。
		</div>

		<button id="topBtn">メインメニューに戻る</button>
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