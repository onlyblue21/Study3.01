<g:if test="${false}">
/**
 * jQueryでのAJAX呼び出しのデフォルト設定を行います。
 * エラーハンドラなども登録します（「サーバー通信時にエラーが発生しました。」と表示します）。
 * この動作を抑制したい場合にはAJAX呼び出し時にglobal:falseを指定してください(ただしすべてのグローバルハンドラが呼び出されなくなります)。
 */
</g:if>
;(function($){
$.ajaxSetup({
	type: 'POST',
	cache: false,
	timeout: 120 * 1000,
	error: function(jqXHR, textStatus, errorThrown) {
		if ($.isFunction(closeWait)) {
			closeWait();
		}
		oiyAlert('サーバー通信時にエラーが発生しました。');
		return false;
	}
});
})(jQuery);
