
<html>
<head>
	<meta name="layout" content="dmolBiz" />
	
	<g:if test="${role == 'office'}">
		<title>注文ステータス</title>
	</g:if>
	<g:if test="${role != 'office'}">
		<title>印刷ステータス</title>
	</g:if>
</head>
<body>
	<div class="mainBlock">
		<table cellpadding="0" cellspacing="0" class="commonTable1 mB20" style="table-layout:fixed;">
			<tbody>
				<tr>
					<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="注文No　：　" /></td>
					<td valign="top">${fieldValue(bean: orderInfoData, field: "orderNo")}</td>
				</tr>
				<tr>
					<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="ご注文者　：　" /></td>
					<sec:ifAllGranted roles="AUTHORITY_PERSONAL_DATA">
						<td valign="top" style="word-wrap:break-word;word-break:break-all; ">${fieldValue(bean: orderInfoData, field: "familyName")}&nbsp;${fieldValue(bean: orderInfoData, field: "firstName")}</td>
					</sec:ifAllGranted>
					<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
						<td valign="top" style="word-wrap:break-word;word-break:break-all; ">**********</td>
					</sec:ifNotGranted>
				</tr>
			</tbody>
		</table>
		<table>
			<tr>
				<td>
					<div class="searchButtons" style="float:left;height:25px;">
					<a onclick="return goBack()" href="javascript:void(0)" id="goBack" class="button"><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<g:hiddenField name="Id">${fieldValue(bean: orderDetailInstance, field: "id")}</g:hiddenField>
					<h1>注文ステータス</h1>
					<table>
					<tbody>
						<tr>
						<td width="200" style="text-align: center;border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス</td>
						<td style="border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス更新日時</td>
					</tr>
				<g:each in="${orderStatusInstanceList}" status="i" var="orderStatusInstance">
					<tr class="prop">
						<td width="200" style="text-align: center;border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;">&nbsp;${orderStatusNameList.get(i)}&nbsp;</td>
						<td style="border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;"><g:formatDate date="${orderStatusInstance.statusUpdate}" format="yyyy/MM/dd HH:mm:ss"/></td>
					</tr>
				</g:each>
					</tbody>
					</table>
				</td>
			</tr>
			<sec:ifNotGranted roles="AUTHORITY_PRINT_USER">
			<tr>
				<td>
					<h1>決済ステータス</h1>
					<table>
					<tbody>
						<tr class="prop">
							<td width="200" style="text-align: center;border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス</td>
							<td style="border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス更新日時</td>
						</tr>
					<g:each in="${settlementStatusInstanceList}" status="i" var="settlementStatusInstance">
						<tr>
							<td width="200" style="text-align: center;border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;">&nbsp;${settlementStatusNameList.get(i)}&nbsp;</td>
							<td style="border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;"><g:formatDate date="${settlementStatusInstance.statusUpdate}" format="yyyy/MM/dd HH:mm:ss"/></td>
						</tr>
					</g:each>
					</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<h1>審査ステータス</h1>
					<table>
					<tbody>
						<tr>
							<td width="200" style="text-align: center;border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス</td>
							<td style="border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス更新日時</td>
						</tr>
					<g:each in="${examinationStatusInstanceList}" status="i" var="examinationStatusInstance">
						<tr class="prop">
							<td width="200" style="text-align: center;border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;">&nbsp;${examinationStatusNameList.get(i)}&nbsp;</td>
							<td style="border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;"><g:formatDate date="${examinationStatusInstance.statusUpdate}" format="yyyy/MM/dd HH:mm:ss"/></td>
						</tr>
					</g:each>
					</tbody>
					</table>
				</td>
			</tr>
			</sec:ifNotGranted>
			<tr>
				<td>
					<h1>印刷ステータス</h1>
					<table>
					<tbody>
						<tr>
							<td width="200" style="text-align: center;border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス</td>
							<td style="border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">ステータス更新日時</td>
						</tr>
					<g:each in="${printStatusInstanceList}" status="i" var="printStatusInstance">
						<tr class="prop">
							<td width="200" style="text-align: center;border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;">&nbsp;${printStatusNameList.get(i)}&nbsp;</td>
							<td style="border-bottom-color: silver; border-bottom-width: 1px; border-bottom-style: solid;"><g:formatDate date="${printStatusInstance.statusUpdate}" format="yyyy/MM/dd HH:mm:ss"/></td>
						</tr>
					</g:each>
					</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				<div class="searchButtons" style="float:left;height:25px;">
				<a onclick="return goBack()" href="javascript:void(0)" id="goBack" class="button"><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
				<input type="hidden" id="returnHref" value="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>${gAction2}"/>
				</div>
				</td>
			</tr>
		</table	>
	</div>
	<script type="text/javascript">
	function goBack(){
		$.post("goBack",function(data){
			if(data.result =="ok"){
				window.location.href = document.getElementById("returnHref").value;
			}
		});
	}
	</script>
	<jq:jquery>
	$(".searchConditionFormArea table tbody tr.prop").evenodd();
	</jq:jquery>
</body>
</html>
