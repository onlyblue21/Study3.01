<html>
<head>
	<meta name="layout" content="main" />
	<title>金額確認</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>金額を確認する<span>金額をご確認ください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSinB">

					<div class="dName">
						<span class="txt1">デザイン名：</span>
						<span class="title">${myLibrary.myLibraryName?.encodeAsHTML()}</span>
					</div>

					<div class="mB30">
						<table cellpadding="0" cellspacing="0" class="listTable3rd2 mB20" width="725">
							<thead>
								<th colspan="2">
									<div class="floatleft">印刷料金</div>
									<div class="floatright"><g:formatNumber format="###,###" number="${productInfo.printAmount}" />円<span class="size12 fontN">（税込）</span></div>
									<div class="clear"></div>
								</th>
							</thead>
							<tbody>
								<tr>
									<td class="align_left bg" width="110">商品</td>
									<td class="align_left">${dispnames.genreName?.encodeAsHTML()}</td>
								</tr>
								<tr>
									<td class="align_left bg">サイズ</td>
									<td class="align_left">${dispnames.paperSizeName?.encodeAsHTML()}</td>
								</tr>
								<tr>
									<td class="align_left bg">カラー</td>
									<td class="align_left">${dispnames.colorTypeName?.encodeAsHTML()}</td>
								</tr>
								<tr>
									<td class="align_left bg">紙の種類</td>
									<td class="align_left">
										<g:if test="${paperTypeSelectable}"><g:link action="paperTypeSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link></g:if>
										<span>${dispnames.paperTypeName?.encodeAsHTML()}</span>
									</td>
								</tr>
								<tr>
									<td class="align_left bg">枚数</td>
									<td class="align_left">
<g:if test="${(optionAddressPrintSelectable || optionSendSelectable || optionFoldReprocessesSelectable) && !optionTownMailSendSelectable}">
										<g:link action="quantitySelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link>
</g:if>
										<span><g:formatNumber format="###,###" number="${specInfo.quantity}" />枚</span>
									</td>
								</tr>
								<tr>
									<td class="align_left bg">納期</td>
									<td class="align_left">
										<g:if test="${deliveryTypeSelectable}"><g:link action="deliveryTypeSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link></g:if>
										<span>${dispnames.deliveryTypeName?.encodeAsHTML()}</span>
									</td>
								</tr>
							</tbody>
						</table>

<g:if test="${productInfo.mailAmount > 0.0G}">
						<table cellpadding="0" cellspacing="0" class="listTable3rd2 mB20" width="725">
							<thead>
								<tr>
									<th>
										<div class="floatleft">郵便はがき代金</div>
										<div class="floatright"><g:formatNumber format="###,###" number="${productInfo.mailAmount}" />円<span class="size12 fontN">（税込）</span></div>
										<div class="clear"></div>
									</th>
								</tr>
							</thead>
						</table>
</g:if>
<g:if test="${optionSendSelectable && (productInfo.optionSendPostcardPrice > 0.0G)}">
						<table cellpadding="0" cellspacing="0" class="listTable3rd2 mB20" width="725">
							<thead>
								<tr>
									<th>
										<div class="floatleft">郵便料金相当料</div>
										<div class="floatright"><g:formatNumber format="###,###" number="${productInfo.optionSendPostcardPrice}" />円<span class="size12 fontN">（税込）</span></div>
										<div class="clear"></div>
									</th>
								</tr>
							</thead>
						</table>
</g:if>

<g:if test="${optionAddressPrintSelectable || optionFoldReprocessesSelectable || optionTownMailSendSelectable}">
						<table cellpadding="0" cellspacing="0" class="listTable3rd2 mB20" width="725">
							<thead>
								<tr>
									<th colspan="2">
										<div class="floatleft">オプション料金</div>
										<div class="floatright"><g:formatNumber format="###,###" number="${productInfo.optionAddressPrintPrice + productInfo.optionSendPrice + productInfo.optionFoldReprocessPrice + productInfo.optionTownMailSendPrice}" />円<span class="size12 fontN">（税込）</span></div>
										<div class="clear"></div>
									</th>
								</tr>
							</thead>
							<tbody>
<g:if test="${optionAddressPrintSelectable}">
								<tr>
									<td class="align_left bg" width="110">あて名印字</td>
									<td class="align_left">
										<g:link action="addressPrintOptionSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link>
										<span><g:if test="${specInfo.optionAddressPrint}">利用する</g:if><g:else>利用しない</g:else></span>
<g:if test="${specInfo.optionAddressPrint}">
										<div class="pT5">
											あて名リスト：${dispnames.myAddressListName?.encodeAsHTML()}（全<g:formatNumber format="###,###" number="${specInfo.optionAddressPrintQuantity}" />件）<br />
											あて名の書体：${dispnames.optionAddressPrintDispName?.encodeAsHTML()}
										</div>
</g:if>
									</td>
								</tr>
</g:if>
<g:if test="${optionSendSelectable}">
								<tr>
									<td class="align_left bg">発送（差出）代行</td>
									<td class="align_left">
										<g:link action="addressPrintOptionSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link>
										<span><g:if test="${specInfo.optionSend}">利用する</g:if><g:else>利用しない</g:else></span>
									</td>
								</tr>
</g:if>
<g:if test="${optionTownMailSendSelectable}">
								<tr>
									<td class="align_left bg" width="110">差出代行</td>
									<td class="align_left">
										<g:link action="townMailSendOptionSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link>
										<span><g:if test="${specInfo.optionTownMailSend}">利用する</g:if><g:else>利用しない</g:else></span>
									</td>
								</tr>
</g:if>
<g:if test="${optionFoldReprocessesSelectable}">
								<tr>
									<td class="align_left bg" width="110">折り加工</td>
									<td class="align_left">
										<g:link action="foldReprocessSelection" id="${myLibrary.id}" params="['prevFlg':true]"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henkou_s.gif" alt="変更" class="mR10" /></g:link>
										<span><g:if test="${specInfo.optionFoldReprocess}">利用する</g:if><g:else>利用しない</g:else></span>
<g:if test="${specInfo.optionFoldReprocess}">
										<div class="pT5">
											${dispnames.foldReprocessName?.encodeAsHTML()}
										</div>
</g:if>
									</td>
								</tr>
</g:if>
							</tbody>
						</table>
</g:if>

						<div class="total">
							<table cellpadding="0" cellspacing="0" class="goukeiTable">
<g:if test="${productInfo.discountReason}">
								<tr>
									<th>小計</th>
									<td><g:formatNumber format="###,###" number="${productInfo.totalAmount}" />円<span class="fontN size12">（税込）</span></td>
								</tr>
								<tr class="waribiki">
									<th>${productInfo.discountReason?.encodeAsHTML()}</th>
									<td><g:formatNumber format="###,###" number="${productInfo.discountedTotalAmount - productInfo.totalAmount}" />円<span class="fontN size12">（税込）</span></td>
								</tr>
</g:if>
								<tr class="goukei">
									<th>合計金額</th>
									<td><g:formatNumber format="###,###" number="${productInfo.discountedTotalAmount}" />円<span class="fontN size12">（税込）</span></td>
								</tr>
							</table>
						</div>
						<div class="clear"></div>
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
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:form method="post" action="addToCart" id="${params.id}" name="nextForm" />
<g:form method="get" action="${prevAction}" id="${params.id}" name="prevForm">
<input type="hidden" name="prevFlg" value="true" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	pleaseWait();
	document.nextForm.submit();
	return false;
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
