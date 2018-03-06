
<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>送り先編集</title>
</head>
<body>
	<div class="mainBlock">
		<g:form name="orderInfoForm" action="updateInfo">
			<input type="hidden" name="id" value="${orderInfoInstance?.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${orderInfoInstance?.version?.encodeAsHTML()}" />
			<input type="hidden" name="destinationZipcode" value="" />
			<input type="hidden" name="destinationTelno" value="" />
			<g:render template="/common/fragment/flashmessages" />

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20" style="table-layout:fixed;">
				<tbody>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="注文No　：　" /></td>
						<td valign="top">${fieldValue(bean: orderInfoInstance, field: "orderNo")}</td>
					</tr>
					<tr>
						<td valign="top" style="text-align: right" width="100"><g:message code="orderInfo.orderNo.label" default="ご注文者　：　" /></td>
						<td valign="top" style="word-wrap:break-word;word-break:break-all; ">${fieldValue(bean: orderInfoInstance, field: "familyName")}&nbsp;${fieldValue(bean: orderInfoInstance, field: "firstName")}</td>
					</tr>
				</tbody>
			</table>
			<h1>お届け先情報</h1>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
				<tbody>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／漢字　：　<br />（全角）　　</td>
						<td>
							<span id="usernameZen">
							<input type="text" id="destinationFamilyName" name="destinationFamilyName" size="40" maxlength="128" value="${orderInfoInstance?.destinationFamilyName?.encodeAsHTML()}" />
							<input type="text" id="destinationFirstName" name="destinationFirstName" size="40" maxlength="128" value="${orderInfoInstance?.destinationFirstName?.encodeAsHTML()}" />
							</span>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">お名前／ふりがな　：　<br />（全角ひらがな）　　</td>
						<td>
							<span id="usernameKana">
							<input type="text" id="destinationFamilyNameKana" name="destinationFamilyNameKana" size="40" maxlength="128" value="${orderInfoInstance?.destinationFamilyNameKana?.encodeAsHTML()}" />
							<input type="text" id="destinationFirstNameKana" name="destinationFirstNameKana" size="40" maxlength="128" value="${orderInfoInstance?.destinationFirstNameKana?.encodeAsHTML()}" />
							</span>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">郵便番号　：　</td>
						<td>
							<span id="zipCode">
							<g:set var="zipcode3" value="${(orderInfoInstance?.destinationZipcode?.size() > 3) ? (orderInfoInstance.destinationZipcode.substring(0,3)) : (orderInfoInstance?.destinationZipcode)}" />
							<g:set var="zipcode4" value="${(orderInfoInstance?.destinationZipcode?.size() > 3) ? (orderInfoInstance.destinationZipcode.substring(3)) : ''}" />
							<input type="text" id="zipcode3" name="zipcode3" class="w40" maxlength="3" value="${zipcode3?.encodeAsHTML()}" />
							 - 
							<input type="text" id="zipcode4" name="zipcode4" class="w40" maxlength="4" value="${zipcode4?.encodeAsHTML()}" />
							</span> 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">都道府県　：　</td>
						<td>
							<div>
								<g:select id="destinationAddressStateCode" name="destinationAddressStateCode" value="${destinationStateId}"
									from="${stateList}"
									optionKey="id" optionValue="name" >
								</g:select>
							</div>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">市区町村　：　</td>
						<td>
							<span id="destinationAddressCheck1">
							<input type="text" id="destinationAddress1" name="destinationAddress1" size="40" maxlength="256" value="${orderInfoInstance?.destinationAddress1?.encodeAsHTML()}" />
							</span> 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">町域名　：　</td>
						<td>
							<span id="destinationAddressCheck2">
							<input type="text" id="destinationAddress2" name="destinationAddress2" size="40" maxlength="256" value="${orderInfoInstance?.destinationAddress2?.encodeAsHTML()}" />
							</span> 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">丁目・番地等　：　</td>
						<td>
							<span id="destinationAddressCheck3">
							<input type="text" id="destinationAddress3" name="destinationAddress3" size="40" maxlength="256" value="${orderInfoInstance?.destinationAddress3?.encodeAsHTML()}" />
							</span> 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">アパート・ビル・マンション　：　</td>
						<td>
							<span id="destinationAddressCheck4">
							<input type="text" id="destinationAddress4" name="destinationAddress4" size="40" maxlength="256" value="${orderInfoInstance?.destinationAddress4?.encodeAsHTML()}" />
							</span> 
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">電話番号　：　</td>
						<td>
							<span id="telNumber">
								<g:set var="telno1" value="${ (orderInfoInstance?.destinationTelno?.split('-',-1)?.size() == 3) ? (orderInfoInstance.destinationTelno.split('-',-1)[0]) : ('')}" />
								<g:set var="telno2" value="${ (orderInfoInstance?.destinationTelno?.split('-',-1)?.size() == 3) ? (orderInfoInstance.destinationTelno.split('-',-1)[1]) : ('')}" />
								<g:set var="telno3" value="${ (orderInfoInstance?.destinationTelno?.split('-',-1)?.size() == 3) ? (orderInfoInstance.destinationTelno.split('-',-1)[2]) : ('')}" />
								<input type="text" id="telno1" name="telno1" size="6" maxlength="5" value="${telno1}" />
								- 
								<input type="text" id="telno2" name="telno2" size="6" maxlength="5" value="${telno2}" />
								- 
								<input type="text" id="telno3" name="telno3" size="5" maxlength="4" value="${telno3}" />
							</span>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">会社名　：　</td>
						<td>
							<span id="destinationCorporateNameCheck">
							<input type="text" name="destinationCorporateName" size="40" maxlength="256" value="${orderInfoInstance?.destinationCorporateName?.encodeAsHTML()}" />
							</span>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">部署名　：　</td>
						<td>
							<span id="destinationDepartmentNameCheck">
							<input type="text" name="destinationDepartmentName" size="40" maxlength="256" value="${orderInfoInstance?.destinationDepartmentName?.encodeAsHTML()}" />
							</span>
						</td>
					</tr>
					<tr class="prop">
						<td style="text-align: right" width="200">肩書・役職　：　</td>
						<td>
							<span id="destinationBusinessTitleCheck">
							<input type="text" id="destinationBusinessTitle" name="destinationBusinessTitle" size="40" maxlength="256" value="${orderInfoInstance?.destinationBusinessTitle?.encodeAsHTML()}" />
							</span>
						</td>
					</tr>
			</table>

			<div class="searchButtons" style="float: canter;">
				<a onclick="goBack()" href="<g:createLink controller='${gControll}' action='${gAction}'></g:createLink>" id="goBack" class="button"><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
				<a href="javascript:void(0)" id="updateBtn" class="button" ><span class="icon-search">&nbsp;更新&nbsp;</span></a>
			</div>
		</g:form>
	</div>
