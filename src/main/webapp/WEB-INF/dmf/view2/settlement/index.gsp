<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="layout" content="main" />
	<title>決済方法選択</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header"/>
<g:form name="creditcardForm" action="creditcard" onsubmit="return false;">
</g:form>
<g:form name="bankForm" action="bank" onsubmit="return false;">
</g:form>
<g:form name="cashOnDeliveryForm" action="cashOnDelivery" onsubmit="return false;">
 <input type="hidden" name="orderNo" value="${orderNo?.encodeAsHTML()}" />
</g:form>
<g:form name="paymentOnInvoiceForm" action="paymentOnInvoice" onsubmit="return false;">
 <input type="hidden" name="orderNo" value="${orderNo?.encodeAsHTML()}" />
</g:form>
	<!-- breadcrumb -->
		<!--  <div class="breadcrumb bgGrad" style="margin-top: 2px;">
			<ul>
				<li><a href="javascript:toHome();">ホーム</a></li>
	      <li>決済方法選択</li>
			</ul>
		</div>-->

	<!-- /breadcrumb END -->
	<!-- mainBlock -->
		<div class="mainBlock">
			<h1>決済方法選択</h1>
	<!-- commonContents -->
			<div class="commonContents w664">
<g:if test="${isOK}">
			<img src="${resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_3.gif" class="mB20" />
			<h2>決済方法選択</h2>

			<p>決済方法を選択してください。</p>

			<p class="w500 m0a size12 mB10">
		<div class="kessaiChui">
			<h3>&lt;&lt;決済方法に関するご注意&gt;&gt;</h3>
			<strong>● 銀行振込について</strong><br />
			・銀行振込は、入金確認をもって受注確定となります。<br />
			　お急ぎの場合は、「クレジットカード決済」を選択してください。<br />
			・振込手数料は、お客さまにてご負担ください。<br />
			<span class="red2">・年賀はがきやかもめ～る等、販売期間が定められている商品をお求めの場合、<br />
			　販売終了日直前の一定期間は、銀行振込を選択できません。
			</span><br />
			<br />
			<strong>● 代金引換について</strong><br />
			・代金引換は、DMファクトリー会員のお客さまのみご利用いただけます。<br />
			・郵便はがき、年賀はがき、かもめ～る、喪中はがきをご注文の場合は、ご利用いただけません。<br />
			・ご利用金額の上限は、1注文あたり32,400円（税込）未満となります。<br />
			・1回のご注文につき、1種類の商品のみご注文いただけます。<br/>
			<br />
			<strong>● 請求書決済について</strong><br />
			・請求書決済は、DMファクトリー会員の法人のお客さまのみご利用いただけます。<br />
			・請求書は、決済代行会社（株式会社ネットプロテクションズ）よりメール添付にて発行します。<br />
			　（月末締め翌月末支払い　請求書発行：翌月2営業日）<br />
			・ご利用にあたって、決済代行会社（株式会社ネットプロテクションズ）による与信審査がございます。<br />
			・ご利用金額の上限は、月あたり300,000円（税込）までとなります。<br />
			・振込手数料は、お客さまにてご負担ください。<br />
			　下記URLを参照いただき、ご了承の上、お申込みください。<br/>
			　<a href="https://np-kakebarai.com/buy/"target="_blank">https://np-kakebarai.com/buy/</a><br /><br />
		</div>
			<table class="m0a w500">
			<tbody>
			<tr>
			<td class="w250 valignT">
				<input id="creditcardBtn" type="image" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_big1-off.gif" alt="クレジットカード決済" class="mB5" />
				<img src="${resource(dir:'/static/dmol/users/images/common', file:'bt')}/credit.gif"  height="34"  alt="クレジット"/><br />
				<div class="mB15">VISA・MasterCard・JCB・DinersClub</div>
			</td>
			<td class="w250 valignT">
				<!-- 第三期 2012/07/30 by LAC Start -->
				<g:if test="${isBankOK == true}">
				<input id="bankBtn" type="image" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_big2-off.gif" alt="銀行振込" />
				</g:if>
				<g:if test="${isBankOK == false}">
				<img style="padding: 1px;vertical-align: middle;" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_big2-disable.gif" />
				</g:if>
				<!-- 第三期 2012/07/30 by LAC End -->
			</td>
			</tr>
			<tr>
			<td class="w250 valignT">
				<g:if test="${isCashOnDeliveryOK == true}">
				<input type="image" id="cashOnDeliveryBtn" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_daibiki-off.gif" alt="代金引換" class="mB10" />
				</g:if>
				<g:if test="${isCashOnDeliveryOK == false}">
				<img style="padding: 1px;vertical-align: middle;" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_daibiki-disable.gif" class="mB10" />
				</g:if>
			</td>
			<td class="w250 valignT">
				<g:if test="${isPaymentOnInvoiceOK == true}">
				<input type="image" id="paymentOnInvoiceBtn" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_seikyu-off.gif" alt="請求書決済" />
				</g:if>
				<g:if test="${isPaymentOnInvoiceOK == false}">
				<img style="padding: 1px;vertical-align: middle;" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/bt_seikyu-disable.gif" />
				</g:if>
			</td>
			</tr>
			</tbody>
			</table>
			</div>
			<div class="btnArea mB15">
			</div>
			<div class="align_center">
				<a href="#" class="mR15" id="backBtn"><img src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/btn_modoru.gif" alt="戻る" /></a>
			</div>
</g:if>
<g:else>
<g:set var="errormessage" value="${flash.message ?: '注文データを取得できませんでした。'}" />
			<p class="size20 align_center red"><strong>${errormessage?.encodeAsHTML()}</strong></p>
</g:else>
	   </div>
	<!-- commonContents END -->
		</div>
	<!-- /mainBlock END -->
<g:form name="backForm" action="back" >
</g:form>
<g:form method="get" name="topForm" controller="mainMenu" action="index" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#creditcardBtn").click(function() {
	document.creditcardForm.submit();
	return false;
});
$("#bankBtn").click(function() {
	document.bankForm.submit();
	return false;
});
$("#cashOnDeliveryBtn").click(function() {
	document.cashOnDeliveryForm.submit();
	return false;
});
$("#paymentOnInvoiceBtn").click(function() {
	document.paymentOnInvoiceForm.submit();
	return false;
});
$("#backBtn").click(function() {
	var params = null;
	backBtn(params);
});
</jq:jquery>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'zipcode')}"></script>
</body>
</html>