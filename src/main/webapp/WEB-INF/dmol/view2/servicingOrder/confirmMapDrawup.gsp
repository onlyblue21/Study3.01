<html>
<head>
	<meta name="layout" content="main" />
	<title>地図印刷データ作成サービス</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>地図印刷データ作成サービス</h1>

<!-- commonContents -->
		<div class="commonContents">

<g:render template="/common/fragment/flashmessages" />

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w180">サービス名</th>
				<td>地図印刷データ作成サービス</td>
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
				<th>地図のデザイン</th>
				<td>
					${params.mapDesignType?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>目的地名称</th>
				<td>
					${params.destinationName?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>目的地住所</th>
				<td>
					${params.destinationAddress?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>目印１</th>
				<td>
					${params.landmark1?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>目印２</th>
				<td>
					${params.landmark2?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>目印３</th>
				<td>
					${params.landmark3?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>目印４</th>
				<td>
					${params.landmark4?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>目印５</th>
				<td>
					${params.landmark5?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>目印６</th>
				<td>
					${params.landmark6?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>マップエリア</th>
				<td>
					およそ半径${params.areaType?.encodeAsHTML()}のエリア
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

<g:form action="confirmMapDrawupKiyaku" name="editMapDrawupForm">
<input type="hidden" name="mapDesignType" value="${params.mapDesignType?.encodeAsHTML()}" />
<input type="hidden" name="destinationName" value="${params.destinationName?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddress" value="${params.destinationAddress?.encodeAsHTML()}" />
<input type="hidden" name="landmark1" value="${params.landmark1?.encodeAsHTML()}" />
<input type="hidden" name="landmark2" value="${params.landmark2?.encodeAsHTML()}" />
<input type="hidden" name="landmark3" value="${params.landmark3?.encodeAsHTML()}" />
<input type="hidden" name="landmark4" value="${params.landmark4?.encodeAsHTML()}" />
<input type="hidden" name="landmark5" value="${params.landmark5?.encodeAsHTML()}" />
<input type="hidden" name="landmark6" value="${params.landmark6?.encodeAsHTML()}" />
<input type="hidden" name="areaType" value="${params.areaType?.encodeAsHTML()}" />
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
		mapDesignType	: document.editMapDrawupForm.mapDesignType.value,
		destinationName	: document.editMapDrawupForm.destinationName.value,
		destinationAddress	: document.editMapDrawupForm.destinationAddress.value,
		landmark1		: document.editMapDrawupForm.landmark1.value,
		landmark2		: document.editMapDrawupForm.landmark2.value,
		landmark3		: document.editMapDrawupForm.landmark3.value,
		landmark4		: document.editMapDrawupForm.landmark4.value,
		landmark5		: document.editMapDrawupForm.landmark5.value,
		landmark6		: document.editMapDrawupForm.landmark6.value,
		areaType		: document.editMapDrawupForm.areaType.value,
		orderMessage	: document.editMapDrawupForm.orderMessage.value
	};
	$.ajax({
		url: "${createLink(action:'createOrderByMapDrawup')}",
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
	document.editMapDrawupForm.submit();
	return false;
});
});</r:script>
</body>
</html>