<html>
<head>
	<meta name="layout" content="main" />
	<title>注文エラー</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>注文エラー</h1>
		
<!-- commonContents -->
		<div class="commonContents w664">

<g:render template="/common/fragment/flashmessages" />

		<div class="align_center mT20 mB20">
			<a href="javascript:void(0)" id="topBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_back_mypageB.gif" alt="マイページに戻る" /></a>
		</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" name="topForm" controller="myPage" action="index" />
<r:script>
;jQuery(function(){
$("#topBtn").click(function() {
	document.topForm.submit();
	return false;
});
});</r:script>
</body>
</html>