<html>
<head>
	<meta name="layout" content="main" />
	<title>紙の種類を選ぶ</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>紙の種類を選ぶ<span>ご希望の紙の種類をお選びください。　※あとで変更することができます。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSin">
					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_kamisyurui.gif" width="143" height="30" alt="紙の種類を選ぶ" /></h3>
					<div class="sentakuArea">
						<g:form action="selectPaperType" id="${params.id}" name="nextForm">
							<g:select name="paperTypeId" class="mySpecSelect" from="${paperTypeList}" value="${params.paperTypeId}" optionKey="paperTypeId" optionValue="paperTypeName" noSelection="['':'選択してください']" />
						</g:form>
					</div>

					<div class="nouki02">
						<div class="leftArea">
							<h3 class="gaid">紙の種類について</h3>
						</div>

						<div class="rightArea">
							<h4>コート紙</h4>
							<p>両面に前後のコート剤を塗布している用紙です。<br />
							カラーの再現性も良く、ポスターやカタログ、雑誌のカラーページなどに幅広く使われています。</p>

							<h4>マットコート紙</h4>
							<p>表面処理によって光沢を抑えたコート紙です。<br />
							しっとりとした質感と輝くような白色に人気があり、カタログやポスター、書籍の本文などに使われています。</p>

							<h4>上質紙</h4>
							<p>印刷効果の高い新雪のような白色で、キメ細かい滑らかさは高級感にあふれています。<br />
							紙腰はしなやかで強靭。弾力性にも富む高品位な風合いの上質紙です。</p>
						</div>

						<div class="clear"></div>

						<div class="leftArea">
							<h3 class="gaid">紙の厚さについて</h3>
						</div>

						<div class="rightArea">
							<p>紙の厚さは、「原紙1,000枚分の重さが何㎏になるか」で表します。これを「連量」といいます。<br />
							同じ種類の紙なら、「連量」が多いほど厚いということになります。<br />
							厚さの目安として、コピー用紙は約55kg、通常はがきは約180kgになります。</p>
						</div>

						<div class="clear"></div>
					</div>   

					<div class="bgSbtm"></div>
				</div>
				<!-- bgSin END -->

			</div>  
			<!-- colorSen END -->  

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
<g:if test="${prevBtnEnabled}">
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
</g:if>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
					<img id="disabledNextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-disable.gif" alt="次へ進む" />
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:if test="${prevBtnEnabled}">
<g:form method="get" action="orderConfirm" id="${params.id}" name="prevForm">
<input type="hidden" name="prevFlg" value="true" />
</g:form>
</g:if>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var nextBtn = $("#nextBtn");
var disabledNextBtn = $("#disabledNextBtn");
var enableNextBtn = function(enable) {
	if (enable) {
		disabledNextBtn.hide();
		nextBtn.show();
	} else {
		nextBtn.hide();
		disabledNextBtn.show();
	}
	return false;
};
var paperTypeId = $("#paperTypeId");
paperTypeId.change(function() {
	var selected = $(this).val();
	enableNextBtn(!$.isNull(selected));
	return true;
});
nextBtn.click(function() {
	var selected = paperTypeId.val();
	if ($.isNull(selected)) {
		$().toastmessage('showWarningToast', "紙の種類を選択してください。");
		return false;
	}
	document.nextForm.submit();
	return false;
});
<g:if test="${prevBtnEnabled}">
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
</g:if>
enableNextBtn(!$.isNull(paperTypeId.val()));
});</r:script>
</body>
</html>
