<sec:ifLoggedIn>
<jq:jquery>
var keepalive = function(callback) {
	$(document).oneTime(20 * 60 * 1000, "keepalive", callback); // 20 minutes
};
var callbackKeepAlive = function() {
	${remoteFunction(controller:'login', action:'keepalive', onSuccess:'return onSuccessKeepAlive(data,textStatus);')}
	return false;
};
var showMaintenanceMessage = function(alertMsg) {
	var msg = alertMsg + "\nログアウトしてください。";
	if (typeof(isOpenOiyConfirm) == 'function') {
		if (!isOpenOiyConfirm()) {
			oiyAlert(msg, null, {width:480});
		}
	} else {
		alert(msg);
	}
	return false;
}
var onSuccessKeepAlive = function(data,textStatus) {
	if (data != 'OK') {
		showMaintenanceMessage(data);
	}
	keepalive(callbackKeepAlive);
	return false;
};
keepalive(callbackKeepAlive);
<g:if test="${loginState?.alertInfo?.shutdown}">
showMaintenanceMessage("${loginState.alertInfo.msg?.encodeAsHTML()}");
</g:if>
</jq:jquery>
</sec:ifLoggedIn>