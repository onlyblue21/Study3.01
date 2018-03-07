<html>
<head>
	<meta name="layout" content="main" />
	<title>枚数を入力する</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>枚数を入力する<span>枚数を入力してください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSin">
					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_maisuu.gif" width="143" height="30" alt="枚数を入力する" /></h3>
					<div class="sentakuArea02">
						<g:form action="selectQuantity" id="${params.id}" name="nextForm">

<g:if test="${type4}">
						<div class="floatleft">
							<input class="mySpecSelect02" id="sheetCount" name="sheetCount" type="text" value="${params.quantity ? (params.quantity / 4).encodeAsHTML() : ''}" />シート × 4 ＝ <span id="type4QuantityDisplay" class="bold">${params.quantity?.encodeAsHTML()}</span>枚
							<input type="hidden" id="type4Quantity" name="quantity" value="${params.quantity?.encodeAsHTML()}" />
						</div>
						<div class="floatright mT30 pR60">
							<span class="red2 size12 align_right">※あとで変更することができます。</span>
						</div>
</g:if>
<g:elseif test="${quantityTextType}">
						<input class="mySpecSelect02" id="quantity" name="quantity" type="text" value="${params.quantity?.encodeAsHTML()}" />
						枚　<span class="red2 size12">※あとで変更することができます。</span>
</g:elseif>
<g:else>
						<g:select class="mySpecSelect02" style="width:auto;height:auto;" name="quantity" from="${quantityInfoList}" value="${params.quantity}" optionKey="lotSize" optionValue="dispLotSize" noSelection="['':'枚数を選択']" />
						枚　<span class="red2 size12">※あとで変更することができます。</span>
</g:else>
						</g:form>
					</div>
					<div class="nouki">
						<div class="leftAreaB29">
<g:if test="${type4}">
							<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:(false ? 'b29_img.gif' : 'b29_img_nenga.gif'))}" alt="1シートあたりはがき4枚分です！" class="leftImg" />
</g:if>
<g:else>
							<h3 class="gaid">枚数について</h3>
