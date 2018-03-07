<html>
<head>
	<meta name="layout" content="main" />
	<title>あて名データ管理</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myList">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>CSVファイルアップロード</h1>

<!-- commonContents -->
		<div class="commonContents">

<g:render template="/common/fragment/flashmessages" />

			<g:uploadForm method="post" action="uploadCustomData" name="uploadCustomDataForm" onsubmit="return false;">
			<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
			<input type="hidden" name="custumDataDelimiter" value="${params.custumDataDelimiter?.encodeAsHTML()}" />
			<input type="hidden" name="custumDataNoFirstLine" value="${params.custumDataNoFirstLine?.encodeAsHTML()}" />
			<div class="box700">
				<div class="boxTop"></div>
				<div class="boxMiddle">
					<h2>アップロードするファイルを選択して、アップロードボタンを押してください。</h2>
					<div class="lineGW mB10"></div>
					<div class="pT20 mB20">
						<table cellpadding="0" cellspacing="0" class="commonTable2">
							<tr>
								<td class="align_center"><strong class="valignM size14">ファイル選択：</strong>　<input type="file" id="myAddressListFile" name="myAddressListFile" value="" size="50" class="valignM" /></td>
							</tr>
							<tr>
								<td class="align_center"><input type="image" id="uploadCustomDataBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_upload_b-off.gif" alt="アップロード" disabled="disabled" /></td>
							</tr>
						</table>
					</div>
					<div class="lineGW mT10"></div>
					<div class="btnArea">
						<a href="javascript:void(0)" id="prevBtn" class="floatleft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoruB.gif" alt="戻る" /></a>
					</div>
				</div>
				<div class="boxBottom"></div>
			</div>
			</g:uploadForm>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form action="selectCustomDataDelimiter" name="selectCustomDataDelimiterForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
<input type="hidden" name="custumDataDelimiter" value="${params.custumDataDelimiter?.encodeAsHTML()}" />
<input type="hidden" name="custumDataNoFirstLine" value="${params.custumDataNoFirstLine?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var uploadFormValidator = $("#uploadCustomDataForm").validate({
	onfocusout:false,
	onkeyup:false,
	onclick:false,
	rules:{
		myAddressListFile:{
			required:true,
			extension:'csv'
		}
	},
	messages:{
		myAddressListFile:{
			required:"あて名データファイルを指定してください。",
			extension:"あて名データにはCSVファイルを指定してください。"
		}
	},
	showErrors:function(errorMap, errorList) {
		if (errorList) {
			for (var index = 0; index < errorList.length; index++) {
				var message = errorList[index].message;
				$().toastmessage('showErrorToast', message);
			}
		}
		return false;
	}
});
var myAddressListFile = $("#myAddressListFile");
var uploadCustomDataBtn = $("#uploadCustomDataBtn");
var enableUploadBtn = function() {
	var file = myAddressListFile.val();
	if ($.isNull(file)) {
		uploadCustomDataBtn.setDisabled(true);
	} else {
		uploadCustomDataBtn.setDisabled(false);
	}
};
myAddressListFile.change(enableUploadBtn);
enableUploadBtn();
uploadCustomDataBtn.click(function() {
	if (uploadFormValidator.form()) {
		pleaseWait();
		document.uploadCustomDataForm.submit();
	}
	return false;
});
$("#prevBtn").click(function() {
	pleaseWait();
	document.selectCustomDataDelimiterForm.submit();
	return false;
});
});</r:script>
</body>
</html>