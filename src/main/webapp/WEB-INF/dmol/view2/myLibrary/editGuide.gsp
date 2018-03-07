<html>
<head>
	<title>DM Factory.jp</title>
	<meta name="layout" content="main" />
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">

<g:render template="/common/fragment/editAttention" />

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
				<li class="floatright"><a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_hensyu-off.gif" alt="編集画面へ進む" /></a></li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<form method="post" action="${flexLayoutURL}" name="layoutEditForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="returnUserId" value="" />
<input type="hidden" name="returnURL" value="" />
<input type="hidden" name="errorURL" value="" />
<input type="hidden" name="editorType" value="dmf" />
<input type="hidden" name="forceLayout" value="true" />
<input type="hidden" name="purposeName" value="minimum" />
<input type="hidden" name="pagePurposeNames" value="" />
<input type="hidden" name="resultType" value="html" />
<input type="hidden" name="resultName" value="dmf" />
<input type="hidden" name="srcType" value="remotefile" />
<input type="hidden" name="remotefile" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
<input type="hidden" name="layoutId" value="" />
<input type="hidden" name="pageNo" value="1" />
<input type="hidden" name="pageSaveURL" value="" />
<input type="hidden" name="pageSaveMode" value="lla" />
<input type="hidden" name="_custom_addSampleMark" value="" />
<input type="hidden" name="_custom_largeThumbOption1" value="" />
<input type="hidden" name="_custom_largeThumbOption2" value="" />
<input type="hidden" name="_custom_blankClass" value="" />
<input type="hidden" name="_custom_registeredUser" value="${loginUserInfo?.registeredUser?.toString()}" />
</form>
<g:form method="get" action="index" name="prevForm" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
// 編集開始
var startEditingFunc = function(myLibraryId) {
	var params = { id:myLibraryId };
	$.post("${createLink(action:'flexRelayInfo')}", params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				pleaseWait();
				document.layoutEditForm.relayUserId.value = result.relayUserId;
				document.layoutEditForm.returnUserId.value = result.returnUserId;
				document.layoutEditForm.returnURL.value = result.returnURL;
				document.layoutEditForm.errorURL.value = result.errorURL;
				document.layoutEditForm.dtime.value = result.dtime;
				document.layoutEditForm.clientId.value = result.clientId;
				document.layoutEditForm.remotefile.value = result.remotefile;
				document.layoutEditForm.layoutId.value = result.layoutId;
				document.layoutEditForm.pagePurposeNames.value = result.pagePurposeNames;
				document.layoutEditForm.pageSaveURL.value = result.pageSaveURL;
				document.layoutEditForm._custom_addSampleMark.value = result.addSampleMark;
				document.layoutEditForm._custom_largeThumbOption1.value = result.largeThumbOption1;
				document.layoutEditForm._custom_largeThumbOption2.value = result.largeThumbOption2;
				document.layoutEditForm._custom_blankClass.value = result.blankClass;
				document.layoutEditForm.submit();
				return false;
			} else if (result.message) {
				oiyAlert(result.message);
				closeWait();
				return false;
			}
		}
		closeWait();
		oiyAlert('編集を開始することができませんでした。');
		return false;
	});
	return false;
};
// 編集状態の確認
var isEditing = function(myLibraryId) {
	var params = { id:myLibraryId };
	$.post("${createLink(action:'isEditing')}", params, function(data, textStatus){
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				return startEditingFunc(myLibraryId);
			} else if (result.result == 'editing') {
				return startEditingFunc(myLibraryId);
//				var message = result.message + '\n別の画面で編集されているか、あるいは、前回の編集時に編集が完了されていません。\nロックを解除すれば編集可能ですが別の画面で編集中の場合には、\n編集結果を上書きしたり、されたりする可能性があります。\nロックを解除しますか？';
//				options = { width:540, heiht:300 };
//				oiyConfirm(message, function() {
//					return startEditingFunc(myLibraryId);
//				}, options, false, 'ロックを解除して編集開始', '編集中止');
			} else {
				oiyAlert(result.message);
			}
			closeWait();
			return false;
		}
		closeWait();
		oiyAlert('編集を開始することができませんでした。');
		return false;
	});
	return false;
};
$("#nextBtn").click(function() {
	pleaseWait();
	return isEditing("${params.id?.encodeAsHTML()}");
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
