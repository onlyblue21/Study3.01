<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>JPOSTメニュー</title>
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

<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER_SALES_BRANCH">
				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="memberBtn" class="button"><span class="nowrap">会員管理</span></a></td>
					<td>会員管理画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_JPOST_HEAD_OFFICE">
					<tr>
						<td class="leftcol"><g:link controller="largeInstitutionalCustomer" action="list" class="button"><span class="nowrap">大口顧客</span></g:link></td>
						<td>大口顧客メンテナンス画面を表示します</td>
					</tr>
</sec:ifAllGranted>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="performanceSummaryBtn" class="button"><span class="nowrap">実績集計</span></a></td>
					<td>実績集計画面を表示します</td>
				</tr>

				<tr>
					<td class="leftcol"><a href="javascript:void(0)" id="recievedOrderBtn" class="button"><span class="nowrap">受注管理</span></a></td>
					<td>受注管理画面を表示します</td>
				</tr>

			</tbody>
		</table>
	</div>

<g:form method="get" name="userForm" controller="user" action="list" />
<form method="post" action="${performanceSummaryURL}" name="performanceSummaryForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
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
$("#memberBtn").click(function() {
	document.userForm.submit();
	return false;
});
$("#performanceSummaryBtn").click(function() {
	return relayLogin(document.performanceSummaryForm, '実績集計');
});
$("#recievedOrderBtn").click(function() {
	return relayLogin(document.recievedOrderForm, '受注管理');
});
});</r:script>
</body>
</html>