<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>実績集計</title>
</head>
<body>
	<div class="mainBlock">
		<h1>実績集計</h1>
		<div class="message flashmessages" id="fileNameError" style="display:none;">
		<p>ファイルが見つかりません。</p>
		</div>
<g:render template="/common/fragment/flashmessages" />
		
		<table id="menu" >
			<col style="width:100px;">
			<col style="width:400px;">
			<tbody>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="40px"><div style="text-align: center;padding-top: 5px;">
					<a href="${createLink(controller:'performanceAggregate', action:'performanceInitialView')}" id="salesAccountBtn" class="button" ><span class="nowrap" >実績集計</span></a></div></td>
					<td><div style="padding-top: 5px;padding-left: 5px;">実績集計画面を表示します。</div></td>
				</tr>
				<sec:ifAnyGranted roles ="AUTHORITY_JPOST_USER">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="40px">
						<div style="text-align: center;padding-top: 5px;">
							<a id="dowmLoad" name="dowmLoad" class="button" href="#">
							<span class="nowrap">受注一覧のダウンロード</span></a>
						</div>	
					</td>
					<td><div style="padding-top: 5px;padding-left: 5px;">受注一覧表をダウンロードします。</div></td>
				</tr>
				</sec:ifAnyGranted>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</tbody>
		</table>
	</div>
<g:form name="downloadForm" action="downloadOrder">

</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#menu tbody tr:visible").evenodd();

$("#dowmLoad").click(function() { 
    $.post("searchOrder", function(data) {
		if(data.fileSize == 0){			
			document.getElementById("fileNameError").style.display = "block";
		}else{
			document.getElementById("fileNameError").style.display = "none";	
		    document.downloadForm.submit();	
		}
	});
    
	return true;
});
</jq:jquery>
</body>
</html>