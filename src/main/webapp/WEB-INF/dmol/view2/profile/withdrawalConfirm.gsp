<html>
<head>
	<meta name="layout" content="main" />
	<title>退会手続き</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>退会手続き</h1>

<!-- commonContents -->
		<div class="commonContents w664">
			<h2>注意事項</h2>

			<div class="tyuiBox">
				<p>退会についてのご注意<br />
					DMファクトリーをご利用いただき、ありがとうございます。<br />
					１度退会されますと、再び新規の会員として登録を行わない限り、会員専用サービスの利用はできなくなります。<br />
					また、今まで保存されたデータはご利用できなくなります。<br />
					なお、現在ご注文いただいているサービスがある場合、キャンセルとはなりませんのでご注意ください。<br />
					よろしいですか？</p>
			</div>
			<p class="align_center">上記内容をご確認いただき、同意する方は、「同意して進む」ボタンを押してください</p>
			<div class="align_center">
				<g:link controller="myPage" action="index" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></g:link>
				<a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_d_susumu-off.gif" alt="同意して進む" /></a>
			</div>

	  </div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="post" name="nextForm" action="withdrawal" />
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	document.nextForm.submit();
	return false;
});
});</r:script>
</body>
</html>