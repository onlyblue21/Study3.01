<html>
<head>
	<meta name="layout" content="main" />
	<title>注文内容の確認</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header"/>	
<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />
	
	<!-- breadcrumb -->
	<!--  <div class="breadcrumb bgGrad">
		<ul>
			<li><a href="javascript:toHome();">ホーム</a></li>
      <li>注文内容の確認</li>
		</ul>
	</div>-->
	<!-- /breadcrumb END -->
			
	<!-- mainBlock -->
		<div class="mainBlock">
			<h1>注文内容の確認</h1>
		
		
	<!-- commonContents -->
<g:if test="${isOK}">
	<g:form name="updateForm" action="bankupdate" onsubmit="return false;">
			<div class="commonContents w664">
				
			<img src="${resource(dir:'/static/dmol/users/images',file:'layout')}/c_chart_4.gif" class="mB20" />
			 <h2>銀行振込決済の説明</h2>
		        
			<!-- <iframe src="${g.resource(dir:'static/dmol/users', file:'bankhelp.html')}" frameborder="0" scrolling="no" width="100%" height="100%" marginheight="0"></iframe> -->
			 
			<g:render template="/common/fragment/bankhelp" />
	 		<h2>銀行振込決済の内容確認</h2>
			
			<p class="mB15">内容をご確認いただき、「注文を確定する」ボタンを押してください。<br />
			なお、注文確定後のキャンセルはできませんので、ご了承ください。</p>
	 
			<g:if test="${screenCol == 'DIVISION_FUTAI'}">
			<table cellpadding="0" cellspacing="0" class="listTable1 w664 mB5">
				<tr>
					<th width="80" class="align_center">ご注文明細</th>
					<th class="align_center">商品名</th>
					<th width="130" class="align_center">ご利用金額（税込）</th>
				</tr>
				<g:each in="${details}"  var="detail" status="i" >
				<tr class="bgcff">
					<td class="align_center">01&nbsp;
					</td>
					<td class="align_left">${detail?.futaiServiceName?.encodeAsHTML()}&nbsp;
					</td>
					<td class="align_right"><g:formatNumber number="${detail?.totalAmount?.encodeAsHTML()}" format="#,###" />円</td>
				</tr>
				</g:each>
			</table>
			</g:if>
			<g:else>
			<table cellpadding="0" cellspacing="0" class="listTable1 w664 mB5">
				<tr>
					<th width="80" class="align_center">ご注文明細</th>
					<!--  <th width="100" class="align_center">プロダクト番号</th>-->
					<th class="align_center">デザイン名</th>
					<th width="130" class="align_center">ご利用金額（税込）</th>
				</tr>
				<g:each in="${details}"  var="detail" status="i" >
				<tr class="bgcff">
					<td class="align_center">${detail?.detailNo?.encodeAsHTML()}&nbsp;
					</td>
					<!--  <td class="align_center">${detail?.myProductNo?.encodeAsHTML()}&nbsp;
					</td>-->
					<td class="align_left">${detail?.myProductName?.encodeAsHTML()}&nbsp;
					</td>
					<td class="align_right"><g:formatNumber number="${detail?.totalAmount?.encodeAsHTML()}" format="#,###" />円</td>
					<td style="display: none;">
					<input type="hidden" name="id${i}" value="${detail?.id?.encodeAsHTML()}" />	
					<input type="hidden" name="version${i}" value="${detail?.version?.encodeAsHTML()}" />			
					</td>
				</tr>
				</g:each>
			</table>		
	 		</g:else>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20 w664">
				<tr>
					<th width="180">お振込み金額合計（税込）</th>
					<td class="pL10">${fieldValue(bean: info, field: "totalAmount")}円</td>
				</tr>
			</table>		
	 
			<h3 class="align_left" style="font-size: 14px;">ご依頼主:</h3>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20 w664">
				<tr>
					<th width="180">お名前</th>
					<td class="pL10">${info?.familyName?.encodeAsHTML()}&nbsp;&nbsp;${info?.firstName?.encodeAsHTML()}&nbsp;&nbsp;様</td>
				</tr>
			</table>		
	 
			<h3 class="align_left" style="font-size: 14px;">お届け先:</h3>
			<table cellpadding="0" cellspacing="0" class="commonTable1 mB20 w664">
				<tr>
					<th width="180">お名前</th>
					<td class="pL10">${info?.destinationFamilyName?.encodeAsHTML()}&nbsp;&nbsp;${info?.destinationFirstName?.encodeAsHTML()}&nbsp;&nbsp;様</td>
				</tr>
				<tr>
					<th width="180">郵便番号</th>
					<td class="pL10">${destinationZipcode?.encodeAsHTML()}&nbsp;</td>
				</tr>
				<tr>
					<th width="180">住所</th>
					<td class="pL10">${info?.destinationAddressState?.encodeAsHTML()}	
						${info?.destinationAddress1?.encodeAsHTML()}	
						${info?.destinationAddress2?.encodeAsHTML()}
						${info?.destinationAddress3?.encodeAsHTML()}&nbsp;
						<br />
						${info?.destinationAddress4?.encodeAsHTML()}
						
					</td>
				</tr>
				<tr>
					<th width="180">会社名</th>
					<td class="pL10">${info?.destinationCorporateName?.encodeAsHTML()}&nbsp;</td>
				</tr>
				<tr>
					<th width="180">部署名</th>
					<td class="pL10">${info?.destinationDepartmentName?.encodeAsHTML()}&nbsp;</td>
				</tr>
				<tr>
					<th width="180">電話番号</th>
					<td class="pL10">${info?.destinationTelno?.encodeAsHTML()}&nbsp;</td>
				</tr>
			</table>
			<!-- 第三期 2012/03/19 by A&I Start -->
			<g:render template="/common/fragment/questionnaire" />  
			<!-- 第三期 2012/03/19 by A&I End -->
			<div class="align_center">
				<a href="#" id="topBtn" class="mR15"><img src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/btn_modoru_kessaiB.gif" alt="決算方法選択に戻る" class="valignM" /></a>
				<input type="image" id="nextBtn" src="${resource(dir:'/static/dmol/users/images/common',file:'bt')}/btn_kakutei-off.gif" alt="注文を確定する ※確定後のキャンセルはできません。" class="valignM" />
			</div>
	          
	        
	   </div>
	    </g:form>
	<!-- commonContents END -->
</g:if>
<g:else>
<g:set var="errormessage" value="${flash.message ?: '注文データを取得できませんでした。'}" />
			<p class="size20 align_center red"><strong>${errormessage?.encodeAsHTML()}</strong></p>
</g:else>
	</div>
	<!-- /mainBlock END -->
	
<g:form name="topForm" action="backMenu">
</g:form>
<jq:jquery>
$("#nextBtn").click(function() {
	var param = {};
	// 第三期 2012/03/19 by A&I Start
	param.settlementValue = document.getElementById("settlementValue").value;
	param.myValue = document.getElementById("myField").value;
	param.postCd = document.getElementById("settlementPostCd").value;
	param.postNm =  document.getElementById("salesPerson").value;
	// 第三期 2012/03/19 by A&I End
	var url = '${createLink(controller:'settlement', action:'bankupdate')}';
	return relayLogin(url, param);
});
$("#topBtn").click(function() {	
	document.topForm.submit();
	return false;
});
</jq:jquery>
</body>
</html>