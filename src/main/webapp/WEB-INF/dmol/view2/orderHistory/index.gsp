<html>
<head>
	<meta name="layout" content="main" />
	<title>ご注文内容確認</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">

			<h2>ご注文内容確認<span>注文番号と電話番号を入力してください。</span></h2>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<g:form name="authForm" action="auth" onsubmit="return false;">
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<tr>
				<th>注文番号　<span class="red">必須</span></th>
				<td>
					<input type="text" class="w150 updateNextBtnState" id="orderNo" name="orderNo" maxlength="14" value="${params.orderNo?.encodeAsHTML()}" /> <span class="size10">(半角数字)</span>
				</td>
			</tr>
			<tr>
				<th>電話番号　<span class="red">必須</span></th>
				<td>
					<input type="text" name="telno0" class="w50 updateNextBtnState" maxlength="5" value="${params.telno0?.encodeAsHTML()}" />
					-
					<input type="text" name="telno1" class="w50 updateNextBtnState" maxlength="5" value="${params.telno1?.encodeAsHTML()}" />
					-
					<input type="text" name="telno2" class="w50 updateNextBtnState" maxlength="4" value="${params.telno2?.encodeAsHTML()}" /> <span class="size10">(半角数字)</span><br />
					<span class="size10">※ご注文時に入力した番号</span>
				</td>
			</tr>
			</table>
			</g:form>
          
		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var formValidator = $("#authForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	onfocusout: false,
	onkeyup: false,
	onclick: false,
	groups:{
		telno:"telno0 telno1 telno2"
	},
	rules:{
		orderNo:{
			required:true,
			rangelength:[14,14],
			nozenkaku:true,
			digits:true
		},
		telno0:{
			required:true,
			rangelength:[2,5],
			nozenkaku:true,
			digits:true
		},
		telno1:{
			required:true,
			rangelength:[2,5],
			nozenkaku:true,
			digits:true
		},
		telno2:{
			required:true,
			rangelength:[4,4],
			nozenkaku:true,
			digits:true
		}
	},
	messages:{
		orderNo:{
			required:"注文番号を指定してください。",
			rangelength:"注文番号は14桁で指定してください。",
			nozenkaku:"注文番号には全角文字をご利用になれません。",
			digits:"注文番号を指定してください。"
		},
		telno0:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			nozenkaku:"電話番号には全角文字をご利用になれません。",
			digits:"電話番号をご確認ください。"
		},
		telno1:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			nozenkaku:"電話番号には全角文字をご利用になれません。",
			digits:"電話番号をご確認ください。"
		},
		telno2:{
			required:"電話番号を指定してください。",
			rangelength:"電話番号をご確認ください。",
			nozenkaku:"電話番号には全角文字をご利用になれません。",
			digits:"電話番号をご確認ください。"
		}
	}
});
$("#nextBtn").click(function() {
	if (formValidator.form()) {
		document.authForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>