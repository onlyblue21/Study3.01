<div id="_oiy_alertDialog" title="情報" style="display:none;text-align:left;">
	<div id="_oiy_alertDialog_content" class="ui-state-highlight ui-corner-all" style="padding: 8px;"><span id="_oiy_alertDialog_icon" class="ui-icon ui-icon-info" style="float: left; margin-right: 4px;"></span><span id="_oiy_alertDialog_message"></span></div>
</div>
<div id="_oiy_confirmDialog" title="確認" style="display:none;text-align:left;">
	<div id="_oiy_confirmDialog_content" class="ui-state-highlight ui-corner-all" style="padding: 8px;"><span id="_oiy_confirmDialog_icon" class="ui-icon ui-icon-info" style="float: left; margin-right: 4px;"></span><span id="_oiy_confirmDialog_message"></span></div>
</div>
<g:javascript><!--
function oiyAlert(alertMsgm, okfunc, options, errorStyle) {
	if (alertMsgm) {
		alertMsgm = alertMsgm.replace(/\n/g, "<br />");
	}
	$("#_oiy_alertDialog_message").html(alertMsgm);
	OIY.Dialog.setupInfoOrErrorContentClass('_oiy_alertDialog_content', '_oiy_alertDialog_icon', errorStyle)
	return OIY.Dialog.alert("_oiy_alertDialog", options, okfunc, "OK");
}
function oiyConfirm(confirmMsg, okfunc, options, errorStyle) {
	if (confirmMsg) {
		confirmMsg = confirmMsg.replace(/\n/g, "<br />");
	}
	$("#_oiy_confirmDialog_message").html(confirmMsg);
	OIY.Dialog.setupInfoOrErrorContentClass('_oiy_confirmDialog_content', '_oiy_confirmDialog_icon', errorStyle)
	return OIY.Dialog.confirm("_oiy_confirmDialog", options, okfunc, null, "OK", "キャンセル");
}
function isOpenOiyConfirm() {
	var confirmDlg = $("#_oiy_confirmDialog");
	var isopen = confirmDlg.dialog('isOpen');
	return (confirmDlg != isopen) ? isopen : false;
}
function confirmTransition(nextURL) {
	oiyConfirm("編集した内容が失われる可能性があります。\nページを移動してもよろしいでしょうか？", function() {
		location.href = nextURL;
	});
	return false;
}
function confirmRemove(form, confirmMsg, width, height) {
	if (form) {
		if (!confirmMsg) {
			confirmMsg = "削除しますか？";
		}
		var options = {};
		if (width) {
			options.width = width;
		}
		if (height) {
			options.height = height;
		}
		oiyConfirm(confirmMsg, function() {
			form.submit();
			pleaseWait();
		}, options, true);
	}
	return false;
}
function displayDialog(dialogId, options) {
	if (options == null) {
		options = {};
	}
	if (!options.minWidth) {
		options.minWidth = 320;
	}
	if (!options.minHeight) {
		options.minHeight = 240;
	}
	if (!options.width) {
		options.width = 640;
	}
	if (!options.height) {
		options.height = 480;
	}
	return OIY.Dialog.alert(dialogId, options, null, "閉じる");
}
//-->
</g:javascript>
<jq:jquery>
<sec:ifLoggedIn>
$("a.logout").click(function() {
	var logoutURL = this.href;
<g:if test="${loginUserInfo?.justNowUser}">
	oiyConfirm("非会員の方が一度ログアウトするとそれまで作成したデザインデータは削除されます。\n保存するためには新規会員登録を行ってください。\nログアウトしてもよろしいですか？", function() {
		location.href = logoutURL;
	}, { width:640, height:200 });
</g:if>
<g:else>
	oiyConfirm("ログアウトしてもよろしいですか？", function() {
		location.href = logoutURL;
	});
</g:else>
	return false;
});
</sec:ifLoggedIn>
</jq:jquery>
