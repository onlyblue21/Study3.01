<html>
<head>
	<meta name="layout" content="main" />
	<title>ご利用いただけません</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents w664">

			<div style="margin-bottom: 2em;">
				<div class="errors">申し訳ございませんが、こちらのページをご利用いただくことは出来ません。</div>
			</div>

			<div class="align_center">
<g:if test="${normalTopPath}">
				<a href="${normalTopPath}" class="transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></a>
</g:if>
<g:else>
				<g:link controller="mainMenu" action="index" class="transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_homego.gif" alt="ホームに戻る" /></g:link>
</g:else>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->
</body>
</html>
