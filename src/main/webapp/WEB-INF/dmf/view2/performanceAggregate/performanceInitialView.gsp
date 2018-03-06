<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>実績集計</title>
</head>
<body>
	<div class="mainBlock">
		<g:render template="/common/fragment/flashmessages" />
		<h1>実績集計</h1>
		<table>
			<tbody>
				<tr>
					<td height="40px">
						<div style="padding: 10px 10px 10px 10px;">
						<g:form name="searchForm" action="search">
						<input type="hidden" id="transitionId" name="transitionId" value="${result?.transitionId?.encodeAsHTML()}" />
							<table style="border-style: none;">
								<tr class="prop odd">
									<td class="name" style="text-align: center;font-weight :bold;border-right: 2px solid #ffffff;">
										<div>集計年月：</div>
										
									</td>
									<td class="value">
									<div style="padding-left: 5px;float:left;">
									<g:select id="year" name="year" from="${result?.addYearList}" value="${result?.year?.encodeAsHTML()}" />
									</div>
									<div style="padding-left: 5px;float:left;">
									&nbsp;&nbsp;年&nbsp;&nbsp;
									</div>	
									<div style="padding-left: 5px;float:left;">
									<g:select id="month" name="month" from="${result?.addMonthList}" value="${result?.month?.encodeAsHTML()}" />
									</div>
									<div style="padding-left: 5px;float:left;">
									&nbsp;&nbsp;月
									</div>
									</td>
								</tr>
								<tr class="prop even">
									<td class="name" style="text-align: center;font-weight :bold;">
										<div>集計の種類：</div>
										
									</td>
									<td class="value">
										<table style="border-style: none;">
										<g:if test="${result?.screenControl == 'ROLE_JPOST_BRANCH_USER'}">
											<tr height="30px">
												<td>支店向け</td>
												<td><div style="padding-top: 6px;">${salesBranchName?.encodeAsHTML()}</div>
												<input type="hidden" id="salesBranchName" name="salesBranchName" value="${salesBranchName?.encodeAsHTML()}" />
												<input type="hidden" id="salesBranchId" name="salesBranchId" value="${salesBranchId?.encodeAsHTML()}" />
												</td>
											</tr>
											
										</g:if>
										<g:else>
											<tr height="30px">
												<td><input type="radio" id="myGroupBranch" name="myGroup" value="Branch" <g:if test="${radioSelect == 'Branch'}">checked="checked"</g:if>/><label for="myGroupBranch">支店向け</label></td>
												<td><div style="padding-top: 6px;"><span id="salesBranchName">${salesBranchName?.encodeAsHTML()}</span>
												<input type="hidden" id="salesBranchNameHidden" name="salesBranchName" value="${salesBranchName?.encodeAsHTML()}" />
												<input type="hidden" id="salesBranchId" name="salesBranchId" value="${salesBranchId?.encodeAsHTML()}" />
												<a id="searchConditiontoggler" class="button" href="javascript:topwin();">
												<span class="icon-conditiontoggler">支店検索</span></a>
												</div>
												</td>
											</tr>
											<tr>
												<td><input type="radio" id="myGroupBranchOffice" name="myGroup" value="BranchOffice" <g:if test="${radioSelect == 'BranchOffice'}">checked="checked"</g:if>/><label for="myGroupBranchOffice">支社・本社向け</label></td>
												<td>
												<g:select id="divisionName" name="divisionName" value="${divisionName?.encodeAsHTML()}" onChange="javascript:divisionNameChange();"
													from="${result?.codeList}"
													noSelection="${['000000':'全社']}"
													optionKey="id" optionValue="name" >
												</g:select>
												
												</td>
											</tr>
										</g:else>
										</table>
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
							<tr class="prop odd">
								<td>
									<div style="padding:12px 20px 8px 400px;float:left;">
									<sec:ifAnyGranted roles ="AUTHORITY_JPMD_MANAGE_USER,AUTHORITY_JPMD_PERSONAL_DATA_USER,AUTHORITY_JPMD_USER">
									<a href="${createLink(controller:'salesManagement', action:'index')}"  class="button" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
									</sec:ifAnyGranted>
									<sec:ifAnyGranted roles ="AUTHORITY_JPOST_USER">
									<a id="backBtn" class="button" href="#">
									<span class="icon-conditiontoggler">戻る</span></a>
									</sec:ifAnyGranted>
									</div>
									<div style="padding:12px 20px 8px 20px;">
									<a id="searchBtn" class="button" href="#">
									<span class="icon-conditiontoggler">集計ファイル検索</span></a>
									</div>
								</td>
								
							</tr>
						</table>
					
					</td>
				</tr>
			</tbody>
		</table>
		<div><h1>検索結果</h1></div>
		<div>
			<table>
				<tbody>
					<tr>
						<td>
							<div style="padding: 20px 10px 10px 10px;">
								<table>
									<col style="width:20%;">
									<col style="width:40%;">
									<col style="width:40%;">
									
								
									<tr class="prop odd">
										
										<td style="text-align: center;border-right: 2px solid #ffffff;">集計ファイル</td>
										<td style="border-right: 2px solid #ffffff;">
											<div style="padding-left: 5px;" id="fileName">${fileName?.encodeAsHTML()}</div>
										</td>
										<td>
											<div style="padding-top: 12px;padding-left: 12px;" class="searchConditiontoggler"　　>
											<a id="dowmLoad" name="dowmLoad" class="button" href="#">
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
        <div><h1>申込状況ダウンロード</h1></div>
            <g:form method="get" action="hidukeLoad" name="hidukeLoad">
        	<table>
				<tbody>
				    <tr><td><span style="margin-left:10px;padding-top:20px;font-weight:bold;">日付検索</span></td></tr>
					<tr>
						<td>
							<!-- <div style="padding: 20px 10px 10px 10px;"> -->
							<div style="padding-left:10px;padding-right:10px;">
								<table>
									<col style="width:20%;">
									<col style="width:40%;">
									<col style="width:40%;">
									
								
									<tr class="prop odd">
										
										<td style="text-align: center;border-right: 2px solid #ffffff;">
										   <input type="radio" id="tyumonhi" name="myGroup" value="Branch" checked="checked"/><label for="tyumonhi">注文日</label>
										</td>
										<td>
											<span id="date" style="margin-left:10px;">
												<input type="text" id="orderDateFrom" name="orderDateFrom" value="${params?.orderDateFrom?.encodeAsHTML()}" />
												～
												<input type="text" id="orderDateTo" name="orderDateTo" value="${params?.orderDateTo?.encodeAsHTML()}" />
											</span>
									    </td>
										<td>
											<div style="padding-top: 12px;padding-left: 12px;" class="searchConditiontoggler"　　>
											<a id="hidukeDownload" name="hidukeDownload" class="button" href="#">
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
		</g:form>
	</div>

