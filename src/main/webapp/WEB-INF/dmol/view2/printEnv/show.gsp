<html>
<head>
	<meta name="layout" content="printenv" />
	<title>環境情報</title>
<style type="text/css">
<!--
body {
	font-family: Meiryo,Osaka,"ＭＳ Ｐゴシック","MS PGothic",sans-serif;
	font-size: 12px;
	line-height:1.5;
}
-->
</style>
</head>
<body>
<h2>環境情報</h2>
<h3>【OS】</h3>
<blockquote>${environment?.os?.encodeAsHTML()} ${environment?.os_version?.encodeAsHTML()}</blockquote>
<h3>【ブラウザ】</h3>
<blockquote>
	<p>${environment?.name?.encodeAsHTML()} ${environment?.version?.encodeAsHTML()}</p>
</blockquote>
<h3>【クッキー】</h3>
<blockquote>
	<g:if test="${cookieEnabled}"><p>有効です</p></g:if><g:else><p>無効です</p></g:else>
</blockquote>
<h3>【Javascript】</h3>
<blockquote>
	<p id="JSOK" style="display: none;">有効です</p>
	<p id="JSNG">無効です</p>
</blockquote>
<h3>【ユーザー情報】</h3>
<blockquote>
	<p>${userAgent?.encodeAsHTML()}</p>
</blockquote>
<script type="application/javascript">
(function(){
function setDisplay(id, display) {
	var element = document.getElementById(id);
	if (element) {
		element.style.display = display;
	}
}
setDisplay('JSNG', 'none');
setDisplay('JSOK', 'block');
})();
</script>
</body>
</html>
