<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>ログイン</title>
	<link rel="stylesheet" href="${r.resource(dir:'static/dmol/users/css',file:'layout.css')}" />
	<r:require module="css-dmol-kanri-login" />
</head>
<body>
	<div class="popBox">
		<div id="cautionBlock">実績集計については、毎週火曜までに前週日曜日までの分をポータルサイトに掲載しています。<br />ポータルサイトをご覧ください。</div>
			<div id="intraChart"><img src="${r.resource(dir:'/static/dmol/kanri/images',file:'kanri')}/fig_jp_potal.gif" /></div>
			<div id="intraurl"><a href="http://jppucm.kyotu.pnet.yusei.go.jp/idc/idcplg?IdcService=COLLECTION_DISPLAY&amp;dCollectionID=163615&amp;hasCollectionID=true" target="_blank">http://jppucm.kyotu.pnet.yusei.go.jp/idc/idcplg?IdcService=COLLECTION_DISPLAY&dCollectionID=163615&hasCollectionID=true </a></div>
		</div>

		<div id="window_B">
		    <div class="topB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_top.gif" width="536" height="6" alt="" /></div>
	    	<div class="inB">
				<form action="${authURL}" method="post" id="loginForm" name="loginForm">
				<p class="wtitle">ログインしてください。</p>
				<div class="bodr_B"></div>
				<g:if test="${flash.message}">
				<div class="login_message">${flash.message?.encodeAsHTML()}</div>
				</g:if>

				<ul>
					<li class="size12 w100 align_right"><strong>ID</strong></li>
					<li class="m0a mL10"><input type="text" class="w150" name="username" id="username" />
					<input type="hidden" class="w150" name="j_username" id="j_username" />   <span class="size10">(半角英数字)</span><br />
					</li>
				</ul>
				<div class="clearboth"></div>
				<ul>
					<li class="size12 w100 align_right "><strong>パスワード</strong></li>
					<li class="m0a mL10"><input type="password" class="w100" name="j_password" id="j_password" maxlength="16" />   <span class="size10">(半角英数字8～16文字)</span></li>
				</ul>
				<div class="clearboth"></div>

				<div class="align_center mB15 mT10">
					<input type="image" id="loginBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_login-off.gif" alt="ログイン" />
				</div>

				<div class="btomB"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_btom.gif" width="536" height="5" alt="" /></div>
				</form>
			</div>
		</div>
	</div>

<g:form method="get" controller="mainMenu" action="index" name="topForm" />
<r:script>
;jQuery(function(){
$('#username').blur(function() {
$("#j_username").val("admin_" + $("#username").val());
});
$("#j_username").focus();
$("#loginBtn").click(function() {
	$("#j_username").val("admin_" + $("#username").val());
	document.loginForm.submit();
	return false;
});
});</r:script>
</body>
</html>
