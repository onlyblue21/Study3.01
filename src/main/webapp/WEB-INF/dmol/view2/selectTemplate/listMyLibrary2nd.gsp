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
			<h2>デザインを選ぶ<span>過去に作成したデザインからご希望のものをお選びください。</span></h2>
			<p>画像をクリックすると、詳しい説明をご覧いただけます。</p>

			<div class="temBox">

<g:if test="${false}">
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
</g:if>

				<div class="w716center">
					<h3 class="pnone"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_tempitiran.gif" alt="テンプレート一覧" /></h3>
					<div id="myLibraryPageInfoListArea" class="itiranIn">
						<p class="rightText dispPage">全<span class="num totalCountOfItems">0</span>件中　<span class="num startCountOfItems">0</span>～<span class="num endCountOfItems">0</span>件　を表示</p>
						<div class="boberLine"></div>

						<div class="btnAreaTem pagination">
							<span class="p"><a href="javascript:void(0)" class="btLeft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_backT.gif" alt="前を見る" /></a></span>
							<span class="n"><a href="javascript:void(0)" class="btRight"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_nextT.gif" alt="次を見る" /></a></span>
							<div class="clear"></div> 
						</div> 

						<table id="myLibraryPageInfoListTable" class="tempBox" border="0" cellspacing="5" cellpadding="0"></table>

						<div class="btnAreaTem pagination">
							<span class="p"><a href="javascript:void(0)" class="btLeft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_backT.gif" alt="前を見る" /></a></span>
							<div class="listMyLibraryLink listTemplateLink" style="display:none;">
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

