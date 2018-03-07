<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>印刷会社メニュー</title>
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
					<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
					<td>付帯サービス管理画面を表示します</td>
				</tr>

<g:if test="${false}">
				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="printDeliveryBtn" class="button"><span class="nowrap">印刷発送管理</span></a></td>
					<td>印刷発送管理画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="salesRecordBtn" class="button"><span class="nowrap">売上管理</span></a></td>
					<td>売上管理画面を表示します</td>
				</tr>
</g:if>

			</tbody>
		</table>
	</div>

<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<g:form method="get" controller="manageServicing" action="list" name="manageServicingForm" />
<g:if test="${false}">
<form method="post" action="${salesRecordURL}" name="salesRecordForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
</g:if>
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
$("#servingBtn").click(function() {
	document.manageServicingForm.submit();
	return false;
});
<g:if test="${false}">
$("#printDeliveryBtn").click(function() {
	oiyAlert('未実装');
	return false;
});
$("#salesRecordBtn").click(function() {
	return relayLogin(document.salesRecordForm, '売上管理');
});
</g:if>
});</r:script>
</body>
</html>