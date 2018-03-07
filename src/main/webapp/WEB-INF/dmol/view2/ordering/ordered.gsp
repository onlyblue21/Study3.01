<html>
<head>
	<meta name="layout" content="main" />
	<title>注文完了</title>
<script>
dataLayer = [{
	'transactionId': "${orderInfo.orderNo}",
	'transactionTotal': ${orderInfo.totalAmount ? orderInfo.totalAmount.toLong() : '0'},
	'event':'thanks'
}];
</script>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>注文完了</h1>
		
<!-- commonContents -->
		<div class="commonContents w664">

<g:if test="${orderInfo}">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_5.gif" class="mB70" />

			<p class="size20 align_center red"><strong>注文が完了しました</strong></p>

			<p class="size16 mB70 align_center">
			ご注文ありがとうございました。<br />
			注文番号は　<strong class="size20">${orderInfo?.orderNo?.encodeAsHTML()}</strong>　です。
			</p>

	 		<h2>ご注文状況のご確認について</h2>
			<p>お客さまのメールアドレスへ注文内容確認メールを送信します。<br />
			なお、会員のお客さまはご注文の状況をマイページの注文一覧にてご確認いただけます。<br />
			</p>

	 		<h2>ご注文のキャンセルについて</h2>
			<p>
			お預かりしたデザインデータによっては注文をキャンセルさせていただく場合がございます。
			</p>
</g:if>
<g:else>
<g:set var="errormessage" value="${flash.message ?: '注文データを取得できませんでした。'}" />
			<p class="size20 align_center red"><strong>${errormessage?.encodeAsHTML()}</strong></p>
</g:else>

<g:if test="${justNowUser}">
 		<h2>会員登録</h2>
		<p>
		会員登録をすると作成いただいたデザインやあて名リスト等が保存されます。<br />
		保存したデータは次回ご注文時に呼び出して使うことができます。
		</p>		
		<div class="align_center">
			<a href="javascript:void(0)" id="topBtn" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_ktoroku_non.gif" alt="会員登録をしない" /></a>
			<a href="javascript:void(0)" id="registBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_ktoroku-off.gif" alt="会員登録をする" /></a>
		</div>
</g:if>
<g:else>
		<div class="align_center mB20">
			<a href="javascript:void(0)" id="topBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_back_mypageB.gif" alt="マイページに戻る" /></a>
		</div>
</g:else>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:if test="${justNowUser}">
<form method="get" name="topForm" action="${normalTopPath?.encodeAsHTML()}" ></form>
<g:form method="get" controller="justNowUserRegist" action="edit" name="justNowUserRegistForm" />
</g:if>
<g:else>
<g:form method="get" name="topForm" controller="myPage" action="index" />
</g:else>
<r:script>
;jQuery(function(){
$("#topBtn").click(function() {
	document.topForm.submit();
	return false;
});
<g:if test="${justNowUser}">
$("#registBtn").click(function() {
	document.justNowUserRegistForm.submit();
	return false;
});
</g:if>
});</r:script>
</body>
</html>