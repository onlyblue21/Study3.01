<html>
<head>
	<meta name="layout" content="main" />
	<title>注文</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>注文</h1>
		
<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_1.gif" alt="注文内容" class="mB20" />
			<h2>注文内容</h2>

<g:render template="/common/fragment/flashmessages" />

			<div id="myProductListBody"></div>

			<div class="kakuninBottom w650">	
				<table cellpadding="0" cellspacing="0" class="goukeiTable">
					<tr>
						<th>お支払い総額</th>
						<td class="black"><span id="orderTotalAmount">0</span>円<span class="fontN size12">（税込）</span></td>
					</tr>
				</table>
				<p class="align_right floatright clearboth size12 pT5">※送料は無料です。</p>
				<div class="clearboth"></div>
			</div>

			<div class="align_center">
				<g:link controller="myProduct" action="index" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/bt_back_cart.gif" alt="ショッピングカートに戻る" /></g:link>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" name="nextForm" action="editCustomerInfo" />
<g:form method="get" name="indexForm" controller="myProduct" action="index" />
<g:form controller="myProduct" action="productPreviewPdf" name="myProductPreviewForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
</g:form>
<g:render template="/common/fragment/myProductDetailDialog" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${r.resource(dir:'static/dmol/js',file:'myProductDetailDialog.js')}"></script>
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	document.nextForm.submit();
	return false;
});
var createInfoTableRow = function(header, data, red) {
	var tr = $("<tr></tr>");
	var th = $('<th class="align_right w140"></th>').html(header);
	var td = $('<td class="align_left w200"></td>').text($.nvlW(data));
	if (red) {
		th.addClass('red');
		td.addClass('red');
	}
	tr.append(th).append(td);
	return tr;
};
var createThumbTableRow = function(url, alt) {
	if ($.isNull(url)) {
		return null;
	}
	var tr = $("<tr></tr>");
	var td = $('<td style="width:130px; height:130px; text-align:center; vertical-align:middle; padding:5px; overflow:hidden;"></td>');
	var img = $('<img />', { style:"border:solid 1px lightgray;" }).attr('alt', $.nvl(alt)).attr('src', url);
	td.append(img);
	tr.append(td);
	return tr;
};
var createMyProductInfo = function(myProduct) {
	var outerDiv = $('<div class="chumonBox"></div>');
	var leftDiv = $('<div class="left floatleft mR20" style="width:340px;"></div>');
	var leftTable = $('<table cellpadding="0" cellspacing="0" class="listTable"></table>');
	leftTable.append(createInfoTableRow('あて名リスト名', myProduct.myAddressListName));
	leftTable.append(createInfoTableRow('アイテム', myProduct.genreName));
	leftTable.append(createInfoTableRow('サイズ', myProduct.paperSizeName));
	leftTable.append(createInfoTableRow('色数', myProduct.colorTypeName));
	leftTable.append(createInfoTableRow('用紙', myProduct.paperTypeName));
	leftTable.append(createInfoTableRow('出荷日<br /><a href="/about/delivery.html" target="_blank" class="fontN">出荷日について</a>', myProduct.deliveryTypeName));
	leftTable.append(createInfoTableRow('枚数', myProduct.quantityStr));
	leftTable.append(createInfoTableRow('あて名印字', $.isNull(myProduct.optionAddressPrintId) ? 'なし' : 'あり'));
	leftTable.append(createInfoTableRow('発送（差出）代行', $.isNull(myProduct.optionSendId) ? 'なし' : 'あり'));
//	leftTable.append(createInfoTableRow('加工', $.isNull(myProduct.optionFoldReprocessId) ? 'なし' : 'あり'));
	leftTable.append(createInfoTableRow('タウン差出代行', $.isNull(myProduct.optionTownMailSendId) ? 'なし' : 'あり　' + myProduct.quantityStr + '件'));
	leftTable.append(createInfoTableRow('印刷料金', myProduct.normalPrintSubtotalStr + '円（税込）'));
	leftTable.append(createInfoTableRow('郵便はがき代金', myProduct.mailAmountStr + '円（税込）'));
	leftTable.append(createInfoTableRow('オプション料金', myProduct.optionSubtotalStr + '円（税込）'));
	leftTable.append(createInfoTableRow('郵便料金相当料', myProduct.optionSendPostcardPriceStr + '円（税込）'));

	if (!$.isNull(myProduct.discountReason)) {
		leftTable.append(createInfoTableRow('小計', myProduct.normalTotalAmountStr + '円（税込）'));
		leftTable.append(createInfoTableRow(myProduct.discountReason, myProduct.discountedAmountStr + '円（税込）', true));
	}
	leftTable.append(createInfoTableRow('合計金額', myProduct.totalAmountStr + '円（税込）'));

	leftDiv.append(leftTable);

	var rightDiv = $('<div class="right w250 align_left" style="overflow:hidden;"></div>');
	var ul = $('<ul class="borderDot"></ul>');
	ul.append($("<li></li>").text(myProduct.myProductName));
	rightDiv.append(ul);

	var thumbDiv = $('<div class="align_center"></div>');
	var thumbTable = $('<table cellpadding="0" cellspacing="0" class="mT20 mB20" style="margin-left:auto; margin-right:auto;"></table>');
	var prefix = "${createLink(controller:'myProduct',action:'productThumbnail')}/" + encodeURIComponent(myProduct.id) + "?pageNo=";
	thumbTable.append(createThumbTableRow(prefix + "1", myProduct.myProductName));
	if (myProduct.pageCount > 1) {
		thumbTable.append(createThumbTableRow(prefix + "2", myProduct.myProductName));
	}
	thumbDiv.append(thumbTable);
	rightDiv.append(thumbDiv);

	var previewBtnDiv = $('<div class="align_center"></div>');
	var previewBtn = $('<input type="image" class="myProductPreviewBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_preview.gif" alt="プレビュー" />');
	previewBtn.data(myProduct);
	previewBtnDiv.append(previewBtn);
	rightDiv.append(previewBtnDiv);

	if (!$.isNull(myProduct.optionAddressPrintId) && !$.isNull(myProduct.optionAddressPrintDispname)) {
		var fontDiv = $('<div class="align_left mT10"></div>');
		var fontTitle = $('<div class="red size20 bold">あて名印字の書体：</div>');
		var fontSpan = $('<div class="align_center red size20 bold"></div>').text(myProduct.optionAddressPrintDispname);
		fontDiv.append(fontTitle);
		fontDiv.append(fontSpan);
		rightDiv.append(fontDiv);
	}

	outerDiv.append(leftDiv).append(rightDiv);
	return outerDiv;
};
var updateMyProductList = function(offset) {
	$.ajax({
		url: "${createLink(action:'listOrderingProduct')}",
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var myProductListBody = $("#myProductListBody");
				myProductListBody.empty();
				var myProductList = data.list;
				if (myProductList && (myProductList.length > 0)) {
					var disabledGenre = false;
					for (var index = 0; index < myProductList.length; index++) {
						var myProduct = myProductList[index];
						var myProductInfo = createMyProductInfo(myProduct);
						if (myProductInfo) {
							myProductListBody.append(myProductInfo);
							if (!myProduct.genreEnabled) {
								disabledGenre = true;
							}
						}
					}
					$(".myProductPreviewBtn", myProductListBody).unbind('click').click(function() {
						var myProduct = $(this).data();
						document.myProductPreviewForm.id.value = myProduct.id;
						document.myProductPreviewForm.submit();
						return false;
					});
					$("#orderTotalAmount").text(data.orderTotalAmountStr);
					if (disabledGenre) {
						oiyAlert("注文いただけないデザインが含まれています。\nショッピングカートをご確認ください。", function() {
							document.indexForm.submit();
							pleaseWait();
							return false;
						}, { width:'400px' });
					}
				} else {
					$("#orderTotalAmount").text("0");
				}

			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
updateMyProductList(0);
});</r:script>
</body>
</html>