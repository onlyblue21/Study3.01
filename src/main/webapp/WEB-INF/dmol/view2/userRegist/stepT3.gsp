<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>登録内容確認</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/i_chart_2.gif" width="620" height="54" class="mB20" />
			<h2>登録内容確認</h2>
			<p>間違いなければ「進む」ボタンを押してください。<br />
本登録用のご案内をメールアドレスへ送信します。</p>

			<g:form action="stepT3save" id="${params.id}" name="userRegistForm">
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th>メールアドレス</th>
				<td width="480">${user?.email?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td>**********</td>
			</tr>
			</table>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" name="prevForm" action="stepT2back" id="${params.id}" />
<r:script>
;jQuery(function(){
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
$("#nextBtn").click(function() {
	document.userRegistForm.submit();
	return false;
});
});</r:script>
</body>
</html>