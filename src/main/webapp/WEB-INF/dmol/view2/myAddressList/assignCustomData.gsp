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
		<h1>CSVファイルアップロード</h1>

<!-- commonContents -->
		<div class="commonContents">

<g:render template="/common/fragment/flashmessages" />

			<p class="readOrange"><span class="bold size14">読み込んだCSVファイルのリスト項目を、DMファクトリーの項目に割り当てます。</span><br />
			プルダウンメニューをクリックして、割り当てる項目を選んでください。<br />
			使用しない項目については、「使用しない」を選択してください。</p>
			
			<div class="innnerBox1 mB30">
				<h2>読み込んだCSVファイルの項目</h2>
				<div class="tableScrollBox borderAblack h100">
					<table cellspacing="0" cellpadding="0" class="csvTable">
						<tr>
<g:each var="header" in="${headers}" status="i">
<th>${header.encodeAsHTML()}</th>
</g:each>
						</tr>
						<tr>
<g:each var="header" in="${headers}" status="i">
<td><g:select name="fieldMapping_${i}" from="${fieldMappingList}" value="${fieldMappedList[i]}" optionKey="key" optionValue="value" class="fieldMappingSelection" /></td>
</g:each>
						</tr>
					</table>
				</div>
			</div>

			<p class="readOrange"><span class="bold size14">項目を割り当てた結果をプレビュー表示します。表示内容を確認し、「アップロード」ボタンをクリックしてください。</span><br />
			<span class="red2">※「氏名・姓」と「会社名」は、いずれかの入力が必須となります。</span></p>
			
			<div class="innnerBox1">
				<h2>プレビュー（先頭から10件分のデータを表示します）</h2>
				<div class="tableScrollBox borderAblack">
					<table cellspacing="0" cellpadding="0" class="csvTable csvTableB" id="demoTableA">
						<thead>
							<tr>
								<th>郵便番号(必須)</th>
								<th>都道府県</th>
								<th>市区町村番地(必須)</th>
								<th>建物(マンション等)</th>
								<th>氏名・姓(必須※)</th>
								<th>氏名・姓(カナ)</th>
								<th>氏名・名</th>
								<th>氏名・名(カナ)</th>
								<th>氏名・敬称</th>
								<th>連名1・姓</th>
								<th>連名1・名</th>
								<th>連名1・敬称</th>
								<th>連名2・姓</th>
								<th>連名2・名</th>
								<th>連名2・敬称</th>
								<th>連名3・姓</th>
								<th>連名3・名</th>
								<th>連名3・敬称</th>
								<th>連名4・姓</th>
								<th>連名4・名</th>
								<th>連名4・敬称</th>
								<th>会社名(必須※)</th>
								<th>組織名(部・グループ)</th>
								<th>部署名(課・係・チーム)</th>
								<th>役職名</th>
								<th>会社敬称</th>
							</tr>
						</thead>
						<tbody id="mappingSampleArea">
<g:each var="index" in="${(1..10)}">
							<tr>
								<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
								<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
								<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
								<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
								<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
