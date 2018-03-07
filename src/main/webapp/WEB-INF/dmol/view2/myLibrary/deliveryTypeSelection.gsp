<html>
<head>
	<meta name="layout" content="main" />
	<title>納期を選ぶ</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>納期を選ぶ<span>ご希望の納期をお選びください。　※あとで変更することができます。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSin">
					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_noukisentaku.gif" width="143" height="30" alt="納期を選ぶ" /></h3>
					<div class="sentakuArea">
						<g:form action="selectDeliveryType" id="${params.id}" name="nextForm">
							<g:select name="deliveryTypeId" class="mySpecSelect" from="${deliveryTypeList}" value="${params.deliveryTypeId}" optionKey="deliveryTypeId" optionValue="deliveryTypeName" noSelection="['':'選択してください']" />
						</g:form>
					</div>

					<div class="nouki">
						<div class="leftArea">
							<h3 class="gaid">納期について</h3>
						</div>
						<div class="rightArea">
							<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/img_gotyui.gif" width="558" height="92" alt="" /><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/img_kakuteibi.gif" width="558" height="266" alt="" />
						</div>
					</div>

					<div class="clear"></div>
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
<g:form method="get" action="${prevAction}" id="${params.id}" name="prevForm">
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
var deliveryTypeId = $("#deliveryTypeId");
deliveryTypeId.change(function() {
	var selected = $(this).val();
	enableNextBtn(!$.isNull(selected));
	return true;
});
nextBtn.click(function() {
	var selected = deliveryTypeId.val();
	if ($.isNull(selected)) {
		$().toastmessage('showWarningToast', "納期を選択してください。");
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
enableNextBtn(!$.isNull(deliveryTypeId.val()));
});</r:script>
</body>
</html>
