<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>大口顧客一覧</title>
	<link rel="stylesheet" href="${r.resource(dir:'static/dmol/css',file:'common.css')}" />
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>大口顧客一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>大口顧客一覧</h1>

		<div class="buttons">
			<span class="button"><g:link action="bundle" class="button">一括アップロード</g:link></span>
		</div>

<g:render template="/common/fragment/flashmessages" />

		<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
			<g:form method="get" action="list" name="searhCondition" onsubmit="return false;">
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.LargeInstitutionalCustomer?.customerType?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="conditionCustomerType" from="${customerTypeList}" optionKey="key" optionValue="value" value="${params.customerType}" noSelection="['':'すべて']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.LargeInstitutionalCustomer?.customerName?.encodeAsHTML()}:</td>
						<td class="value">
							<select id="conditionCustomerName" name="conditionCustomerName">
								<option value="">すべて</option>
							</select>
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

					<tr class="prop">
						<td colspan="2" style="text-align: center;">
							<div class="searchButtons">
								検索した結果を<button id="removeByConditionBtn">一括削除</button>する
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
							<th class="vhcenter"><input type="checkbox" id="selectAllCheckbox" /></th>
							<th>${fieldNames?.LargeInstitutionalCustomer?.customerType?.encodeAsHTML()}</th>
							<th>${fieldNames?.LargeInstitutionalCustomer?.customerName?.encodeAsHTML()}</th>
							<th>${fieldNames?.LargeInstitutionalCustomer?.email?.encodeAsHTML()}</th>
						</tr>
					</thead>
					<tbody id="largeInstitutionalCustomerTable">
					</tbody>
				</table>
			</div>
		</div>

		<div class="buttons">
			<button id="deleteBtn">&nbsp;削除&nbsp;</button>
		</div>

	</div>

<form>
<input type="hidden" id="ccCustomerType" name="ccCustomerType" value="${params.customerType?.encodeAsHTML()}" />
<input type="hidden" id="ccCustomerName" name="ccCustomerName" value="${params.customerName?.encodeAsHTML()}" />
</form>
<div id="removeByConditionPasswdDialog" title="大口会員一括削除" style="display:none;">
	<div style="text-align:left;">
		検索した結果を一括削除します<br />
		<table style="border:none;">
			<tr>
				<td style="width:8em;text-align:right;">登録全件数：</td>
				<td><span id="removeByConditionPasswdDialogTotalCount"></span>件</td>
			</tr>
			<tr>
				<td style="text-align:right;">条件一致件数：</td>
				<td><span id="removeByConditionPasswdDialogRemoveCount"></span>件</td>
			</tr>
		</table>
		よろしければ削除用パスワードを入力して<br />OKボタンを押してください。
	</div>
	<div style="text-align:left;">
		<input type="password" id="removeByConditionPasswdDialogPasswd" name="removeByConditionPasswdDialogPasswd" size="40" maxlength="20" value="" />
	</div>
