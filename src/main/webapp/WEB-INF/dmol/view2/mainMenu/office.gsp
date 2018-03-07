<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>事務局メニュー</title>
<style type="text/css">
<!--
table#menu tbody tr td {
	padding: 4px;
}
.leftcol {
	width: 14em;
}
-->
</style>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>メインメニュー</h1>

<g:render template="/common/fragment/flashmessages" />

		<table id="menu">
			<tbody>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="recievedOrderBtn" class="button"><span class="nowrap">受注管理</span></a></td>
					<td>受注管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="creditBtn" class="button"><span class="nowrap">クレジット管理</span></a></td>
					<td>クレジット管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="bankTransferBtn" class="button"><span class="nowrap">銀行振込管理</span></a></td>
					<td>銀行振込管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="cashOnDeliveryBtn" class="button"><span class="nowrap">代引き管理</span></a></td>
					<td>代引き管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="invoicePaymentBtn" class="button"><span class="nowrap">請求書払管理</span></a></td>
					<td>請求書払管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="reviewAdBtn" class="button"><span class="nowrap">広告審査</span></a></td>
					<td>広告審査画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="memberBtn" class="button"><span class="nowrap">会員管理</span></a></td>
					<td>会員管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="salesRecordBtn" class="button"><span class="nowrap">売上管理</span></a></td>
					<td>売上管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
					<td>付帯サービス管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="outputOrderInfoBtn" class="button"><span class="nowrap">OrderInfo出力</span></a></td>
					<td>OrderInfoデータのダウンロード画面に遷移します</td>
				</tr>

			</tbody>
		</table>
	</div>

<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${creditURL}" name="creditForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${bankTransferURL}" name="bankTransferForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${cashOnDeliveryURL}" name="cashOnDeliveryForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${invoicePaymentURL}" name="invoicePaymentForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${reviewAdURL}" name="reviewAdForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<g:form method="get" name="userForm" controller="user" action="list" />
<form method="post" action="${salesRecordURL}" name="salesRecordForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<g:form method="get" controller="manageServicing" action="list" name="manageServicingForm" />
<form method="post" action="${outputOrderInfoURL}" name="outputOrderInfoForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#menu tbody tr:visible").evenodd();
var relayLogin = function(form, title) {
	var params = null;
	$.post("${createLink(action:'settlementRelayInfo')}", params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				pleaseWait();
				form.relayUserId.value = result.relayUserId;
				form.dtime.value = result.dtime;
				form.clientId.value = result.clientId;
				form.submit();
				return false;
			} else if (result.message) {
				oiyAlert(result.message);
				return false;
			}
		}
		oiyAlert(title + '画面を表示することができませんでした。');
		return false;
	});
	return false;
};
$("#recievedOrderBtn").click(function() {
	return relayLogin(document.recievedOrderForm, '受注管理');
});
$("#creditBtn").click(function() {
	return relayLogin(document.creditForm, 'クレジット管理');
});
$("#bankTransferBtn").click(function() {
	return relayLogin(document.bankTransferForm, '銀行振込管理');
});
$("#cashOnDeliveryBtn").click(function() {
	return relayLogin(document.cashOnDeliveryForm, '代引き管理');
});
$("#invoicePaymentBtn").click(function() {
	return relayLogin(document.invoicePaymentForm, '請求書払管理');
});
$("#reviewAdBtn").click(function() {
	return relayLogin(document.reviewAdForm, '広告審査');
});
$("#memberBtn").click(function() {
	document.userForm.submit();
	return false;
});
$("#salesRecordBtn").click(function() {
	return relayLogin(document.salesRecordForm, '売上管理');
});
$("#servingBtn").click(function() {
	document.manageServicingForm.submit();
	return false;
});
$("#outputOrderInfoBtn").click(function() {
	return relayLogin(document.outputOrderInfoForm, 'OrderInfo出力');
});
});</r:script>
</body>
</html>