<g:form name="downloadForm" action="download">
<input type="hidden" id="year" name="year" value="${result?.year?.encodeAsHTML()}" />
<input type="hidden" id="month" name="month" value="${result?.month?.encodeAsHTML()}" />
<input type="hidden" id="salesBranchName" name="salesBranchName" value="${salesBranchName?.encodeAsHTML()}" />
<input type="hidden" id="salesBranchId" name="salesBranchId" value="${salesBranchId?.encodeAsHTML()}" />
<input type="hidden" id="divisionName" name="divisionName" value="${divisionName?.encodeAsHTML()}" />
<input type="hidden" id="radioSelect" name="radioSelect" value="${radioSelect?.encodeAsHTML()}" />
</g:form>
<g:form name="backForm" action="back">
<input type="hidden" id="transitionId" name="transitionId" value="${result?.transitionId?.encodeAsHTML()}" />
</g:form>		
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
var formValidator = $("#hidukeLoad").validate({<%-- 検索ボタン入力チェック --%>
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	groups: {
		date: "orderDateFrom orderDateTo",
	},
	errorPlacement: function(error, element) {
		switch(element.prop('name')) {
			case "orderDateFrom":
			case "orderDateTo":
				error.insertAfter($('#date'));
				break;
			default:
				error.insertAfter(element);
		}
	},
	rules:{
		orderDateFrom:{
			date:true,
			dateDiff:true
		},
		orderDateTo:{
			date:true,
			dateDiff:true
		}
	},
	messages:{
		orderDateFrom:{
			date:"日付が正しくありません。",
			dateDiff:"終了日を開始日以降に入力してください。"
		},
		orderDateTo:{
			date:"日付が正しくありません。",
			dateDiff:"終了日を開始日以降に入力してください。"
		}
	}
});
//日付比較
jQuery.validator.addMethod("dateDiff", function(value, element) {
	var dateTo = $('#orderDateTo').val();
	var dateFrom = $('#orderDateFrom').val();
	if(!dateTo || dateTo == "" || !dateFrom || dateFrom == ""){
		return true;
	}else{
		return new Date(Date.parse(dateFrom.replace("-", "/"))) <= new Date(Date.parse(dateTo.replace("-", "/")));
	}},"終了日に開始日以降の日付を入力してください。"
);
$("#searchBtn").click(function() {
	document.searchForm.submit();
	return false;
});
$("#backBtn").click(function() {
	document.backForm.submit();
	return false;
});
$("#dowmLoad").click(function() {
	document.downloadForm.submit();
	return false;
});
$('#hidukeDownload').click(function() { 
   if (formValidator.form()) {
	    if($('#orderDateFrom').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateFrom').val())){
			return false;
		}
		if($('#orderDateTo').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateTo').val())){
			return false;
		}

		var fromdate = new Date($('#orderDateFrom').val());
	    var todate = new Date($('#orderDateTo').val());
	    fromdate.setYear(fromdate.getFullYear()+1);
	    if(fromdate <= todate){
	      alert("日付範囲は１ヶ年を超える");
	      return false;
	    }
		document.hidukeLoad.submit();
	}
});
<%-- 検索実行 --%>
function isDate(str)
{
	var d = new Date(str)
	return !isNaN(d)
}
$('#orderDateFrom').datepicker({});
$('#orderDateTo').datepicker({});
</jq:jquery>
<script type="text/javascript">
function fileSearch() {
	$.post("search", function(data) {
		if(data.fileName == ""){
		document.getElementById("validatorMessageArea").style.display = "block";
		document.getElementById("validatorMessageBox").innerHTML = "ファイルが見つかません。";
		}else{
		document.getElementById("validatorMessageArea").style.display = "none";		
		}
	});
	return false;
}
function topwin(){
	var returnValue = window.showModalDialog("${createLink(controller:'performanceAggregate', action:'officeSearch')}","","dialogWidth:600px;dialogHeight:500px;scroll:no;status:no");
	
	if (returnValue == null) 
	{
		return;
	}
	else
	{
		
		document.getElementById("salesBranchNameHidden").value = returnValue[1];
		document.getElementById("salesBranchName").innerHTML = returnValue[1];
		document.getElementById("salesBranchId").value = returnValue[0];
		document.getElementById("myGroupBranch").checked = "checked";
	}
	
	
   } 
function divisionNameChange(){
	document.getElementById("myGroupBranchOffice").checked = "checked";
} 
</script>
</body>
</html>