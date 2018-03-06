<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>当日入金一覧CSV作成</title>
</head>
<body>
<g:form method="get" name="creatingCSVForm" action="creatingCSVForm">
			
	<div class="mainBlock">
		<h1>当日入金一覧CSV作成</h1>
		<g:render template="/common/fragment/flashmessages" />
		<table>
			<tbody>
				<tr>
					<td height="40px">
						<div style="padding: 10px 10px 10px 10px;">
							<table style="border-style: none;">
								<tr class="prop even">
									<td class="name" style="text-align: center;font-weight :bold;border: 2px solid #ffffff;">
										<div>決済方法：</div>
									</td>
									<td class="value" style="border: 2px solid #ffffff;">
										<div style="float:left;width:100px;">
											<input type="radio" id="settlementMethodBankTransfer" name="settlementMethod" value="01" <g:if test="${settlementMethod == '01'}">checked="checked"</g:if>/><label for="settlementMethodBankTransfer">銀行振込 </label>
										</div>
										<div style="float:left;width:100px;">
											<input type="radio" id="settlementMethodCashOnDelivery" name="settlementMethod" value="04" <g:if test="${settlementMethod == '04'}">checked="checked"</g:if>/><label for="settlementMethodCashOnDelivery">代金引換</label>
										</div>
										<div style="float:left;width:100px;">
											<input type="radio" id="settlementMethodPaymentOnInvoice" name="settlementMethod" value="03" <g:if test="${settlementMethod == '03'}">checked="checked"</g:if>/><label for="settlementMethodPaymentOnInvoice">請求書決済</label>
										</div>
									</td>
								</tr>
								<tr class="prop odd">
									<td class="name" style="text-align: center;font-weight :bold;border: 2px solid #ffffff;">
										<div>報告日：</div>
										<div class="nowrap" >（入金消込日）</div>
									</td>
									<td class="value" style="border: 2px solid #ffffff;">
										<div style="padding-left: 5px;">
											<input type="text" id="targetDay" name="targetDay" value="${targetDay?.encodeAsHTML()}">
										</div>
									</td>
								</tr>
							</table>
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
									<a id="" class="button" href="${createLink(controller:'dailyTreatment', action:'index')}">
									<span class="icon-conditiontoggler">戻る</span></a>
									</div>
								</td>
								<td height="40px">
									<div style="padding-top:10px;text-align: left;" class="searchConditiontoggler"　>
									<a id="creatingCSV" class="button" href="#">
									<span class="icon-conditiontoggler">当日入金一覧CSV&nbsp;&nbsp;作成</span></a>
									</div>
								</td>
								
							</tr>
						</table>
					
					</td>
				</tr>
			</tbody>
		</table>
		<div style="padding-top: 10px"><h1>当日入金一覧CSV検索</h1></div>
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
							<span class="icon-conditiontoggler">当日入金一覧CSV&nbsp;&nbsp;検索</span></a>
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
											<div style="padding-left: 5px;float:left" id="fileName">${fileName?.encodeAsHTML()}</div>
											
										</td>
										<td>
											<div style="padding-top: 12px;padding-left: 12px;" class="searchConditiontoggler"　>
											<a id="dowmLoad" class="button" href="javascript:void(0)">
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
</g:form>
<g:form name="downloadForm" action="download">
<input type="hidden" id="fileNameHidden" name="fileName" value="${fileName?.encodeAsHTML()}" />
<input type="hidden" name="targetDay" value="${targetDay?.encodeAsHTML()}" />
<input type="hidden" id="filePathName" name="filePathName" value="${filePathName?.encodeAsHTML()}" />
<input type="hidden" name="settlementMethod" value="${settlementMethod?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
var formValidator = $("#creatingCSVForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		
		targetDay:{
			required:true,	
			date:true
		}
	},
	messages:{
		
		targetDay:{
			required:"・報告日を指定してください。",
			date:"日付が正しくありません。"
		}
	}
});
	
$("#creatingCSV").click(function() {
	if (formValidator.form()) {
	document.creatingCSVForm.submit();
	}
	return false;
});

$("#search").click(function() {
	var params = {};
	var methodArray;
	methodArray = document.getElementsByName("settlementMethod");
    for(var i=0; i<methodArray.length; i++){
        if(methodArray[i].checked){
        	params.settlementMethod = methodArray[i].value;
            break;
        }
    }
	$.post("search", params, function(data) {
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
});

$("#dowmLoad").click(function() {
	var fileName = document.getElementById("fileName").innerHTML;
	if(fileName != ""){
	document.downloadForm.submit();
	}
	return false;
});
$('#targetDay').datepicker({
});
</jq:jquery>
</body>
</html>