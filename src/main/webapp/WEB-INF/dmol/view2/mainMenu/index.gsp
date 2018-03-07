<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>メインメニュー</title>
<style type="text/css">
<!--
table#menu tbody tr td {
	padding: 4px;
}
.leftcol {
	width: 20em;
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
		<sec:ifAllGranted roles="AUTHORITY_JPMD_MANAGE_USER">
			<table id="menu">
				<tbody>
					<tr>
						<td class="leftcol"><g:link controller="itemGenre" action="list" class="button"><span class="nowrap">アイテム区分一覧</span></g:link></td>
						<td>アイテム区分一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="itemInfo" action="list" class="button"><span class="nowrap">アイテム一覧</span></g:link></td>
						<td>アイテム一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="updateItemInfo" action="index" class="button"><span class="nowrap">アイテムの更新</span></g:link></td>
						<td>アイテム（テンプレート）の有効期限などを更新します。</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="systemUser" action="list" class="button"><span class="nowrap">ユーザ一覧</span></g:link></td>
						<td>ユーザ一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="salesBranchMaster" action="index" class="button"><span class="nowrap">営業担当支店マスタ</span></g:link></td>
						<td>営業担当支店マスタメンテナンス画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="salesBranchZipcodeMaster" action="index" class="button"><span class="nowrap">担当エリアマスタ</span></g:link></td>
						<td>担当エリアマスタマスタメンテナンス画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="goodsInfo" action="list" class="button"><span class="nowrap">商品一覧</span></g:link></td>
						<td>商品一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="townMailDeliveryArea" action="bundle" class="button"><span class="nowrap">タウンメール配達地域のアップロード</span></g:link></td>
						<td>タウンメール配達地域を更新します。</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="providerInfo" action="list" class="button"><span class="nowrap">プロバイダ</span></g:link></td>
						<td>プロバイダメンテナンス画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="systemMaster" action="list" class="button"><span class="nowrap">システムマスタ一覧</span></g:link></td>
						<td>システムマスタ一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><g:link controller="loginState" action="list" class="button"><span class="nowrap">ログインユーザ一覧</span></g:link></td>
						<td>ログインユーザ一覧画面を表示します</td>
					</tr>
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
					<sec:ifAllGranted roles="AUTHORITY_MENU_USER_LIST">
						<tr>
							<td class="leftcol">
							<g:link controller="user" action="list" ellementId="memberBtn" class="button"><span class="nowrap">会員管理</span></g:link></td>
							<td>会員管理画面を表示します</td>
						</tr>
					</sec:ifAllGranted>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="salesRecordBtn" class="button"><span class="nowrap">売上管理</span></a></td>
						<td>売上管理画面を表示します</td>
					</tr>

					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
						<td>付帯サービス管理画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="orderInfoNewBtn" class="button"><span class="nowrap">OrderInfo出力</span></a></td>
						<td>OrderInfoデータのダウンロード画面に遷移します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="accountReceivableBtn" class="button"><span class="nowrap">売掛金残高一覧</span></a></td>
						<td>売掛金残高一覧画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="opLogSearchBtn" class="button"><span class="nowrap">操作ログ出力</span></a></td>
						<td>操作ログ出力画面に遷移します</td>
					</tr>
				</tbody>
			</table>
		</sec:ifAllGranted>
		<sec:ifAllGranted roles="AUTHORITY_JPMD_PERSONAL_DATA_USER">
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
					<sec:ifAllGranted roles="AUTHORITY_MENU_USER_LIST">
						<tr>
							<td class="leftcol">
							<g:link controller="user" action="list" ellementId="memberBtn" class="button"><span class="nowrap">会員管理</span></g:link></td>
							<td>会員管理画面を表示します</td>
						</tr>
					</sec:ifAllGranted>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="salesRecordBtn" class="button"><span class="nowrap">売上管理</span></a></td>
						<td>売上管理画面を表示します</td>
					</tr>

					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
						<td>付帯サービス管理画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="orderInfoNewBtn" class="button"><span class="nowrap">OrderInfo出力</span></a></td>
						<td>OrderInfoデータのダウンロード画面に遷移します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="accountReceivableBtn" class="button"><span class="nowrap">売掛金残高一覧</span></a></td>
						<td>売掛金残高一覧画面を表示します</td>
					</tr>
				</tbody>
			</table>
		</sec:ifAllGranted>
		<sec:ifAllGranted roles="AUTHORITY_JPMD_USER">
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
					<sec:ifAllGranted roles="AUTHORITY_MENU_USER_LIST">
						<tr>
							<td class="leftcol">
							<g:link controller="user" action="list" ellementId="memberBtn" class="button"><span class="nowrap">会員管理</span></g:link></td>
							<td>会員管理画面を表示します</td>
						</tr>
					</sec:ifAllGranted>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="salesRecordBtn" class="button"><span class="nowrap">売上管理</span></a></td>
						<td>売上管理画面を表示します</td>
					</tr>

					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
						<td>付帯サービス管理画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="orderInfoNewBtn" class="button"><span class="nowrap">OrderInfo出力</span></a></td>
						<td>OrderInfoデータのダウンロード画面に遷移します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="accountReceivableBtn" class="button"><span class="nowrap">売掛金残高一覧</span></a></td>
						<td>売掛金残高一覧画面を表示します</td>
					</tr>
				</tbody>
			</table>
		</sec:ifAllGranted>
		<sec:ifAllGranted roles="AUTHORITY_JPOST_USER">
			<table id="menu">
				<tbody>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="recievedOrderBtn" class="button"><span class="nowrap">受注管理</span></a></td>
						<td>受注管理画面を表示します</td>
					</tr>
					<sec:ifAllGranted roles="AUTHORITY_MENU_USER_LIST">
						<tr>
							<td class="leftcol"><g:link controller="user" action="list" ellementId="memberBtn" class="button"><span class="nowrap">会員管理</span></g:link></td>
							<td>会員管理画面を表示します</td>
						</tr>
					</sec:ifAllGranted>
					<tr>
						<td class="leftcol"><g:link controller="largeInstitutionalCustomer" action="list" class="button"><span class="nowrap">大口顧客</span></g:link></td>
						<td>大口顧客メンテナンス画面を表示します</td>
					</tr>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="performanceSummaryBtn" class="button"><span class="nowrap">実績集計</span></a></td>
						<td>実績集計画面を表示します</td>
					</tr>
				</tbody>
			</table>
		</sec:ifAllGranted>
		<sec:ifAllGranted roles="AUTHORITY_PRINT_USER">
			<table id="menu">
				<tbody>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="recievedOrderBtn" class="button"><span class="nowrap">受注管理</span></a></td>
						<td>受注管理画面を表示します</td>
					</tr>
					<sec:ifAllGranted roles="AUTHORITY_MENU_USER_LIST">
						<tr>
							<td class="leftcol">
							<g:link controller="user" action="list" ellementId="memberBtn" class="button"><span class="nowrap">会員管理</span></g:link></td>
							<td>会員管理画面を表示します</td>
						</tr>
					</sec:ifAllGranted>
					<tr>
						<td class="leftcol"><a href="javascript:void(0)" id="servingBtn" class="button"><span class="nowrap">付帯サービス管理</span></a></td>
						<td>付帯サービス管理画面を表示します</td>
					</tr>
				</tbody>
			</table>
		</sec:ifAllGranted>
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
<form method="post" action="${accountReceivableURL}" name="accountReceivableForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${opLogSearchURL}" name="opLogSearchForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<form method="post" action="${orderInfoNewURL}" name="orderInfoNewForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<g:form method="get" name="userForm" controller="user" action="list" />
<form method="post" action="${performanceSummaryURL}" name="performanceSummaryForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<g:form method="get" controller="manageServicing" action="list" name="manageServicingForm" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var passwdMsg = "${passwdDate}";
if(null != passwdMsg && "" != passwdMsg){
	oiyAlert(passwdMsg);
}
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
$("#accountReceivableBtn").click(function() {
	return relayLogin(document.accountReceivableForm, '売掛金残高一覧');
});
$("#orderInfoNewBtn").click(function() {
	return relayLogin(document.orderInfoNewForm, 'OrderInfo出力');
});
$("#opLogSearchBtn").click(function() {
	return relayLogin(document.opLogSearchForm, '操作ログ出力');
});
$("#performanceSummaryBtn").click(function() {
	return relayLogin(document.performanceSummaryForm, '実績集計');
});
$("#servingBtn").click(function() {
	document.manageServicingForm.submit();
	return false;
});
});</r:script>
</body>
</html>