<html>
<head>
	<meta name="layout" content="main" />
	<title>デザインをご確認ください。</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>デザインを確認する<span>入力内容や印刷位置などをご確認ください。</span></h2>

<g:render template="/common/fragment/flashmessages" />

			<div id="tmpleCont">
				<h3 class="h3Top">デザイン詳細</h3>
				<div class="tmpIn">

					<p class="seondTxt">確認事項をすべてチェックして、「決定」ボタンを押してください。<g:if test="${!addSampleMark}"><br />お手元に届くはがきは、現在販売中のものです。</g:if></p>
					<table class="tmpNaka" width="0" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<img src="${createLink(controller:'myLibrary',action:'getLargeThumbnail')}/${myLibrary?.id?.encodeAsHTML()}?pageNo=1" alt="1" />
							</td>
							<td>
<g:if test="${pageCount > 1}">
								<img src="${createLink(controller:'myLibrary',action:'getLargeThumbnail')}/${myLibrary?.id?.encodeAsHTML()}?pageNo=2" alt="2" />
</g:if><g:elseif test="${blankClass}">
								<div class="b24img ${blankClass}"></div>
</g:elseif>
							</td>
						</tr>
					</table>

				</div>
				<div class="tmpBtm"></div>

				<!--CHECK-->
				<div class="checkBox">
					<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'check_00.gif')}" />
<g:if test="${addSampleMark}">
					<p class="cRTl"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'apos.gif')}" class="valignM" />ご確認ください。</p>
					<div class="lineCheck"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/img_setsumei.gif" /></div>
</g:if>
<g:else>
					<p class="cRTl"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'apos.gif')}" class="valignM" />チェックを入れてから決定ボタンを押してください。</p>
</g:else>

					<div class="cList">
<g:if test="${addSampleMark}">
						<p class="cR">チェックを入れてから決定ボタンを押してください。</p>
</g:if>
						<input type="checkbox" name="check_1" id="check_1" class="designCheck">
						<label for="check_1"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'check_c1.gif')}" alt="誤字・脱字・文字の修正モレはありませんか？" class="valignM" /></label>
						<br />
						<input type="checkbox" name="check_2" id="check_2" class="designCheck">
						<label for="check_2"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'check_c2.gif')}" alt="配置した文字や画像が印刷エリアから外れていませんか？" class="valignM"/></label>
						<br />
						<input type="checkbox" name="check_3" id="check_3" class="designCheck">
						<label for="check_3"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'check_c3.gif')}" alt="その他、デザインの内容に間違いはありませんか？"  class="valignM"/></label>
					</div>
					<div><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'check_03.gif')}" /></div>
				</div>
				<!--CHECK END-->

			</div>

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
<g:if test="${loginUserInfo?.registeredUser}">
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images/common/3rd',file:'bt')}/btn_back-off.gif" alt="戻る" /></a></li>
</g:if>
				<li class="floatright">
					<img id="disabledBtn" src="${r.resource(dir:'/static/dmol/users/images/common/3rd/bt',file:'btn_dc-disable.gif.gif')}" alt="決定" />
					<a href="javascript:void(0)" id="nextBtn" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images/common/3rd',file:'bt')}/btn_dc-off.gif" alt="決定" /></a>
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:form method="get" action="paperTypeSelection" id="${myLibrary?.id}" name="nextForm" />
<g:if test="${loginUserInfo?.registeredUser}">
<g:form method="get" action="index" name="prevForm" />
</g:if>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
var disabledBtn = $("#disabledBtn");
var nextBtn = $("#nextBtn");
$("input:checkbox.designCheck").click(function() {
	if ($("input:checkbox.designCheck:checked").length == 3) {
		disabledBtn.hide();
		nextBtn.show();
	} else {
		nextBtn.hide();
		disabledBtn.show();
	}
	return true;
});
nextBtn.click(function() {
	document.nextForm.submit();
	return false;
});
<g:if test="${loginUserInfo?.registeredUser}">
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
</g:if>
});</r:script>
</body>
</html>
