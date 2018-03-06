<html>
<head>
	<meta name="layout" content="content" />
	<title>支店検索</title>
</head>
<body>
	<div style="width:600px;" class="mainBlock">
		
<g:render template="/common/fragment/flashmessages" />
		<table>
			<tbody>
				<tr>
					<td height="40px">
						<div style="padding: 10px 10px 10px 10px;">
						<g:form name="officeSearchForm" action="officeSearchBtn">
							<table style="border-style: none;">
								<tr class="prop odd">
									<td class="name" style="text-align: center;font-weight :bold;">
										都道府県：									
									</td>
									<td class="name" style="text-align: center;font-weight :bold;">
																				
									</td>
									<td class="value"><div style="padding-left: 5px;">
									<g:select id="listAddressState" name="salesBranchStateName" value="${salesBranchStateName}"
										from="${listAddressState}"
										noSelection="${['':'すべて']}"
										optionKey="name" optionValue="name" >
									</g:select>
									</div></td>
								</tr>
								<tr class="prop even">
									<td class="name" style="text-align: center;font-weight :bold;">
										<div>支店名：</div>
										
									</td>
									<td class="name" style="text-align: left;font-weight :bold;">
										<div>(漢字）</div>
										
									</td>
									<td class="value">
										<input type="text" id="salesBranchName" name="salesBranchName" value="${salesBranchName?.encodeAsHTML()}" />
									</td>
								</tr>
								<tr class="prop odd">
									<td class="name" style="text-align: center;font-weight :bold;">
									</td>
									<td class="name" style="text-align: left;font-weight :bold;">
										<div>支店コード</div>
									</td>
									<td class="value">
										<input type="text" id="salesBranchId" name="salesBranchId" value="${salesBranchId?.encodeAsHTML()}" />
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
									<div style="padding:12px 20px 8px 230px;float:left;">
									<a id="searchBtn" class="button" href="javascript:void(0)">
									<span class="icon-conditiontoggler">検索</span></a>
									</div>
									<div style="padding:12px 20px 8px 20px;">
									<a id="closeBtn" class="button" href="javascript:return false;">
									<span class="icon-conditiontoggler">閉じる</span></a>
									</div>
								</td>
								
							</tr>
						</table>
					
					</td>
				</tr>
			</tbody>
		</table>

		<div>
			<table>
				<tbody>
					<tr>
						<td>
							<div class="list" style="padding: 10px 10px 0px 10px;">
								<table style="width:556px;table-layout: fixed;">
									<col style="width:10%;">
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:50%;">
									<tr class="prop odd">
										<th style="text-align: center;font-weight :bold;">
											選択
										</th>
										<th style="text-align: center;font-weight :bold;">都道府県</th>
										<th style="text-align: center;font-weight :bold;">
											支店コード
										</th>
										<th style="text-align: center;font-weight :bold;">
											支店名
										</th>
										
									</tr>
								</table>
							</div>
						
							<div class="list" style="padding: 0px 10px 10px 10px;">
								<div style="overflow-y:auto; width:100%;height:150px">
								<table style="width:556px;table-layout: fixed;">
									<col style="width:10%;">
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:50%;">
								
									<tbody id="resultListBody" >
		  							</tbody>
								</table>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="displayCol"  style="text-align: left;padding-top: 12px;padding-left: 12px;display:none" 
							class="searchConditiontoggler">
							<a id="selectBtn" class="button" href="javascript:return true;">
							<span class="icon-conditiontoggler">選択決定</span></a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		
		</div>
		
	</div>
	
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#searchBtn").click(function() {	
//	document.officeSearchForm.submit();	
	fileSearch();
	return false;
});
$("#closeBtn").click(function() {	
	window.close();
	return false;
});
$("#selectBtn").click(function() {	
	var code ="";
	var name ="";
    var num;                           
    var myGroup = document.getElementsByName("myGroup");
    for(i = 0; i < myGroup.length; i++)
        if(myGroup[i].checked) {
        	num = parseInt(myGroup[i].value);
        	var codeId = "code" + num;
        	var nameId = "name" + num;
        	code = document.getElementById(codeId).innerHTML;
        	name = document.getElementById(nameId).innerHTML;
            break;
        }
	var returnValue = [];
	returnValue.push(code);
	returnValue.push(name);
	window.returnValue = returnValue;
	window.close();
	return false;
 });
</jq:jquery>
<script type="text/javascript">
function fileSearch() {
	var param = {};
	param.salesBranchId = document.getElementById('salesBranchId').value;
	param.salesBranchStateName = $('#listAddressState').val();
	param.salesBranchName = document.getElementById('salesBranchName').value;
	$.post("officeSearchBtn",param, function(data) {
		var html = "";
		$.each(data, function(i, rec) {
			if(i%2==0){
				html += '<tr class="prop odd">';
			}else{
				html += '<tr class="prop even">';
			}
			html += '<td style="text-align: center;">';
			if(i == 0){
				html += '<input type="radio" id="'+ i + '" name="myGroup" value="'+ i +'" checked="checked"/>';
				}else{
				html += '<input type="radio" id="'+ i + '" name="myGroup" value="'+ i +'"/>';
				}
			html += '</td>';
			html += '<td>'+ rec.salesBranchStateName +'</td>';
			html += '<td id="code'+ i +'">'+ rec.salesBranchId +'</td>';
			html += '<td id="name'+ i +'">' + rec.salesBranchName +'</td>';
			html += '</tr>';
		})
		if(data.length != 0){
		document.getElementById('displayCol').style.display = "block";
		}
		$("#resultListBody").html(html);
	});
	return false;
}

</script>
</body>
</html>