<jq:jquery>
var formValidator = $("#orderInfoForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	groups: {
		usernameZen: "destinationFamilyName destinationFirstName",
		usernameKana: "destinationFamilyNameKana destinationFirstNameKana",
		zipCode: "zipcode3 zipcode4",
		telNumber: "telno1 telno2 telno3"
	},
	errorPlacement: function(error, element) {
		switch(element.prop('name')) {
			case "destinationFamilyName":
			case "destinationFirstName":
				error.insertAfter($('#usernameZen'));
				break;
			case "destinationFamilyNameKana":
			case "destinationFirstNameKana":
				error.insertAfter($('#usernameKana'));
				break;
			case "zipcode3":
			case "zipcode4":
				error.insertAfter($('#zipCode'));
				break;
			case "destinationAddress1":
				error.insertAfter($('#destinationAddressCheck1'));
				break;
			case "destinationAddress2":
				error.insertAfter($('#destinationAddressCheck2'));
				break;
			case "destinationAddress3":
				error.insertAfter($('#destinationAddressCheck3'));
				break;
			case "destinationAddress4":
				error.insertAfter($('#destinationAddressCheck4'));
				break;
			case "destinationCorporateName":
				error.insertAfter($('#destinationCorporateNameCheck'));
				break;
			case "destinationDepartmentName":
				error.insertAfter($('#destinationDepartmentNameCheck'));
				break;
			case "destinationBusinessTitle":
				error.insertAfter($('#destinationBusinessTitleCheck'));
				break;
			case "destinationFamilyNameKana":
			case "destinationFirstNameKana":
				error.insertAfter($('#usernameKana'));
				break;

			case "telno1":
			case "telno2":
			case "telno3":
				error.insertAfter($('#telNumber'));
				break;
			default:
				error.insertAfter(element);
		}
	},
	rules:{
		destinationFamilyName:{
			required:true,
			zenKaku:true
		},
		destinationFirstName:{
			required:true,
			zenKaku:true
		},
		destinationFamilyNameKana:{
			required:true,
			zenKaku:true
		},
		destinationFirstNameKana:{
			required:true,
			zenKaku:true
		},
		zipcode3:{
			required:true,
			number:true,
			minlength:[3]
		},
		zipcode4:{
			required:true,
			number:true,
			minlength:[4]
		},
		destinationAddress1:{
			required:true
		},
		destinationAddress2:{
			required:true
		},
		telno1:{
			required:true,
			number:true,
			minlength:[2]
		},
		telno2:{
			required:true,
			number:true,
			minlength:[2]
		},
		telno3:{
			required:true,
			number:true,
			minlength:[4]
		}

	},
	messages: {
		zipcode3: {
			minlength: "郵便番号は「３桁」＋「４桁」で入力してください"
		},
		zipcode4: {
			minlength: "郵便番号は「３桁」＋「４桁」で入力してください"
		},
		telno1: {
			minlength: "電話番号をご確認ください。"
		},
		telno2: {
			minlength: "電話番号をご確認ください。"
		},
		telno3: {
			minlength: "電話番号をご確認ください。"
		}
	}
});
//全角文字チェック
jQuery.validator.addMethod("zenKaku", function(value, element) {
		if(value==""||value==null){return true;}
		return value.match(/^([^ -~｡-ﾟ]|\\s)+$/);
		},"全角文字のみを入力してください。"
);

$("#updateBtn").click(function() {
	if (formValidator.form()) {
		//pleaseWait();
		oiyConfirm("送付先内容を更新します。よろしいですか？", function() {
			document.orderInfoForm.destinationZipcode.value = document.orderInfoForm.zipcode3.value + document.orderInfoForm.zipcode4.value;
			document.orderInfoForm.destinationTelno.value = 
				document.orderInfoForm.telno1.value + "-" +
				document.orderInfoForm.telno2.value + "-" +
				document.orderInfoForm.telno3.value 
			document.orderInfoForm.submit();
		});
		
	}
	return false;
});

$("table tbody tr.prop").evenodd();
</jq:jquery>
</body>
</html>
