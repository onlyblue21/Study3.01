<html>
<head>
	<meta name="layout" content="main" />
	<title>あて名データ管理</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myList">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>あて名を登録する<span>以下のステップに従って、あて名をご登録ください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<g:form method="post" action="selectUploadType" name="selectUploadTypeForm" onsubmit="return false;">
				<div class="bgStop"></div>
				<div class="bgSinB">
					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_atenaData.gif" alt="あて名データ管理" /></h3>
					<div class="selectForm mB15 align_left">

						<h3 class="fontBlue mB0"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/atena_midashi1.gif" alt="①あて名フォルダを作成する" /></h3>
						<p class="mB10 size12">あて名リスト（CSV）を登録するためのフォルダを作成してください。</p>
						<div class="rBox1 mB20">
							<div class="rbTop"></div>
							<div class="rbMiddle pL10">
								<table class="selectTable">
									<tr>
										<th class="align_left">
											<input type="image" src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_atena_new.gif" id="myAddressListCreateBtn" alt="あて名フォルダの作成" />
										</th>
										<td class="tLineLeft">
											<g:select id="uploadMyAddressListId" name="myAddressListId" from="${malList}" value="${params.uploadMyAddressListId}" optionKey="id" optionValue="myAddressListName" class="w160" />
										</td>
										<td class="pL10"><a href="javascript:void(0)" id="uploadMyAddressListEditBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_henshu.gif" alt="編集" /></a></td>
									</tr>
								</table>
							</div>
							<div class="rbBottom"></div>
						</div>

						<h3 class="fontBlue mB0"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/atena_midashi2.gif" alt="②あて名フォーマット（CSV）をダウンロードする" /></h3>
						<p class="mB10 size12">フォーマットをダウンロードして、あて名リスト（CSV）を作成してください。<br />
						すでにあて名リスト（CSV）をお持ちの方は、ステップ③にお進みください。</p>
						<div class="rBox1 mB20">
							<div class="rbTop"></div>
							<div class="rbMiddle pL10">
								<table class="selectTable">
									<tr>
										<th class="align_left">
											<g:link action="downloadMyAddressTemplate"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_csv_dl.gif" alt="あて名フォーマット（CSV）ダウンロード" /></g:link>
										</th>
									</tr>
								</table>
							</div>
							<div class="rbBottom"></div>
						</div>

						<h3 class="fontBlue mB0"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/atena_midashi3.gif" alt="③あて名リスト（CSV）をアップロードする" /></h3>
						<p class="mB10 size12 pL15">②で作成した<span class="mB10 size12">あて名リスト（CSV）</span>や、お手持ちの<span class="mB10 size12">あて名リスト（CSV）</span>をアップロードしてください。<br />
						　<span class="red size10">※</span><span class="size10">シフトJISに含まれない文字や環境依存文字は文字化けする恐れがありますので、使用しないでください。</span><br />
						　<span class="red size10">※</span><span class="size10">あて名リストの不備にともなう文字化けや体裁崩れについては、弊社で責任は負いかねますので予めご了承ください。 </span></p>
						<div class="rBox1">
							<div class="rbTop"></div>
							<div class="rbMiddle pL10">
								<table class="selectTable">
									<tr>
										<th class="align_left">
											<input type="image" id="selectUploadTypeBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_csv_up.gif" alt="CSVアップロード" />
										</th>
									</tr>
								</table>
							</div>
							<div class="rbBottom"></div>
						</div>

					</div>
					<div class="clear"></div>
					<div class="bgSbtm"></div>
				</div>
				<!-- bgSinB END -->
				</g:form>

				<div id="listArea" class="innnerBox1">
					<h2>あて名データ表示</h2>
					<div class="innnerBox1in">

						<div class="hTab">
							<div class="hTabTop">
								<ul id="hTabUL" class="tALL">
									<li class="tALL"><a href="javascript:void(0)" id="selectAllBtn" class="selectPrimarySearchKeyBtn" searchkey=""><span class="alt">全部</span></a></li>
									<li class="tE"><a href="javascript:void(0)" id="selectANBtn" class="selectPrimarySearchKeyBtn" searchkey="a"><span class="alt">英数字</span></a></li>
									<li class="tA"><a href="javascript:void(0)" id="selectABtn" class="selectPrimarySearchKeyBtn" searchkey="あ"><span class="alt">あ</span></a></li>
									<li class="tKA"><a href="javascript:void(0)" id="selectKBtn" class="selectPrimarySearchKeyBtn" searchkey="か"><span class="alt">か</span></a></li>
									<li class="tSA"><a href="javascript:void(0)" id="selectSBtn" class="selectPrimarySearchKeyBtn" searchkey="さ"><span class="alt">さ</span></a></li>
									<li class="tTA"><a href="javascript:void(0)" id="selectTBtn" class="selectPrimarySearchKeyBtn" searchkey="た"><span class="alt">た</span></a></li>
									<li class="tNA"><a href="javascript:void(0)" id="selectNBtn" class="selectPrimarySearchKeyBtn" searchkey="な"><span class="alt">な</span></a></li>
									<li class="tHA"><a href="javascript:void(0)" id="selectHBtn" class="selectPrimarySearchKeyBtn" searchkey="は"><span class="alt">は</span></a></li>
									<li class="tMA"><a href="javascript:void(0)" id="selectMBtn" class="selectPrimarySearchKeyBtn" searchkey="ま"><span class="alt">ま</span></a></li>
									<li class="tYA"><a href="javascript:void(0)" id="selectYBtn" class="selectPrimarySearchKeyBtn" searchkey="や"><span class="alt">や</span></a></li>
									<li class="tRA"><a href="javascript:void(0)" id="selectRBtn" class="selectPrimarySearchKeyBtn" searchkey="ら"><span class="alt">ら</span></a></li>
									<li class="tWA"><a href="javascript:void(0)" id="selectWBtn" class="selectPrimarySearchKeyBtn" searchkey="わ"><span class="alt">わ</span></a></li>
									<li class="tAT"><a href="javascript:void(0)" id="selectOBtn" class="selectPrimarySearchKeyBtn" searchkey="＝"><span class="alt">その他</span></a></li>
								</ul>
								<a href="javascript:void(0)" id="createMyAddressBtn" class="floatright" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_atesaki_tsuika.gif" alt="あて名の新規追加" /></a>
								<img id="disabledCreateMyAddressBtn" class="floatright" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_atesaki_tsuika_disable.gif" alt="あて名の新規追加" />
							</div>
							<div class="hTabMiddle">
								<table class="selectTable">
									<tr>
										<th>あて名リスト</th>
										<td>
											<g:select id="editMyAddressListId" name="editMyAddressListId" from="${malList}" value="${params.editMyAddressListId}" optionKey="id" optionValue="myAddressListName" noSelection="['':'']" class="w160" />
										</td>
										<td><a href="javascript:void(0)" id="downloadBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_atenaikkatsu_dl.gif" alt="あて名リスト（CSV）一括ダウンロード" /></a></td>
									</tr>
								</table>
							</div>
						</div>

						<div class="listTableHead">
							<div class="leftBlock btnArea">
								<a href="javascript:void(0)" id="deleteBtn" class="btn1"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sakujyo.gif" alt="削除" /></a>
								<a href="javascript:void(0)" id="deleteAllBtn" class="btn2" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_list_del.gif" alt="あて名データ一括削除" /></a>
								<img id="disabledDeleteAllBtn" class="btn2" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_list_del_disable.gif" alt="あて名データ一括削除" />
							</div>
