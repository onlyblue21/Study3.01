<html>
<head>
	<meta name="layout" content="main" />
	<title>あて名を登録する</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>オプションサービスを選ぶ<span>オプションサービスをお選びください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSinB">

					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_option.gif" alt="オプションサービスを選ぶ" /></h3>
					<div class="opRightTxt">※あとで変更することができます。</div>
					<div class="clear"></div>

<g:if test="${optionAdressPrintType == 'offset'}">
<g:set var="titleImage" value="option_img_shisei.gif" />
<g:set var="itemsPerLine" value="${2}" />
<g:set var="fontListAreaClass" value="atenaShisei" /><g:set var="paddingLeft" value="pL40" /><g:set var="paddingRight" value="pR40" />
<g:set var="optionAddressPrintServiceInfoList" value="${[[id:'1009', labelClass:'atena2'], [id:'1011', labelClass:'atena1']]}" />
</g:if><g:elseif test="${optionAdressPrintType == 'a4postcard'}">
<g:set var="titleImage" value="option_img_a4.gif" />
<g:set var="itemsPerLine" value="${2}" />
<g:set var="fontListAreaClass" value="atenaA4" /><g:set var="paddingLeft" value="pL20" /><g:set var="paddingRight" value="pR20" />
<g:set var="optionAddressPrintServiceInfoList" value="${[[id:'3064', labelClass:'atena2'], [id:'3066', labelClass:'atena1'], [id:'3067', labelClass:'atena5'], [id:'3065', labelClass:'atena6']]}" />
</g:elseif><g:else>
<g:set var="titleImage" value="option_img1.gif" />
<g:set var="itemsPerLine" value="${4}" />
<g:set var="fontListAreaClass" value="" /><g:set var="paddingLeft" value="pL20" /><g:set var="paddingRight" value="pR20" />
<g:set var="optionAddressPrintServiceInfoList" value="${[[id:'1006', labelClass:'atena5'], [id:'1008', labelClass:'atena6'], [id:'1002', labelClass:'atena3'], [id:'1004', labelClass:'atena4'], [id:'1010', labelClass:'atena2'], [id:'1012', labelClass:'atena1']]}" />
</g:else>
<g:set var="endOffset" value="${itemsPerLine - 1}" />
					<div class="optionBox">
						<div class="boxTop"></div>
						<div class="boxMid">
							<div class="boxLeft">
								<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:titleImage)}" alt="あて名印字" />
							</div>
							<div class="boxRight pT20">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="pR15">
											<label for="optionAddressPrintNone"><input type="radio" name="optionAddressPrintUsage" id="optionAddressPrintNone" ${!params.optionAddressPrint ? 'checked="checked" ' : ''}/><span class="valignM size16">利用しない</span></label>
										</td>
										<td>
											<label for="optionAddressPrintUse"><input type="radio" name="optionAddressPrintUsage" id="optionAddressPrintUse" ${params.optionAddressPrint ? 'checked="checked" ' : ''}/><span class="valignM size16">利用する</span></label>
										</td>
									</tr>
								</table>
							</div>
							<div class="boxRight pT10">
								<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/txt_atena.gif" alt="あて名リストを選ぶ" />
								<table cellpadding="0" cellspacing="0" class="optionTable mB15" width="100%">
									<tr>
										<td>
											<div class="floatleft mR15">
												<g:select name="myAddressListId" from="${addressList}" value="${params.myAddressListId}" optionKey="id" optionValue="name" noSelection="['':'あて名リストを選択']" />
											</div>
											<div class="floatleft align_left borderL pL10">
												<g:link controller="myAddressList" action="index"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_atenalist_new.gif" alt="あて名リスト登録" /></g:link>
												<p class="size12">あて名リストを登録する方はこちら</p>
											</div>
										</td>
									</tr>
								</table>
								<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/txt_atena2.gif" alt="あて名の書体を選ぶ" />
								<table cellpadding="0" cellspacing="0" class="optionTable2 ${fontListAreaClass}" width="100%">
									<tr class="opSelect">
<g:set var="itemIndex" value="${0}" />
<g:each in="${optionAddressPrintServiceInfoList}" status="i" var="optionAddressPrintServiceInfo">
<g:set var="oapInfo" value="${optionAddressPrintMap[optionAddressPrintServiceInfo.id]}" />
<g:if test="${oapInfo}">
<g:set var="itemOffset" value="${itemIndex.mod(itemsPerLine)}" /><g:set var="itemIndex" value="${itemIndex + 1}" />
										<td class="${(itemOffset == 0) ? paddingLeft : ((itemOffset == endOffset) ? paddingRight : '')}">
											<label for="opE_${optionAddressPrintServiceInfo.id}" class="${optionAddressPrintServiceInfo.labelClass}"><input type="radio" name="optionAddressPrint" id="opE_${optionAddressPrintServiceInfo.id}" value="${oapInfo.optionServiceId?.encodeAsHTML()}" ${(params.optionAddressPrint == oapInfo.optionServiceId) ? 'checked="checked" ' : ''}/></label>
										</td>
