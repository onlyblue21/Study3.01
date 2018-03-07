<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテム（テンプレート）一覧</title>
	<r:require module="css-moon-common" />
	<r:require module="application-foldertree" />
	<r:require module="application-utils" />
	<r:require module="application-js-listfunc" />
	<r:require module="css-itemInfo-list" />
<r:script>
	//--------------------
	// グローバル変数
	//--------------------
	var itemInfoListFunc = new listFunc("itemInfoListFunc", 20, "lastUpdated", "desc");

	/* ----------------------
	 * アイテム（テンプレート）一覧処理
	----------------------- */

	// ---------------------

	//１ページの行数の設定
	function setPageMax(max, updateList) {
		html = "";
		html += createMaxSelector(10, max) + "&nbsp;";
		html += createMaxSelector(20, max) + "&nbsp;";
		html += createMaxSelector(50, max) + "&nbsp;";
		html += createMaxSelector(100, max) + "&nbsp;";
		$("#maxSelector").html(html);
		
		itemInfoListFunc.pageMax = max;
		if(updateList)
			getItemInfoList();
	}

	function createMaxSelector(lines, max) {
		if(lines == max)
			return lines;
		return '<a href="javascript:setPageMax(' + lines + ', true)">' + lines + '</a>';
	}

	//全選択・解除
	function selectAll(select) {
		$(".selectItemInfo").setChecked(select);
	}

	//アイテム（テンプレート）の削除
	function removeItemInfo() {
		var selIds = new Array();
		$(".selectItemInfo:checked").each(function(){selIds.push($(this).val())});
		if(selIds.length <= 0 ) {
			showDialog("alert", "アイテム（テンプレート）を選択してください");
			return;
		}
		showDialog("confirm", "選択中のアイテム（テンプレート）を削除します。<br/><br/>よろしいでしょうか？", [
			{
				text:"はい",
				click:function() {
					closeDialog();
					doRemoveItemInfo(selIds);
				}
			},
			{
				text:"いいえ",
				click:function() {
					closeDialog();
				}
			}
		]);
	}
	
	function doRemoveItemInfo(selIds) {
		post("removeItemInfo", { itemInfoIdList:selIds.join(",") }, function(data) {
			if(data.result != "ok")
				showDialog("alert", data.message);
			getItemInfoList();
		});
	}

	// アイテム（テンプレート）の編集
	function editItemInfo(id) {
		document.editForm.id.value = id;
		document.editForm.submit();
		return false;
	}

	// アイテム（テンプレート）一覧の取得
	function getItemInfoList() {
		$("#itemInfoListBody").empty();
		$("#selectAllCheck").setChecked(false);
		var param = itemInfoListFunc.getPageSortParam();
		param.genreId = $("#genreId").val();
		param.itemNo = $("#itemNo").val();
		param.likeItemName = $("#likeItemName").val();
		param.paperSizeId = $("#paperSizeId").val();
		param.printFace = $("#printFace").val();
		param.numberOfColors = $("#numberOfColors").val();
		param.templateType = $("#templateType").val();
		var tags = Array();
		$("input:checkbox[name='tag']:checked").each(function(index, element) {
			tags.push($(this).val());
		});
		param.tag = tags;
		post("listItemInfo", param, function(data) {
			itemInfoListFunc.updatePagination(data.totalCount, data.offset);
			itemInfoList = data.list;
			var thumb = "${createLink(action:'thumb')}/";
			var html = "";
			for(var i = 0; i < itemInfoList.length; i++) {
				var now = new Date();
				var itemInfo = itemInfoList[i];
				var thumblink = thumb + encodeURIComponent(itemInfo.id);
				var onclickfunc = "editItemInfo('" + encodeURIComponent(itemInfo.id) + "')";
				html += '<tr>';
				html += '<td class="alignCenter"><input type="checkbox" class="selectItemInfo" value="' + itemInfo.id + '" /></td>';

				html += '<td class="thumbCell vhcenter">';
				html += '<a href="javascript:void(0)" onclick="' + onclickfunc + '">'
				html += '<img src="' + thumblink + '" alt="' + sanitize(itemInfo.itemName, true) + '" border="0" class="thumbnail" />';
				html += '</a>';
				html += '</td>';

				html += '<td>';
				html += '<div class="tbpadding tbunderline vhcenter">';
				html += sanitize(itemInfo.genreName, true);
				html += "</div>";
				html += '<div class="tbpadding tbunderline vhcenter">';
				html += sanitize(itemInfo.itemNo, true);
				html += "</div>";
				html += '<div class="tbpadding tbunderline vhcenter">';
				html += '<a href="javascript:void(0)" onclick="' + onclickfunc + '">'
				html += sanitize(itemInfo.itemName, true);
				html += '</a>';
				html += "</div>";
				html += '<div class="tbpadding vhcenter">';
				if (itemInfo.enabled) {
					html += "有効";
				} else {
					html += "無効";
				}
				html += "／";
				if (itemInfo.templateType == 'blank') {
					html += "ホワイトテンプレート";
				} else if (itemInfo.templateType == 'easy') {
					html += "かんたんテンプレート";
				} else {
					html += "デザインテンプレート";
				}
				html += "</div>";
				html += '</td>';

				html += '<td>';
				html += '<div class="tbpadding tbunderline vhcenter">';
				html += sanitize(itemInfo.paperSizeName, true);
				html += "</div>";
				html += '<div class="tbpadding tbunderline vhcenter">';
				html += sanitize(itemInfo.printFaceName, true);
				html += "</div>";
				html += '<div class="tbpadding vhcenter" style="white-space:normal;">';
				html += sanitize(itemInfo.numberOfColorsName, true);
				html += "</div>";
				html += '</td>';

				html += '<td class="alignRight">' + sanitize(itemInfo.lastUpdated, true) + '</td>';
				html += '</tr>';
			}
			$("#itemInfoListBody").html(html);
			$('.selectItemInfo').shiftClick();
		});
	}

	//初期化
    $(document).ready( function() {
		itemInfoListFunc.initList();
		getItemInfoList();
	   	//ソートボタンとページングの初期化
	   	itemInfoListFunc.addEventListner(getItemInfoList, getItemInfoList);
		setPageMax(itemInfoListFunc.pageMax, false);
	});
