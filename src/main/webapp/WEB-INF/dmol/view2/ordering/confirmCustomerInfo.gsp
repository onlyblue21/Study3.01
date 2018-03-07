<html>
<head>
	<meta name="layout" content="main" />
	<title>氏名住所確認</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>氏名住所確認</h1>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_2.gif" alt="お届け先入力" class="mB20" />
			<h2>ご依頼主</h2>
			<p>内容をご確認いただき、次にお進みください。</p>

<g:render template="/common/fragment/flashmessages" />

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB50">
			<tr>
				<th class="w180">メールアドレス</th>
				<td>
					${params.email?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>法人区分</th>
				<td>
					${params.corporateUse ? '法人' : '個人'}
				</td>
			</tr>
			<tr>
				<th>お名前/漢字</th>
				<td>
					 ${params.familyName?.encodeAsHTML()}　${params.firstName?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>お名前/ふりがな</th>
				<td>
					${params.familyNameKana?.encodeAsHTML()}　${params.firstNameKana?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>郵便番号</th>
				<td>
<g:set var="zipcode3" value="${(params.zipcode?.size() > 3) ? (params.zipcode.substring(0,3)) : (params.zipcode)}" />
<g:set var="zipcode4" value="${(params.zipcode?.size() > 3) ? (params.zipcode.substring(3)) : ''}" />
					${zipcode3?.encodeAsHTML()} - ${zipcode4?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>都道府県</th>
				<td>
					${params.addressState?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>市区町村</th>
				<td>
					${params.address1?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>町域名</th>
				<td>
					${params.address2?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>
					${params.address3?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>
					${params.address4?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>電話番号</th>
				<td>
					${params.telno?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
					${params.corporateName?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
              <th>部署名</th>
				<td>
					${params.departmentName?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
              <th>肩書・役職</th>
				<td>
					${params.businessTitle?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			</table>

			<h2>お届け先</h2>
			<p>発送(差出)代行の場合は、差出後の残りの印刷物のお届け先です。</p>

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w180">お名前/漢字</th>
				<td>
					${params.destinationFamilyName?.encodeAsHTML()}　${params.destinationFirstName?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>お名前/ふりがな</th>
				<td>
					${params.destinationFamilyNameKana?.encodeAsHTML()}　${params.destinationFirstNameKana?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>郵便番号</th>
				<td>
<g:set var="destinationZipcode3" value="${(params.destinationZipcode?.size() > 3) ? (params.destinationZipcode.substring(0,3)) : (params.destinationZipcode)}" />
<g:set var="destinationZipcode4" value="${(params.destinationZipcode?.size() > 3) ? (params.destinationZipcode.substring(3)) : ''}" />
					${destinationZipcode3?.encodeAsHTML()} - ${destinationZipcode4?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>都道府県</th>
				<td>
					${params.destinationAddressState}
				</td>
			</tr>
			<tr>
				<th>市区町村</th>
				<td>
					${params.destinationAddress1?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>町域名</th>
				<td>
					${params.destinationAddress2?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>
					${params.destinationAddress3?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>
					${params.destinationAddress4?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
				<th>電話番号</th>
				<td>
					${params.destinationTelno?.encodeAsHTML()}
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
					${params.destinationCorporateName?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
              <th>部署名</th>
				<td>
					${params.destinationDepartmentName?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			<tr>
              <th>肩書・役職</th>
				<td>
					${params.destinationBusinessTitle?.encodeAsHTML() ?: '&nbsp;'}
				</td>
			</tr>
			</table>

			<div class="align_center">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form name="customerInfoForm" action="reditCustomerInfo">
<input type="hidden" name="email" value="${params.email?.encodeAsHTML()}" />
<input type="hidden" name="corporateUse" value="${params.corporateUse?.encodeAsHTML()}" />
<input type="hidden" name="familyName" value="${params.familyName?.encodeAsHTML()}" />
<input type="hidden" name="firstName" value="${params.firstName?.encodeAsHTML()}" />
<input type="hidden" name="familyNameKana" value="${params.familyNameKana?.encodeAsHTML()}" />
<input type="hidden" name="firstNameKana" value="${params.firstNameKana?.encodeAsHTML()}" />
<input type="hidden" name="zipcode" value="${params.zipcode?.encodeAsHTML()}" />
<input type="hidden" name="addressState" value="${params.addressState?.encodeAsHTML()}" />
<input type="hidden" name="address1" value="${params.address1?.encodeAsHTML()}" />
<input type="hidden" name="address2" value="${params.address2?.encodeAsHTML()}" />
<input type="hidden" name="address3" value="${params.address3?.encodeAsHTML()}" />
<input type="hidden" name="address4" value="${params.address4?.encodeAsHTML()}" />
<input type="hidden" name="telno" value="${params.telno?.encodeAsHTML()}" />
<input type="hidden" name="corporateName" value="${params.corporateName?.encodeAsHTML()}" />
<input type="hidden" name="departmentName" value="${params.departmentName?.encodeAsHTML()}" />
<input type="hidden" name="businessTitle" value="${params.businessTitle?.encodeAsHTML()}" />
<input type="hidden" name="destinationFamilyName" value="${params.destinationFamilyName?.encodeAsHTML()}" />
<input type="hidden" name="destinationFirstName" value="${params.destinationFirstName?.encodeAsHTML()}" />
<input type="hidden" name="destinationFamilyNameKana" value="${params.destinationFamilyNameKana?.encodeAsHTML()}" />
<input type="hidden" name="destinationFirstNameKana" value="${params.destinationFirstNameKana?.encodeAsHTML()}" />
<input type="hidden" name="destinationZipcode" value="${params.destinationZipcode?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddressState" value="${params.destinationAddressState?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddress1" value="${params.destinationAddress1?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddress2" value="${params.destinationAddress2?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddress3" value="${params.destinationAddress3?.encodeAsHTML()}" />
<input type="hidden" name="destinationAddress4" value="${params.destinationAddress4?.encodeAsHTML()}" />
<input type="hidden" name="destinationTelno" value="${params.destinationTelno?.encodeAsHTML()}" />
<input type="hidden" name="destinationCorporateName" value="${params.destinationCorporateName?.encodeAsHTML()}" />
<input type="hidden" name="destinationDepartmentName" value="${params.destinationDepartmentName?.encodeAsHTML()}" />
<input type="hidden" name="destinationBusinessTitle" value="${params.destinationBusinessTitle?.encodeAsHTML()}" />
</g:form>
<form method="post" action="${settlementURL}" name="settlementForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
<input type="hidden" name="orderNo" value="" />
</form>
<g:form method="get" name="indexForm" controller="myProduct" action="index" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#prevBtn").click(function() {
	document.customerInfoForm.submit();
	return false;
});
$("#nextBtn").click(function() {
	var oparams = {
		email						: document.customerInfoForm.email.value,
		corporateUse				: document.customerInfoForm.corporateUse.value,
		familyName					: document.customerInfoForm.familyName.value,
		firstName					: document.customerInfoForm.firstName.value,
		familyNameKana				: document.customerInfoForm.familyNameKana.value,
		firstNameKana				: document.customerInfoForm.firstNameKana.value,
		zipcode						: document.customerInfoForm.zipcode.value,
		addressState				: document.customerInfoForm.addressState.value,
		address1					: document.customerInfoForm.address1.value,
		address2					: document.customerInfoForm.address2.value,
		address3					: document.customerInfoForm.address3.value,
		address4					: document.customerInfoForm.address4.value,
		telno						: document.customerInfoForm.telno.value,
		corporateName				: document.customerInfoForm.corporateName.value,
		departmentName				: document.customerInfoForm.departmentName.value,
		businessTitle				: document.customerInfoForm.businessTitle.value,
		destinationFamilyName		: document.customerInfoForm.destinationFamilyName.value,
		destinationFirstName		: document.customerInfoForm.destinationFirstName.value,
		destinationFamilyNameKana	: document.customerInfoForm.destinationFamilyNameKana.value,
		destinationFirstNameKana	: document.customerInfoForm.destinationFirstNameKana.value,
		destinationZipcode			: document.customerInfoForm.destinationZipcode.value,
		destinationAddressState		: document.customerInfoForm.destinationAddressState.value,
		destinationAddress1			: document.customerInfoForm.destinationAddress1.value,
		destinationAddress2			: document.customerInfoForm.destinationAddress2.value,
		destinationAddress3			: document.customerInfoForm.destinationAddress3.value,
		destinationAddress4			: document.customerInfoForm.destinationAddress4.value,
		destinationTelno			: document.customerInfoForm.destinationTelno.value,
		destinationCorporateName	: document.customerInfoForm.destinationCorporateName.value,
		destinationDepartmentName	: document.customerInfoForm.destinationDepartmentName.value,
		destinationBusinessTitle	: document.customerInfoForm.destinationBusinessTitle.value
	};
	$.ajax({
		url: "${createLink(action:'createOrderByProduct')}",
		data: oparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				pleaseWait();
				document.settlementForm.relayUserId.value = data.relayUserId;
				document.settlementForm.dtime.value = data.dtime;
				document.settlementForm.clientId.value = data.clientId;
				document.settlementForm.orderNo.value = data.orderNo;
				document.settlementForm.submit();

			} else if (data.result == "reorder") {
				oiyAlert("注文いただけないデザインが含まれています。\nショッピングカートをご確認ください。", function() {
					document.indexForm.submit();
					pleaseWait();
					return false;
				}, { width:'400px' });

			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "注文できませんでした。");
			}
			return false;
		}
	});
	return false;
});
});</r:script>
</body>
</html>