<g:if test="${(itemOffset == endOffset) && (itemIndex < optionAddressPrintServiceInfoList.size())}">
									</tr><tr class="opSelect">
</g:if>
</g:if>
</g:each>
<g:if test="${itemOffset < endOffset}">
<g:each in="${((itemOffset + 1)..endOffset)}">
										<td>&nbsp;</td>
</g:each>
</g:if>
									</tr>
								</table>
							</div>
						</div>
						<div class="boxBot"></div>
					</div>

<g:if test="${optionInfo.optionSendList}">
					<div class="optionBox">
						<div class="boxTop"></div>
						<div class="boxMid">
							<div class="boxLeft">
								<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/option_img2.gif" alt="発送（差出）代行" />
							</div>
							<div class="boxRight pT20">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="pR15">
											<label for="optionSendNone"><input type="radio" name="optionSend" id="optionSendNone" ${!params.optionSend ? 'checked="checked" ' : '' }/><span class="valignM size16">利用しない</span></label>
										</td>
										<td>
											<label for="optionSendUse"><input type="radio" name="optionSend" id="optionSendUse" ${params.optionSend ? 'checked="checked" ' : '' }/><span class="valignM size16">利用する</span></label>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="boxBot"></div>
					</div>
</g:if>

					<div class="w740">
						<h4 class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/option_h4_01.gif" alt="あて名印字サービス（別途料金がかかります）" /></h4>
						<div class="pL30 mB20">
							<p class="mB10">
								<span class="valignM">あて名面に、あて名を印字するサービスです。事前に、あて名リストの登録が必要です。</span>
								<g:link controller="myAddressList" action="index"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_atenalist_new.gif" alt="あて名リスト登録" /></g:link>
							</p>
							<p class="mB10"><a href="https://dmfactory.biz.post.japanpost.jp/about/atena.html" class="listBlue" target="_blank">あて名印字サービスの詳しい説明・印字レイアウトはこちら</a></p>
		
							<p class="size12">
								※ 私製はがきを選択した場合は、横書きタイプの印字のみご利用いただけます。
							</p>
						</div>

						<h4 class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/option_h4_02.gif" alt="発送（差出）代行サービス（別途料金がかかります）" /></h4>
						<div class="pL30 mB30">
							<p class="mB10">
								印刷されたDM・はがきを、あて名登録した受取人様へ直接発送するサービスです。
							</p>
							<p class="mB10">
								<a href="https://dmfactory.biz.post.japanpost.jp/about/daikou.html" class="listBlue" target="_blank">発送（差出）代行サービスの詳しい説明はこちら</a>
							</p>
							<p class="size12">
								※あて名印字サービスへのお申込みが前提条件です。<br />
								※伏見郵便局（〒612-8799）からの発送となります。
							</p>
						</div>
					</div>

					<div class="bgSbtm"></div>
				</div>
				<!-- bgSinB END -->

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
					<a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
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
<g:form method="post" action="selectAddressPrintOption" id="${params.id}" name="nextForm">
<input type="hidden" name="optionAddressPrint" value="" />
<input type="hidden" name="myAddressListId" value="" />
<input type="hidden" name="optionSend" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var enableAddressPrintSelection = function(enable) {
	$("#myAddressListId,input:radio[name='optionAddressPrint'],input:radio[name='optionSend']").setDisabled(!enable);
	return false;
};
var addressPrintSelected = function() {
	return $("#optionAddressPrintUse").isChecked();
};
$("input:radio[name='optionAddressPrintUsage']").click(function() {
	enableAddressPrintSelection(addressPrintSelected());
	return true;
});
enableAddressPrintSelection(addressPrintSelected());
$("#nextBtn").click(function() {
	if (addressPrintSelected()) {
		var optionAddressPrint = $("input:radio[name='optionAddressPrint']:checked").val();
		var myAddressListId = $("#myAddressListId").val();
		var optionSend = '';
<g:if test="${optionInfo.optionSendList}">
		if ($("#optionSendUse").isChecked()) {
			optionSend = "${optionInfo.optionSendList.getAt(0).optionServiceId?.encodeAsHTML()}";
		}
</g:if>
		if ($.isNull(myAddressListId)) {
			$().toastmessage('showWarningToast', "あて名リストを選択してください。");
			return false;
		}
		if ($.isNull(optionAddressPrint)) {
			$().toastmessage('showWarningToast', "あて名の書体を選択してください。");
			return false;
		}
		document.nextForm.optionAddressPrint.value = optionAddressPrint;
		document.nextForm.myAddressListId.value = myAddressListId;
		document.nextForm.optionSend.value = optionSend;
	} else { // あて名印字を利用しない
		document.nextForm.optionAddressPrint.value = '';
		document.nextForm.myAddressListId.value = '';
		document.nextForm.optionSend.value = '';
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
});</r:script>
</body>
</html>
