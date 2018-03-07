<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>付帯サービス管理</title>
	<link rel="stylesheet" href="${r.resource(dir:'static/dmol/css',file:'common.css')}" />
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>付帯サービス管理</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>付帯サービス管理</h1>

<g:render template="/common/fragment/flashmessages" />

		<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
			<g:form method="get" action="list" name="searhCondition" onsubmit="return false;">
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.OrderInfo?.orderNo?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="conditionOrderNo" name="orderNo" value="${params.orderNo?.encodeAsHTML()}" size="40" maxlength="20" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">付帯サービス:</td>
						<td class="value">
							<input type="checkbox" id="conditionServicingTypeLogoTrace" name="conditionServicingType" value="logoTrace" />
							<label for="conditionServicingTypeLogoTrace" class="mR15">ロゴ印刷データ変換</label>
							<input type="checkbox" id="conditionServicingTypeMapDrawup" name="conditionServicingType" value="mapDrawup" />
							<label for="conditionServicingTypeMapDrawup">地図印刷データ作成</label>
						</td>
					</tr>

					<tr class="prop">
						<td colspan="2" style="text-align: center;">
							<div class="searchButtons">
								<button id="searchBtn">&nbsp;検索&nbsp;</button>
								<button id="clearSearchConditionBtn">&nbsp;クリア&nbsp;</button>
							</div>
						</td>
					</tr>

				</tbody>
			</table>
			</g:form>
		</div>

		<div id="listArea">
			<div class="bgGray" style="float:none; width:100%; height:34px;">
				<g:render template="/common/pagination/pagination" />
			</div>

			<div style="float:none; width:100%;">
				<table style="width:100%;">
					<thead>
						<tr class="odd">
							<th>注文No.</th>
							<th>明細No.</th>
							<th>サービス名</th>
							<th>注文ステータス</th>
							<th>校正１</th>
							<th>校正２</th>
							<th>素材登録</th>
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
							<th>代理校了</th>
</sec:ifAnyGranted>
						</tr>
					</thead>
					<tbody id="orderDetailTable">
					</tbody>
				</table>
			</div>
		</div>

	</div>

