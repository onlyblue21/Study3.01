<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>入金取消込アップロード</title>
		<g:javascript library="jquery" plugin="jquery" />
	</head>
	<body>

		<div class="mainBlock">
			<h1>入金消込の更新</h1>

			<hr style="margin-top:1em; margin-bottom:1em;" />

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<g:uploadForm action="upload" name="uploadForm">
				<div>
					入金消込CSVファイル：
					<input type="file" name="csvFile" value="" size="40", maxlength="255" />
				</div>
				<div class="searchButtons" style="float:left;">
				<a href="<g:createLink controller='bankManagement' action='index'></g:createLink>" id="goBack" class="button" onclick="" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
				</div>
				<div>
					<button id="uploadBtn">入金消込アップロード</button>
				</div>
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