</g:else>
						</div>

						<div class="rightArea">
							<p>商品によって、お選びいただける枚数が変わります。</p>

							<p style="width:580px;">年賀はがき（DM・あいさつ状）・年賀タウンメール・オリジナル年賀はがき・、<br />
								かもめ～る（DM・あいさつ状）・かもめタウン・オリジナルかもめ～る・郵便はがき・喪中はがきは、 <br />
								最低40枚から、1枚単位で30,000枚までお申込みいただけます。<br />
								<br />
								私製はがき・タウンプラス・封入チラシ（はがきサイズ）は、 <br />
								100枚、250枚、500枚、1,000枚、1,500枚、2,000枚、3,000枚、4,000枚、 <br />
								5,000枚、10,000枚、以降10,000枚単位で30,000枚までお申込みいただけます。<br />
								<br />
								封入チラシ（はがきサイズを除く）は、 <br />
								1,000枚、2,000枚、3,000枚、4,000枚、5,000枚、10,000枚、 <br />
								以降10,000枚単位で30,000枚までお申込みいただけます。</p>

							<table class="hyouH" style="width:580px;" width="0" border="0" cellspacing="0" cellpadding="0">
								<tr class="midT">
									<th scope="col">&nbsp;</th>
									<th scope="col" width="60" style="text-align:left;">最小枚数</th>
									<th scope="col" width="70" style="text-align:left;">最大枚数</th>
								</tr>
								<tr>
									<th class="kmid align_left" scope="row">年賀はがき(DM・あいさつ状)・年賀タウンメール・オリジナル年賀はがき・<br />
										かもめ～る（DM・あいさつ状）・かもめタウン・オリジナルかもめ～る<br />
										郵便はがき・喪中はがき</th>
									<td class="bodDot align_left">40枚</td>
									<td class="bodDot align_left">30,000枚</td>
								</tr>
								<tr>
									<th class="kmid align_left" scope="row">私製はがき・タウンプラス・封入チラシ（はがきサイズ）</th>
									<td class="bodDo align_leftt">100枚</td>
									<td class="bodDot align_left">30,000枚</td>
								</tr>
								<tr>
									<th class="kmid align_left" scope="row">封入チラシ（はがきサイズを除く）</th>
									<td class="bodDo align_leftt">1,000枚</td>
									<td class="bodDot align_left">30,000枚</td>
								</tr>
							</table>
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
	return enable;
};
var gQuantityInfoList = Array();
<g:each in="${quantityInfoList}" status="i" var="quantityInfo">gQuantityInfoList.push({minQuantity:${quantityInfo.minQuantity},maxQuantity:${quantityInfo.maxQuantity},lotSize:${quantityInfo.lotSize}});</g:each>
var selectQuantityInfo = function(quantity) {
	if (!gQuantityInfoList || (gQuantityInfoList.length <= 0)) {
		return null;
	}
	var minQuantity = gQuantityInfoList[0].minQuantity;
	if ($.isNaN(minQuantity)) {
		minQuantity = 0;
	}
	if (quantity < minQuantity) {
		return null; // 最低枚数を満たしていない
	}
	var quantityInfo = null;
	for (var index = 0; index < gQuantityInfoList.length; index++) {
		var qinfo = gQuantityInfoList[index];
		if (quantity <= qinfo.maxQuantity) {
			quantityInfo = qinfo;
			break;
		}
	}
	if (!quantityInfo) {
		// 最後の設定の最大値が無指定、または、０の場合は無制限
		var lastInfo = gQuantityInfoList[gQuantityInfoList.length - 1];
		if ($.isNaN(lastInfo.maxQuantity) || (lastInfo.maxQuantity <= 0)) {
			quantityInfo = lastInfo;
		}
	}
	return quantityInfo;
};
<g:if test="${type4}">
var quantityHiddenForm = $("#type4Quantity");
var type4QuantityDisplaySpan = $("#type4QuantityDisplay");
var sheetCountInputForm = $("#sheetCount");
var getQuantityValue = function() {
	var value = sheetCountInputForm.val();
	if (!$.isNull(value) && !$.isNaN(value) && (/^\d+$/.test(value))) {
		value = value.replace(/^0+/, ''); // 先頭の0を削除
		value = parseInt(value);
		value *= 4; // 枚数に変換
	}
	return value;
};
var updateQuantity = function(value) {
	if (!$.isNull(value) && !$.isNaN(value)) {
		quantityHiddenForm.val(value.toString());
		type4QuantityDisplaySpan.text($.insertComma(value));
	}
};
var validateQuantity = function(value) {
	if ($.isNull(value)) {
		return false;
	}
	if ($.isNaN(value)) {
		$().toastmessage('showWarningToast', "シート数を指定してください。");
		return false;
	}
	var lotSize = 4; // 四面連刷：ロットサイズ4固定
	value = parseInt(value);
	var qinfo = selectQuantityInfo(value);
	if (qinfo) {
		lotSize = qinfo.lotSize;
	}
	var minQuantity = gQuantityInfoList[0].minQuantity;
	if ($.isNaN(minQuantity)) {
		minQuantity = 0;
	}
	if (value < minQuantity) {
		var message = $.validator.format("{0}以上のシート数を指定してください。", $.insertComma(minQuantity / lotSize));
		$().toastmessage('showWarningToast', message);
		return false;
	}
	var maxQuantity = gQuantityInfoList[gQuantityInfoList.length - 1].maxQuantity;
	if ((maxQuantity > 0) && (maxQuantity < value)) {
		var message = $.validator.format("{0}以下のシート数を指定してください。", $.insertComma(maxQuantity / lotSize));
		$().toastmessage('showWarningToast', message);
		return false;
	}
	if (!qinfo) {
		$().toastmessage('showErrorToast', "シート数指定情報を取得できませんでした。");
		return false;
	}
	return true;
};
sheetCountInputForm.blur(function() {
	var quantity = getQuantityValue();
	updateQuantity(quantity);
	enableNextBtn(validateQuantity(quantity));
	return true;
});
$("#nextForm").submit(function() {
	var quantity = getQuantityValue();
	updateQuantity(quantity);
	return enableNextBtn(validateQuantity(quantity));
});
updateQuantity(getQuantityValue());
</g:if>
<g:elseif test="${quantityTextType}">
var quantityInputForm = $("#quantity");
var getQuantityValue = function() {
	return quantityInputForm.val();
};
var validateQuantity = function(value) {
	if ($.isNull(value)) {
		return false;
	}
	if ($.isNaN(value) || !(/^\d+$/.test(value))) {
		$().toastmessage('showWarningToast', "枚数を指定してください。");
		return false;
	}
	value = value.replace(/^0+/, ''); // 先頭の0を削除
	value = parseInt(value);
	var minQuantity = gQuantityInfoList[0].minQuantity;
	if ($.isNaN(minQuantity)) {
		minQuantity = 0;
	}
	if (minQuantity < ${myAddressCount}) {
		minQuantity = ${myAddressCount};
	}
	if (value < minQuantity) {
		var message = $.validator.format("{0}枚以上の枚数を指定してください。", $.insertComma(minQuantity));
		$().toastmessage('showWarningToast', message);
		return false;
	}
	var maxQuantity = gQuantityInfoList[gQuantityInfoList.length - 1].maxQuantity;
	if ((maxQuantity > 0) && (maxQuantity < value)) {
		var message = $.validator.format("{0}枚以下の枚数を指定してください。", $.insertComma(maxQuantity));
		$().toastmessage('showWarningToast', message);
		return false;
	}
	var qinfo = selectQuantityInfo(value);
	if (!qinfo) {
		$().toastmessage('showErrorToast', "枚数指定情報を取得できませんでした。");
		return false;
	}
	var mod = value % qinfo.lotSize;
	if (mod != 0) {
		var message = $.validator.format("{0}枚単位にてご指定ください。", $.insertComma(qinfo.lotSize));
		$().toastmessage('showWarningToast', message);
		return false;
	}
	return true;
};
quantityInputForm.blur(function() {
	var value = $(this).val();
	enableNextBtn(validateQuantity(value));
	return true;
});
$("#nextForm").submit(function() {
	var quantity = getQuantityValue();
	return enableNextBtn(validateQuantity(quantity));
});
</g:elseif>
<g:else>
var quantityInputForm = $("#quantity");
var getQuantityValue = function() {
	return quantityInputForm.val();
};
var validateQuantity = function(value) {
	if ($.isNull(value)) {
		return false;
	}
	value = value.replace(/^0+/, ''); // 先頭の0を削除
	value = parseInt(value);
	if (value < ${myAddressCount}) {
		$().toastmessage('showWarningToast', "あて名リスト(${myAddressCount})以上の枚数を選択してください。");
		return false;
	}
	return true;
};
quantityInputForm.change(function() {
	var value = $(this).val();
	enableNextBtn(validateQuantity(value));
	return true;
});
</g:else>
nextBtn.click(function() {
	var quantity = getQuantityValue();
	if (validateQuantity(quantity)) {
		document.nextForm.submit();
	}
	return false;
});
<g:if test="${prevBtnEnabled}">
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
</g:if>
enableNextBtn(validateQuantity(getQuantityValue()));
});</r:script>
</body>
</html>
