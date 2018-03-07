<html>
<head>
	<title>DM Factory.jp</title>
	<meta name="layout" content="main" />
	<r:require module="application-js-listfunc" />
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>テンプレートを選ぶ<span>ご希望のテンプレートをお選びください。</span></h2>
			<p>テンプレート画像をクリックすると、詳しい説明をご覧いただけます。</p>

			<div class="temBox">

				<div class="sideLeft">
					<div class="sidTop"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/serch_top.gif" width="158" height="28" alt="絞り込み検索" /></div>            
					<div class="sidIn">

						<p><strong>カラー：</strong></p>
						<table class="srechColor" width="0" border="0" cellspacing="0" cellpadding="0">
<g:each in="${colorCategoryList}" status="i" var="colorCategory">
							<tr>
								<td class="txtone">
									<label for="colorCategory_${i}"><input type="checkbox" id="colorCategory_${i}" name="tag" value="${colorCategory.category}" ${params.tagmap[colorCategory.category] ? 'checked="checked"' : '' }>${colorCategory.categoryName}</label>
								</td>
							</tr>
</g:each>
						</table>

						<p><strong>季節・イベント：</strong></p>
						<table class="srechColor" width="0" border="0" cellspacing="0" cellpadding="0">
<g:each in="${seasonCategoryList}" status="i" var="seasonCategory">
							<tr>
								<td class="txtone">
									<label for="seasonCategory_${i}"><input type="checkbox" id="seasonCategory_${i}" name="tag" value="${seasonCategory.category}" ${params.tagmap[seasonCategory.category] ? 'checked="checked"' : '' }>${seasonCategory.categoryName}</label>
								</td>
							</tr>
