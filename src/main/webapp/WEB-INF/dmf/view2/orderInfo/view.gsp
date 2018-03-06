
<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>送り先参照</title>
</head>
<body>
	<div class="mainBlock">
		<g:form name="orderInfoForm" action="updateInfo">
			<input type="hidden" name="id" value="${orderInfoInstance?.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${orderInfoInstance?.version?.encodeAsHTML()}" />
			<input type="hidden" name="destinationZipcode" value="" />
			<input type="hidden" name="destinationTelno" value="" />
			<g:render template="/common/fragment/flashmessages" />

			
			<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
				<tbody>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="注文No　：　" /></td>
						<td valign="top">${fieldValue(bean: orderInfoInstance, field: "orderNo")}</td>
					</tr>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="ご注文者　：　" /></td>
						<td valign="top">${fieldValue(bean: orderInfoInstance, field: "familyName")}&nbsp;${fieldValue(bean: orderInfoInstance, field: "firstName")}</td>
					</tr>
				</tbody>
			</table>
			<h1>お届け先情報</h1>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
				<tbody>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／漢字　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationFamilyName")}　${fieldValue(bean: orderInfoInstance, field: "destinationFirstName")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／ふりがな　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationFamilyNameKana")}　${fieldValue(bean: orderInfoInstance, field: "destinationFirstNameKana")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">郵便番号　：　</td>
						<td>
							<g:set var="zipcode3" value="${(orderInfoInstance?.destinationZipcode?.size() > 3) ? (orderInfoInstance.destinationZipcode.substring(0,3)) : (orderInfoInstance?.destinationZipcode)}" />
							<g:set var="zipcode4" value="${(orderInfoInstance?.destinationZipcode?.size() > 3) ? (orderInfoInstance.destinationZipcode.substring(3)) : ''}" />
							${zipcode3} - ${zipcode4} 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">都道府県　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationAddressState")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">市区町村　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationAddress1")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">町域名　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationAddress2")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">丁目・番地等　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationAddress3")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">アパート・ビル・マンション　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationAddress4")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">電話番号　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationTelno")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">会社名　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationCorporateName")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">部署名　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationDepartmentName")}</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">肩書・役職　：　</td>
						<td>${fieldValue(bean: orderInfoInstance, field: "destinationBusinessTitle")}</td>
					</tr>
			</table>
			</sec:ifAnyGranted>
			
			<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
				<tbody>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="注文No　：　" /></td>
						<td valign="top">${fieldValue(bean: orderInfoInstance, field: "orderNo")}</td>
					</tr>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="ご注文者　：　" /></td>
						<td valign="top">**********</td>
					</tr>
				</tbody>
			</table>
			<h1>お届け先情報</h1>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
				<tbody>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／漢字　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／ふりがな　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">郵便番号　：　</td>
						<td>
							*** - ****
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">都道府県　：　</td>
						<td>*****</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">市区町村　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">町域名　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">丁目・番地等　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">アパート・ビル・マンション　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">電話番号　：　</td>
						<td>*** - **** - ****</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">会社名　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">部署名　：　</td>
						<td>**********</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">肩書・役職　：　</td>
						<td>**********</td>
					</tr>
			</table>
			</sec:ifNotGranted>


			<div class="searchButtons" style="float: canter;">
				<a onclick="goBack()" href="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>" id="goBack" class="button"><span class="icon-search">&nbsp;戻る&nbsp;</span></a> 
			</div>
		</g:form>
	</div>
</body>
<jq:jquery>
$(".searchConditionFormArea table tbody tr.prop").evenodd();
</jq:jquery>
</html>
