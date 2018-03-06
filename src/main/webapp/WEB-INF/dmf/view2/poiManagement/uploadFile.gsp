<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>NP用ファイルアップロード</title>
		<g:javascript library="jquery" plugin="jquery" />
	</head>
	<body>

		<div class="mainBlock">
			<h1>NP用ファイルアップロード</h1>

			<hr style="margin-top:1em; margin-bottom:1em;" />

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />
	<g:uploadForm action="upload" name="uploadForm">
		<table id="menu" >
			<col style="width:100px;">
			<col style="width:500px;">
			<tbody>
				<tr style="height:30px;" class="prop">
					<td>種別：</td>
					<td>
						<div style="float:left;width:180px;">
							<input type="radio" id="authority" name="category" value="authority" <g:if test="${category == 'authority'}">checked="true"</g:if>/><label for="authority">与信結果登録</label>
						</div>
						<div style="float:left;width:180px;">
							<input type="radio" id="transfer" name="category" value="transfer" <g:if test="${category == 'transfer'}">checked="true"</g:if>/><label for="transfer">支払明細登録</label>
						</div>
					</td>
				</tr>
				<tr style="height:30px;" class="prop">
					<td>CSVファイル：</td>
					<td>
						<div><input type="file" id="csvFile" name="csvFile" value="" size="40", maxlength="255" /></div>
					</td>
				</tr>
				<tr style="height:20px;" class="prop"></tr>
				<tr style="height:30px;" class="prop">
					<td colspan="2" style="text-align: center;">
						<div class="searchButtons" style="float:left;">
							<a href="<g:createLink controller='poiManagement' action='index'></g:createLink>" id="goBack" class="button" onclick="" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
						</div>
						<div class="searchButtons">
							<a id="uploadBtn" class="button"><span class="icon-search">&nbsp;アップロード&nbsp;</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</g:uploadForm>

<g:if test="${result == 'success'}">
			<hr style="margin-top:1em; margin-bottom:1em;" />

			<div>
				<g:formatNumber format="###,###" number="${successCount}" /> 件登録しました。
			</div>
<g:if test="${failedList}">
			<div>
				<h3>次のレコードは登録できませんでした。(<g:formatNumber format="###,###" number="${failedList.size()}" /> 件)</h3>
<g:each in="${failedList}" status="i" var="failed">
				<div>
					<span><g:formatNumber format="###,###" number="${failed.line}" />行目</span>：
					<span>${failed.data?.encodeAsHTML()}</span>
					(<span>${failed.message?.encodeAsHTML()}</span>)
				</div>
</g:each>
			</div>
</g:if>
</g:if>

		</div>
<jq:jquery>
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
var formValidator = $("#uploadForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		csvFile:{
			required:true,
			accept:'csv'
		}
	},
	messages:{
		csvFile:{
			required:"CSVファイルを指定してください。",
			accept:"CSVファイルを指定してください。"
		}
	}
});
$("#uploadBtn").button().click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.uploadForm.submit();
	}
	return false;
});
</jq:jquery>
	</body>
</html>