</g:each>
						</table>      

						<div class="sidBtm"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/serch_btm.gif" width="158" height="6" /></div>
					</div>
				</div>

				<div class="sideRight">
					<h3 class="pnone"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_tempitiran.gif" alt="テンプレート一覧" /></h3>
					<div id="itemInfoListArea" class="itiranIn">
						<p class="rightText dispPage">全<span class="num totalCountOfItems">0</span>件中　<span class="num startCountOfItems">0</span>～<span class="num endCountOfItems">0</span>件　を表示</p>
						<div class="boberLine"></div>

						<div class="btnAreaTem pagination">
							<span class="p"><a href="javascript:void(0)" class="btLeft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_backT.gif" alt="前を見る" /></a></span>
							<span class="n"><a href="javascript:void(0)" class="btRight"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_nextT.gif" alt="次を見る" /></a></span>
							<div class="clear"></div> 
						</div> 

						<table id="itemInfoListTable" class="tempBox" border="0" cellspacing="5" cellpadding="0"></table>

						<div class="btnAreaTem pagination">
							<span class="p"><a href="javascript:void(0)" class="btLeft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_backT.gif" alt="前を見る" /></a></span>
							<div class="listTemplateLink" style="display:none;">
								<table>
									<tr>
										<td class="pageList" id="paginatelinksArea"></td>
										<td class="pageCount" style="vertical-align:baseline;"><span class="currentPageOfItems">0</span> / <span class="totalPagesOfItems">0</span> ページ</td>
									</tr>
								</table>
							</div>
							<span class="n"><a href="javascript:void(0)" class="btRight"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_nextT.gif" alt="次を見る" /></a></span>
							<div class="clear"></div> 
						</div> 

						<div class="itiranBtm"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_tempitiran_Btm.gif" width="676" height="7" /></div>
					</div>
				</div>
				<!-- sideRight END -->
				<div class="clear"></div>

			</div>
			<!-- tempBox END -->

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:form action="selectTemplate2nd" name="confirmSelectedTemplateForm">
<input type="hidden" name="itemInfoId2nd" value="" />
<input type="hidden" name="offset" value="" />
</g:form>
<form name="prevForm" action="${prevPath}"></form>
<r:script>
var itemInfoListFunc = null;
;jQuery(function(){
var confirmSelectedTemplate = function(ioffset, itemInfo) {
	pleaseWait();
	document.confirmSelectedTemplateForm.offset.value = ioffset;
	document.confirmSelectedTemplateForm.itemInfoId2nd.value = itemInfo.id;
	document.confirmSelectedTemplateForm.submit();
	return false;
};
$("input:checkbox[name='tag']").click(function() {
	updateItemInfoList(0);
	return true;
});
itemInfoListFunc = new listFunc("itemInfoListFunc", 30, "dispOrder", "asc");
var itemInfoListArea = $("#itemInfoListArea");
var listTemplateLink = $(".listTemplateLink");
var paginatelinksArea = $("#paginatelinksArea");
itemInfoListFunc.setDispPageCallback(function(startCount, endCount, totalCount) {
	$(".totalCountOfItems", itemInfoListArea).text(totalCount);
	$(".startCountOfItems", itemInfoListArea).text(startCount);
	$(".endCountOfItems", itemInfoListArea).text(endCount);

	paginatelinksArea.empty();
	if (totalCount > 0) {
		var offset = itemInfoListFunc.offset;
		var currentPage = Math.ceil(offset/itemInfoListFunc.pageMax);
		var totalPages = Math.ceil(totalCount / itemInfoListFunc.pageMax);
		$(".currentPageOfItems", listTemplateLink).text(currentPage + 1);
		$(".totalPagesOfItems", listTemplateLink).text(totalPages);

		var paginatelinks = $('<div class="paginatelinks"></div>');
		paginatelinksArea.append(paginatelinks);
		var num_display_entries = 6;
		if (totalCount > 100) {
			num_display_entries = 4;
		}
		paginatelinks.pagination(totalCount, {
			items_per_page:itemInfoListFunc.pageMax,
			num_display_entries:num_display_entries,
			current_page:currentPage,
			num_edge_entries:1,
			link_to:"#",
			prev_text:false,
			next_text:false,
			ellipse_text:"...",
			prev_show_always:false,
			next_show_always:false,
			callback:function(page){
				var newoffset = page * itemInfoListFunc.pageMax;
				if (newoffset != offset) {
					updateItemInfoList(newoffset);
				}
				return false;
			}
		});
		listTemplateLink.show();
	} else {
		listTemplateLink.hide();
	}
	return false;
});
var createThumbSrc = function(itemInfo, pageNo) {
	var prefix = "${createLink(controller:'templateInfo',action:'getThumbnail')}";
	var img = $('<img />').attr('src', prefix + "?trackingId=" + encodeURIComponent(itemInfo.trackingId) + "&pageNo=" + pageNo);
	return img;
};
var createLargeThumbURL = function(itemInfo, pageNo) {
	var prefix = "${createLink(controller:'itemInfo',action:'largeThumb')}";
	var url = prefix + "/" + encodeURIComponent(itemInfo.id) + "?pageNo=" + pageNo;
	return url;
};
var createItemInfoCell = function(ioffset, itemInfo) {
	var td = $('<td />');
	var itemThumb = $('<a href="javascript:void(0)" class="itemThumb" ></a>').append(createThumbSrc(itemInfo, 1)).data('ioffset', ioffset).data('itemInfo', itemInfo).data('largeThumbURL', createLargeThumbURL(itemInfo, 1));
	td.append(itemThumb);
	return td;
}
var updateItemInfoList = function(offset) {
	if (!$.isNaN(offset)) {
		itemInfoListFunc.offset = offset;
	}
	if (itemInfoListFunc.offset < 0) {
		itemInfoListFunc.offset = 0;
	}
	var sparams = {};
	sparams.itemGenreId = "${targetItemGenre?.id?.encodeAsHTML()}";
	sparams.paperSizeId = "${paperSizeId?.encodeAsHTML()}";
	sparams.printFace = "${printFace?.encodeAsHTML()}";
	sparams.numberOfColors = "${numberOfColors?.encodeAsHTML()}";
	sparams.templateType = "${templateType2nd?.encodeAsHTML()}";
	if ($.isNull(sparams.itemGenreId)) {
		sparams.itemGenreId = '';
	}
	if ($.isNull(sparams.paperSizeId)) {
		sparams.paperSizeId = '';
	}
	if ($.isNull(sparams.printFace)) {
		sparams.printFace = '';
	}
	if ($.isNull(sparams.numberOfColors)) {
		sparams.numberOfColors = '';
	}
	if ($.isNull(sparams.templateType)) {
		sparams.templateType = '';
	}
	var tags = Array();
	$("input:checkbox[name='tag']:checked").each(function(index, element) {
		tags.push($(this).val());
	});
	sparams.tag = tags;
	var pparams = itemInfoListFunc.getPageSortParam(null);
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listItemInfo')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				itemInfoListFunc.updatePagination(data.totalCount, data.offset);
				var offset = data.offset;
				var itemInfoListTable = $("#itemInfoListTable");
				itemInfoListTable.empty();
				var itemInfoList = data.list;
				if (itemInfoList && (itemInfoList.length > 0)) {
					var itemStep = 5;
					for (var index = 0; index < itemInfoList.length; index += itemStep) {
						var tr = $('<tr />');
						for (var column = 0; column < itemStep; column++) {
							var itemIndex = index + column;
							if (itemIndex >= itemInfoList.length) {
								break;
							}
							var ioffset = offset + index + column;
							var itemInfo = itemInfoList[itemIndex];
							var cell = createItemInfoCell(ioffset, itemInfo);
							tr.append(cell);
						}
						itemInfoListTable.append(tr);
					}
					$(".itemThumb").click(function() {
						var ioffset = $(this).data('ioffset');
						var itemInfo = $(this).data('itemInfo');
						return confirmSelectedTemplate(ioffset, itemInfo);
					}).tooltip({
						track:true,
						delay:0,
						showURL:false,
						fixPNG:true,
						bodyHandler:function() {
							var self = $(this);
							var itemInfo = self.data('itemInfo');
							var largeThumbURL = self.data('largeThumbURL');
							return $('<img />').attr('src', largeThumbURL).attr('alt', itemInfo.itemName);
						}
					});
				} else {
					var notfound = $('<td colspan="5" />', { style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					itemInfoListTable.append($('<tr />').append(notfound));
				}

			} else {
				itemInfoListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "テンプレート一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
itemInfoListFunc.initList($("#itemInfoListArea"));
itemInfoListFunc.addEventListner(updateItemInfoList, updateItemInfoList);
var currentOffset = ${params.offset ?: 0};
currentOffset = Math.floor(currentOffset / itemInfoListFunc.pageMax) * itemInfoListFunc.pageMax;
updateItemInfoList(currentOffset);
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
