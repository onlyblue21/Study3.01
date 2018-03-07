<html>
<head>
	<meta name="layout" content="main" />
	<title>ご注文一覧</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow w920">
			<h2>ご注文履歴<span>今までの注文履歴の一覧です。</span></h2>

			<div class="innnerBox1 w920 rirekiList">
				<h2 class="rirekiListTitle"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/rireki_title.gif" alt="注文履歴" /></h2>
				<div id="orderDetailListArea" class="innnerBox1in">

					<table cellpadding="0" cellspacing="0" class="listTable1 w890">
						<thead>
							<tr>
								<th width="100" class="align_center"><span>注文No.</span> <input type="image" class="btnDoff" id="orderNo_desc" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-off.gif" /><input type="image" class="btnUoff" id="orderNo_asc" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-off.gif" /></th>
								<th width="100" class="align_center"><span>注文日時</span> <input type="image" class="btnDoff" id="orderDate_desc" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-off.gif" /><input type="image" class="btnUoff" id="orderDate_asc" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-off.gif" /></th>
								<th width="280" class="align_center">デザイン名</th>
								<th width="55" class="align_center">詳細</th>
								<th width="120" class="align_center">アイテム</th>
								<th width="80" class="align_center">注文ｽﾃｰﾀｽ</th>
								<th width="90" class="align_center">校正</th>
								<th width="35" class="align_center">削除</th>
							</tr>
						</thead>
						<tbody id="orderDetailListBody" />
					</table>
					<div class="listTableHead" style="padding-bottom:7px; margin-bottom:10px; width:888px;">
<g:render template="/common/pagination/mypagination" />
					</div>

					<div class="align_left">
						<table class="mL10 red2 size12">
							<tbody>
								<tr>
									<td class="valignT align_left">※</td>
									<td class="align_left">校正は、ロゴ印刷データ変換サービスと地図印刷データ作成サービスをご利用の際に行います。<br>
									印刷物に対する校正はいたしませんので、ご了承ください。</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="rirekiListBoxBottom"></div>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<div id="orderDeliveryStatusDialog" title="注文・配送状況" class="popBox" style="background-color:white; display:none;">
	<table cellpadding="0" cellspacing="0" class="listTable mB10" width="300">
		<tr>
			<th width="100" class="oya">進捗</th>
			<th class="oya">完了日時</th>
		</tr>
		<tr>
			<th class="align_right">注文申込日</th>
			<td class="align_left"><span id="orderDeliveryStatusDialogOrderDate"></span></td>
		</tr>
		<tr>
			<th class="align_right">注文確定日</th>
			<td class="align_left"><span id="orderDeliveryStatusDialogOrderFixedDate"></span></td>
		</tr>
		<tr>
			<th class="align_right">出荷日</th>
			<td class="align_left"><span id="orderDeliveryStatusDialogShippingDate"></span></td>
		</tr>
		<tr>
			<th class="align_right">伝票番号</th>
			<td class="align_left"><span id="orderDeliveryStatusDialogTrackingNumber"></span></td>
		</tr>
	</table>
	<div class="align_center clearboth mB10">
		<a href="javascript:void(0)" id="orderDeliveryStatusDialogCloseBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_tojiruB2.gif" width="112" height="33" alt="閉じる" /></a>
	</div>
</div>

<div id="myProductRenameDialog" title="デザイン名" class="popBox" style="background-color:white; display:none;">
	<strong>デザイン名</strong>を指定してください。
	<input type="text" id="myProductRename" name="myProductRename" class="w500" maxlength="128" value="" />
