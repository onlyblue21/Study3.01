<%@ page import="jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo" %>
<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>注文詳細</title>
</head>
<body>
	<div class="mainBlock" id="listArea">
		<h1>注文者情報</h1>
		<g:render template="/common/fragment/flashmessages" />		
		<g:hiddenField name="Id">${fieldValue(bean: orderInfoInstance, field: "id")}</g:hiddenField>
		<div class="searchButtons" style="float:left;height:25px;">
		<a onclick="return goBack(this.href)" href="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>" id="goBack" class="button"><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
		<input type="hidden" id="returnHref" value="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>"/>
		</div>
		<table style="table-layout:fixed;">
			<tbody>
				<g:if test="${role == 'office'}">
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.enabled.label" default="会員区分" /></td>
					<td valign="top" class="value"><g:formatBoolean boolean="${orderInfoInstance.owner?.userType == 300}" true="非会員" false="会員" /></td>
				</tr>
				</g:if>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.enabled.label" default="法人区分" /></td>
					<td valign="top" class="value"><g:formatBoolean boolean="${orderInfoInstance.corporateUse}" true="法人" false="個人" /></td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.email.label" default="E-Mail" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "email")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.zipcode.label" default="郵便番号" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "zipcode")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.address.label" default="住所" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "addressState")}
						${fieldValue(bean: orderInfoInstance, field: "address1")}
						${fieldValue(bean: orderInfoInstance, field: "address2")}
						${fieldValue(bean: orderInfoInstance, field: "address3")}
						<br />
						${fieldValue(bean: orderInfoInstance, field: "address4")}
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.corporateName.label" default="会社名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "corporateName")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.departmentName.label" default="部署名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "departmentName")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.departmentName.label" default="肩書・役職" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "businessTitle")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.telno.label" default="電話番号" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "telno")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.name.label" default="氏名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "familyName")}
						${fieldValue(bean: orderInfoInstance, field: "firstName")}
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.nameKana.label" default="氏名(かな)" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "familyNameKana")}
						${fieldValue(bean: orderInfoInstance, field: "firstNameKana")}
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.npCustomerId.label" default="請求書決済顧客ID" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance.owner?.npCustomer, field: "npCustomerId")}
					</td>
				</tr>
			</tbody>
		</table>
		<h1>お届け先情報</h1>
		<table style="table-layout:fixed;">
			<tbody>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationZipcode.label" default="郵便番号" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "destinationZipcode")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationAddressState.label" default="住所" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "destinationAddressState")}
						${fieldValue(bean: orderInfoInstance, field: "destinationAddress1")}
						${fieldValue(bean: orderInfoInstance, field: "destinationAddress2")}
						${fieldValue(bean: orderInfoInstance, field: "destinationAddress3")}
						<br />
						${fieldValue(bean: orderInfoInstance, field: "destinationAddress4")}
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationCorporateName.label" default="会社名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "destinationCorporateName")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationDepartmentName.label" default="部署名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "destinationDepartmentName")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.departmentName.label" default="肩書・役職" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "destinationBusinessTitle")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationTelno.label" default="電話番号" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">${fieldValue(bean: orderInfoInstance, field: "destinationTelno")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationName.label" default="氏名" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "destinationFamilyName")}
						${fieldValue(bean: orderInfoInstance, field: "destinationFirstName")}
					</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.destinationNameKana.label" default="氏名(かな)" /></td>
					<td valign="top" style="word-wrap:break-word;word-break:break-all; " class="value">
						${fieldValue(bean: orderInfoInstance, field: "destinationFamilyNameKana")}
						${fieldValue(bean: orderInfoInstance, field: "destinationFirstNameKana")}
					</td>
				</tr>
			</tbody>
		</table>
		<h1>注文内容</h1>
		<table style="table-layout:fixed;">
			<tbody>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.orderNo.label" default="注文No" /></td>
					<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "orderNo")}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.orderDate.label" default="注文日" /></td>
					<td valign="top" class="value"><g:formatDate date="${orderInfoInstance?.orderDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
				</tr>
				<g:if test="${role == 'office'}">
					<tr class="prop">
						<td valign="top" class="name"><g:message code="orderInfo.printAmount.label" default="印刷料" /></td>
						<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "printAmount")}円</td>
					</tr>
					<tr class="prop">
						<td valign="top" class="name"><g:message code="orderInfo.mailAmount.label" default="郵便料" /></td>
						<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "mailAmount")}円</td>
					</tr>
					<tr class="prop">
						<td valign="top" class="name"><g:message code="orderInfo.futaiServiceAmount.label" default="付帯サービス料" /></td>
						<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "futaiServiceAmount")}円</td>
					</tr>
					<!-- /*#931 2012/02/21 by A&I Start*/ -->
					<tr class="prop">
						<td valign="top" class="name"><g:message code="orderInfo.cashOnDeliveryFee.label" default="代引手数料" /></td>
						<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "cashOnDeliveryFee")}円</td>
					</tr>
					<!-- /*#931 2012/02/21 by A&I End*/ -->
					<tr class="prop">
						<td valign="top" class="name"><g:message code="orderInfo.totalAmount.label" default="合計金額" /></td>
						<td valign="top" class="value">${fieldValue(bean: orderInfoInstance, field: "totalAmount")}円</td>
					</tr>
				</g:if>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.settlementMethodId.label" default="決済方法" /></td>
					<td valign="top" class="value">${orderInfoInstancePlus.settlementMethodName}</td>
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="orderInfo.details.label" default="注文明細" /></td>
					<td valign="top" style="text-align: left;" class="value">
						<ul>
						<g:each in="${orderInfoInstance?.details}" var="d">
							<li><a onclick="return goForward(this.href)" href="<g:createLink controller='orderDetail' action='show' id='${d.id}'></g:createLink>">
							${d?.detailNo?.encodeAsHTML()}</a></li>
						</g:each>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
		<br />
		<div class="searchButtons"  style="float:left;height:25px;">
		<a onclick="return goBack(this.href)" href="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>" id="goBack" class="button">
		<span class="icon-search">&nbsp;戻る&nbsp;</span></a>
		</div>
	</div>
	<script type="text/javascript">
	function goForward(url){
		$.post("goForward",function(data){
			if(data.result=="ok"){
				window.location.href = url;
			}
		});
		return false;
	}
	function goBack(url){
		$.post("goBack",function(data){
			if(data.result=="ok"){
				window.location.href = url;
			}
		});
		return false;
	}
	</script>
<jq:jquery>
$("table tbody tr.prop").evenodd();
</jq:jquery>
</body>
</html>