<g:render template="/common/pagination/myaddresspagination" />
						</div>
						<table cellpadding="0" cellspacing="0" class="listTable1">
							<thead>
								<tr>
									<th width="25"><input type="checkbox" id="selectAllCheckbox" /></th>
									<th width="40">No.</th>
									<th width="320">会社名</th>
									<th width="125">名前</th>
									<th width="270">住所</th>
									<th width="55">詳細</th>
								</tr>
							</thead>
							<tbody id="myAddressTable">
							</tbody>
						</table>
					</div>
				</div>

			</div>  
			<!-- colorSen END -->  

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<div id="myAddressListEditDialog" title="あて名リスト一覧" style="background-color:white; display:none;">
	<div>
		<div class="gPlus"><input type="image" id="myAddressListEditDialogCreateBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_plus.gif" alt="新規登録" /></div>
		<table cellpadding="0" cellspacing="0" class="listTable mB20">
			<thead>
				<tr>
					<th width="200">あて名リスト</th>
					<th width="70">名前変更</th>
					<th width="30">削除</th>
				</tr>
			</thead>
			<tbody id="myAddressListTable">
			</tbody>
		</table>
		<div class="align_center clearboth mB10"><a href="javascript:void(0)" id="myAddressListEditDialogCloseBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_tojiruB2.gif" width="112" height="33" alt="閉じる" /></a></div>
	</div>
