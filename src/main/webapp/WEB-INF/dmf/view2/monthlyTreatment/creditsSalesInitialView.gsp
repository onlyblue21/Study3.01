<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>クレジット売上げデータCSV作成</title>
</head>
<body>
	<div class="mainBlock">
		<h1>クレジット&nbsp;&nbsp;売上げデータCSV作成</h1>
		<g:render template="/common/fragment/flashmessages" />
		<table>
			<tbody>
				<tr>
					<td height="40px">
						<div style="padding: 10px 10px 10px 10px;">
						<g:form name="creatingCSVForm" action="creatingCSVForm">
							<table style="border-style: none;">
								<tr class="prop odd">
									<td class="name" style="text-align: center;font-weight :bold;border-right: 2px solid #ffffff;">
										<div>報告月：</div>
										<div class="nowrap" >（出荷月）</div>
									</td>
									<td class="value">
									<div style="padding-left: 5px;float:left;">
									<g:select id="year" name="year" from="${addYearList}" value="${year?.encodeAsHTML()}" />
									</div>
									<div style="padding-left: 5px;float:left;">
									&nbsp;&nbsp;年&nbsp;&nbsp;
									</div>	
									<div style="padding-left: 5px;float:left;">								
									<g:select id="month" name="month" from="${addMonthList}" value="${month?.encodeAsHTML()}" />
									</div>
									<div style="padding-left: 5px;float:left;">
									&nbsp;&nbsp;月
									</div>
									</td>
								</tr>
							</table>
						</g:form>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<table style="border-style: none;">
						<col style="width:50%;">
						<col style="width:50%;">
							<tr>
								<td>
									<div style="padding-top:10px;text-align: right;padding-right: 30px;" class="searchConditiontoggler"　>
									<a id="" class="button" href="${createLink(controller:'monthlyTreatment', action:'index')}">
									<span class="icon-conditiontoggler">戻る</span></a>
									</div>
								</td>
								<td height="40px">
									<div style="padding-top:10px;text-align: left;" class="searchConditiontoggler"　>
									<a id="creatingCSV" class="button" href="#">
									<span class="icon-conditiontoggler">クレジット売上げデータCSV&nbsp;&nbsp;作成</span></a>
									</div>
								</td>
								
							</tr>
						</table>
					
					</td>
				</tr>
			</tbody>
		</table>
		<div style="padding-top: 10px"><h1>クレジット売上げデータCSV検索</h1></div>
		<div>
			<div class="message flashmessages" id="fileNameError" style="display:none;">
				<p>ファイルが見つかりません。</p>
			</div>
			<table>
				<tbody>
					<tr>
						<td>
							<div style="padding-top:20px;text-align: center;" class="searchConditiontoggler"　>
							<a id="search" class="button" href="#">
							<span class="icon-conditiontoggler">クレジット売上げデータCSV&nbsp;&nbsp;検索</span></a>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="padding-top:20px;padding-left: 10px;">
							検索結果
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="padding: 20px 10px 10px 10px;">
								<table>
									<col style="width:20%;">
									<col style="width:40%;">
									<col style="width:40%;">
									<tr class="prop odd">
										<td style="text-align: center;font-weight :bold;border-right: 2px solid #ffffff;">ファイル名</td>
										<td style="border-right: 2px solid #ffffff;">
											<div style="padding-left: 5px;" id="fileName">${fileName?.encodeAsHTML()}</div>
										</td>
										<td>
											<div style="padding-top: 12px;padding-left: 12px;" class="searchConditiontoggler"　>
											<a id="dowmLoad" class="button" href="#">
											<span class="icon-conditiontoggler">ダウンロード</span></a>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
<g:form name="downloadForm" action="download">
<input type="hidden" id="fileNameHidden" name="fileName" value="${fileName?.encodeAsHTML()}" />
<input type="hidden" id="filePathName" name="filePathName" value="${filePathName?.encodeAsHTML()}" />
<input type="hidden" id="year" name="year" value="${year?.encodeAsHTML()}" />
<input type="hidden" id="month" name="month" value="${month?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>


	
$("#creatingCSV").click(function() {
	
	document.creatingCSVForm.submit();

	return false;
});
$("#search").click(function() {
	fileSearch();
	return false;
});
$("#dowmLoad").click(function() {
	var fileName = document.getElementById("fileName").innerHTML;
	if(fileName != ""){
	document.downloadForm.submit();
	}
	return false;
});
</jq:jquery>
<script type="text/javascript">
function fileSearch() {
	$.post("search", function(data) {
		if(data.fileName == ""){			
			document.getElementById("fileNameError").style.display = "block";
			}else{
			document.getElementById("fileNameError").style.display = "none";		
			}
		document.getElementById("fileName").innerHTML = data.fileName;
		document.getElementById("fileNameHidden").value = data.fileName;
		document.getElementById("filePathName").value = data.filePathName;
	});
	return false;
}


</script>
</body>
</html>