<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテム（テンプレート）の一括アップロード</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">アイテム（テンプレート）一覧</g:link></li>
			<li>アイテム（テンプレート）の一括アップロード</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>アイテム（テンプレート）の一括アップロード</h1>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<h2>システムからダウンロード</h2>

		<div>
			<g:link action="download">アイテム（テンプレート）CSV</g:link>
		</div>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<h2>システムに登録</h2>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<g:uploadForm action="upload" name="uploadForm">
			<div>
				アイテム（テンプレート）：
				<input type="file" name="csvFile" value="" size="40", maxlength="255" />
			</div>
			<div>
				<button id="uploadBtn">登録</button>
			</div>
		</g:uploadForm>

<g:if test="${result == 'success'}">
		<hr style="margin-top:1em; margin-bottom:1em;" />

		<div>
			<g:formatNumber format="###,###" number="${successCount}" /> 件登録しました。<br />
			サムネイル(大)を更新する場合、<g:link controller="updateTemplateInfo" action="index">アイテムの更新</g:link>を実行してください。
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

<r:script>
;jQuery(function(){
var formValidator = $("#uploadForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		csvFile:{
			required:true,
			extension:'csv'
		}
	},
	messages:{
		csvFile:{
			required:"アイテム（テンプレート）を指定してください。",
			extension:"CSVファイルを指定してください。"
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
});</r:script>
</body>
</html>
