<html>
<head>
	<meta name="layout" content="main" />
	<title>あて名データ編集</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myList">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>あて名データ編集</h1>

<!-- commonContents -->
		<div class="commonContents w664">
			<h2>あて名データ編集</h2>
			<p>※環境依存文字は文字化けする恐れがありますので、入力しないでください。</p>

<g:render template="/common/fragment/flashmessages" />
			<g:hasErrors bean="${myAddress}">
				<div class="errors">
					<g:renderErrors bean="${myAddress}" as="list" />
				</div>
			</g:hasErrors>
<g:render template="/common/fragment/validatormessages" />

			<g:form name="myAddressForm" action="updateMyAddress">
			<input type="hidden" name="id" value="${myAddress?.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${myAddress?.version?.encodeAsHTML()}" />
			<input type="hidden" name="zipcode" value="" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th>グループ</th>
				<td>
					<g:select id="uploadMyAddressListId" name="myAddressListId" from="${malList}" value="${params.myAddressListId}" optionKey="id" optionValue="myAddressListName" />
				</td>
			</tr>
			<tr>
				<th>郵便番号</th>
				<td>
<g:set var="zipcode3" value="${(myAddress?.zipcode?.size() > 3) ? (myAddress.zipcode.substring(0,3)) : (myAddress?.zipcode)}" />
<g:set var="zipcode4" value="${(myAddress?.zipcode?.size() > 3) ? (myAddress.zipcode.substring(3)) : ''}" />
					<input type="text" id="zipcode3" name="zipcode3" class="w40" maxlength="3" value="${zipcode3?.encodeAsHTML()}" />
					 - 
					<input type="text" id="zipcode4" name="zipcode4" class="w40" maxlength="4" value="${zipcode4?.encodeAsHTML()}" />
					<span class="size10">(半角数字)</span>
					<a href="javascript:void(0)" id="zipcodeToAddressBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_jyusyo.gif" alt="住所を入力" /></a>
				</td>
			</tr>
			<tr>
				<th>都道府県</th>
				<td>
					<g:select id="addressState" name="addressState" from="${addressStateList}" value="${myAddress?.addressState}" noSelection="['':'選択してください']" />
				</td>
			</tr>
			<tr>
				<th>市区町村番地</th>
				<td>
					<input type="text" id="address1" name="address1" class="w300" maxlength="256" value="${myAddress?.address1?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>建物（マンション等）</th>
				<td>
					<input type="text" id="address2" name="address2" class="w300" maxlength="256" value="${myAddress?.address2?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>お名前/漢字<br />（全角）</th>
				<td>姓
					<input type="text" name="familyName" class="w120" maxlength="128" value="${myAddress?.familyName?.encodeAsHTML()}" />
					名
					<input type="text" name="firstName" class="w120" maxlength="128" value="${myAddress?.firstName?.encodeAsHTML()}" />
<g:render template="/myAddressList/personalTitle" model="${[fromList:personalTitleList, personalTitleId:'primaryNameSelection', personalTitleValue:myAddress?.primaryNameSelection]}" />
				</td>
			</tr>
			<tr>
				<th>お名前/ふりがな<br />（全角ひらがな）</th>
				<td>せい
					<input type="text" name="familyNameKana" class="w120" maxlength="128" value="${myAddress?.familyNameKana?.encodeAsHTML()}" />
					めい
					<input type="text" name="firstNameKana" class="w120" maxlength="128" value="${myAddress?.firstNameKana?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>連名１</th>
				<td>姓
					<input type="text" name="jointFamilyName1" class="w120" maxlength="128" value="${myAddress?.jointFamilyName1?.encodeAsHTML()}" />
					名
					<input type="text" name="jointFirstName1" class="w120" maxlength="128" value="${myAddress?.jointFirstName1?.encodeAsHTML()}" />
<g:render template="/myAddressList/personalTitle" model="${[fromList:jointPersonalTitleList, personalTitleId:'jointNameSelection1', personalTitleValue:myAddress?.jointNameSelection1]}" />
					<br />
					<span class="red size10">※氏名と姓が同じ場合は姓の入力は不要です。入力すると姓も印字されますのでご注意下さい。</span>
				</td>
			</tr>
			<tr>
				<th>連名２</th>
				<td>姓
					<input type="text" name="jointFamilyName2" class="w120" maxlength="128" value="${myAddress?.jointFamilyName2?.encodeAsHTML()}" />
					名
					<input type="text" name="jointFirstName2" class="w120" maxlength="128" value="${myAddress?.jointFirstName2?.encodeAsHTML()}" />
<g:render template="/myAddressList/personalTitle" model="${[fromList:jointPersonalTitleList, personalTitleId:'jointNameSelection2', personalTitleValue:myAddress?.jointNameSelection2]}" />
					<br />
					<span class="red size10">※氏名と姓が同じ場合は姓の入力は不要です。入力すると姓も印字されますのでご注意下さい。</span>
				</td>
			</tr>
			<tr>
				<th>連名３</th>
				<td>姓
					<input type="text" name="jointFamilyName3" class="w120" maxlength="128" value="${myAddress?.jointFamilyName3?.encodeAsHTML()}" />
					名
					<input type="text" name="jointFirstName3" class="w120" maxlength="128" value="${myAddress?.jointFirstName3?.encodeAsHTML()}" />
