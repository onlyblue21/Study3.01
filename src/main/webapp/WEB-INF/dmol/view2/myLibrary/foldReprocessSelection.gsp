<html>
<head>
	<meta name="layout" content="main" />
	<title>オプションサービスを選ぶ</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>オプションサービスを選ぶ<span>オプションサービスをお選びください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div class="colorSen">
				<div class="bgStop"></div>
				<div class="bgSinB">

					<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_option.gif" alt="オプションサービスを選ぶ" /></h3>
					<div class="opRightTxt">※あとで変更することができます。</div>
					<div class="clear"></div>

					<div class="optionBox">
						<div class="boxTop"></div>
						<div class="boxMid">
							<div class="boxLeft">
								<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/option_tit1.gif" alt="折り加工" />
							</div>
							<div class="boxRight pT5">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td class="pR15">
											<label for="optionFoldReprocessNone"><input type="radio" name="optionFoldReprocessUsage" id="optionFoldReprocessNone" ${!params.optionFoldReprocess ? 'checked="checked" ' : ''}/><span class="valignM size16">利用しない</span></label>
										</td>
										<td>
											<label for="optionFoldReprocessUse"><input type="radio" name="optionFoldReprocessUsage" id="optionFoldReprocessUse" ${params.optionFoldReprocess ? 'checked="checked" ' : ''}/><span class="valignM size16">利用する</span></label>
										</td>
									</tr>
								</table>
								<table cellpadding="0" cellspacing="3" class="optionTable" width="100%">
									<tr>
										<th class="align_left"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/txt_orikakou.gif" alt="折り加工を選ぶ" /></th>
									</tr>
									<tr class="opSelect">
<g:if test="${optionFoldReprocessesMap['2068']}">
										<td>
											<label for="optionFoldReprocess1" class="ori1"><input type="radio" name="optionFoldReprocess" id="optionFoldReprocess1" value="2068" ${(params.optionFoldReprocess == '2068') ? 'checked="checked" ' : ''}/><span>二つ折</span></label>
										</td>
</g:if>
<g:if test="${optionFoldReprocessesMap['2069']}">
										<td>
											<label for="optionFoldReprocess2" class="ori2"><input type="radio" name="optionFoldReprocess" id="optionFoldReprocess2" value="2069" ${(params.optionFoldReprocess == '2069') ? 'checked="checked" ' : ''}/><span>巻三つ折</span></label>
										</td>
</g:if>
<g:if test="${optionFoldReprocessesMap['2070']}">
										<td>
											<label for="optionFoldReprocess3" class="ori3"><input type="radio" name="optionFoldReprocess" id="optionFoldReprocess3" value="2070" ${(params.optionFoldReprocess == '2070') ? 'checked="checked" ' : ''}/><span>外三つ折</span></label>
										</td>
</g:if>
<g:if test="${optionFoldReprocessesMap['2071']}">
										<td>
											<label for="optionFoldReprocess4" class="ori4"><input type="radio" name="optionFoldReprocess" id="optionFoldReprocess4" value="2071" ${(params.optionFoldReprocess == '2071') ? 'checked="checked" ' : ''}/><span>DM折</span></label>
										</td>
</g:if>
									</tr>
								</table>
							</div>
						</div>
						<div class="boxBot"></div>
					</div>

					<div class="w740">
						<h4 class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/option_h4_ori.gif" alt="折り加工サービスについて" /></h4>
						<div class="pL30 mB30">
							<p class="mB10">封入チラシをご注文いただいた際に、折り加工をするサービスです。</p>
							<p class="mB10"><a href="https://dmfactory.biz.post.japanpost.jp/about/ori.html" class="listBlue" target="_blank">折り加工オプションサービス</a></p>
						</div>
					</div>

					<div class="bgSbtm"></div>
				</div>
				<!-- bgSinB END -->

			</div>  
			<!-- colorSen END -->  

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
<g:if test="${prevBtnEnabled}">
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
</g:if>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:if test="${prevBtnEnabled}">
<g:form method="get" action="${prevAction}" id="${params.id}" name="prevForm">
<input type="hidden" name="prevFlg" value="true" />
</g:form>
</g:if>
<g:form method="post" action="selectFoldReprocess" id="${params.id}" name="nextForm">
<input type="hidden" name="optionFoldReprocess" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var enableFoldReprocessSelection = function(enable) {
	$("input:radio[name='optionFoldReprocess']").setDisabled(!enable);
	return false;
};
var foldReprocessSelected = function() {
	return $("#optionFoldReprocessUse").isChecked();
};
$("input:radio[name='optionFoldReprocessUsage']").click(function() {
	enableFoldReprocessSelection(foldReprocessSelected());
	return true;
});
enableFoldReprocessSelection(foldReprocessSelected());
$("#nextBtn").click(function() {
	if (foldReprocessSelected()) {
		var optionFoldReprocess = $("input:radio[name='optionFoldReprocess']:checked").val();
		if ($.isNull(optionFoldReprocess)) {
			$().toastmessage('showWarningToast', "折り加工を選択してください。");
			return false;
		}
		document.nextForm.optionFoldReprocess.value = optionFoldReprocess;
	} else { // 折り加工を利用しない
		document.nextForm.optionFoldReprocess.value = '';
	}
	document.nextForm.submit();
	return false;
});
<g:if test="${prevBtnEnabled}">
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
</g:if>
});</r:script>
</body>
</html>
