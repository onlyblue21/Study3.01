<html>
<head>
	<meta name="layout" content="main" />
	<title>ショッピングカート</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
<style type='text/css' media='screen'>
.popBox th, .popBox td { font-family: Meiryo,Osaka,"ＭＳ Ｐゴシック","MS PGothic",sans-serif; font-size: 12px; }
</style>
</head>
<body class="myPage myProduct">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>ショッピングカートの中身を確認する<span>金額をご確認ください。</span></h2> 

<g:render template="/common/fragment/flashmessages" />

			<div id="myProductListArea" class="contIn mB30">
				<table cellpadding="0" cellspacing="0" class="listTable3rd1 mB10">
					<thead>
						<tr>
							<th width="30" class="align_center"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/check.gif" /></th>
							<th width="30" class="align_center">No.</th>
							<th><span>デザイン名</span></th>
							<th width="60" class="align_center">詳細</th>
							<th width="110" class="align_center">登録日時</th>
							<th width="135" class="align_center">アイテム</th>
							<th width="85" class="align_center">金額</th>
							<th width="35" class="align_center">削除</th>
						</tr>
					</thead>
					<tbody id="myProductListBody" />
				</table>

				<div class="kakuninBottom">
<sec:ifLoggedIn>
<g:if test="${loginUserInfo?.registeredUser}">
					<g:link controller="myPage" action="index" class="floatleft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_tsuzukeru.gif" alt="買い物を続ける" /></g:link>
</g:if>
</sec:ifLoggedIn>
					<div id="totalAmountArea" style="display:none;">
						<table cellpadding="0" cellspacing="0" class="goukeiTable">
							<tr>
								<th>お支払い総額</th>
								<td><span id="totalAmount"></span>円<span class="fontN size12">（税込）</span></td>
							</tr>
						</table>
						<p class="align_right floatright clearboth size12 pT5">※送料は無料です。</p>
					</div>
				</div>
			</div>

		</div>
<!-- commonContents END -->

<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
					<img id="disabledNextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-disable.gif" alt="次へ進む" />
				</li>
			</ul>
		</div>
