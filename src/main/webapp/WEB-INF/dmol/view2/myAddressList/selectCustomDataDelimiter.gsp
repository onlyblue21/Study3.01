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

			<g:form action="selectCustomData" name="selectCustomDataForm">
			<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
			<div class="box700">
				<div class="boxTop"></div>
				<div class="boxMiddle">
					<h2>アップロードするCSVファイルの項目区切り記号を選択してください。</h2>
					<div class="lineGW mB10"></div>
					<div class="selectBox">
						<table cellpadding="0" cellspacing="0" class="commonTable2 w630">
							<tr>
								<th width="100" class="borderBdotGG norap">項目区切り記号 :</th>
								<td class="borderBdotGG">
<g:set var="checked_comma" value="" />
<g:set var="checked_tab" value="" />
<g:set var="checked_semicolon" value="" />
<g:if test="${params.custumDataDelimiter == 'tab'}"><g:set var="checked_tab" value='checked=\"checked\"' /></g:if>
<g:elseif test="${params.custumDataDelimiter == 'semicolon'}"><g:set var="checked_semicolon" value='checked=\"checked\"' /></g:elseif>
<g:else><g:set var="checked_comma" value='checked=\"checked\"' /></g:else>
									<input type="radio" name="custumDataDelimiter" id="custumDataDelimiter_comma" value="comma" ${checked_comma} /><label for="custumDataDelimiter_comma"> カンマ</label>
									<input type="radio" name="custumDataDelimiter" id="custumDataDelimiter_tab" value="tab" ${checked_tab} class="mL10" /><label for="custumDataDelimiter_tab"> タブ</label>
									<input type="radio" name="custumDataDelimiter" id="custumDataDelimiter_semicolon" value="semicolon" ${checked_semicolon} class="mL10" /><label for="custumDataDelimiter_semicolon"> セミコロン</label>
								</td>
							</tr>
							<tr>
								<th>&nbsp;</th>
								<td>
<g:set var="checked_nofirstline" value='checked=\"checked\"' />
<g:if test="${params.custumDataNoFirstLine == 'false'}"><g:set var="checked_nofirstline" value="" /></g:if>
									<input type="checkbox" id="custumDataNoFirstLine" name="custumDataNoFirstLine" value="true" ${checked_nofirstline} />　<label for="custumDataNoFirstLine">CSVデータの1行目を読み込まない（推奨）</label>
									<p class="txt1">通常、あて名管理ソフトウェアで作成されたCSVファイルでは、<br />
									1行目に項目名（「住所」、「姓」、「名」など）が設定されているため、<br />
									DMファクトリーでは1行目のデータを読み込みません。<br />
									1行目のデータを読込み対象とする場合は、上記チェックを外してください。</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="lineGW mT10"></div>
					<div class="btnArea">
						<a href="javascript:void(0)" id="prevBtn" class="floatleft"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoruB.gif" alt="戻る" /></a>
						<a href="javascript:void(0)" id="nextBtn" class="floatright"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_susumu-off.gif" alt="進む" /></a>
					</div>
				</div>
				<div class="boxBottom"></div>
			</div>
			</g:form>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form action="selectUploadType" name="selectUploadTypeForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	pleaseWait();
	document.selectCustomDataForm.submit();
	return false;
});
$("#prevBtn").click(function() {
	pleaseWait();
	document.selectUploadTypeForm.submit();
	return false;
});
});</r:script>
</body>
</html>