<g:form action="selectMyLibrary2nd" name="confirmSelectedMyLibraryForm">
<input type="hidden" name="myLibraryPageInfoId2nd" value="" />
<input type="hidden" name="offset" value="" />
</g:form>
<form name="prevForm" action="${prevPath}"></form>
<r:script>
var myLibraryPageInfoListFunc = null;
;jQuery(function(){
var confirmSelectedMyLibrary = function(ioffset, myLibraryPageInfo) {
	pleaseWait();
	document.confirmSelectedMyLibraryForm.offset.value = ioffset;
	document.confirmSelectedMyLibraryForm.myLibraryPageInfoId2nd.value = myLibraryPageInfo.id;
	document.confirmSelectedMyLibraryForm.submit();
	return false;
};
$("input:checkbox[name='tag']").click(function() {
	updateMyLibraryPageInfoList(0);
	return true;
});
myLibraryPageInfoListFunc = new listFunc("myLibraryPageInfoListFunc", 30, "dispOrder", "asc");
var myLibraryPageInfoListArea = $("#myLibraryPageInfoListArea");
var listMyLibraryLink = $(".listMyLibraryLink");
var paginatelinksArea = $("#paginatelinksArea");
myLibraryPageInfoListFunc.setDispPageCallback(function(startCount, endCount, totalCount) {
	$(".totalCountOfItems", myLibraryPageInfoListArea).text(totalCount);
	$(".startCountOfItems", myLibraryPageInfoListArea).text(startCount);
	$(".endCountOfItems", myLibraryPageInfoListArea).text(endCount);

	paginatelinksArea.empty();
	if (totalCount > 0) {
		var offset = myLibraryPageInfoListFunc.offset;
		var currentPage = Math.ceil(offset/myLibraryPageInfoListFunc.pageMax);
		var totalPages = Math.ceil(totalCount / myLibraryPageInfoListFunc.pageMax);
		$(".currentPageOfItems", listMyLibraryLink).text(currentPage + 1);
		$(".totalPagesOfItems", listMyLibraryLink).text(totalPages);

		var paginatelinks = $('<div class="paginatelinks"></div>');
		paginatelinksArea.append(paginatelinks);
		var num_display_entries = 6;
		if (totalCount > 100) {
			num_display_entries = 4;
		}
		paginatelinks.pagination(totalCount, {
			items_per_page:myLibraryPageInfoListFunc.pageMax,
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
				var newoffset = page * myLibraryPageInfoListFunc.pageMax;
				if (newoffset != offset) {
					updateMyLibraryPageInfoList(newoffset);
				}
				return false;
			}
		});
		listMyLibraryLink.show();
	} else {
		listMyLibraryLink.hide();
	}
	return false;
});
var createThumbSrc = function(myLibraryPageInfo) {
	var prefix = "${createLink(controller:'myLibrary',action:'getThumbnail')}";
	var img = $('<img />').attr('src', prefix + "/" + encodeURIComponent(myLibraryPageInfo.myLibrary.id) + "?pageNo=" + myLibraryPageInfo.pageNo);
	return img;
};
var createLargeThumbURL = function(myLibraryPageInfo) {
	var prefix = "${createLink(controller:'myLibrary',action:'getLargeThumbnail')}";
	var url = prefix + "/" + encodeURIComponent(myLibraryPageInfo.myLibrary.id) + "?pageNo=" + myLibraryPageInfo.pageNo;
	return url;
};
var createMyLibraryPageInfoCell = function(ioffset, myLibraryPageInfo) {
	var td = $('<td />');
	var myLibraryThumb = $('<a href="javascript:void(0)" class="myLibraryThumb" ></a>').append(createThumbSrc(myLibraryPageInfo)).data('ioffset', ioffset).data('myLibraryPageInfo', myLibraryPageInfo).data('largeThumbURL', createLargeThumbURL(myLibraryPageInfo));
	td.append(myLibraryThumb);
	return td;
}
var updateMyLibraryPageInfoList = function(offset) {
	if (!$.isNaN(offset)) {
		myLibraryPageInfoListFunc.offset = offset;
	}
	if (myLibraryPageInfoListFunc.offset < 0) {
		myLibraryPageInfoListFunc.offset = 0;
	}
	var sparams = {};
	sparams.printMethod = "${printMethod?.encodeAsHTML()}";
	sparams.paperSizeId = "${paperSizeId?.encodeAsHTML()}";
	sparams.printFace = "${printFace?.encodeAsHTML()}";
	sparams.numberOfColors = "${numberOfColors?.encodeAsHTML()}";
	if ($.isNull(sparams.printMethod)) {
		sparams.printMethod = '';
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
	var tags = Array();
	$("input:checkbox[name='tag']:checked").each(function(index, element) {
		tags.push($(this).val());
	});
	sparams.tag = tags;
	var pparams = myLibraryPageInfoListFunc.getPageSortParam(null);
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listMyLibraryPageInfo')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				myLibraryPageInfoListFunc.updatePagination(data.totalCount, data.offset);
				var offset = data.offset;
				var myLibraryPageInfoListTable = $("#myLibraryPageInfoListTable");
				myLibraryPageInfoListTable.empty();
				var myLibraryPageInfoList = data.list;
				if (myLibraryPageInfoList && (myLibraryPageInfoList.length > 0)) {
					var itemStep = 5;
					for (var index = 0; index < myLibraryPageInfoList.length; index += itemStep) {
						var tr = $('<tr />');
						for (var column = 0; column < itemStep; column++) {
							var itemIndex = index + column;
							if (itemIndex >= myLibraryPageInfoList.length) {
								break;
							}
							var ioffset = offset + index + column;
							var myLibraryPageInfo = myLibraryPageInfoList[itemIndex];
							var cell = createMyLibraryPageInfoCell(ioffset, myLibraryPageInfo);
							tr.append(cell);
						}
						myLibraryPageInfoListTable.append(tr);
					}
					$(".myLibraryThumb").click(function() {
						var ioffset = $(this).data('ioffset');
						var myLibraryPageInfo = $(this).data('myLibraryPageInfo');
						return confirmSelectedMyLibrary(ioffset, myLibraryPageInfo);
					}).tooltip({
						track:true,
						delay:0,
						showURL:false,
						fixPNG:true,
						bodyHandler:function() {
							var self = $(this);
							var myLibraryPageInfo = self.data('myLibraryPageInfo');
							var largeThumbURL = self.data('largeThumbURL');
							return $('<img />').attr('src', largeThumbURL).attr('alt', myLibraryPageInfo.itemName);
						}
					});
				} else {
					var notfound = $('<td colspan="5" />', { style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					myLibraryPageInfoListTable.append($('<tr />').append(notfound));
				}

			} else {
				myLibraryPageInfoListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "保存済みデザイン一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
myLibraryPageInfoListFunc.initList($("#myLibraryPageInfoListArea"));
myLibraryPageInfoListFunc.addEventListner(updateMyLibraryPageInfoList, updateMyLibraryPageInfoList);
var currentOffset = ${params.offset ?: 0};
currentOffset = Math.floor(currentOffset / myLibraryPageInfoListFunc.pageMax) * myLibraryPageInfoListFunc.pageMax;
updateMyLibraryPageInfoList(currentOffset);
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