</div>
<g:form method="get" controller="servicingReview" action="review" name="reviewForm">
<input type="hidden" name="id" value="" />
</g:form>
<g:render template="/common/fragment/orderDetailDialog" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${r.resource(dir:'static/dmol/js',file:'orderDetailDialog.js')}"></script>
<r:script>
;jQuery(function(){
// ご注文一覧
var orderDeliveryStatusDialog = $("#orderDeliveryStatusDialog").dialog({
	modal:true,
	resizable: false,
	autoOpen: false,
	width: 400,
	height: 300,
	overley: { backGroundColor:'#000', opacity:0.5 }
});
$("#orderDeliveryStatusDialogCloseBtn", orderDeliveryStatusDialog).click(function() {
	orderDeliveryStatusDialog.dialog('close');
	return false;
});
var showOrderDeliveryStatusDialog = function(orderDetail) {
	$("#orderDeliveryStatusDialogOrderDate", orderDeliveryStatusDialog).text($.nvlW(orderDetail.orderInfo.orderDate));
	$("#orderDeliveryStatusDialogOrderFixedDate", orderDeliveryStatusDialog).text($.nvlW(orderDetail.orderFixedDate));
	$("#orderDeliveryStatusDialogShippingDate", orderDeliveryStatusDialog).text($.nvlW(orderDetail.shippingDate));
	var orderDeliveryStatusDialogTrackingNumber = $("#orderDeliveryStatusDialogTrackingNumber", orderDeliveryStatusDialog);
	orderDeliveryStatusDialogTrackingNumber.empty();
	if (!$.isNull(orderDetail.trackingNumber)) {
		var url = 'http://tracking.post.japanpost.jp/service/singleSearch.do?searchKind=S002&locale=ja&reqCodeNo1=' + orderDetail.trackingNumber;
		var tlink = $('<a></a>').text(orderDetail.trackingNumber).attr('href', url).attr('target', '_blank');
		orderDeliveryStatusDialogTrackingNumber.append(tlink);
	}
	orderDeliveryStatusDialog.dialog('open');
	return false;
};
orderDetailListFunc = new listFunc("orderDetailListFunc", 10, "${oparams.sort?.encodeAsHTML()}", "${oparams.order?.encodeAsHTML()}");
var updateOrderDetailList = function(offset) {
	if (!$.isNaN(offset)) {
		orderDetailListFunc.offset = offset;
	}
	if (orderDetailListFunc.offset < 0) {
		orderDetailListFunc.offset = 0;
	}
	$("input:image.btnDoff", orderDetailListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-off.gif");
	$("input:image.btnUoff", orderDetailListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-off.gif");
	$("input:image.btnDon", orderDetailListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-on.gif");
	$("input:image.btnUon", orderDetailListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-on.gif");
	var pparams = orderDetailListFunc.getPageSortParam(null);
	var sparams = {};
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
				var orderDetailListBody = $("#orderDetailListBody");
				orderDetailListBody.empty();
				var orderDetailList = data.list;
				if (orderDetailList && (orderDetailList.length > 0)) {
					var td0Attr = { style:"vertical-align:middle;" };
					var td1Attr = { style:"vertical-align:middle;" };
					var td2Attr = { style:"vertical-align:middle;" };
					var td3Attr = { style:"vertical-align:middle;" };
					var td4Attr = { style:"vertical-align:middle;" };
					var td5Attr = { style:"vertical-align:middle;" };
					var td6Attr = { style:"vertical-align:middle;" };
					var td7Attr = { style:"vertical-align:middle;" };
					for (var index = 0; index < orderDetailList.length; index++) {
						var tr = $('<tr />');
						var orderDetail = orderDetailList[index];
						var orderInfo = orderDetail.orderInfo;
						var isServicingOrder = orderDetail.isServicingOrder;
						if (orderDetail.rowspan > 0) {
							var td0 = $('<td />', td0Attr).addClass('align_center').text($.nvlW(orderInfo.orderNo));
							var td1 = $('<td />', td1Attr).addClass('align_center').text($.nvlW(orderInfo.orderDate));
							if (orderDetail.rowspan > 1) {
								td0.attr('rowspan', orderDetail.rowspan);
								td1.attr('rowspan', orderDetail.rowspan);
							}
							tr.append(td0).append(td1);
						}
						var td2 = $('<td />', td2Attr).addClass('align_left').text($.nvlW(orderDetail.designName));
						var td3 = $('<td />', td3Attr).addClass('align_center');
						if (isServicingOrder) {
							td3.text('-');
						} else {
							var detailBtn = $('<input type="image" alt="詳細" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_shousai_s.gif").addClass('orderDetailDetailBtn').data(orderDetail);
							td3.append(detailBtn);
						}
						var td4 = $('<td />', td4Attr).addClass('align_left').text($.nvlW(orderDetail.itemName));
						var statusBtn = $('<a href="javascript:void(0)"></a>').addClass('orderStatusBtn').text($.nvlW(orderDetail.orderStatusDispString)).data(orderDetail);
						var td5 = $('<td />', td5Attr).addClass('align_center').append(statusBtn);
						var td6 = $('<td />', td6Attr).addClass('align_center');
						if (isServicingOrder) {
							if (orderDetail.reviewStatusString == '-') {
								td6.text(orderDetail.reviewStatusString);
							} else {
								var reviewBtn = $('<a href="javascript:void(0)"></a>').addClass('reviewBtn').text($.nvlW(orderDetail.reviewStatusString)).data(orderDetail);
								td6.append(reviewBtn);
							}
						} else {
							td6.text(' ');
						}
						var td7 = $('<td />', td7Attr).addClass('align_center');
						if (orderDetail.deletable) {
							var deleteBtn = $('<input type="image" alt="削除" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_del.gif").addClass('orderDetailDeleteBtn').data(orderDetail);
							td7.append(deleteBtn);
						} else {
							td7.text(' ');
						}
						tr.append(td2).append(td3).append(td4).append(td5).append(td6).append(td7);
						orderDetailListBody.append(tr);
					}
					$(".orderDetailDetailBtn", orderDetailListBody).click(function() {
						var orderDetail = $(this).data();
						return showOrderDetailDialog(orderDetail, null, showOrderDeliveryStatusDialog);
					});
					$(".orderStatusBtn", orderDetailListBody).click(function() {
						var orderDetail = $(this).data();
						return showOrderDeliveryStatusDialog(orderDetail);
					});
					$(".reviewBtn", orderDetailListBody).click(function() {
						var orderDetail = $(this).data();
						document.reviewForm.id.value = orderDetail.id;
						document.reviewForm.submit();
						return false;
					});
					$(".orderDetailDeleteBtn", orderDetailListBody).click(function() {
						var orderDetail = $(this).data();
						return deleteOrderDetail(orderDetail);
					});
					$("tr", orderDetailListBody).evenodd();
				} else {
					var td = $('<td />', { colspan:8, style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					orderDetailListBody.append(tr);
				}

			} else {
				orderDetailListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "ご注文一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var deleteOrderDetail = function(orderDetail) {
	var detailName = orderDetail.myProductName;
	if (orderDetail.serviceDivision == ${jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail.SERVICE_DIVISION_FUTAI}) {
		detailName = orderDetail.futaiServiceName;
	}
	return oiyConfirm('注文明細[' + $.nvl(detailName) + ']を削除しますか？', function() {
		pleaseWait();
		var rparams = { id:orderDetail.id };
		$.ajax({
			url: "${createLink(controller:'myPage', action:'removeOrderDetail')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "注文明細[" + orderDetail.myProductName + "]を削除しました。");
					// リストの再表示
					updateOrderDetailList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "注文明細[" + orderDetail.myProductName + "]を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
	return false;
};
orderDetailListFunc.initList($("#orderDetailListArea"));
orderDetailListFunc.addEventListner(updateOrderDetailList, updateOrderDetailList);
updateOrderDetailList(${oparams.offset});
});</r:script>
</body>
</html>