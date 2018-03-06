<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>NP用ファイルダウンロード</title>
		<g:javascript library="jquery" plugin="jquery" />
	</head>
	<body>

		<div class="mainBlock">
			<h1>NP用ファイルダウンロード</h1>

			<hr style="margin-top:1em; margin-bottom:1em;" />

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />
	<div id="searchConditionFormArea">
		<table>
			<tbody>
				<tr class="prop">
					<td class="name">種別：</td>
					<td class="value">
						<div style="float:left;width:180px;">
							<g:radio id="transaction" name="category" value="transaction" checked="true"/><label for="transaction">取引登録用CSV</label>
						</div>
					</td>
				</tr>
				<tr class="prop">
					<td class="name"></td>
					<td class="value">
						<div style="float:left;width:50px;">&nbsp;&nbsp;</div>
						<div style="float:left;width:150px;">
							<g:checkBox id="ssNone" name="ssNone" checked="true"/><label for="ssNone">未確認（新規与信）</label>
						</div>
						<div style="float:left;width:100px;">
							<g:checkBox id="ssBillInCreditlimit" name="ssBillInCreditlimit" /><label for="ssBillInCreditlimit">与信中</label>
						</div>
						<div style="float:left;width:100px;">
							<g:checkBox id="ssBillInExamination" name="ssBillInExamination" /><label for="ssBillInExamination">与信審査中</label>
						</div>
						<div style="float:left;width:100px;">
							<g:checkBox id="ssBillInReservation" name="ssBillInReservation" /><label for="ssBillInReservation">与信保留</label>
						</div>
						<div style="float:left;width:100px;">
							<g:checkBox id="ssBillNG" name="ssBillNG" /><label for="ssBillNG">与信NG</label>
						</div>
					</td>
				</tr>
				<tr style="height:10px;" class="prop"></tr>
				<tr class="prop">
					<td class="name">&nbsp;</td>
					<td class="value">
						<div style="float:left;width:180px;">
							<g:radio id="adding" name="category" value="adding" /><label for="adding">売上報告用CSV</label>
						</div>
					</td>
				</tr>
				<tr class="prop">
					<td class="name">&nbsp;</td>
					<td class="value">
						<div style="float:left;width:50px;">&nbsp;&nbsp;</div>
						<div style="float:left;width:150px;">
							<g:checkBox id="ssBillOK" name="ssBillOK" checked="true"/><label for="ssBillOK">与信済（新規売上報告）</label>
						</div>
						<div style="float:left;width:180px;">
							<g:checkBox id="ssBillAdding" name="ssBillAdding" /><label for="ssBillAdding">請求済</label>
						</div>
					</td>
				</tr>
				<tr style="height:20px;" class="prop"></tr>
				<tr class="prop">
					<td colspan="2" style="text-align: center;">
						<div class="searchButtons" style="float:left;">
							<a href="<g:createLink controller='poiManagement' action='index'></g:createLink>" id="goBack" class="button" onclick="" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
						</div>
						<div class="searchButtons">
							<a href="javascript:void(0)" id="downloadBtn" class="button"><span class="icon-search">&nbsp;ダウンロード&nbsp;</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>
<g:form action="download" name="downloadForm">
<input type="hidden" name="category" value="" />
<input type="hidden" name="ssNone" value="" />
<input type="hidden" name="ssBillInCreditlimit" value="" />
<input type="hidden" name="ssBillInExamination" value="" />
<input type="hidden" name="ssBillInReservation" value="" />
<input type="hidden" name="ssBillNG" value="" />
<input type="hidden" name="ssBillOK" value="" />
<input type="hidden" name="ssBillAdding" value="" />
</g:form>
<jq:jquery>
$("#downloadBtn").click(function() {
	document.getElementById("validatorMessageArea").style.display = "none";
	document.getElementById("validatorMessageBox").innerHTML = "";
	if ($("#transaction").is(':checked')) {
		if ($("#ssNone").is(':checked') == false &&
			$("#ssBillInCreditlimit").is(':checked') == false &&
			$("#ssBillInExamination").is(':checked') == false &&
			$("#ssBillInReservation").is(':checked') == false &&
			$("#ssBillNG").is(':checked') == false) {
			document.getElementById("validatorMessageArea").style.display = "block";
			document.getElementById("validatorMessageBox").innerHTML = "取引登録CSV用の決済ステータスを選択して下さい。";
			return false;
		}
		document.downloadForm.category.value = $("#transaction").val();
		document.downloadForm.ssNone.value = $("#ssNone").is(':checked');
		document.downloadForm.ssBillInCreditlimit.value = $("#ssBillInCreditlimit").is(':checked');
		document.downloadForm.ssBillInExamination.value = $("#ssBillInExamination").is(':checked');
		document.downloadForm.ssBillInReservation.value = $("#ssBillInReservation").is(':checked');
		document.downloadForm.ssBillNG.value = $("#ssBillNG").is(':checked');
	}
	else if ($("#adding").is(':checked')) {
		if ($("#ssBillOK").is(':checked') == false &&
			$("#ssBillAdding").is(':checked') == false) {
			document.getElementById("validatorMessageArea").style.display = "block";
			document.getElementById("validatorMessageBox").innerHTML = "売上報告CSV用の決済ステータスを選択して下さい。";
			return false;
		}
		document.downloadForm.category.value = $("#adding").val();
		document.downloadForm.ssBillOK.value = $("#ssBillOK").is(':checked');
		document.downloadForm.ssBillAdding.value = $("#ssBillAdding").is(':checked');
	}
	document.downloadForm.submit();
	return true;
});
</jq:jquery>
	</body>
</html>