<g:render template="/myAddressList/personalTitle" model="${[fromList:jointPersonalTitleList, personalTitleId:'jointNameSelection3', personalTitleValue:myAddress?.jointNameSelection3]}" />
					<br />
					<span class="red size10">※氏名と姓が同じ場合は姓の入力は不要です。入力すると姓も印字されますのでご注意下さい。</span>
				</td>
			</tr>
			<tr>
				<th>連名４</th>
				<td>姓
					<input type="text" name="jointFamilyName4" class="w120" maxlength="128" value="${myAddress?.jointFamilyName4?.encodeAsHTML()}" />
					名
					<input type="text" name="jointFirstName4" class="w120" maxlength="128" value="${myAddress?.jointFirstName4?.encodeAsHTML()}" />
<g:render template="/myAddressList/personalTitle" model="${[fromList:jointPersonalTitleList, personalTitleId:'jointNameSelection4', personalTitleValue:myAddress?.jointNameSelection4]}" />
					<br />
					<span class="red size10">※氏名と姓が同じ場合は姓の入力は不要です。入力すると姓も印字されますのでご注意下さい。</span>
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
					<input type="text" name="corporateName" class="w300" maxlength="256" value="${myAddress?.corporateName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>組織名（部・グループ）</th>
				<td>
					<input type="text" name="divisionName" class="w400" maxlength="256" value="${myAddress?.divisionName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>部署名（課・係・チーム）</th>
				<td>
					<input type="text" name="departmentName" class="w400" maxlength="256" value="${myAddress?.departmentName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>役職名</th>
				<td>
					<input type="text" name="businessTitle" class="w400" maxlength="256" value="${myAddress?.businessTitle?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>会社敬称</th>
				<td>
<g:render template="/myAddressList/titleType" model="${[fromList:corporateTitleList, titleType:myAddress?.titleType]}" />
				</td>
			</tr>
			</table>

			<div class="align_center">
				<a href="javascript:void(0)" id="cancelBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_cancelB.gif" alt="キャンセル" /></a>
				<input type="image" id="okBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_toroku-off.gif" alt="登録する" />
			</div>
			</g:form>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" action="index" name="cancelForm" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'zipcode')}"></script>
<r:script>
;jQuery(function(){
var isEmptyDestination = function() {
	return ($.isNull(document.myAddressForm.familyName.value) && $.isNull(document.myAddressForm.firstName.value) && $.isNull(document.myAddressForm.corporateName.value));
};
$("#zipcodeToAddressBtn").click(function() {
	return zipcodeToAddress("zipcode3", "zipcode4", "addressState", "address1", "address2");
});
var formValidator = $("#myAddressForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	rules:{
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
		familyName:{
			required:isEmptyDestination,
			zenkaku:true
		},
		firstName:{
			zenkaku:true
		},
		familyNameKana:{
			zenkaku:true
		},
		firstNameKana:{
			zenkaku:true
		},
		jointFamilyName1:{
			zenkaku:true
		},
		jointFirstName1:{
			zenkaku:true
		},
		jointFamilyName2:{
			zenkaku:true
		},
		jointFirstName2:{
			zenkaku:true
		},
		jointFamilyName3:{
			zenkaku:true
		},
		jointFirstName3:{
			zenkaku:true
		},
		jointFamilyName4:{
			zenkaku:true
		},
		jointFirstName4:{
			zenkaku:true
		}
	},
	messages:{
		zipcode3:{
			required:"郵便番号(上3桁)を指定してください。",
			rangelength:"郵便番号は3桁-4桁形式にて指定してください。",
			digits:"郵便番号は半角数字にて指定してください。"
		},
		zipcode4:{
			required:"郵便番号(下4桁)を指定してください。",
			rangelength:"郵便番号は3桁-4桁形式にて指定してください。",
			digits:"郵便番号は半角数字にて指定してください。"
		},
		address1:{
			required:"市区町村番地を指定してください。"
		},
		familyName:{
			required:"あて先として「氏名」または「会社名」のいずれかを入力する必要があります。",
			zenkaku:"お名前／漢字姓には全角文字を入力してください。"
		},
		firstName:{
			zenkaku:"お名前／漢字名には全角文字を入力してください。"
		},
		familyNameKana:{
			zenkaku:"お名前／ふりがな姓には全角文字を入力してください。"
		},
		firstNameKana:{
			zenkaku:"お名前／ふりがな名には全角文字を入力してください。"
		},
		jointFamilyName1:{
			zenkaku:"連名１姓には全角文字を入力してください。"
		},
		jointFirstName1:{
			zenkaku:"連名１名には全角文字を入力してください。"
		},
		jointFamilyName2:{
			zenkaku:"連名２姓には全角文字を入力してください。"
		},
		jointFirstName2:{
			zenkaku:"連名２名には全角文字を入力してください。"
		},
		jointFamilyName3:{
			zenkaku:"連名３姓には全角文字を入力してください。"
		},
		jointFirstName3:{
			zenkaku:"連名３名には全角文字を入力してください。"
		},
		jointFamilyName4:{
			zenkaku:"連名４姓には全角文字を入力してください。"
		},
		jointFirstName4:{
			zenkaku:"連名４名には全角文字を入力してください。"
		}
	}
});
$("#okBtn").click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.myAddressForm.zipcode.value = document.myAddressForm.zipcode3.value + document.myAddressForm.zipcode4.value;
		document.myAddressForm.submit();
	}
	return false;
});
$("#cancelBtn").click(function() {
	document.cancelForm.submit();
	return false;
});
});</r:script>
</body>
</html>