<html>
<head>
	<meta name="layout" content="main" />
	<title>デザイン一覧</title>
	<r:require module="application-js-listfunc" />
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div id="myLibraryListArea" class="commonContents flow">
			<h2>保存したデザインを確認する<span>保存したデザインの編集と注文ができます。</span></h2>

			<div id="tmpleCont">
				<h3 class="mB0"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/design_title.gif" alt="保存したデザイン一覧" /></h3>
				<div class="tmpIn">
					<div class="designIn">
						<div id="pagingInfo">
							<p class="rightText mB10">全<span class="num totalCountOfItems">0</span>件中　<span class="num startCountOfItems">0</span>～<span class="num endCountOfItems">0</span>件　を表示</p>
						</div>

						<div id="myLibraryListBody"></div>

						<div class="pT10">
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
						</div>
					</div>
				</div>
				<!-- tmpIn END -->
				<div class="tmpBtm"></div>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<div id="myLibraryNameDialog" title="デザイン名" class="popBox" style="background-color:white; display:none;">
	<strong>デザイン名</strong>を指定してください。
	<input type="text" id="myLibraryName" name="myLibraryName" class="w500" maxlength="128" value="" />
</div>
<g:form action="editGuide" name="editGuideForm">
<input type="hidden" name="id" value="" />
</g:form>
<g:form action="orderConfirm" name="orderForm">
<input type="hidden" name="id" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${r.resource(dir:'static/dmol/js',file:'label_for_ie.js')}"></script>
<r:script>
var myLibraryListFunc = null;
;jQuery(function(){
var myLibraryNameDialog = $("#myLibraryNameDialog");
var myLibraryNameText = $("#myLibraryName", myLibraryNameDialog);
var myLibraryNameFunc = null;
myLibraryNameDialog.dialog({
	modal:true,
	resizable: false,
	autoOpen: false,
	width: 540,
	height: 160,
	overley: { backGroundColor:'#000', opacity:0.5 },
	buttons: [
		{
			text:"OK",
			click:function() {
				var name = myLibraryNameText.val();
				if (!name) {
					$().toastmessage('showWarningToast', "デザイン名を指定してください。");
					myLibraryNameText.focus();
					return false;
				}
				if ($.isFunction(myLibraryNameFunc)) {
					myLibraryNameFunc(name);
				}
				myLibraryNameDialog.dialog('close');
				return false;
			}
		},
		{
			text:"キャンセル",
			click:function() {
				myLibraryNameDialog.dialog('close');
				return false;
			}
		}
	],
	open: function() {
		OIY.Dialog.closeOnEnterKeypressed(this); 
		myLibraryNameText.focus();
	}
});
var myLibraryNameInputDialog = function(name, callback) {
	myLibraryNameText.val(name);
	myLibraryNameFunc = callback;
	myLibraryNameDialog.dialog('open');
	return false;
};
var renameMyLibrary = function(myLibrary) {
	myLibraryNameInputDialog(myLibrary.myLibraryName, function(name) {
		pleaseWait();
		var cparams = { id:myLibrary.id, myLibraryName:name };
		$.ajax({
			url: "${createLink(action:'renameMyLibrary')}",
			data: cparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "デザイン名を更新しました。");
					updateMyLibraryList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "デザイン名を更新することが出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
	return false;
};
var copyMyLibrary = function(myLibrary) {
	myLibraryNameInputDialog(myLibrary.myLibraryName, function(name) {
		pleaseWait();
		var cparams = { id:myLibrary.id, myLibraryName:name };
		$.ajax({
			url: "${createLink(action:'copyMyLibrary')}",
			data: cparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "デザインをコピーしました。");
					updateMyLibraryList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "デザインをコピーすることが出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
	return false;
};
var deleteMyLibrary = function(myLibrary) {
	return oiyConfirm("デザイン(" + myLibrary.myLibraryName + ")を削除してもよろしいですか？", function() {
		var cparams = { id:myLibrary.id };
		$.ajax({
			url: "${createLink(action:'deleteMyLibrary')}",
			data: cparams,
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "デザインを削除しました。");
					updateMyLibraryList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "デザインを削除することが出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
};
myLibraryListFunc = new listFunc("myLibraryListFunc", 10, "${lparams.sort?.encodeAsHTML()}", "${lparams.order?.encodeAsHTML()}");
var pagingInfo = $("#pagingInfo");
var listTemplateLink = $(".listTemplateLink");
var paginatelinksArea = $("#paginatelinksArea");
myLibraryListFunc.setDispPageCallback(function(startCount, endCount, totalCount) {
	$(".totalCountOfItems", pagingInfo).text(totalCount);
	$(".startCountOfItems", pagingInfo).text(startCount);
	$(".endCountOfItems", pagingInfo).text(endCount);

	paginatelinksArea.empty();
	if (totalCount > 0) {
		var offset = myLibraryListFunc.offset;
		var currentPage = Math.ceil(offset/myLibraryListFunc.pageMax);
		var totalPages = Math.ceil(totalCount / myLibraryListFunc.pageMax);
		$(".currentPageOfItems", listTemplateLink).text(currentPage + 1);
		$(".totalPagesOfItems", listTemplateLink).text(totalPages);

		var paginatelinks = $('<div class="paginatelinks"></div>');
		paginatelinksArea.append(paginatelinks);
		var num_display_entries = 6;
		if (totalCount > 100) {
			num_display_entries = 4;
		}
		paginatelinks.pagination(totalCount, {
			items_per_page:myLibraryListFunc.pageMax,
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
				var newoffset = page * myLibraryListFunc.pageMax;
				if (newoffset != offset) {
					updateMyLibraryList(newoffset);
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
var myLibraryListBody = $("#myLibraryListBody");
var thumbPrefix = "${createLink(action:'getThumbnail')}";
var createOneLibrary = function(myLibrary) {
	// サムネイル
	var imgstyle = { style:'border:solid 1px #cccccc;' };
	var imgsrc = thumbPrefix + "/" + encodeURIComponent(myLibrary.id) + '?pageNo=';
	var imgleft = $('<img />', imgstyle).attr('src', imgsrc + "1");
	var thumbleft = $('<td />').append(imgleft);
	var thumbright = $('<td />');
	if (myLibrary.pageCount > 1) {
		var imgright = $('<img />', imgstyle).attr('src', imgsrc + "2");
		thumbright.append(imgright);
	}
	var thumbtr = $('<tr />').append(thumbleft).append(thumbright);
	var thumbtable = $('<table cellpadding="0" cellspacing="5" class="sumbTable"></table>').append(thumbtr);
	var tdthumb = $('<td class="sumb" />').append(thumbtable);

	// デザイン名
	var myLibraryName = $('<span class="valignM mR6"></span>').text($.nvl(myLibrary.myLibraryName));
	var renameBtn = $('<a href="javascript:void(0)"></a>').addClass('myLibraryRenameBtn').text('デザイン名の変更').data(myLibrary);
	var title = $('<div class="title"></div>').append(myLibraryName).append(renameBtn);
	// 種類
	var type1 = $('<div class="type1"></div>').text(myLibrary.genreName);
	// スペック
	var size = $('<div class="size"></div>').text(myLibrary.paperSizeName);
	var color = $('<div class="color"></div>').text(myLibrary.colorTypeName);
	var type2 = $('<div class="type2"></div>').append(size).append(color);
	// 更新日時
	var update = $('<div class="update"></div>').text(myLibrary.updatedTimestamp + " ").append($('<span class="red3">更新</span>'));
	// ボタン
	var editImg = $('<img alt="デザインの編集" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/design_bt_henshu.gif");
	var copyImg = $('<img alt="デザインの複製" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/design_bt_hukusei.gif");
	var orderImg = $('<img alt="注文へすすむ" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/design_bt_chumon.gif");
	var editBtn = $('<a href="javascript:void(0)"></a>').addClass('myLibraryEditBtn mR6').data(myLibrary).append(editImg);
	var copyBtn = $('<a href="javascript:void(0)"></a>').addClass('myLibraryCopyBtn mR6').data(myLibrary).append(copyImg);
	var orderBtn = $('<a href="javascript:void(0)"></a>').addClass('myLibraryOrderBtn').data(myLibrary).append(orderImg);
	var buttonArea = $('<div class="buttonArea"></div>').append(editBtn).append(copyBtn);
	if (myLibrary.genreEnabled) {
		buttonArea.append(orderBtn)
	}
	var tdspec = $('<td class="spec" />').append(title).append(type1).append(type2).append(update).append(buttonArea);

	var deleteBtn = $('<input type="image" alt="削除" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/design_bt_del.gif").addClass('myLibraryDeleteBtn').data(myLibrary);
	var tddel = $('<td class="del" />').append(deleteBtn);

	var tr = $('<tr />').append(tdthumb).append(tdspec).append(tddel);
	var designTable = $('<table cellpadding="0" cellspacing="0" class="designTable"></table>').append(tr);
	var designBlock = $('<div class="designBlock"></div>').append(designTable);
	return designBlock;
}
var updateMyLibraryList = function(offset) {
	if (!$.isNaN(offset)) {
		myLibraryListFunc.offset = offset;
	}
	if (myLibraryListFunc.offset < 0) {
		myLibraryListFunc.offset = 0;
	}
	$("input:image.btnDoff", myLibraryListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-off.gif");
	$("input:image.btnUoff", myLibraryListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-off.gif");
	$("input:image.btnDon", myLibraryListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_down-on.gif");
	$("input:image.btnUon", myLibraryListFunc.element).attr("src", "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sort_up-on.gif");
	var pparams = myLibraryListFunc.getPageSortParam(null);
	var sparams = {};
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listMyLibrary')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				myLibraryListFunc.updatePagination(data.totalCount, data.offset);
				myLibraryListBody.empty();
				var myLibraryList = data.list;
				if (myLibraryList && (myLibraryList.length > 0)) {
					for (var index = 0; index < myLibraryList.length; index++) {
						var myLibrary = myLibraryList[index];
						var oneLibrary = createOneLibrary(myLibrary);
						myLibraryListBody.append(oneLibrary);
					}
					$(".myLibraryRenameBtn", myLibraryListBody).click(function() {
						var myLibrary = $(this).data();
						return renameMyLibrary(myLibrary);
					});
					$(".myLibraryCopyBtn", myLibraryListBody).click(function() {
						var myLibrary = $(this).data();
						return copyMyLibrary(myLibrary);
					});
					$(".myLibraryEditBtn", myLibraryListBody).click(function() {
						pleaseWait();
						var myLibrary = $(this).data();
						document.editGuideForm.id.value = myLibrary.id;
						document.editGuideForm.submit();
						return false;
					});
					$(".myLibraryOrderBtn", myLibraryListBody).click(function() {
						pleaseWait();
						var myLibrary = $(this).data();
						document.orderForm.id.value = myLibrary.id;
						document.orderForm.submit();
						return false;
					});
					$(".myLibraryDeleteBtn", myLibraryListBody).click(function() {
						var myLibrary = $(this).data();
						return deleteMyLibrary(myLibrary);
					});
				} else {
					var designBlock = $('<div class="designBlock" style="padding:8px 0px; text-align:center; vertical-align:middle;"></div>').text('登録されていません');
					myLibraryListBody.append(designBlock);
				}

			} else {
				myLibraryListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "デザイン一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
myLibraryListFunc.initList($("#myLibraryListArea"));
myLibraryListFunc.addEventListner(updateMyLibraryList, updateMyLibraryList);
updateMyLibraryList(${lparams.offset});
});</r:script>
</body>
</html>
