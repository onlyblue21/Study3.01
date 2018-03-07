<%@ page import="net.sf.ehcache.search.aggregator.Count" %>
<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>タウンメール配達地域の一括アップロード</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>タウンメール配達地域の一括アップロード</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>タウンメール配達地域の一括アップロード</h1>

		<hr style="margin-top:1em; margin-bottom:1em;" />

		<h2>システムに登録</h2>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<g:uploadForm action="upload" name="uploadForm">
			<div>
				タウンメール配達地域：
				<input type="file" name="dataFile" value="" size="40", maxlength="255" />
			</div>
			<div>
				<button id="uploadBtn">登録</button>
			</div>
		</g:uploadForm>

<g:if test="${result == 'success'}">
		<hr style="margin-top:1em; margin-bottom:1em;" />

		<div>
			<g:formatNumber format="###,###" number="${successCount}" /> 件登録、<g:formatNumber format="###,###" number="${removeCount}" /> 件削除しました。
		</div>
<g:if test="${failedList}">
		<div>
			<h3>次のレコードは登録できませんでした。(<g:formatNumber format="###,###" number="${failedCount}" /> 件)</h3>
<g:each in="${failedList}" status="i" var="failed">
<g:if test="${failed.filename}">
			<div>----${failed.filename.encodeAsHTML()}----</div>
</g:if>
<g:else>
			<div>
				<span><g:formatNumber format="###,###" number="${failed.line}" />行目</span>：
				<span>${failed.data?.encodeAsHTML()}</span>
				(<span>${failed.message?.encodeAsHTML()}</span>)
			</div>
</g:else>
</g:each>
		</div>
</g:if>
</g:if>

		<hr style="margin-top:1em; margin-bottom:1em;" />
		<div>
			<button id="deleteAllBtn">全件削除</button>
		</div>

	</div>

<g:form name="deleteAllForm" action="deleteAll"></g:form>
<r:script>
;jQuery(function(){
var formValidator = $("#uploadForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		dataFile:{
			required:true,
			extension:'csv|zip'
		}
	},
	messages:{
		dataFile:{
			required:"タウンメール配達地域を指定してください。",
			extension:"CSVファイル、または、ZIPファイルを指定してください。"
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
$("#deleteAllBtn").button().click(function() {
	return confirmRemove(document.deleteAllForm, "タウンメール配達地域を全て削除します。\nよろしいでしょうか？");
});
});</r:script>
</body>
</html>