</g:each>
						</tbody>
					</table>
				</div>
			</div>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" class="valignM" /></a>
				<input type="image" id="okBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_ok_b-off.gif" alt="OK" class="valignM" disabled="disabled" />
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form action="loadCustomData" name="loadCustomDataForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
<input type="hidden" name="custumDataDelimiter" value="${params.custumDataDelimiter?.encodeAsHTML()}" />
<input type="hidden" name="custumDataNoFirstLine" value="${params.custumDataNoFirstLine?.encodeAsHTML()}" />
<input type="hidden" name="fieldMappedList" value="" />
</g:form>
<g:form action="selectCustomData" name="selectCustomDataForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
<input type="hidden" name="custumDataDelimiter" value="${params.custumDataDelimiter?.encodeAsHTML()}" />
<input type="hidden" name="custumDataNoFirstLine" value="${params.custumDataNoFirstLine?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var okBtn = $("#okBtn");
var listFieldMapping = function() {
	var list = [];
	$("select.fieldMappingSelection").each(function(index, element) {
		list.push($(this).val());
	});
	return list;
};
var createTd = function(value) {
	var td = $('<td />');
	if ($.isNull(value)) {
		td.html('&nbsp;');
	} else {
		td.text(value);
	}
	return td;
};
var updateSampleList = function() {
	okBtn.setDisabled(true);
	var fieldMappedList = listFieldMapping();
	var mparams = { fieldMappedList:fieldMappedList.join(',') };
	$.ajax({
		url: "${createLink(action:'listMappingSample')}",
		data:mparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				// 一覧に値を表示
				var mappingSampleArea = $("#mappingSampleArea"); // 追加先tbody
				mappingSampleArea.empty();
				var appendedCount = 0;
				var sampleList = data.list;
				if (sampleList && (sampleList.length > 0)) {
					for (var index = 0; index < sampleList.length; index++) {
						var sample = sampleList[index];
						var tr = $('<tr />');
						tr.append(createTd(sample.zipcode)); // 郵便番号
						tr.append(createTd(sample.addressState)); // 都道府県
						tr.append(createTd(sample.address1)); // 市区町村番地
						tr.append(createTd(sample.address2)); // 建物(マンション等)
						tr.append(createTd(sample.familyName)); // 氏名・姓
						tr.append(createTd(sample.familyNameKana)); // 氏名・姓(カナ)
						tr.append(createTd(sample.firstName)); // 氏名・名
						tr.append(createTd(sample.firstNameKana)); // 氏名・名(カナ)
						tr.append(createTd(sample.primaryNameSelection)); // 氏名・敬称
						tr.append(createTd(sample.jointFamilyName1)); // 連名１・姓
						tr.append(createTd(sample.jointFirstName1)); // 連名１・名
						tr.append(createTd(sample.jointNameSelection1)); // 連名１の敬称
						tr.append(createTd(sample.jointFamilyName2)); // 連名２・姓
						tr.append(createTd(sample.jointFirstName2)); // 連名２・名
						tr.append(createTd(sample.jointNameSelection2)); // 連名２の敬称
						tr.append(createTd(sample.jointFamilyName3)); // 連名３・姓
						tr.append(createTd(sample.jointFirstName3)); // 連名３・名
						tr.append(createTd(sample.jointNameSelection3)); // 連名３の敬称
						tr.append(createTd(sample.jointFamilyName4)); // 連名４・姓
						tr.append(createTd(sample.jointFirstName4)); // 連名４・名
						tr.append(createTd(sample.jointNameSelection4)); // 連名４の敬称
						tr.append(createTd(sample.corporateName)); // 会社名
						tr.append(createTd(sample.divisionName)); // 組織名(部・グループ)
						tr.append(createTd(sample.departmentName)); // 部署名(課・係・チーム)
						tr.append(createTd(sample.businessTitle)); // 役職名
						tr.append(createTd(sample.titleType)); // 会社敬称
						mappingSampleArea.append(tr);
						appendedCount++;
					}
					var mapped = { zipcode:false };
					for (var index = 0; index < fieldMappedList.length; index++) {
						var fieldMapping = fieldMappedList[index];
						mapped[fieldMapping] = true;
					}
					if (mapped.zipcode && mapped.address1 && (mapped.familyName || mapped.corporateName)) {
						okBtn.setDisabled(false);
					}
				}
				var blankCount = 10 - appendedCount;
				if (blankCount > 0) {
					for (var index = 0; index < blankCount; index++) {
						var tr = $('<tr />');
						for (var tdindex = 0; tdindex < 26; tdindex++) {
							tr.append(createTd(null));
						}
						mappingSampleArea.append(tr);
					}
				}

			} else {
				$().toastmessage('showErrorToast', "割り当て結果プレビューを取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
$("select.fieldMappingSelection").change(function() {
	updateSampleList();
	return true;
});
okBtn.click(function() {
	pleaseWait();
	var fieldMappedList = listFieldMapping();
	document.loadCustomDataForm.fieldMappedList.value = fieldMappedList.join(',');
	document.loadCustomDataForm.submit();
	return false;
});
$("#prevBtn").click(function() {
	pleaseWait();
	document.selectCustomDataForm.submit();
	return false;
});
updateSampleList();
});</r:script>
</body>
</html>