</r:script>
</head>
<body>
    <div id="panel" style="display:none;text-align:left;"></div>

<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>アイテム（テンプレート）一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<!-- ▼main -->
	<div class="mainBlock">
		<h1>アイテム（テンプレート）一覧</h1>

		<div class="contents">

<g:render template="/common/fragment/flashmessages" />

			<div class="searchConditiontoggler"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="display:none;">
				<g:form method="get" action="list" name="searhCondition">
				<g:hiddenField name="sort" value="${params.sort?.encodeAsHTML()}" />
				<g:hiddenField name="order" value="${params.order?.encodeAsHTML()}" />
				<g:hiddenField name="search" value="true" />
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="genreId">アイテム区分:</label>
							</td>
							<td valign="top" class="value">
								<g:select id="genreId" name="genreId" from="${itemGenreList}" value="${params.genreId}" optionKey="genreId" optionValue="genreName" noSelection="['':'']" />
							</td>
						</tr> 

						<tr class="prop">
							<td class="name">${fieldNames?.ItemInfo?.itemNo?.encodeAsHTML()}:</td>
							<td class="value">
								<input type="text" size="40" maxlength="64" id="itemNo" name="itemNo" value="${params.itemNo?.encodeAsHTML()}"/>
							</td>
						</tr>

						<tr class="prop">
							<td class="name">${fieldNames?.ItemInfo?.itemName?.encodeAsHTML()}:</td>
							<td class="value">
								<input type="text" size="40" maxlength="64" id="likeItemName" name="likeItemName" value="${params.likeItemName?.encodeAsHTML()}"/>
								(前方一致)
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="paperSizeId">${fieldNames?.ItemInfo?.paperSizeId?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value">
								<g:select id="paperSizeId" name="paperSizeId" from="${paperSizeList}" value="${params.paperSizeId}" optionKey="paperSizeId" optionValue="paperSizeDispName" noSelection="['':'']" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="printFace">${fieldNames?.ItemInfo?.printFace?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value">
								<g:select id="printFace" name="printFace" from="${printFaceList}" value="${params.printFace}" optionKey="printFace" optionValue="printFaceName" noSelection="['':'']" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="numberOfColors">${fieldNames?.ItemInfo?.numberOfColors?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value">
								<g:select id="numberOfColors" name="numberOfColors" from="${numberOfColorsList}" value="${params.numberOfColors}" optionKey="numberOfColors" optionValue="numberOfColorsName" noSelection="['':'']" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								カラー:
							</td>
							<td valign="top" class="value">
<g:each in="${colorCategoryList}" status="i" var="colorCategory">
								<input type="checkbox" id="colorCategory_${i}" name="tag" value="${colorCategory.category}" ${params.tagmap[colorCategory.category] ? 'checked="checked"' : '' }/> <label for="colorCategory_${i}">${colorCategory.categoryName}</label> 
</g:each>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								季節・イベント:
							</td>
							<td valign="top" class="value">
<g:each in="${seasonCategoryList}" status="i" var="seasonCategory">
								<input type="checkbox" id="seasonCategory_${i}" name="tag" value="${seasonCategory.category}" ${params.tagmap[seasonCategory.category] ? 'checked="checked"' : '' }/> <label for="seasonCategory_${i}">${seasonCategory.categoryName}</label> 
</g:each>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="templateType">${fieldNames?.ItemInfo?.templateType?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value">
<g:render template="/common/fragment/templateTypeConditionList" model="[templateTypeValue:params.templateType]"/>
							</td>
						</tr> 

						<tr class="prop">
							<td colspan="2" style="text-align: center;">
								<div class="searchButtons">
									<a href="javascript:void(0)" id="searchBtn" class="button"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
									<a href="javascript:void(0)" id="clearSearchConditionBtn" class="button"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
								</div>
							</td>
						</tr>

					</tbody>
				</table>
				</g:form>
			</div>

		<div class="floatleft w200" style="display:none;">

			<div class="folderMenu">
				<div class="top"></div>
				<h2>
					<span style="font-size:12px;float:left;">ユーザグループ</span>
<g:if test="${false}">
					<a href="javascript:unselectGroup();" class="button" style="font-size:12px;float:left;">選択解除</a>
</g:if>
				</h2>
				<br style="clear:both" />
				<div id="groupTree">
				</div>

				<div class="bottom"></div>
				
			</div>
		</div> <!-- floatleft -->

<g:if test="${false}">
		<!--▼contentsTop-->
		<div class="contentsTop">
			<div class="folderBlock">
				<!-- header -->
					<span id="currentPathName"></span>
			</div>

		</div><!--△contentsTop-->
</g:if>

		<!-- アイテム（テンプレート）一覧 -->
		<div id="listArea">
			<div class="folderFuncBlock" style="border:1px solid #cccccc;">
				<div>
					<span class="button"><a href="javascript:void(0)" id="createBtn" class="button"><span class="icon-create">アイテム（テンプレート）追加</span></a></span>
					<span class="button"><g:link action="bundle" class="button">一括アップロード</g:link></span>
				</div>
			</div>
			<div class="folderFuncBlockBottom"></div>

			<div class="bgGray">
				<div class="bgGrayIn">
					<div class="floatleft">
						<input type="image" src="${r.resource(dir:'static/moon/images/common',file:'btn_sakujo.gif')}" alt="削除" onClick="removeItemInfo()" />
					</div>
					<div class="floatright">（<span id="maxSelector">
						 <a href="javascript:setPageMax(10, true)">10</a>
						 <a href="javascript:setPageMax(20, true)">20</a>
						 <a href="javascript:setPageMax(50, true)">50</a>
						 <a href="javascript:setPageMax(100, true)">100</a>
						 </span>
						件表示）
					</div>
				</div>
			<g:render template="/common/pagination/pagination" />
			</div>

			<table cellpadding="0" cellspacing="0" class="contentsTable">
				<thead>
					<tr>
						<th width="40" class="alignCenter">選択<br /><input type="checkbox" onClick="selectAll(this.checked)" id="selectAllCheck" /></th>
						<th width="120" class="alignCenter">サムネイル</th>
						<th class="alignCenter">
							アイテム区分<br />
							アイテムNo<div class="toolBtn"><button type="submit" class="btnUoff" id="itemNo_asc">up</button><button type="submit" class="btnDoff" id="itemNo_desc">down</button></div><br />
							アイテム名称<div class="toolBtn"><button type="submit" class="btnUoff" id="itemName_asc">up</button><button type="submit" class="btnDoff" id="itemName_desc">down</button></div><br />
							有効/無効／白紙
						</th>
						<th width="140" class="alignCenter">用紙サイズ<br />印刷面<br />色数</th>
						<th width="120" class="alignCenter">更新日時<div class="toolBtn"><button type="submit" class="btnUoff" id="lastUpdated_asc">up</button><button type="submit" class="btnDoff" id="lastUpdated_desc">down</button></div></th>
					</tr>
				</thead>
				<tbody id="itemInfoListBody" />
			</table>

			<div class="bgGray">
				<div class="bgGrayIn">
					<div class="floatleft">
						<input type="image" src="${r.resource(dir:'static/moon/images/common',file:'btn_sakujo.gif')}" alt="削除" onClick="removeItemInfo()"/>
					</div>
				</div>
			<g:render template="/common/pagination/pagination" />
			</div>
		</div>
		</div> <!-- ▲contents -->
	</div> <!-- ▲main -->

<g:form method="post" action="create" name="createForm"></g:form>
<g:form method="post" action="edit" name="editForm">
<input type="hidden" name="id" value="" />
</g:form>
<r:script>
;jQuery(function(){
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
$('#searchBtn').click(function() {
	getItemInfoList();
	return false;
});
$("#clearSearchConditionBtn").click(function() {
	$('#genreId').val("");
	$('#itemNo').val("");
	$('#itemName').val("");
	$('#likeItemName').val("");
	$('#paperSizeId').val("");
	$('#printFace').val("");
	$('#numberOfColors').val("");
	$("input:checkbox[name='tag']:checked").each(function(index, element) {
		$(this).setChecked(false);
	});
	$('#templateType').val("");
	return false;
});
$('#createBtn').click(function() {
	document.createForm.submit();
	return false;
});
$(".searchConditionFormArea table tbody tr.prop").evenodd();
});</r:script>
</body>
</html>
