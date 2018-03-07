<g:if test="${false}">
/**
 * jQueryでのAJAX呼び出しのデフォルト設定を行います。
 * エラーハンドラなども登録します（「サーバー通信時にエラーが発生しました。」と表示します）。
 * この動作を抑制したい場合にはAJAX呼び出し時にglobal:falseを指定してください(ただしすべてのグローバルハンドラが呼び出されなくなります)。
 *
 * 次の指定はjquery.validate.jsでremoteメソッドによるバリデーションを実行するために必要です。
 * jsonpを利用する場合には何らかの対処が必要になるでしょう(jquery.validate.jsでremoteメソッドとは両立しないでしょう)。
 *	jsonp: null,
 *	jsonpCallback: null,
 */
</g:if>
;(function($){
$.ajaxSetup({
	type: 'POST',
	cache: false,
	timeout: 120 * 1000,
	jsonp: null,
	jsonpCallback: null,
	error: function(jqXHR, textStatus, errorThrown) {
		if ($.isFunction(closeWait)) {
			closeWait();
		}
		oiyAlert('サーバー通信時にエラーが発生しました。');
		return false;
	}
});
})(jQuery);
