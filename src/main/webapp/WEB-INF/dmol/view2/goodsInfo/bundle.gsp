<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>商品マスタ</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">商品一覧</g:link></li>
			<li>商品マスタ</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>商品マスタ</h1>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<h2>システムからダウンロード</h2>

		<div>
			<g:link action="download">商品マスタCSV</g:link>
		</div>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<h2>システムに登録</h2>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<g:uploadForm action="upload" name="uploadForm">
			<div>
				商品マスタ：
				<input type="file" name="csvFile" value="" size="40", maxlength="255" />
			</div>
			<div>
				<button id="uploadBtn">登録</button>
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
			required:"商品マスタを指定してください。",
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
