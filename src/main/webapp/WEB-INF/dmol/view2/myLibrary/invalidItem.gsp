<html>
<head>
	<meta name="layout" content="main" />
	<title>販売終了</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">

<g:render template="/common/fragment/flashmessages" />

			<div class="box563 mB50">
				<div class="hensyuBackDialog mB30">
					<p class="w400">選択いただいた商品は、販売を終了いたしました。<br />
					他の商品を選択して、注文にお進みください。</p>
				</div>

<g:if test="${loginUserInfo?.registeredUser}">
				<div class="btnArea align_center">
					<g:link controller="myPage" action="index" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_back_mypageB.gif" alt="マイページに戻る" /></g:link>
				</div>
</g:if>
<g:else>
				<div class="btnArea align_center">
					<a href="${normalTopPath?.encodeAsHTML()}" class="mR10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></a>
				</div>
</g:else>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

</body>
</html>
