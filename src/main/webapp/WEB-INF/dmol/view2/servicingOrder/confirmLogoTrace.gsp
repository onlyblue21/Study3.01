<html>
<head>
	<meta name="layout" content="main" />
	<title>ロゴ印刷データ変換サービス</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>ロゴ印刷データ変換サービス</h1>

<!-- commonContents -->
		<div class="commonContents">

<g:render template="/common/fragment/flashmessages" />

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w180">サービス名</th>
				<td>ロゴ印刷データ変換サービス</td>
			</tr>
			<tr>
				<th>料金（税込）</th>
				<td><g:formatNumber format="###,###" number="${price}" />円</td>
			</tr>
			<tr>
				<th>納品について</th>
				<td>
					お客さまの「過去に追加した画像」に登録します。<br />
					「過去に追加した画像」に登録された素材は、DMファクトリー上でのみ利用できます。
				</td>
			</tr>
			<tr>
				<th>出荷日について</th>
				<td>
					校正なしの場合：受注確定後、２週間程度<br />
					校正２回の場合：受注確定後、３週間程度<br />
					※校正は２回までです。
				</td>
			</tr>
			<tr>
				<th>入稿データ</th>
				<td>
					<g:link action="downloadLogoTrace" params="${[now:System.currentTimeMillis()]}">${filename?.encodeAsHTML()}</g:link>
				</td>
			</tr>
			<tr>
				<th>コメント</th>
				<td>
					<div class="w500 h125" style="overflow:auto;"><pre>${params.orderMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			</table>

			<p class="align_center">上記内容でよろしければ、注文に進んでください。</p>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="orderBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_order-off.gif" alt="注文" />
			</div>

		</div>
		<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form action="confirmLogoTraceKiyaku" name="confirmLogoTraceKiyakuForm">
<input type="hidden" name="orderMessage" value="${params.orderMessage?.encodeAsHTML()}" />
</g:form>
<form method="post" action="${settlementURL}" name="settlementForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
<input type="hidden" name="orderNo" value="" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#orderBtn").click(function() {
	var oparams = {
		orderMessage	: document.confirmLogoTraceKiyakuForm.orderMessage.value
	};
	$.ajax({
		url: "${createLink(action:'createOrderByLogoTrace')}",
		data: oparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				pleaseWait();
				document.settlementForm.relayUserId.value = data.relayUserId;
				document.settlementForm.dtime.value = data.dtime;
				document.settlementForm.clientId.value = data.clientId;
				document.settlementForm.orderNo.value = data.orderNo;
				document.settlementForm.submit();

			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "注文できませんでした。");
			}
			return false;
		}
	});
	return false;
});
$("#prevBtn").click(function() {
	document.confirmLogoTraceKiyakuForm.submit();
	return false;
});
});</r:script>
</body>
</html>