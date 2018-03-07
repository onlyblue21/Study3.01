<html>
<head>
	<meta name="layout" content="main" />
	<title>氏名住所編集</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>氏名住所編集</h1>

<!-- commonContents -->
		<div class="commonContents w664">
			<img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_2.gif" alt="お届け先入力" class="mB20" />
			<h2>ご依頼主</h2>
			<p>内容をご確認いただき、編集してください。<br />
			 ※環境依存文字は文字化けする恐れがありますので、入力しないでください。</p>

<g:render template="/common/fragment/flashmessages" />
<g:if test="${!params.registeredUser}">
<g:render template="/common/fragment/validatormessages" />
</g:if>

			<g:form name="editCustomerForm" action="confirmCustomerInfo" onsubmit="return false;">
			<input type="hidden" name="zipcode" value="" />
			<input type="hidden" name="telno" value="" />
			<input type="hidden" name="destinationZipcode" value="" />
			<input type="hidden" name="destinationTelno" value="" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w180">メールアドレス</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="email" name="email" value="${params.email?.encodeAsHTML()}" />
					${params.email?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="email" name="email" class="w250" maxlength="128" value="${params.email?.encodeAsHTML()}" />
</g:else>
				</td>
			</tr>
<g:if test="${!params.registeredUser}">
			<tr>
				<th>メールアドレス（再入力）</th>
				<td>
					<input type="text" id="email2" name="email2" class="w250" maxlength="128" value="${params.email?.encodeAsHTML()}" />
				</td>
			</tr>
</g:if>
			<tr>
				<th>法人区分<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="corporateUse" name="corporateUse" value="${params.corporateUse?.encodeAsHTML()}" />
					${params.corporateUse ? '法人' : '個人'}
</g:if>
<g:else>
					<input type="radio" id="corporateUseTrue" name="corporateUse" value="true" ${params.corporateUse ? 'checked' : ''} /><label for="corporateUseTrue">法人</label>
					　　
					<input type="radio" id="corporateUseFalse" name="corporateUse" value="false" ${params.corporateUse ? '' : 'checked'} /><label for="corporateUseFalse">個人</label>
</g:else>
				</td>
			</tr>
			<tr>
				<th>お名前/漢字<g:if test="${!params.registeredUser}">　<span class="red">必須</span><br />（全角）</g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					 <input type="hidden" id="familyName" name="familyName" value="${params.familyName?.encodeAsHTML()}" />
					 <input type="hidden" id="firstName" name="firstName" value="${params.firstName?.encodeAsHTML()}" />
					 ${params.familyName?.encodeAsHTML()}　${params.firstName?.encodeAsHTML()}
</g:if>
<g:else>
					姓 <input type="text" id="familyName" name="familyName" class="w120" maxlength="128" value="${params.familyName?.encodeAsHTML()}" />　　　名 <input type="text" id="firstName" name="firstName" class="w120" maxlength="128" value="${params.firstName?.encodeAsHTML()}" /><br />
　　例）郵便　　　　　　　　　　　　 　　 例）太郎
</g:else>
				</td>
			</tr>
			<tr>
				<th>お名前/ふりがな<g:if test="${!params.registeredUser}">　<span class="red">必須</span><br />（全角ひらがな）</g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="familyNameKana" name="familyNameKana" value="${params.familyNameKana?.encodeAsHTML()}" />
					<input type="hidden" id="firstNameKana" name="firstNameKana" value="${params.firstNameKana?.encodeAsHTML()}" />
					${params.familyNameKana?.encodeAsHTML()}　${params.firstNameKana?.encodeAsHTML()}
</g:if>
<g:else>
					せい<input type="text" id="familyNameKana" name="familyNameKana" class="w120" maxlength="128" value="${params.familyNameKana?.encodeAsHTML()}" />　　めい <input type="text" id="firstNameKana" name="firstNameKana" class="w120" maxlength="128" value="${params.firstNameKana?.encodeAsHTML()}" /><br />
　　　例）ゆうびん　　　　　　　　　　　　　        例）たろう
</g:else>
				</td>
			</tr>
			<tr>
				<th>郵便番号<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:set var="zipcode3" value="${(params.zipcode?.size() > 3) ? (params.zipcode.substring(0,3)) : (params.zipcode)}" />
<g:set var="zipcode4" value="${(params.zipcode?.size() > 3) ? (params.zipcode.substring(3)) : ''}" />
<g:if test="${params.registeredUser}">
					<input type="hidden" id="zipcode3" name="zipcode3" value="${zipcode3?.encodeAsHTML()}" />
					<input type="hidden" id="zipcode4" name="zipcode4" value="${zipcode4?.encodeAsHTML()}" />
					${zipcode3?.encodeAsHTML()} - ${zipcode4?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="zipcode3" name="zipcode3" class="w40" maxlength="3" value="${zipcode3?.encodeAsHTML()}" />
					 - 
					<input type="text" id="zipcode4" name="zipcode4" class="w40" maxlength="4" value="${zipcode4?.encodeAsHTML()}" />
					<span class="size10">(半角数字)</span>
					<a href="javascript:void(0)" id="zipcodeToAddressBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_jyusyo.gif" alt="住所を入力" /></a>
</g:else>
				</td>
			</tr>
			<tr>
				<th>都道府県<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="addressState" name="addressState" value="${params.addressState?.encodeAsHTML()}" />
					${params.addressState?.encodeAsHTML()}
</g:if>
<g:else>
					<g:select id="addressState" name="addressState" from="${addressStateList}" value="${params.addressState}" />
</g:else>
				</td>
			</tr>
			<tr>
				<th>市区町村<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="address1" name="address1" value="${params.address1?.encodeAsHTML()}" />
					${params.address1?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="address1" name="address1" class="w200" maxlength="256" value="${params.address1?.encodeAsHTML()}" /><br />
 					<span class="size10">例）千代田区</span>
</g:else>
				</td>
			</tr>
			<tr>
				<th>町域名<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="address2" name="address2" value="${params.address2?.encodeAsHTML()}" />
					${params.address2?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="address2" name="address2" class="w150" maxlength="256" value="${params.address2?.encodeAsHTML()}" />
					<a href="javascript:void(0)" class="addressToZipcodeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_yubinbango.gif" alt="郵便番号を入力する" /></a><br />
					<span class="size10">例）霞ヶ関</span>
</g:else>
				</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="address3" name="address3" value="${params.address3?.encodeAsHTML()}" />
					${params.address3?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="address3" name="address3" class="w120" maxlength="256" value="${params.address3?.encodeAsHTML()}" /><br />
					<span class="size10">例）1-3-2</span>
</g:else>
				</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="address4" name="address4" value="${params.address4?.encodeAsHTML()}" />
					${params.address4?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="address4" name="address4" class="w250" maxlength="256" value="${params.address4?.encodeAsHTML()}" /><br />
					<span class="size10">例）日本郵政ビル　8階</span>
</g:else>
				</td>
			</tr>
			<tr>
				<th>電話番号<g:if test="${!params.registeredUser}">　<span class="red">必須</span></g:if></th>
				<td>
<g:set var="telnoList" value="${params.telno?.split('-')}" />
<g:set var="telno0" value="${(telnoList?.size() > 0) ? telnoList.getAt(0) : ''}" />
<g:set var="telno1" value="${(telnoList?.size() > 1) ? telnoList.getAt(1) : ''}" />
<g:set var="telno2" value="${(telnoList?.size() > 2) ? telnoList.getAt(2) : ''}" />
<g:if test="${params.registeredUser}">
					<input type="hidden" id="telno0" name="telno0" value="${telno0?.encodeAsHTML()}" />
					<input type="hidden" id="telno1" name="telno1" value="${telno1?.encodeAsHTML()}" />
					<input type="hidden" id="telno2" name="telno2" value="${telno2?.encodeAsHTML()}" />
					${params.telno?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="telno0" name="telno0" class="w50" maxlength="5" value="${telno0?.encodeAsHTML()}" />
					-
					<input type="text" id="telno1" name="telno1" class="w50" maxlength="5" value="${telno1?.encodeAsHTML()}" />
					-
					<input type="text" id="telno2" name="telno2" class="w50" maxlength="4" value="${telno2?.encodeAsHTML()}" /> <span class="size10">(半角数字)<br />
					※ケータイ電話番号可</span>
</g:else>
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="corporateName" name="corporateName" value="${params.corporateName?.encodeAsHTML()}" />
					${params.corporateName?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="corporateName" name="corporateName" class="w200" maxlength="256" value="${params.corporateName?.encodeAsHTML()}" /><br />
					<span class="size10 red2">※法人区分の場合は必須</span>
</g:else>
				</td>
			</tr>
			<tr>
              <th>部署名</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="departmentName" name="departmentName" value="${params.departmentName?.encodeAsHTML()}" />
					${params.departmentName?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="departmentName" name="departmentName" class="w200" maxlength="256" value="${params.departmentName?.encodeAsHTML()}" />
</g:else>
				</td>
			</tr>
			<tr>
              <th>肩書・役職</th>
				<td>
<g:if test="${params.registeredUser}">
					<input type="hidden" id="businessTitle" name="businessTitle" value="${params.businessTitle?.encodeAsHTML()}" />
					${params.businessTitle?.encodeAsHTML()}
</g:if>
<g:else>
					<input type="text" id="businessTitle" name="businessTitle" class="w200" maxlength="256" value="${params.businessTitle?.encodeAsHTML()}" />
</g:else>
				</td>
			</tr>
			</table>

			<h2>お届け先</h2>
			<p>発送(差出)代行の場合は、差出後の残りの印刷物のお届け先です。</p>
			<p class="align_center">
				<input type="radio" id="delivery_destination_same" name="delivery_destination" value="true" /><label for="delivery_destination_same">上記の住所と同じ</label>　　
				<input type="radio" id="delivery_destination_diff" name="delivery_destination" value="false" /><label for="delivery_destination_diff">上記の住所と異なる場合</label>
			</p>

<g:if test="${params.registeredUser}">
<g:render template="/common/fragment/validatormessages" />
</g:if>

			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th class="w180">お名前/漢字　<span class="red">必須</span><br />（全角）</th>
				<td>姓 <input type="text" id="destinationFamilyName" name="destinationFamilyName" class="w120" maxlength="128" value="${params.destinationFamilyName?.encodeAsHTML()}" />　　　名 <input type="text" id="destinationFirstName" name="destinationFirstName" class="w120" maxlength="128" value="${params.destinationFirstName?.encodeAsHTML()}" /><br />
　　例）郵便　　　　　　　　　　　　 　　 例）太郎</td>
			</tr>
			<tr>
				<th>お名前/ふりがな　<span class="red">必須</span><br />（全角ひらがな）</th>
				<td>せい<input type="text" id="destinationFamilyNameKana" name="destinationFamilyNameKana" class="w120" maxlength="128" value="${params.destinationFamilyNameKana?.encodeAsHTML()}" />　　めい <input type="text" id="destinationFirstNameKana" name="destinationFirstNameKana" class="w120" maxlength="128" value="${params.destinationFirstNameKana?.encodeAsHTML()}" /><br />
　　　例）ゆうびん　　　　　　　　　　　　　        例）たろう</td>
			</tr>
			<tr>
				<th>郵便番号　<span class="red">必須</span></th>
				<td>
<g:set var="destinationZipcode3" value="${(params.destinationZipcode?.size() > 3) ? (params.destinationZipcode.substring(0,3)) : (params.destinationZipcode)}" />
<g:set var="destinationZipcode4" value="${(params.destinationZipcode?.size() > 3) ? (params.destinationZipcode.substring(3)) : ''}" />
					<input type="text" id="destinationZipcode3" name="destinationZipcode3" class="w40" maxlength="3" value="${destinationZipcode3?.encodeAsHTML()}" />
					 - 
					<input type="text" id="destinationZipcode4" name="destinationZipcode4" class="w40" maxlength="4" value="${destinationZipcode4?.encodeAsHTML()}" />
					<span class="size10">(半角数字)</span>
					<a href="javascript:void(0)" id="destinationZipcodeToAddressBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_jyusyo.gif" alt="住所を入力" /></a>
				</td>
			</tr>
			<tr>
				<th>都道府県　<span class="red">必須</span></th>
				<td>
					<g:select id="destinationAddressState" name="destinationAddressState" from="${addressStateList}" value="${params.destinationAddressState}" />
				</td>
			</tr>
			<tr>
				<th>市区町村　<span class="red">必須</span></th>
				<td>
					<input type="text" id="destinationAddress1" name="destinationAddress1" class="w200" maxlength="256" value="${params.destinationAddress1?.encodeAsHTML()}" /><br />
 					<span class="size10">例）千代田区</span>
				</td>
			</tr>
			<tr>
				<th>町域名　<span class="red">必須</span></th>
				<td>
					<input type="text" id="destinationAddress2" name="destinationAddress2" class="w150" maxlength="256" value="${params.destinationAddress2?.encodeAsHTML()}" />
					<a href="javascript:void(0)" class="addressToZipcodeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_yubinbango.gif" alt="郵便番号を入力する" /></a><br />
					<span class="size10">例）霞ヶ関</span>
				</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>
					<input type="text" id="destinationAddress3" name="destinationAddress3" class="w120" maxlength="256" value="${params.destinationAddress3?.encodeAsHTML()}" /><br />
					<span class="size10">例）1-3-2</span>
				</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>
					<input type="text" id="destinationAddress4" name="destinationAddress4" class="w250" maxlength="256" value="${params.destinationAddress4?.encodeAsHTML()}" /><br />
					<span class="size10">例）日本郵政ビル　8階</span>
				</td>
			</tr>
			<tr>
				<th>電話番号　<span class="red">必須</span></th>
				<td>
<g:set var="destinationTelnoList" value="${params.destinationTelno?.split('-')}" />
<g:set var="destinationTelno0" value="${(destinationTelnoList?.size() > 0) ? destinationTelnoList.getAt(0) : ''}" />
<g:set var="destinationTelno1" value="${(destinationTelnoList?.size() > 1) ? destinationTelnoList.getAt(1) : ''}" />
<g:set var="destinationTelno2" value="${(destinationTelnoList?.size() > 2) ? destinationTelnoList.getAt(2) : ''}" />
					<input type="text" id="destinationTelno0" name="destinationTelno0" class="w50" maxlength="5" value="${destinationTelno0?.encodeAsHTML()}" />
					-
					<input type="text" id="destinationTelno1" name="destinationTelno1" class="w50" maxlength="5" value="${destinationTelno1?.encodeAsHTML()}" />
					-
					<input type="text" id="destinationTelno2" name="destinationTelno2" class="w50" maxlength="4" value="${destinationTelno2?.encodeAsHTML()}" /> <span class="size10">(半角数字)</span>
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
					<input type="text" id="destinationCorporateName" name="destinationCorporateName" class="w200" maxlength="256" value="${params.destinationCorporateName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
              <th>部署名</th>
				<td>
					<input type="text" id="destinationDepartmentName" name="destinationDepartmentName" class="w200" maxlength="256" value="${params.destinationDepartmentName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
              <th>肩書・役職</th>
				<td>
					<input type="text" id="destinationBusinessTitle" name="destinationBusinessTitle" class="w200" maxlength="256" value="${params.destinationBusinessTitle?.encodeAsHTML()}" />
				</td>
			</tr>
			</table>

			<div class="align_center">
				<g:link action="confirmOrdering" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></g:link>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_susumu-off.gif" alt="進む" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<form method="get" name="addressToZipForm" action="http://www.post.japanpost.jp/zipcode/" target="_blank"></form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'zipcode')}"></script>
<r:script>
;jQuery(function(){
var copyDstInfo = function() {
	$("#destinationFamilyName").val($("#familyName").val());
	$("#destinationFirstName").val($("#firstName").val());
	$("#destinationFamilyNameKana").val($("#familyNameKana").val());
	$("#destinationFirstNameKana").val($("#firstNameKana").val());
	$("#destinationZipcode3").val($("#zipcode3").val());
	$("#destinationZipcode4").val($("#zipcode4").val());
	$("#destinationAddressState").val($("#addressState").val());
	$("#destinationAddress1").val($("#address1").val());
	$("#destinationAddress2").val($("#address2").val());
	$("#destinationAddress3").val($("#address3").val());
	$("#destinationAddress4").val($("#address4").val());
	$("#destinationTelno0").val($("#telno0").val());
	$("#destinationTelno1").val($("#telno1").val());
	$("#destinationTelno2").val($("#telno2").val());
	$("#destinationCorporateName").val($("#corporateName").val());
	$("#destinationDepartmentName").val($("#departmentName").val());
	$("#destinationBusinessTitle").val($("#businessTitle").val());
	formValidator.resetForm();
};
$("#delivery_destination_same").click(function() {
	copyDstInfo();
	return true;
});
$("#delivery_destination_diff").click(function() {
	$("#destinationFamilyName").val('');
	$("#destinationFirstName").val('');
	$("#destinationFamilyNameKana").val('');
	$("#destinationFirstNameKana").val('');
	$("#destinationZipcode3").val('');
	$("#destinationZipcode4").val('');
	$("#destinationAddressState").attr('selectedIndex', 0);
	$("#destinationAddress1").val('');
	$("#destinationAddress2").val('');
	$("#destinationAddress3").val('');
	$("#destinationAddress4").val('');
	$("#destinationTelno0").val('');
	$("#destinationTelno1").val('');
	$("#destinationTelno2").val('');
	$("#destinationCorporateName").val('');
	$("#destinationDepartmentName").val('');
	$("#destinationBusinessTitle").val('');
	formValidator.resetForm();
	return true;
});
var formValidator = $("#editCustomerForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	groups:{
<g:if test="${!params.registeredUser}">
		zipcode:"zipcode3 zipcode4",
		telno:"telno0 telno1 telno2",
</g:if>
		destinationZipcode:"destinationZipcode3 destinationZipcode4",
		destinationTelno:"destinationTelno0 destinationTelno1 destinationTelno2"
	},
	rules:{
<g:if test="${!params.registeredUser}">
		email:{
			required:true,
			email:true,
			nozenkaku:true,
			noktaiemail:true
		},
		email2:{
			required:true,
			equalTo:"#email",
			email:true
		},
		familyName:{
			required:true,
			zenkaku:true
		},
		firstName:{
			required:true,
			zenkaku:true
		},
		familyNameKana:{
			required:true,
			zenkaku:true
		},
		firstNameKana:{
			required:true,
			zenkaku:true
		},
		zipcode3:{
			required:true,
			rangelength:[3,3],
			digits:true
		},
		zipcode4:{
			required:true,
			rangelength:[4,4],
			digits:true
		},
		address1:{
			required:true
		},
		address2:{
			required:true
		},
		telno0:{
			required:true,
			rangelength:[2,5],
			digits:true
		},
		telno1:{
			required:true,
			rangelength:[2,5],
			digits:true
		},
		telno2:{
			required:true,
			rangelength:[4,4],
			digits:true
		},
		corporateName:{
			required:function() {
				var corporateUse = $("input:radio[name=corporateUse]:checked").val();
				return corporateUse == "true";
			}
		},
</g:if>
		destinationFamilyName:{
			required:true,
			zenkaku:true
		},
		destinationFirstName:{
			required:true,
			zenkaku:true
		},
		destinationFamilyNameKana:{
			required:true,
			zenkaku:true
		},
		destinationFirstNameKana:{
			required:true,
			zenkaku:true
		},
		destinationZipcode3:{
			required:true,
			rangelength:[3,3],
			digits:true
		},
		destinationZipcode4:{
			required:true,
			rangelength:[4,4],
			digits:true
		},
		destinationAddress1:{
			required:true
		},
		destinationAddress2:{
			required:true
		},
		destinationTelno0:{
			required:true,
			rangelength:[2,5],
			digits:true
		},
		destinationTelno1:{
			required:true,
			rangelength:[2,5],
			digits:true
		},
		destinationTelno2:{
			required:true,
			rangelength:[4,4],
			digits:true
		}
	},
	messages:{
<g:if test="${!params.registeredUser}">
		email:{
			required:"メールアドレスを指定してください。",
			email:"メールアドレスが正しくありません。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。",
			noktaiemail:"携帯メールアドレスをご利用いただくことは出来ません"
		},
		email2:{
			required:"メールアドレス(再入力)を指定してください。",
			equalTo:"メールアドレスと一致していません。",
			email:"メールアドレス(再入力)が正しくありません。"
		},
		familyName:{
			required:"お名前／漢字姓を指定してください。",
			zenkaku:"お名前／漢字姓には全角文字を入力してください。"
		},
		firstName:{
			required:"お名前／漢字名を指定してください。",
			zenkaku:"お名前／漢字名には全角文字を入力してください。"
		},
		familyNameKana:{
			required:"お名前／ふりがな姓を指定してください。",
			zenkaku:"お名前／ふりがな姓には全角文字を入力してください。"
		},
		firstNameKana:{
			required:"お名前／ふりがな名を指定してください。",
			zenkaku:"お名前／ふりがな名には全角文字を入力してください。"
		},
		zipcode3:{
			required:"郵便番号を指定してください。",
			rangelength:"郵便番号は3桁-4桁形式にて指定してください。",
			digits:"郵便番号は半角数字にて指定してください。"
		},
		zipcode4:{
			required:"郵便番号を指定してください。",
			rangelength:"郵便番号は3桁-4桁形式にて指定してください。",
			digits:"郵便番号は半角数字にて指定してください。"
		},
		address1:{
			required:"市区町村を指定してください。"
		},
		address2:{
			required:"町域名を指定してください。"
		},
		telno0:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			digits:"電話番号は半角数字にて指定してください。"
		},
		telno1:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			digits:"電話番号は半角数字にて指定してください。"
		},
		telno2:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			digits:"電話番号は半角数字にて指定してください。"
		},
		corporateName:{
			required:"法人区分の場合は会社名を指定してください。"
		},
</g:if>
		destinationFamilyName:{
			required:"お届け先のお名前／漢字姓を指定してください。",
			zenkaku:"お届け先のお名前／漢字姓には全角文字を入力してください。"
		},
		destinationFirstName:{
			required:"お届け先のお名前／漢字名を指定してください。",
			zenkaku:"お届け先のお名前／漢字名には全角文字を入力してください。"
		},
		destinationFamilyNameKana:{
			required:"お届け先のお名前／ふりがな姓を指定してください。",
			zenkaku:"お届け先のお名前／ふりがな姓には全角文字を入力してください。"
		},
		destinationFirstNameKana:{
			required:"お届け先のお名前／ふりがな名を指定してください。",
			zenkaku:"お届け先のお名前／ふりがな名には全角文字を入力してください。"
		},
		destinationZipcode3:{
			required:"お届け先の郵便番号を指定してください。",
			rangelength:"お届け先の郵便番号は3桁-4桁形式にて指定してください。",
			digits:"お届け先の郵便番号は半角数字にて指定してください。"
		},
		destinationZipcode4:{
			required:"お届け先の郵便番号を指定してください。",
			rangelength:"お届け先の郵便番号は3桁-4桁形式にて指定してください。",
			digits:"お届け先の郵便番号は半角数字にて指定してください。"
		},
		destinationAddress1:{
			required:"お届け先の市区町村を指定してください。"
		},
		destinationAddress2:{
			required:"お届け先の町域名を指定してください。"
		},
		destinationTelno0:{
			required:"お届け先の電話番号を指定してください。",
			rangelength:"お届け先の電話番号をご確認ください。",
			digits:"お届け先の電話番号は半角数字にて指定してください。"
		},
		destinationTelno1:{
			required:"お届け先の電話番号を指定してください。",
			rangelength:"お届け先の電話番号をご確認ください。",
			digits:"お届け先の電話番号は半角数字にて指定してください。"
		},
		destinationTelno2:{
			required:"お届け先の電話番号を指定してください。",
			rangelength:"お届け先の電話番号をご確認ください。",
			digits:"お届け先の電話番号は半角数字にて指定してください。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.editCustomerForm.zipcode.value = document.editCustomerForm.zipcode3.value + document.editCustomerForm.zipcode4.value;
		document.editCustomerForm.destinationZipcode.value = document.editCustomerForm.destinationZipcode3.value + document.editCustomerForm.destinationZipcode4.value;
		document.editCustomerForm.telno.value = document.editCustomerForm.telno0.value + '-' + document.editCustomerForm.telno1.value + '-' + document.editCustomerForm.telno2.value;
		document.editCustomerForm.destinationTelno.value = document.editCustomerForm.destinationTelno0.value + '-' + document.editCustomerForm.destinationTelno1.value + '-' + document.editCustomerForm.destinationTelno2.value;
		document.editCustomerForm.submit();
	}
	return false;
});
<g:if test="${!params.registeredUser}">
$("#zipcodeToAddressBtn").click(function() {
	return zipcodeToAddress("zipcode3", "zipcode4", "addressState", "address1", "address2", "address3", "address4");
});
</g:if>
$("#destinationZipcodeToAddressBtn").click(function() {
	return zipcodeToAddress("destinationZipcode3", "destinationZipcode4", "destinationAddressState", "destinationAddress1", "destinationAddress2", "destinationAddress3", "destinationAddress4");
});
$(".addressToZipcodeBtn").click(function() {
	document.addressToZipForm.submit();
	return false;
});
<g:if test="${params.registeredUser}">
copyDstInfo();
$("#delivery_destination_same").setChecked(true);
</g:if>
});</r:script>
</body>
</html>