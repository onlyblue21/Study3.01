<g:javascript><!--
var relayLogin = function(url, params) {

	var form = document.relayLoginForm;
	var relayLoginparams = document.getElementById("relayLoginparams");
	pleaseWait();
	$.post(url, params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				var html = "";
				$.each(result.params, function(key, val) {
					html += '<input type="hidden" name="' + key + '" value="' + val + '" />';
				});
				form.action = result.url;
				relayLoginparams.innerHTML = html;
				form.submit();
			} else if (result.message) {
				closeWait();
				oiyAlert(result.message);
			} else {
				closeWait();
				oiyAlert(result.result);
			}
			return false;
		}
		closeWait();
		oiyAlert('画面を表示することができませんでした。');
		return false;
	});
};
//-->
</g:javascript>
<script type="text/javascript">
function toHome() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'toHome')}', params);
}
function backBtn(params) {
	var param = {};
	return relayLogin('${createLink(controller:'toDmfApplication', action:'backToUser')}', param);
}
</script>
<jq:jquery>
$("#logo").click(function() {	
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'toHome')}', params);
});
$("#editMyProfileBtn").click(function() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'systemProfile')}', params);
});
$("#mainMenuBtn").click(function() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'mainMenu')}', params);
});
</jq:jquery>
<form method="post" action="" name="relayLoginForm" onsubmit="return false;">
<div id="relayLoginparams">
</div>
</form>