</div>
<div id="myAddressListNameDialog" title="あて名リスト名" style="display:none;">
	<div style="background-color:white; padding:1em;">
		<div id="myAddressListNameMessage" style="padding-bottom:0.25em;">あて名リスト名を指定してください。</div>
		<div style="padding-top:0.25em;">
			<input type="text" id="myAddressListName" name="myAddressListName" value="" class="w300" maxlength="20" />
		</div>
	</div>
</div>
<g:form action="createMyAddress" name="createMyAddressForm">
<input type="hidden" name="myAddressListId" value="" />
</g:form>
<g:form action="editMyAddress" name="editMyAddressForm">
<input type="hidden" name="myAddressId" value="" />
</g:form>
<g:form action="downloadMyAddress" name="downloadMyAddressForm">
<input type="hidden" name="primarySearchKey" value="" />
<input type="hidden" name="myAddressListId" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<g:if test="${flash.totalCount && flash.errorCount}">
<g:form name="showUploadedErrorsForm" action="showUploadedErrors" target="showUploadedErrors" />
<div id="uploadErrorDialog" title="登録エラー" style="display:none;">
	<div>${flash.totalCount}件中${flash.errorCount}件のデータは、エラーのため登録できませんでした。</div>
</div>
</g:if>
<r:script>
var myAddressListFunc = null;
;jQuery(function(){
var maxMyAddressCountPerList = ${maxMyAddressCountPerList};
var updateMyAddressListOnNameDialog = function() {
	$.ajax({
		url: "${createLink(action:'listMyAddressList')}",
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				// 一覧に値を表示
				var myAddressListTable = $("#myAddressListTable"); // 追加先
				myAddressListTable.empty();
				var uploadMyAddressListSelection = $("#uploadMyAddressListId");
				var editMyAddressListSelection = $("#editMyAddressListId");
				var selectedUploadMyAddressListId = uploadMyAddressListSelection.val();
				var selectedEditMyAddressListId = editMyAddressListSelection.val();
				uploadMyAddressListSelection.empty();
				editMyAddressListSelection.empty();
				editMyAddressListSelection.append($('<option />'));
				var malList = data.list;
				if (malList && (malList.length > 0)) {
					var nameTdAttr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var renameTdAttr = { style:"text-align:center; vertical-align:middle; width:8em;" };
					var removeTdAttr = { style:"text-align:center; vertical-align:middle; width:6em;" };
					for (var index = 0; index < malList.length; index++) {
						var mal = malList[index];
						var name = mal.myAddressListName;
						if (!name) {
							name = '';
						}
						// ダイアログの一覧
						var td1 = $('<td />', nameTdAttr).text($.nvlW(name));
						var renameBtn = $('<input type="image" alt="名前変更" />').addClass('renameMyAddressListBtn').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/name_ch.gif").data(mal);
						var removeBtn = $('<input type="image" alt="削除" />').addClass('removeMyAddressListBtn').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_batsu.gif").data(mal);
						var td2 = $('<td />', renameTdAttr).append(renameBtn);
						var td3 = $('<td />', removeTdAttr).append(removeBtn);
						var tr = $('<tr />').append(td1).append(td2).append(td3);
						myAddressListTable.append(tr);
						// 親画面のプルダウン
						var option = $('<option />', { 'value':mal.id }).text($.nvlW(name));
						uploadMyAddressListSelection.append(option);
						editMyAddressListSelection.append(option.clone());
					}
					$(".renameMyAddressListBtn").click(function() {
						var mal = $(this).data();
						return editMyAddressListName(mal);
					});
					$(".removeMyAddressListBtn").click(function() {
						var mal = $(this).data();
						return removeMyAddressList(mal);
					});
					$("tr", myAddressListTable).evenodd();
					// プルダウンの選択を戻す
					uploadMyAddressListSelection.val(selectedUploadMyAddressListId);
					editMyAddressListSelection.val(selectedEditMyAddressListId);
				}

			} else {
				$().toastmessage('showErrorToast', "あて名リスト一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var editMyAddressListName = function(myAddressList) {
	var myAddressListId = myAddressList.id;
	var myAddressListVersion = myAddressList.version;
	var myAddressListName = myAddressList.myAddressListName;
	var title = "あて名リストの名前変更";
	var message = "あて名リスト「" + $.escapeHTML(myAddressListName) + "」の名前を変更します。\n新しい名前を入力してください。";
	return showMyAddressListNameDialog(title, message, myAddressListName, function(myAddressListNameDialog, myAddressListName) {
		var lparams = { id:myAddressListId, version:myAddressListVersion, myAddressListName:myAddressListName };
		$.ajax({
			type: 'post',
			url: "${createLink(action:'updateMyAddressList')}",
			data: lparams,
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					myAddressListNameDialog.dialog('close');
					updateMyAddressListOnNameDialog(); // 一覧の再表示
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "あて名リストの名前を変更出来ませんでした。");
				}
				return false;
			}
		});
		return true;
	});
	return false;
};
var removeMyAddressList = function(myAddressList) {
	var myAddressListId = myAddressList.id;
	var myAddressListName = myAddressList.myAddressListName;
	return oiyConfirm("本当に「" + $.escapeHTML(myAddressListName) + "」を削除してよろしいですか？", function() {
		var lparams = { id:myAddressListId };
		$.ajax({
			type: 'post',
			url: "${createLink(action:'removeMyAddressList')}",
			data: lparams,
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					updateMyAddressListOnNameDialog(); // 一覧の再表示
					var editMyAddressListSelection = $("#editMyAddressListId");
					if (editMyAddressListSelection.val() == myAddressListId) {
						editMyAddressListSelection.val('');
						updateMyAddressList(0);
					}
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "あて名リストを削除出来ませんでした。");
				}
				return false;
			}
		});
		return true;
	});
};
var showMyAddressListNameDialog = function(title, message, defval, callback) {
	var jqDialog = $("#myAddressListNameDialog");
	if (message) {
		$("#myAddressListNameMessage", jqDialog).text(message);
	}
	var myAddressListName = $("#myAddressListName");
	myAddressListName.val(defval);
	jqDialog.dialog({
		title:title,
		modal:true,
		resizable: true,
		autoOpen: false,
		width: 400,
		height: 200,
		minWidth: 400,
		minHeight: 200,
		overley: { backGroundColor:'#000', opacity:0.5 },
		buttons: [
			{
				text:"OK",
				click:function() {
					var name = myAddressListName.val();
					if (!name) {
						$().toastmessage('showWarningToast', "あて名リスト名を指定してください。");
						myAddressListName.focus();
						return false;
					}
					if (callback) {
						callback(jqDialog, name);
					} else {
						jqDialog.dialog('close');
					}
					return false;
				}
			},
			{
				text:"キャンセル",
				click:function() {
					jqDialog.dialog('close');
					return false;
				}
			}
		],
		open: function() {
			OIY.Dialog.closeOnEnterKeypressed(this);
			myAddressListName.focus();
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	jqDialog.dialog('open');
	return false;
};
var createNewAddressList = function() {
	var title = "あて名リストの新規登録";
	var message = "新規に追加するあて名リストの名前を入力してください。";
	return showMyAddressListNameDialog(title, message, "", function(myAddressListNameDialog, myAddressListName) {
		var lparams = { myAddressListName:myAddressListName };
		$.ajax({
			type: 'post',
			url: "${createLink(action:'addMyAddressList')}",
			data: lparams,
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					myAddressListNameDialog.dialog('close');
					updateMyAddressListOnNameDialog(); // 一覧の再表示
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "あて名リストを新規登録出来ませんでした。");
				}
				return false;
			}
		});
		return true;
	});
};
$("#uploadMyAddressListEditBtn").click(function() {
	var jqDialog = $("#myAddressListEditDialog");
	$("#myAddressListEditDialogCreateBtn", jqDialog).unbind('click').click(createNewAddressList);
	$("#myAddressListEditDialogCloseBtn", jqDialog).unbind('click').click(function() {
		jqDialog.dialog('close');
		return false;
	});

	jqDialog.dialog({
		modal:true,
		resizable: true,
		autoOpen: false,
		width: 400,
		height: 300,
		minWidth: 400,
		minHeight: 300,
		overley: { backGroundColor:'#000', opacity:0.5 },
		open: function() {
			updateMyAddressListOnNameDialog();
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	jqDialog.dialog('open');
	return false;
});
$("#myAddressListCreateBtn").click(createNewAddressList);
var selectUploadTypeFormValidator = $("#selectUploadTypeForm").validate({
	onfocusout:false,
	onkeyup:false,
	onclick:false,
	rules:{
		myAddressListId:{
			required:true
		}
	},
	messages:{
		myAddressListId:"あて名データを登録するあて名リストを指定してください。"
	},
	showErrors:function(errorMap, errorList) {
		if (errorList) {
			for (var index = 0; index < errorList.length; index++) {
				var message = errorList[index].message;
				$().toastmessage('showErrorToast', message);
			}
		}
		return false;
	}
});
$("#selectUploadTypeBtn").click(function() {
	if (selectUploadTypeFormValidator.form()) {
		pleaseWait();
		document.selectUploadTypeForm.submit();
	}
	return false;
});
var primarySearchKey = "${params.primarySearchKey?.encodeAsHTML()}";
var primarySearchKeyMap = { "a":"tE","あ":"tA","か":"tKA","さ":"tSA","た":"tTA","な":"tNA","は":"tHA","ま":"tMA","や":"tYA","ら":"tRA","わ":"tWA","＝":"tAT" };
var updateTabSelection = function() {
	var tabClass = primarySearchKeyMap[primarySearchKey];
	if (!tabClass) {
		tabClass = "tALL";
	}
	$("#hTabUL").removeClass().addClass(tabClass);
	return false;
};
$(".selectPrimarySearchKeyBtn").click(function() {
	primarySearchKey = $(this).attr('searchkey');
	updateTabSelection();
	return updateMyAddressList(0);
});
$("#editMyAddressListId").change(function() {
	updateMyAddressList(0);
	return true;
});
$("#selectAllCheckbox").click(function() {
	$("input:checkbox.selectMyAddressCheckbox").setChecked($(this).isChecked());
	return true;
});
myAddressListFunc = new listFunc("myAddressListFunc", 20, "familyNameKana", "asc");
myAddressListFunc.setDispPageCallback(function(startCount, endCount, totalCount) {
	var pageString = $.insertComma(startCount) + " ～ " + $.insertComma(endCount) + " / " + $.insertComma(totalCount) + "件";
	$(".dispPage", myAddressListFunc.element).text(pageString);
});
var updateMyAddressList = function(offset) {
	if (!$.isNaN(offset)) {
		myAddressListFunc.offset = offset;
	}
	if (myAddressListFunc.offset < 0) {
		myAddressListFunc.offset = 0;
	}
	var myAddressListId = $("#editMyAddressListId").val();
	var pparams = myAddressListFunc.getPageSortParam(null);
	var sparams = { myAddressListId:myAddressListId, primarySearchKey:primarySearchKey };
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	enableCreateMyAddressBtn(false);
	enableDeleteAllBtn(false);
	$.ajax({
		url: "${createLink(action:'listMyAddress')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				myAddressListFunc.updatePagination(data.totalCount, data.offset);
				var myAddressTable = $("#myAddressTable");
				myAddressTable.empty();
				$("#selectAllCheckbox").setChecked(false);
				if (!$.isNull(myAddressListId) && (data.totalCount < maxMyAddressCountPerList)) {
					enableCreateMyAddressBtn(true);
				}
				var madrList = data.list;
				if (madrList && (madrList.length > 0)) {
					if (!$.isNull(myAddressListId)) {
						enableDeleteAllBtn(true);
					}
					var td0Attr = { style:"vertical-align:middle;" };
					var td1Attr = { style:"vertical-align:middle;" };
					var td2Attr = { style:"vertical-align:middle;" };
					var td3Attr = { style:"vertical-align:middle;" };
					var td4Attr = { style:"vertical-align:middle;" };
					var td5Attr = { style:"vertical-align:middle;" };
					var madrno = offset;
					for (var index = 0; index < madrList.length; index++) {
						madrno++;
						var madr = madrList[index];
						// ダイアログの一覧
						var removeCheckbox = $('<input type="checkbox" />').addClass('selectMyAddressCheckbox align_center').data(madr);
						var td0 = $('<td />', td0Attr).append(removeCheckbox);
						var td1 = $('<td />', td1Attr).addClass('align_right').text(madrno);
						var td2 = $('<td />', td2Attr).addClass('align_left').text($.nvlW(madr.corporateName));
						var name = $.nvl(madr.familyName);
						if (!$.isNull(madr.firstName)) {
							if (!$.isNull(name)) {
								name += " ";
							}
							name += madr.firstName;
						}
						var td3 = $('<td />', td3Attr).addClass('align_left').text($.nvlW(name));
						var address = '';
						if (madr.addressState) {
							address += madr.addressState;
						}
						if (madr.address1) {
							address += madr.address1;
						}
						if (madr.address2) {
							address += madr.address2;
						}
						var td4 = $('<td />', td4Attr).addClass('align_left').append(address);
						var editBtn = $('<input type="image" alt="詳細" />').addClass('editMyAddressBtn align_center').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/bt_shousai_w.gif").data(madr);
						var td5 = $('<td />', td5Attr).append(editBtn);
						var tr = $('<tr />').append(td0).append(td1).append(td2).append(td3).append(td4).append(td5);
						myAddressTable.append(tr);
					}
					$(".editMyAddressBtn").click(function() {
						var madr = $(this).data();
						pleaseWait();
						document.editMyAddressForm.myAddressId.value = madr.id;
						document.editMyAddressForm.submit();
						return false;
					});
					$("tr", myAddressTable).evenodd();
				} else {
					var td = $('<td />', { 'colspan':'7', style:'text-align:center; vertical-align:middle;' }).text('登録されていません');
					var tr = $('<tr />').append(td);
					myAddressTable.append(tr);
				}

			} else {
				myAddressListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "あて名一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var createMyAddressBtn = $("#createMyAddressBtn");
var disabledCreateMyAddressBtn = $("#disabledCreateMyAddressBtn");
var enableCreateMyAddressBtn = function(enable) {
	if (enable) {
		createMyAddressBtn.show();
		disabledCreateMyAddressBtn.hide();
	} else {
		createMyAddressBtn.hide();
		disabledCreateMyAddressBtn.show();
	}
};
createMyAddressBtn.click(function() {
	var myAddressListId = $("#editMyAddressListId").val();
	if (!myAddressListId) {
		$().toastmessage('showErrorToast', "あて名リストを選択してください。");
		return false;
	}
	pleaseWait();
	document.createMyAddressForm.myAddressListId.value = myAddressListId;
	document.createMyAddressForm.submit();
	return false;
});
$("#downloadBtn").click(function() {
	document.downloadMyAddressForm.primarySearchKey.value = primarySearchKey;
	document.downloadMyAddressForm.myAddressListId.value = $("#editMyAddressListId").val();
	document.downloadMyAddressForm.submit();
	return false;
});
var deleteAllBtn = $("#deleteAllBtn");
var disabledDeleteAllBtn = $("#disabledDeleteAllBtn");
var enableDeleteAllBtn = function(enable) {
	if (enable) {
		deleteAllBtn.show();
		disabledDeleteAllBtn.hide();
	} else {
		deleteAllBtn.hide();
		disabledDeleteAllBtn.show();
	}
};
deleteAllBtn.click(function() {
	var myAddressListId = $("#editMyAddressListId").val();
	if (!myAddressListId) {
		$().toastmessage('showErrorToast', "あて名リストを選択してください。");
		return false;
	}
	return oiyConfirm("あて名リストに含まれる全てのあて名を削除しますか？", function() {
		var rparams = { myAddressListId:myAddressListId };
		$.ajax({
			url: "${createLink(action:'removeAllMyAddressByList')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "あて名を削除しました。");
					updateMyAddressList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "あて名を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
});
var selectedMyAddressIds = function() {
	var ids = Array();
	$("input:checkbox:checked.selectMyAddressCheckbox").each(function(index, element) {
		var madr = $(this).data();
		ids.push(madr.id);
	});
	return ids;
};
$("#deleteBtn").click(function() {
	var ids = selectedMyAddressIds();
	if (ids.length <= 0) {
		$().toastmessage('showErrorToast', "削除するあて名を選択してください。");
		return false;
	}
	return oiyConfirm("選択したあて名を削除しますか？", function() {
		var rparams = { ids:ids };
		$.ajax({
			url: "${createLink(action:'removeMyAddress')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				if ((data.result == "success") && (data.removed > 0)) {
					$().toastmessage('showSuccessToast', data.totalCount + "件中" + data.removed + "件のあて名を削除しました。");
					updateMyAddressList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "あて名を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
});
myAddressListFunc.initList();
myAddressListFunc.addEventListner(updateMyAddressList, updateMyAddressList);
updateTabSelection();
updateMyAddressList(${params.offset?.encodeAsHTML()});
<g:if test="${flash.totalCount && flash.errorCount}">
var totalCount = ${flash.totalCount};
var errorCount = ${flash.errorCount};
var uploadErrorDialog = $("#uploadErrorDialog");
uploadErrorDialog.dialog({
	modal:true,
	resizable: false,
	autoOpen: true,
	width: 400,
	height: 120,
	overley: { backGroundColor:'#000', opacity:0.5 },
	buttons: [
		{
			text:"エラーの詳細を表示する",
			click:function() {
				uploadErrorDialog.dialog('close');
				document.showUploadedErrorsForm.submit();
				return false;
			}
		},
		{
			text:"閉じる",
			click:function() {
				uploadErrorDialog.dialog('close');
				return false;
			}
		}
	]
});
</g:if>
});</r:script>
</body>
</html>