<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:form action="orderProducts" name="orderProductsForm" />
<g:render template="/common/fragment/myProductDetailDialog" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${r.resource(dir:'static/dmol/js',file:'myProductDetailDialog.js')}"></script>
<r:script>
var myProductListFunc = null;
;jQuery(function(){
var selectedMyProductIds = function() {
	var ids = Array();
	$("input:checkbox:checked.selectMyProductCheckbox").each(function(index, element) {
		var myProduct = $(this).data();
		ids.push(myProduct.id);
	});
	return ids;
};
var enableSelectProductCheckbox = function(myProduct) {
	var selectedCount = $("input:checkbox:checked.selectMyProductCheckbox").length;
	if (selectedCount <= 0) {
		$("input:checkbox:.selectMyProductCheckbox").setDisabled(false);
	} else if (selectedCount == 1) {
		$("input:checkbox:.selectMyProductCheckbox").each(function(index, element) {
			var mp = $(this).data();
			if (myProduct.serviceDivision != mp.serviceDivision) {
				$(this).setDisabled(true);
			}
		});
	}
};
var initialCheck = function() {
	var serviceDivisionMap = Array(0, 0, 0);
	$("input:checkbox:.selectMyProductCheckbox").each(function(index, element) {
		var mp = $(this).data();
		serviceDivisionMap[mp.serviceDivision - 1]++;
	});
	var targetServiceDivision = 1;
	if (serviceDivisionMap[1]) {
		targetServiceDivision = 2;
	} else if (serviceDivisionMap[2]) {
		targetServiceDivision = 3;
	}
	$("input:checkbox:.selectMyProductCheckbox").each(function(index, element) {
		var mp = $(this).data();
		if (mp.serviceDivision == targetServiceDivision) {
			$(this).setChecked(true);
		} else {
			$(this).setDisabled(true);
		}
	});
};
var updateTotalAmount = function() {
	var totalAmount = 0.0;
	$("input:checkbox:checked.selectMyProductCheckbox").each(function(index, element) {
		var mp = $(this).data();
		totalAmount += mp.totalAmount;
	});
	$("#totalAmount").text($.insertComma(totalAmount));
};
var nextBtn = $("#nextBtn");
var disabledNextBtn = $("#disabledNextBtn");
var enableNextBtn = function() {
	if (($("input:checkbox:checked.selectMyProductCheckbox").length > 0)) {
		disabledNextBtn.hide();
		nextBtn.show();
	} else {
		nextBtn.hide();
		disabledNextBtn.show();
	}
	return false;
};
nextBtn.click(function() {
	var ids = selectedMyProductIds();
	if (ids.length <= 0) {
		$().toastmessage('showErrorToast', "注文するデザインを選択してください。");
		return false;
	}
	return submitProductOrder(ids);
});
var submitProductOrder = function(ids) {
	var form = $("#orderProductsForm");
	form.empty();
	if (ids) {
		for (var index = 0; index < ids.length; index++) {
			var id = ids[index];
			var hiddenId = $('<input type="hidden" name="ids" />').val(id);
			form.append(hiddenId);
		}
	}
	form.submit();
	pleaseWait();
	return false;
};
// プロダクト一覧
myProductListFunc = new listFunc("myProductListFunc", 10000, "myProductNo", "asc");
var updateMyProductList = function(offset) {
	if (!$.isNaN(offset)) {
		myProductListFunc.offset = offset;
	}
	if (myProductListFunc.offset < 0) {
		myProductListFunc.offset = 0;
	}
	var pparams = myProductListFunc.getPageSortParam(null);
	var sparams = {};
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listMyProduct')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				myProductListFunc.updatePagination(data.totalCount, data.offset);
				var myProductListBody = $("#myProductListBody");
				myProductListBody.empty();
				var myProductList = data.list;
				if (myProductList && (myProductList.length > 0)) {
					var td0Attr = { style:"vertical-align:middle;" };
					var td1Attr = { style:"vertical-align:middle;" };
					var td2Attr = { style:"vertical-align:middle;" };
					var td3Attr = { style:"vertical-align:middle;" };
					var td4Attr = { style:"vertical-align:middle;" };
					var td5Attr = { style:"vertical-align:middle;" };
					var td6Attr = { style:"vertical-align:middle;" };
					var td7Attr = { style:"vertical-align:middle;" };
					var productNo = 1;
					for (var index = 0; index < myProductList.length; index++) {
						var tr = $('<tr />');
						var myProduct = myProductList[index];
						var selectCheckbox = $('<input type="checkbox" />').addClass('selectMyProductCheckbox').data(myProduct);
						var detailBtn = $('<input type="image" alt="詳細" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_shousai_s.gif").addClass('myProductDetailBtn').data(myProduct);
						var deleteBtn = $('<input type="image" alt="削除" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_del.gif").addClass('myProductDeleteBtn').data(myProduct);
						var td0 = $('<td />', td0Attr).addClass('align_center bg');
						if (myProduct.genreEnabled) {
							td0.append(selectCheckbox);
						}
						var td1 = $('<td />', td1Attr).addClass('align_center bg').text("" + productNo);
						var td2 = $('<td />', td2Attr).addClass('align_left').text($.nvlW(myProduct.myProductName));
						var td3 = $('<td />', td3Attr).addClass('align_center').append(detailBtn);
						var td4 = $('<td />', td4Attr).addClass('align_center size10').text($.nvlW(myProduct.lastUpdated));
						var td5 = $('<td />', td5Attr).addClass('align_center size10').text($.nvlW(myProduct.genreName));
						var td6 = $('<td />', td6Attr).addClass('align_center').text($.insertComma(myProduct.totalAmount) + "円");
						var td7 = $('<td />', td7Attr).addClass('align_center').append(deleteBtn);
						tr.append(td0).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6).append(td7);
						myProductListBody.append(tr);
						productNo++;
					}
					$("input:checkbox.selectMyProductCheckbox", myProductListBody).click(function() {
						enableSelectProductCheckbox($(this).data());
						enableNextBtn();
						updateTotalAmount();
						return true;
					});
					$(".myProductDetailBtn", myProductListBody).click(function() {
						var myProduct = $(this).data();
						return showProductDetail(myProduct);
					});
					$(".myProductDeleteBtn", myProductListBody).click(function() {
						var myProduct = $(this).data();
						return deleteMyProduct(myProduct);
					});
					$("tr", myProductListBody).evenodd();
					initialCheck();
					enableNextBtn();
					updateTotalAmount();
					$("#totalAmountArea").show();
				} else {
					var td = $('<td />', { colspan:8, style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					myProductListBody.append(tr);
					enableNextBtn();
					$("#totalAmountArea").hide();
				}

			} else {
				myProductListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var showProductDetail = function(myProduct) {
	showMyProductDetailDialog(myProduct, function() {
		return submitProductOrder([myProduct.id]);
	});
	return false;
};
var deleteMyProduct = function(myProduct) {
	return oiyConfirm('[' + myProduct.myProductName + ']を削除しますか？', function() {
		pleaseWait();
		var rparams = { id:myProduct.id };
		$.ajax({
			url: "${createLink(action:'removeMyProduct')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "[" + myProduct.myProductName + "]を削除しました。");
					// リストの再表示
					updateMyProductList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "[" + myProduct.myProductName + "]を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
	return false;
};
myProductListFunc.initList($("#myProductListArea"));
myProductListFunc.addEventListner(updateMyProductList, updateMyProductList);
updateMyProductList(${pparams.offset});
});</r:script>
</body>
</html>