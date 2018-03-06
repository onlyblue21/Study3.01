<html>
<head>
	<meta name="layout" content="main" />
	<title>カード番号入力</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header"/>	
		<g:form name="inputForm" action="confirm" onsubmit="return false;">
	<!-- breadcrumb -->
	<!--  <div class="breadcrumb bgGrad">
		<ul>
			<li><a href="javascript:toHome();">ホーム</a></li>
      <li>カード番号入力</li>
		</ul>
	</div>-->
	<!-- /breadcrumb END -->
			
	<!-- mainBlock -->
		<div class="mainBlock">
			<h1>カード番号入力</h1>
	<!-- commonContents -->
			<div class="commonContents w664">
				
<g:if test="${isOK}">
			<img src="${resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_3.gif" class="mB20" />
	 		<h2>クレジットカード決済の説明</h2>
	        
			
	 		<g:render template="/common/fragment/creditcardhelp" />
	 
	 		<h2>クレジットカード決済の必要事項入力</h2>
	 		<g:render template="/common/fragment/flashmessages" />
	 		<g:render template="/common/fragment/validatormessages" />
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20">
			<col style="width:90px">
			<col style="width:300px">
				<tr>
					<th>カード番号</th>
					<td>
						<input type="text" id="cardNo" name="cardNo" class="w150" maxlength="16" style="ime-mode: disabled;" value="${requestRetMap?.cardNo?.encodeAsHTML()}" /> 
						<span>（ハイフン無し）</span>
					</td>
				</tr>
				<tr>
					<th>有効期限</th>
					<td>
						<g:select id="cardExpM" name="cardExpM" from="${addMonthList}" value="${requestRetMap?.cardExpM}" noSelection="${['':'--']}"/>
						 <span>月／</span>
						<g:select id="cardExpY" name="cardExpY" from="${addYearList}" value="${requestRetMap?.cardExpY}" noSelection="${['':'----']}"/>
						 <span>年</span>
					</td>
				</tr>
				<tr>
					<th>セキュリティコード</th>
					<td>
						<input type="text" id="secCd" name="secCd" class="w50" maxlength="4" style="ime-mode: disabled;" value="${requestRetMap?.secCd?.encodeAsHTML()}"/> 
						<span>（クレジットカード表面・裏面の3桁または4桁）</span>
					</td>
				</tr>
				<tr>
					<th>生月日</th>
					<td>
						<g:select id="birthDayM" name="birthDayM" from="${addMonthList}" value="${requestRetMap?.birthDayM}" noSelection="${['':'--']}"/>
						 <span>月／</span>
						<g:select id="birthDayD" name="birthDayD" from="${addDayList}" value="${requestRetMap?.birthDayD}" noSelection="${['':'--']}"/>
						 <span>日</span>
					</td>
				</tr>
			</table>
			
			<div class="align_center">
				<a href="#" id="topBtn" class="mR15"><img src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/btn_modoru_kessaiB.gif" alt="決算方法選択に戻る" /></a>
				<input type="image" id="nextBtn" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/btn_g_susumu-off.gif" alt="進む" />
			</div>
</g:if>
<g:else>
<g:set var="errormessage" value="${flash.message ?: '注文データを取得できませんでした。'}" />
			<p class="size20 align_center red"><strong>${errormessage?.encodeAsHTML()}</strong></p>
</g:else>
	   </div>
	<!-- commonContents END -->
	</div>
	<!-- /mainBlock END -->
	</g:form>

<g:form name="topForm" action="backMenu">
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
var formValidator = $("#inputForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		cardNo:{
			required:true,
			digits:true,
			rangelength:[14,16]
		},
		cardExpM:{
			required:true
		},
		cardExpY:{
			required:true
		},
		secCd:{
			required:true,
			digits:true,
			rangelength:[3,4]
		},
		birthDayM:{
			required:true
		},
		birthDayD:{
			required:true
		}
	},
	messages:{
		cardNo:{
			required:"カード番号を指定してください。",
			digits:"カード番号は半角数字にて指定してください。",
			rangelength:"カード番号には14桁以上を指定してください。"
		},
		cardExpM:{
			required:"有効期間の月を指定してください。"
		},
		cardExpY:{
			required:"有効期間の年を指定してください。"
		},
		secCd:{
			required:"セキュリティコードを指定してください。",
			digits:"セキュリティコードは半角数字にて指定してください。",
			rangelength:"セキュリティコードには3桁または4桁を指定してください。"
		},
		birthDayM:{
			required:"生月日の月を指定してください。"
		},
		birthDayD:{
			required:"生月日の日を指定してください。"
		}
	}
});

$("#nextBtn").click(function() {
	if (formValidator.form()) {
	document.inputForm.submit();
	}
	return false;
});
$("#topBtn").click(function() {	
	document.topForm.submit();
	return false;
});

</jq:jquery>
</body>
</html>