<form>
<input type="hidden" id="ccOrderNo" name="ccOrderNo" value="${params.orderNo?.encodeAsHTML()}" />
<input type="hidden" id="ccServicingTypes" name="ccServicingTypes" value="${params.servicingTypes?.encodeAsHTML()}" />
</form>
<g:form action="review" name="reviewForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
</g:form>
<g:form action="reviewComplete" name="reviewCompleteForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
<input type="hidden" name="servicingReviewLogId" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<g:javascript>var orderDetailListFunc = null;</g:javascript>
<r:script>
;jQuery(function(){
var searchOrderDetail = function() {
	$("#ccOrderNo").val($("#conditionOrderNo").val());
	var conditionServicingTypeList = [];
	$("input:checkbox[name='conditionServicingType']:checked").each(function(index, element) {
		conditionServicingTypeList.push($(this).val());
	});
	$("#ccServicingTypes").val(conditionServicingTypeList.join(','));
	updateOrderDetailList(0);
	return false;
};
$("#searchBtn").button().click(searchOrderDetail);
$("#clearSearchConditionBtn").button().click(function() {
	$("#conditionOrderNo").val('');
	$("input:checkbox[name='conditionServicingType']").setChecked(false);
	return false;
});
var showReviewDialog = function(orderDetail) {
	pleaseWait();
	document.reviewForm.id.value = orderDetail.id;
	document.reviewForm.submit();
	return false;
};
orderDetailListFunc = new listFunc("orderDetailListFunc", 10, "orderNo", "desc");
var updateOrderDetailList = function(offset) {
	if (!$.isNaN(offset)) {
		orderDetailListFunc.offset = offset;
	}
	if (orderDetailListFunc.offset < 0) {
		orderDetailListFunc.offset = 0;
	}
	var orderNo = $("#ccOrderNo").val();
	var servicingTypes = $("#ccServicingTypes").val();
	var pparams = orderDetailListFunc.getPageSortParam(null);
	var sparams = { orderNo:orderNo, servicingTypes:servicingTypes };
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listOrderDetail')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				orderDetailListFunc.updatePagination(data.totalCount, data.offset);
				var orderDetailTable = $("#orderDetailTable");
				orderDetailTable.empty();
				var orderDetailList = data.list;
				if (orderDetailList && (orderDetailList.length > 0)) {
					var td0Attr = { style:"text-align:center; vertical-align:middle; width:12em;" };
					var td1Attr = { style:"text-align:center; vertical-align:middle; width:5em;" };
					var td2Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					var td3Attr = { style:"text-align:center; vertical-align:middle; width:12em;" };
					var td4Attr = { style:"text-align:center; vertical-align:middle; width:12em;" };
					var td5Attr = { style:"text-align:center; vertical-align:middle; width:12em;" };
					var td6Attr = { style:"text-align:center; vertical-align:middle; width:12em;" };
					var td7Attr = { style:"text-align:center; vertical-align:middle; width:7em;" };
					for (var index = 0; index < orderDetailList.length; index++) {
						var orderDetail = orderDetailList[index];
						var servicingReviewLogList = orderDetail.servicingReviewLogList;
						var td0 = $('<td />', td0Attr).text(orderDetail.orderNo);
						var td1 = $('<td />', td1Attr).text(orderDetail.detailNo);
						var td2 = $('<td />', td2Attr).text(orderDetail.serviceName);
						var td3 = $('<td />', td3Attr).text(orderDetail.orderStatusDispString);
						var td4 = $('<td />', td4Attr);
						var td5 = $('<td />', td5Attr);
						var td6 = $('<td />', td6Attr);
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
						var td7 = $('<td />', td7Attr);
						var reviewCompleteBtn = null;
</sec:ifAnyGranted>
						var registMaterialBtn = null;
						if (servicingReviewLogList.length > 0) {
							var review1 = servicingReviewLogList[0];
							var review1Btn = null;
							switch (review1.reviewStatus) {
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_NONE}:
								review1Btn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('未登録').data(orderDetail);
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_WAIT}:
								review1Btn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('校正待ち').data(orderDetail);
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
								orderDetail.servicingReviewLogId = review1.id;
								reviewCompleteBtn = $('<button></button>').addClass('reviewCompleteBtn').text('代理校了').data(orderDetail);
</sec:ifAnyGranted>
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_ACCEPTED}:
								td4.text('校了');
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_REJECTED}:
								td4.text('戻し');
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_REVIEW_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録待ち').data(orderDetail);
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録済み').data(orderDetail);
								break;
							default:
								td4.text('不明');
								break;
							}
							if (review1Btn) {
								td4.append(review1Btn);
							}
						}
						if (servicingReviewLogList.length > 1) {
							var review2 = servicingReviewLogList[1];
							var review2Btn = null;
							switch (review2.reviewStatus) {
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_NONE}:
								review2Btn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('未登録').data(orderDetail);
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_WAIT}:
								review2Btn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('校正待ち').data(orderDetail);
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
								orderDetail.servicingReviewLogId = review2.id;
								reviewCompleteBtn = $('<button></button>').addClass('reviewCompleteBtn').text('代理校了').data(orderDetail);
</sec:ifAnyGranted>
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_ACCEPTED}:
								td5.text('校了');
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_REJECTED}:
								td5.text('戻し');
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_REVIEW_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録待ち').data(orderDetail);
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録済み').data(orderDetail);
								break;
							default:
								td5.text('不明');
								break;
							}
							if (review2Btn) {
								td5.append(review2Btn);
							}
						}
						if (servicingReviewLogList.length > 2) {
							var review3 = servicingReviewLogList[2];
							switch (review3.reviewStatus) {
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_REVIEW_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録待ち').data(orderDetail);
								break;
							case ${jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_COMPLETED}:
								registMaterialBtn = $('<a href="javascript:void(0)" ></a>').addClass('reviewBtn').text('登録済み').data(orderDetail);
								break;
							default:
								td6.text('不明');
								break;
							}
						}
						if (registMaterialBtn) {
							td6.append(registMaterialBtn);
						}
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
						if (reviewCompleteBtn) {
							td7.append(reviewCompleteBtn);
						}
</sec:ifAnyGranted>
						var tr = $('<tr />').append(td0).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6)<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">.append(td7)</sec:ifAnyGranted>;
						orderDetailTable.append(tr);
					}
					$("tr", orderDetailTable).evenodd();
					$(".reviewBtn", orderDetailTable).click(function() {
						var orderDetail = $(this).data();
						return showReviewDialog(orderDetail);
					});
<sec:ifAnyGranted roles="AUTHORITY_JPMD_MANAGE_USER, AUTHORITY_JPMD_PERSONAL_DATA_USER">
					$(".reviewCompleteBtn", orderDetailTable).button().click(function() {
						var orderDetail = $(this).data();
						var msg = "注文/明細No. " + orderDetail.orderNo + " / " + orderDetail.detailNo + " を代理校了しますか？";
						oiyConfirm(msg, function() {
							document.reviewCompleteForm.id.value = orderDetail.id;
							document.reviewCompleteForm.servicingReviewLogId.value = orderDetail.servicingReviewLogId;
							document.reviewCompleteForm.submit();
							return dalse;
						}, {width:440});
						return false;
					});
</sec:ifAnyGranted>
				} else {
					var td = $('<td />', { 'colspan':'7', style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					orderDetailTable.append(tr);
				}

			} else {
				orderDetailListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "付帯サービス一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var initialServicingTypes = $("#ccServicingTypes").val();
if (!$.isNull(initialServicingTypes)) {
	var initialServicingTypeList = initialServicingTypes.split(',');
	$("input:checkbox[name='conditionServicingType']").val(initialServicingTypeList);
}

orderDetailListFunc.initList();
orderDetailListFunc.addEventListner(updateOrderDetailList, updateOrderDetailList);
updateOrderDetailList();
});</r:script>
</body>
</html>
