<html>
<head>
	<meta name="layout" content="main" />
	<title>利用登録</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>基本情報登録</h1>
		<div class="bgGradLine"></div>

<!-- commonContents -->
		<div class="commonContents w664">
			<h2>登録情報の入力</h2>
			<p>内容を入力して、「進む」ボタンを押してください。<br />
			※環境依存文字は文字化けする恐れがありますので、入力しないでください。</p>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<g:form name="updateForm" action="confirm" onsubmit="return false;">
			<input type="hidden" name="zipcode" value="" />
			<input type="hidden" name="telno" value="" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th>メールアドレス  <span class="red">必須</span></th>
				<td>
					<input type="text" class="w250" id="email" name="email" maxlength="128" value="${userInfo?.email?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
				<th>パスワード  <span class="red">必須</span></th>
				<td>
					<input type="password" class="w200" maxlength="16" id="passwd1" name="passwd1" value="" />
					<span class="size10">　(半角英数字8～16文字)</span>
				</td>
			</tr>
			<tr>
				<th>パスワード（確認用）  <span class="red">必須</span></th>
				<td>
					<input type="password" class="w200" maxlength="16" id="passwd2" name="passwd2" value="" />
					<span class="size10">　(半角英数字8～16文字)</span>
				</td>
			</tr>
			<tr>
				<th>法人区分　<span class="red">必須</span></th>
				<td>
					<input type="radio" id="corporateUseTrue" name="corporateUse" value="true" ${userInfo?.corporateUse ? 'checked' : ''} /><label for="corporateUseTrue">法人</label>
					　　
					<input type="radio" id="corporateUseFalse" name="corporateUse" value="false" ${userInfo?.corporateUse ? '' : 'checked'} /><label for="corporateUseFalse">個人</label>
				</td>
			</tr>
			<tr>
				<th>お名前/漢字　<span class="red">必須</span><br />（全角）</th>
				<td>姓 <input type="text" name="familyName" class="w120" maxlength="128" value="${userInfo?.familyName?.encodeAsHTML()}" />　　　名 <input type="text" name="firstName" class="w120" maxlength="128" value="${userInfo?.firstName?.encodeAsHTML()}" /><br />
　　例）郵便　　　　　　　　　　　　 　　 例）太郎</td>
			</tr>
			<tr>
				<th>お名前/ふりがな　<span class="red">必須</span><br />（全角ひらがな）</th>
				<td>せい<input type="text" name="familyNameKana" class="w120" maxlength="128" value="${userInfo?.familyNameKana?.encodeAsHTML()}" />　　めい <input type="text" name="firstNameKana" class="w120" maxlength="128" value="${userInfo?.firstNameKana?.encodeAsHTML()}" /><br />
　　　例）ゆうびん　　　　　　　　　　　　　        例）たろう</td>
			</tr>
			<tr>
				<th>郵便番号　<span class="red">必須</span></th>
				<td>
<g:set var="zipcode3" value="${(userInfo?.zipcode?.size() > 3) ? (userInfo.zipcode.substring(0,3)) : (userInfo?.zipcode)}" />
<g:set var="zipcode4" value="${(userInfo?.zipcode?.size() > 3) ? (userInfo.zipcode.substring(3)) : ''}" />
					<input type="text" id="zipcode3" name="zipcode3" class="w40" maxlength="3" value="${zipcode3?.encodeAsHTML()}" />
					 -
					<input type="text" id="zipcode4" name="zipcode4" class="w40" maxlength="4" value="${zipcode4?.encodeAsHTML()}" />
					<span class="size10">(半角数字)</span>
					<a href="javascript:void(0)" id="zipcodeToAddressBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_jyusyo.gif" alt="住所を入力" /></a>
				</td>
			</tr>
			<tr>
				<th>都道府県　<span class="red">必須</span></th>
				<td>
					<g:select id="addressState" name="addressState" from="${addressStateList}" value="${userInfo?.addressState}" />
				</td>
			</tr>
			<tr>
				<th>市区町村　<span class="red">必須</span></th>
				<td>
					<input type="text" id="address1" name="address1" class="w200" maxlength="256" value="${userInfo?.address1?.encodeAsHTML()}" /><br />
 					<span class="size10">例）千代田区</span>
				</td>
			</tr>
			<tr>
				<th>町域名　<span class="red">必須</span></th>
				<td>
					<input type="text" id="address2" name="address2" class="w150" maxlength="256" value="${userInfo?.address2?.encodeAsHTML()}" />
					<a href="javascript:void(0)" id="addressToZipcodeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_yubinbango.gif" alt="郵便番号を入力する" /></a><br />
					<span class="size10">例）霞ヶ関</span>
				</td>
			</tr>
			<tr>
				<th>丁目・番地等</th>
				<td>
					<input type="text" id="address3" name="address3" class="w120" maxlength="256" value="${userInfo?.address3?.encodeAsHTML()}" /><br />
					<span class="size10">例）1-3-2</span>
				</td>
			</tr>
			<tr>
				<th>アパート・ビル・マンション</th>
				<td>
					<input type="text" id="address4" name="address4" class="w250" maxlength="256" value="${userInfo?.address4?.encodeAsHTML()}" /><br />
					<span class="size10">例）日本郵政ビル　8階</span>
				</td>
			</tr>
			<tr>
				<th>電話番号　<span class="red">必須</span></th>
				<td>