</div>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
var largeInstitutionalCustomerListFunc = null;
;jQuery(function(){
var updateCustomerNameList = function(customerType, initialValue, callback) {
	$.ajax({
		url: "${createLink(action:'listCustomerName')}",
		data: { 'customerType':customerType },
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var conditionCustomerName = $("#conditionCustomerName");
				conditionCustomerName.empty().append($('<option value="">すべて</option>'));
				if (data.list) {
					for (var index = 0; index < data.list.length; index++) {
						var customerName = data.list[index];
						var opt = $('<option></option>').attr('value', customerName).text(customerName);
						if (initialValue && (initialValue == customerName)) {
							opt.attr('selected', 'selected');
						}
						conditionCustomerName.append(opt);
					}
				}
				if ($.isFunction(callback)) {
					callback();
				}
			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "登録名称(会社名)を取得できませんでした。");
			}
			return false;
		}
	});
	return false;
};
$("#conditionCustomerType").change(function() {
	var customerType = $(this).val();
	updateCustomerNameList(customerType);
	return true;
});
var searchLargeInstitutionalCustomer = function() {
	$("#ccCustomerType").val($("#conditionCustomerType").val());
	$("#ccCustomerName").val($("#conditionCustomerName").val());
	updateLargeInstitutionalCustomerList(0);
	return false;
}
$("#searchBtn").button().click(searchLargeInstitutionalCustomer);
var clearSearchConditionFunc = function() {
	$("#conditionCustomerType").val('');
	$("#conditionCustomerName").val('');
	return false;
};
$("#clearSearchConditionBtn").button().click(clearSearchConditionFunc);
$("#selectAllCheckbox").click(function() {
	$("input:checkbox.selectLargeInstitutionalCustomerCheckbox").setChecked($(this).isChecked());
	return true;
});
largeInstitutionalCustomerListFunc = new listFunc("largeInstitutionalCustomerListFunc", 10, "customerType", "asc");
var updateLargeInstitutionalCustomerList = function(offset) {
	if (!$.isNaN(offset)) {
		largeInstitutionalCustomerListFunc.offset = offset;
	}
	if (largeInstitutionalCustomerListFunc.offset < 0) {
		largeInstitutionalCustomerListFunc.offset = 0;
	}
	var customerType = $("#ccCustomerType").val();
	var customerName = $("#ccCustomerName").val();
	var pparams = largeInstitutionalCustomerListFunc.getPageSortParam(null);
	var sparams = { customerType:customerType, customerName:customerName };
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listLargeInstitutionalCustomer')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				largeInstitutionalCustomerListFunc.updatePagination(data.totalCount, data.offset);
				largeInstitutionalCustomerListFunc.allCount = data.allCount; // 全件数
				var largeInstitutionalCustomerTable = $("#largeInstitutionalCustomerTable");
				largeInstitutionalCustomerTable.empty();
				$("#selectAllCheckbox").setChecked(false);
				var largeInstitutionalCustomerList = data.list;
				if (largeInstitutionalCustomerList && (largeInstitutionalCustomerList.length > 0)) {
					var td0Attr = { style:"text-align:center; vertical-align:middle; width:2em;" };
					var td1Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td2Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td3Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					for (var index = 0; index < largeInstitutionalCustomerList.length; index++) {
						var largeInstitutionalCustomer = largeInstitutionalCustomerList[index];
						// ダイアログの一覧
						var removeCheckbox = $('<input type="checkbox" />').addClass('selectLargeInstitutionalCustomerCheckbox').data(largeInstitutionalCustomer);
						var td0 = $('<td />', td0Attr).append(removeCheckbox);
						var td1 = $('<td />', td1Attr).text($.nvlW(largeInstitutionalCustomer.customerTypeName));
						var td2 = $('<td />', td2Attr).text($.nvlW(largeInstitutionalCustomer.customerName));
						var td3 = $('<td />', td3Attr).text($.nvlW(largeInstitutionalCustomer.email));
						var tr = $('<tr />').append(td0).append(td1).append(td2).append(td3);
						largeInstitutionalCustomerTable.append(tr);
					}
					$("tr", largeInstitutionalCustomerTable).evenodd();
				} else {
					var td = $('<td />', { 'colspan':'4', style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					largeInstitutionalCustomerTable.append(tr);
				}

			} else {
				largeInstitutionalCustomerListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "大口会員一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var selectedLargeInstitutionalCustomerIds = function() {
	var ids = Array();
	$("input:checkbox:checked.selectLargeInstitutionalCustomerCheckbox").each(function(index, element) {
		var largeInstitutionalCustomer = $(this).data();
		ids.push(largeInstitutionalCustomer.id);
	});
	return ids;
};
$("#deleteBtn").button().click(function() {
	var ids = selectedLargeInstitutionalCustomerIds();
	if (ids.length <= 0) {
		$().toastmessage('showErrorToast', "削除する大口会員を選択してください。");
		return false;
	}
	return oiyConfirm("選択した大口会員を削除しますか？", function() {
		pleaseWait();
		var rparams = { ids:ids };
		$.ajax({
			url: "${createLink(action:'removeByIds')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if ((data.result == "success") && (data.removed > 0)) {
					$().toastmessage('showSuccessToast', data.removed + "件の大口会員を削除しました。");
					updateLargeInstitutionalCustomerList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "大口会員を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
});
var removeByConditionFunc = function(rpasswd) {
	pleaseWait();
	var customerType = $("#ccCustomerType").val();
	var customerName = $("#ccCustomerName").val();
	var rparams = { rpasswd:rpasswd, customerType:customerType, customerName:customerName };
	$.ajax({
		url: "${createLink(action:'removeByCondition')}",
		data: rparams,
		success: function(data, textStatus, jqXHR) {
			closeWait();
			if ((data.result == "success") && (data.removed > 0)) {
				$().toastmessage('showSuccessToast', data.removed + "件の大口会員を削除しました。");
				clearSearchConditionFunc();
				searchLargeInstitutionalCustomer();
			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "大口会員を削除出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
$("#removeByConditionBtn").button().click(function() {
	$("#removeByConditionPasswdDialogTotalCount").text($.insertComma(largeInstitutionalCustomerListFunc.allCount));
	$("#removeByConditionPasswdDialogRemoveCount").text($.insertComma(largeInstitutionalCustomerListFunc.totalCount));
	var jqDialog = $("#removeByConditionPasswdDialog");
	jqDialog.dialog({
		autoOpen: false,
		resizable: true,
		width: 320,
		height: 240,
		minWidth: 320,
		minHeight: 240,
		modal: true,
		overley: { backGroundColor:'#000', opacity:0.5 },
		buttons: [
			{
				text:"OK",
				click:function() {
					var rpasswd = $("#removeByConditionPasswdDialogPasswd", jqDialog).val();
					if ($.isNull(rpasswd)) {
						oiyAlert('パスワードを指定してください。');
						return;
					}
					var dparams = { 'rpasswd':rpasswd };
					$.ajax({
						url: "${createLink(action:'checkRemovePasswd')}",
						data: dparams,
						success: function(data, textStatus, jqXHR) {
							if (data.result == 'success') {
								jqDialog.dialog('close');
								removeByConditionFunc(rpasswd);
							} else {
								if ($.isNull(data.message)) {
									oiyAlert('パスワードを指定してください。');
								} else {
									oiyAlert(data.message);
								}
							}
							return false;
						}
					});
				}
			},
			{
				text:"キャンセル",
				click:function() {
					jqDialog.dialog('close');
				}
			}
		],
		open: function() {
			OIY.Dialog.closeOnEnterKeypressed(this);
			$("#removeByConditionPasswdDialogPasswd", jqDialog).val('').focus();
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	jqDialog.dialog('open');
	return false;
});
largeInstitutionalCustomerListFunc.initList();
largeInstitutionalCustomerListFunc.addEventListner(updateLargeInstitutionalCustomerList, updateLargeInstitutionalCustomerList);
updateCustomerNameList($("#ccCustomerType").val(), $("#ccCustomerName").val(), function() {
	updateLargeInstitutionalCustomerList(0);
});
});</r:script>
</body>
</html>
