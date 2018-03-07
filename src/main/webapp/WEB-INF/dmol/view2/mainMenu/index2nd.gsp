<html>
<head>
	<title>DM Factory.jp</title>
	<meta name="layout" content="main" />
<style type="text/css">
.selectItemGenreBtn {
	margin:4px;
}
</style>
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':true]" />

	<div style="padding:1em;">

		<a href="/dmf/login/loginOrGotoMyPage?top=kamo"><img src="/dmf/login/loginOrGotoMyPageImg-off.gif" /></a>
		<br />
		<br />
		<a href="/dmf/login/registConfirmProfile"><img src="/dmf/login/registConfirmProfileImg-off.gif" /></a>

		<div style="margin-top:20px;">
			<ul>
				<li><g:link controller="selectTemplate" action="entry" id="o11" class="selectItemGenreBtn">限定オリジナルはがき</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="o10" class="selectItemGenreBtn">オリジナル年賀はがき</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="o15" class="selectItemGenreBtn">四面オリジナル年賀はがき</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="o20" class="selectItemGenreBtn">オリジナルかもめ～る</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="o25" class="selectItemGenreBtn">四面オリジナルかもめ～る</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d10" class="selectItemGenreBtn">年賀はがき</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d15" class="selectItemGenreBtn">四面年賀はがき</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d20" class="selectItemGenreBtn">年賀タウンメール（両面）</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d30" class="selectItemGenreBtn">年賀タウンメール</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d40" class="selectItemGenreBtn">かもめ～る</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d45" class="selectItemGenreBtn">四面かもめ～る</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d50" class="selectItemGenreBtn">かもめタウン（両面）</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d60" class="selectItemGenreBtn">かもめタウン</g:link></li>
				<li><g:link controller="selectTemplate" action="entry" id="d75" class="selectItemGenreBtn">喪中はがき</g:link></li>
			</ul>
		</div>

		<div style="margin-top:20px;padding-top:20px;border-top: dashed 1px gray;">
			<ul>
				<li><g:link uri="/index" class="selectItemGenreBtn">通年サイト</g:link></li>
			</ul>
		</div>

	</div>

<g:if test="${false}">
<g:form method="get" controller="justNowUserRegist" action="edit" name="justNowUserRegistForm" />
<r:script>
;jQuery(function(){
<sec:ifLoggedIn>
<sec:ifAllGranted roles="AUTHORITY_JUST_NOW_USER">
$(".registJusrNow").show();
</sec:ifAllGranted>
</sec:ifLoggedIn>
$("#registJustNowBtn").button().click(function() {
	document.justNowUserRegistForm.submit();
	return false;
});
});</r:script>
</g:if>
<r:script>
;jQuery(function(){
$("a.selectItemGenreBtn").button();
});</r:script>
</body>
</html>