<g:set var="telnoList" value="${userInfo?.telno?.split('-')}" />
<g:set var="telno0" value="${(telnoList?.size() > 0) ? telnoList.getAt(0) : ''}" />
<g:set var="telno1" value="${(telnoList?.size() > 1) ? telnoList.getAt(1) : ''}" />
<g:set var="telno2" value="${(telnoList?.size() > 2) ? telnoList.getAt(2) : ''}" />
					<input type="text" name="telno0" class="w50" maxlength="5" value="${telno0?.encodeAsHTML()}" />
					-
					<input type="text" name="telno1" class="w50" maxlength="5" value="${telno1?.encodeAsHTML()}" />
					-
					<input type="text" name="telno2" class="w50" maxlength="4" value="${telno2?.encodeAsHTML()}" /> <span class="size10">(半角数字)<br />
					※ケータイ電話番号可</span>
				</td>
			</tr>
			<tr>
				<th>会社名</th>
				<td>
					<input type="text" name="corporateName" class="w200" maxlength="256" value="${userInfo?.corporateName?.encodeAsHTML()}" /><br />
					<span class="size10 red2">※法人区分の場合は必須</span>
				</td>
			</tr>
			<tr>
              <th>部署名</th>
				<td>
					<input type="text" name="departmentName" class="w200" maxlength="256" value="${userInfo?.departmentName?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
              <th>肩書・役職</th>
				<td>
					<input type="text" name="businessTitle" class="w200" maxlength="256" value="${userInfo?.businessTitle?.encodeAsHTML()}" />
				</td>
			</tr>
			<tr>
              <th>秘密の質問　<span class="red">必須</span></th>
				<td>
<g:render template="/common/fragment/secretQuestion" model="${[secretQuestion:userInfo?.secretQuestion]}" />
				</td>
			</tr>
			<tr>
              <th>秘密の質問の答え　<span class="red">必須</span></th>
				<td>
					<input type="text" name="secretAnswer" class="w120" maxlength="256" value="" />
				</td>
			</tr>
			<tr>
              <th>郵送でのDM</th>
				<td>
					<input type="radio" id="optinDmByPostingTrue" name="optinDmByPosting" value="true" ${userInfo?.optinDmByPosting ? 'checked' : ''} /><label for="optinDmByPostingTrue">希望する</label>
					　　
					<input type="radio" id="optinDmByPostingFalse" name="optinDmByPosting" value="false" ${userInfo?.optinDmByPosting ? '' : 'checked'} /><label for="optinDmByPostingFalse">希望しない</label>
				</td>
			</tr>
			<tr>
              <th>eメールでのDM</th>
				<td>
					<input type="radio" id="optinDmByEmailTrue" name="optinDmByEmail" value="true" ${userInfo?.optinDmByEmail ? 'checked' : ''} /><label for="optinDmByEmailTrue">希望する</label>
					　　
					<input type="radio" id="optinDmByEmailFalse" name="optinDmByEmail" value="false" ${userInfo?.optinDmByEmail ? '' : 'checked'} /><label for="optinDmByEmailFalse">希望しない</label>
				</td>
			</tr>
			</table>

			<div class="align_center">
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
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	groups:{
		zipcode:"zipcode3 zipcode4",
		telno:"telno0 telno1 telno2"
	},
	rules:{
		email:{
			required:true,
			email:true,
			nozenkaku:true,
			noktaiemail:true
		},
		passwd1:{
			required:true,
			passwordCheck:true
		},
		passwd2:{
			required:true,
			passwordCheck:true,
			equalTo:"#passwd1"
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
		secretAnswer:{
			required:true
		}
	},
	messages:{
		email:{
			required:"メールアドレスを指定してください。",
			email:"メールアドレスが正しくありません。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。",
			noktaiemail:"携帯メールアドレスでの登録は出来ません"
		},
		passwd1:{
			required:"パスワードを指定してください。",
			passwordCheck:"半角英数字混合8～16文字にて指定してください。",
		},
		passwd2:{
			required:"パスワード(確認用)を指定してください。",
			passwordCheck:"半角英数字混合8～16文字にて指定してください。",
			equalTo:"パスワードとパスワード(確認用)が一致していません。"
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
		secretAnswer:{
			required:"秘密の質問の答えを指定してください。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.updateForm.zipcode.value = document.updateForm.zipcode3.value + document.updateForm.zipcode4.value;
		document.updateForm.telno.value = document.updateForm.telno0.value + '-' + document.updateForm.telno1.value + '-' + document.updateForm.telno2.value;
		document.updateForm.submit();
	}
	return false;
});
$("#zipcodeToAddressBtn").click(function() {
	return zipcodeToAddress("zipcode3", "zipcode4", "addressState", "address1", "address2", "address3", "address4");
});
$("#addressToZipcodeBtn").click(function() {
	document.addressToZipForm.submit();
	return false;
});
});</r:script>
</body>
</html>