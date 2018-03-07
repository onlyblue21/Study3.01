<html>
<head>
	<title>DM Factory.jp</title>
	<meta name="layout" content="main" />
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>用紙のサイズを選ぶ<span>ご希望の用紙のサイズをお選びください。</span></h2>

			<div class="contIn2">

				<dl>
					<dt><g:link action="selectPaperSize" params="[paperSizeId:'a3v']" class="selectPaperSizeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b_btn_a3-off.gif" width="229" height="151" alt="A3サイズ（420mm×297mm）" /></g:link></dt>
					<dd>寸法420mm×297mmのA3サイズです。</dd>
				</dl>

				<dl>
					<dt><g:link action="selectPaperSize" params="[paperSizeId:'a4v']" class="selectPaperSizeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b_btn_a4-off.gif" width="229" height="151" alt="A4サイズ（297mm×210mm）" /></g:link></dt>
					<dd>寸法297mm×210mmのA4サイズです。</dd>
				</dl>

				<dl>
					<dt><g:link action="selectPaperSize" params="[paperSizeId:'a5v']" class="selectPaperSizeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b_btn_a5-off.gif" width="229" height="151" alt="A5サイズ（210mm×148mm）" /></g:link></dt>
					<dd>寸法210mm×148mmのA5サイズです。</dd>
				</dl>

				<dl>
					<dt><g:link action="selectPaperSize" params="[paperSizeId:'postcard']" class="selectPaperSizeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b_btn_a6-off.gif" width="229" height="151" alt="A6サイズ（148mm×105mm）" /></g:link></dt>
					<dd>寸法148mm×100mmのはがきサイズです。</dd>
				</dl>

				<div class="clear"></div>
			</div>

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<form name="prevForm" action="${prevPath}"></form>
<r:script>
;jQuery(function(){
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
