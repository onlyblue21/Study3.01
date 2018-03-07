<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>会員の編集</title>
</head>
<body>

<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${createLink(uri:'/')}">メインメニュー</a></li>
			<g:if test="${params.from == 's3s13'}">
				<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
			</g:if>
			<g:else>
				<g:if test="${params.from == 'p3p13'}">
					<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
				</g:if>
				<g:else>
					<g:if test="${params.from == 'jpedituser'}">
						<li><a href="javascript:void(0)" id="recievedOrderBtn">受注管理</a></li>
					</g:if>
					<g:else>
						<li><g:link class="list transition" action="list">会員一覧</g:link></li>
					</g:else>
				</g:else>
			</g:else>
			<li>会員編集</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>会員の編集</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="updateBtn" class="button"><span class="icon-save">更新</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />
		<g:hasErrors bean="${userInfo}">
			<div class="errors">
					<g:renderErrors bean="${userInfo}" as="list" />
			</div>
		</g:hasErrors>
<g:render template="/common/fragment/validatormessages" />

		<g:form name="updateForm" method="post" action="update" onsubmit="return false;">
			<input type="hidden" name="id" value="${params.id?.encodeAsHTML()}" />
			<input type="hidden" name="version" value="${params.version?.encodeAsHTML()}" />
			<div class="dialog">
			<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">${fieldNames?.User?.email?.encodeAsHTML()}:</td>
							<td valign="top" class="value ${hasErrors(bean:userInfo,field:'email','errors')}">
							<input type="text" size="40" maxlength="512" id="email" name="email" value="${userInfo.email?.encodeAsHTML()}"/>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">${fieldNames?.User?.passwd?.encodeAsHTML()}:</td>
							<td valign="top" class="value">
								<button id="resetPasswdBtn">パスワードリセット</button>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">法人区分:</td>
							<td valign="top" class="value"><g:select name="corporateUse" from="${[[title:'法人',ovalue:true],[title:'個人',ovalue:false]]}" optionKey="ovalue" optionValue="title" value="${userInfo?.corporateUse}" /></td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">お名前／漢字（全角）:</td>
							<td valign="top" class="value">
								<input type="text" name="familyName" size="40" maxlength="128" value="${userInfo?.familyName?.encodeAsHTML()}" />
								<input type="text" name="firstName" size="40" maxlength="128" value="${userInfo?.firstName?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">お名前／ふりがな（全角ひらがな）:</td>
							<td valign="top" class="value">
								<input type="text" name="familyNameKana" size="40" maxlength="128" value="${userInfo?.familyNameKana?.encodeAsHTML()}" />
								<input type="text" name="firstNameKana" size="40" maxlength="128" value="${userInfo?.firstNameKana?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵便番号:</td>
							<td valign="top" class="value">
								<input type="text" id="zipcode" name="zipcode" size="10" maxlength="7" value="${userInfo?.zipcode?.encodeAsHTML()}" />
								<button id="zipcodeToAddressBtn">郵便番号=&gt;住所</button>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">都道府県:</td>
							<td valign="top" class="value">
								<g:select id="addressState" name="addressState" from="${addressStateList}" value="${userInfo?.addressState}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">市区町村:</td>
							<td valign="top" class="value">
								<input type="text" id="address1" name="address1" size="40" maxlength="256" value="${userInfo?.address1?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">町域名:</td>
							<td valign="top" class="value">
								<input type="text" id="address2" name="address2" size="40" maxlength="256" value="${userInfo?.address2?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">丁目・番地等:</td>
							<td valign="top" class="value">
								<input type="text" id="address3" name="address3" size="40" maxlength="256" value="${userInfo?.address3?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">アパート・ビル・マンション:</td>
							<td valign="top" class="value">
								<input type="text" id="address4" name="address4" size="40" maxlength="256" value="${userInfo?.address4?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">電話番号:</td>
							<td valign="top" class="value">
								<input type="text" name="telno" size="20" maxlength="16" value="${userInfo?.telno?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">会社名:</td>
							<td valign="top" class="value">
								<input type="text" name="corporateName" size="40" maxlength="256" value="${userInfo?.corporateName?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">部署名:</td>
							<td valign="top" class="value">
								<input type="text" name="departmentName" size="40" maxlength="256" value="${userInfo?.departmentName?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">肩書・役職:</td>
							<td valign="top" class="value">
								<input type="text" name="businessTitle" size="40" maxlength="256" value="${userInfo?.businessTitle?.encodeAsHTML()}" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵送でのDM:</td>
							<td valign="top" class="value">
								<input type="radio" id="optinDmByPostingTrue" name="optinDmByPosting" value="true" ${userInfo?.optinDmByPosting ? 'checked' : ''} /><label for="optinDmByPostingTrue">希望する</label>
								<input type="radio" id="optinDmByPostingFalse" name="optinDmByPosting" value="false" ${userInfo?.optinDmByPosting ? '' : 'checked'} /><label for="optinDmByPostingFalse">希望しない</label>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">eメールでのDM:</td>
							<td valign="top" class="value">
								<input type="radio" id="optinDmByEmailTrue" name="optinDmByEmail" value="true" ${userInfo?.optinDmByEmail ? 'checked' : ''} /><label for="optinDmByEmailTrue">希望する</label>
								<input type="radio" id="optinDmByEmailFalse" name="optinDmByEmail" value="false" ${userInfo?.optinDmByEmail ? '' : 'checked'} /><label for="optinDmByEmailFalse">希望しない</label>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">ID:</td>
							<td valign="top" class="value">${userInfo?.id?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">営業担当支店ID:</td>
							<td valign="top" class="value">${userInfo?.jpostSalesBranch?.salesBranchId?.encodeAsHTML()} <span>${userInfo?.jpostSalesBranch?.salesBranchName?.encodeAsHTML()}</span></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">初回登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.dateCreated}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">本登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.registeredDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">退会日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.withdrawalDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">最終ログイン日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.lastLoginDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">削除フラグ:</td>
							<td valign="top" class="value">
								<g:checkBox name="deleted" value="true" checked="${!userInfo.enabled}" ></g:checkBox>
								<label for="deleted">削除する(論理削除)</label>
							</td>
						</tr>
					</tbody>
				</table>
				</sec:ifAnyGranted>
				
				<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
				<table>
					<tbody>
					
						<tr class="prop">
							<td valign="top" class="name">${fieldNames?.User?.email?.encodeAsHTML()}:</td>
							<td valign="top" class="value">**********</td>
						</tr>
					
						<tr class="prop">
							<td valign="top" class="name">${fieldNames?.User?.passwd?.encodeAsHTML()}:</td>
							<td valign="top" class="value">
								<button id="resetPasswdBtn">パスワードリセット</button>
							</td>
						</tr>
					
						<tr class="prop">
							<td valign="top" class="name">法人区分:</td>
							<td valign="top" class="value"><g:select name="corporateUse" from="${[[title:'法人',ovalue:true],[title:'個人',ovalue:false]]}" optionKey="ovalue" optionValue="title" value="${userInfo?.corporateUse}" /></td>
						</tr>
					
						<tr class="prop">
							<td valign="top" class="name">お名前:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">フリガナ:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵便番号:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">都道府県:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">市区町村:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">町域名:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">丁目・番地等:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">アパート・ビル・マンション:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">電話番号:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">会社名:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">部署名:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">肩書・役職:</td>
							<td valign="top" class="value">**********</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">郵送でのDM:</td>
							<td valign="top" class="value">
								<input type="radio" id="optinDmByPostingTrue" name="optinDmByPosting" value="true" ${userInfo?.optinDmByPosting ? 'checked' : ''} /><label for="optinDmByPostingTrue">希望する</label>
								<input type="radio" id="optinDmByPostingFalse" name="optinDmByPosting" value="false" ${userInfo?.optinDmByPosting ? '' : 'checked'} /><label for="optinDmByPostingFalse">希望しない</label>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">eメールでのDM:</td>
							<td valign="top" class="value">
								<input type="radio" id="optinDmByEmailTrue" name="optinDmByEmail" value="true" ${userInfo?.optinDmByEmail ? 'checked' : ''} /><label for="optinDmByEmailTrue">希望する</label>
								<input type="radio" id="optinDmByEmailFalse" name="optinDmByEmail" value="false" ${userInfo?.optinDmByEmail ? '' : 'checked'} /><label for="optinDmByEmailFalse">希望しない</label>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">ID:</td>
							<td valign="top" class="value">${userInfo?.id?.encodeAsHTML()}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">営業担当支店ID:</td>
							<td valign="top" class="value">${userInfo?.jpostSalesBranch?.salesBranchId?.encodeAsHTML()} <span>${userInfo?.jpostSalesBranch?.salesBranchName?.encodeAsHTML()}</span></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">初回登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.dateCreated}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">本登録日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.registeredDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">退会日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.withdrawalDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">最終ログイン日時:</td>
							<td valign="top" class="value"><g:formatDate format="${timestampFormat}" date="${userInfo?.lastLoginDate}" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">削除フラグ:</td>
							<td valign="top" class="value">
								<g:checkBox name="deleted" value="true" checked="${!userInfo.enabled}" ></g:checkBox>
								<label for="deleted">削除する(論理削除)</label>
							</td>
						</tr>
					</tbody>
				</table>
				</sec:ifNotGranted>
			</div>
		</g:form>
	</div>

<g:form method="get" action="list" name="cancelForm" />
<form method="post" action="${recievedOrderURL}" name="recievedOrderForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		email:{
			required:true,
			email:true,
			nozenkaku:true,
			noktaiemail:true
		},
		familyName:{
			required:true
		},
		firstName:{
			required:true
		},
		familyNameKana:{
			required:true
		},
		firstNameKana:{
			required:true
		},
		zipcode:{
			required:true,
			digits:true
		},
		address1:{
			required:true
		},
		address2:{
			required:true
		},
		telno:{
			required:true
		},
		corporateName:{
			required:function() {
				var corporateUse = $("#corporateUse").val();
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
		familyName:{
			required:"お名前／漢字姓を指定してください。"
		},
		firstName:{
			required:"お名前／漢字名を指定してください。"
		},
		familyNameKana:{
			required:"お名前／ふりがな姓を指定してください。"
		},
		firstNameKana:{
			required:"お名前／ふりがな名を指定してください。"
		},
		zipcode:{
			required:"郵便番号を指定してください。",
			digits:"郵便番号は半角数字にて指定してください。"
		},
		address1:{
			required:"市区町村を指定してください。"
		},
		address2:{
			required:"町域名を指定してください。"
		},
		telno:{
			required:"電話番号を指定してください。"
		},
		corporateName:{
			required:"法人区分の場合は会社名を指定してください。"
		},
		secretAnswer:{
			required:"秘密の質問の答えを指定してください。"
		}
	}
});
$("#updateBtn").click(function() {
	if (formValidator.form()) {
		document.updateForm.submit();
	}
	return false;
});
$("#resetPasswdBtn").button().click(function() {
	oiyConfirm("パスワードをリセットしますか？", function() {
		$.ajax({
			url: "${createLink(action:'reminderMail', id:params.id)}",
			success: function(data, textStatus, jqXHR) {
				if (data.result == "success") {
					$().toastmessage('showSuccessToast', "パスワードリセットメールを送信しました。");
				} else {
					var message = "パスワードリセットメールを送信できませんでした。";
					if (data.message) {
						message = data.message;
					}
					$().toastmessage('showErrorToast', message);
				}
				return false;
			}
		});
		return false;
	});
	return false;
});
$("#zipcodeToAddressBtn").button().click(function() {
	var lparams = {};
	lparams.zipcode = $("#zipcode").val();
	$.ajax({
		url: "${createLink(controller:'zipcode', action:'toAddress')}",
		data: lparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "found") {
				var zinfo = data;
				$("#zipcode").val(zinfo.zipcode);
				$("#addressState").val(zinfo.addressState);
				$("#address1").val(zinfo.address1);
				$("#address2").val(zinfo.address2);
				$("#address3").val(zinfo.address3);
				$("#address4").val(zinfo.address4);
			} else {
				$().toastmessage('showNoticeToast', "住所が見つかりませんでした。");
//				var message = "住所が見つかりませんでした。";
//				oiyAlert(message);
			}
			return false;
		}
	});
	return false;
});
$("#recievedOrderBtn").click(function() {
	return relayLogin(document.recievedOrderForm, '受注管理');
});

var relayLogin = function(form, title) {
	var params = null;
	$.post("${createLink(controller:'mainMenu', action:'settlementRelayInfo')}", params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				pleaseWait();
				form.relayUserId.value = result.relayUserId;
				form.dtime.value = result.dtime;
				form.clientId.value = result.clientId;
				form.submit();
				return false;
			} else if (result.message) {
				oiyAlert(result.message);
				return false;
			}
		}
		oiyAlert(title + '画面を表示することができませんでした。');
		return false;
	});
	return false;
};


$('#cancelBtn').click(function() {
	document.cancelForm.submit();
	return false;
});

$("a.transition").click(function() {
	return confirmTransition(this.href);
});
});</r:script>
</body>
</html>
