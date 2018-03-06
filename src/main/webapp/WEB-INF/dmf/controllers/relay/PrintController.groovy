/**
 * Created on 2011/05/10
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.jpmd.oiy.dmolbiz.controllers.relay
 
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.utils.LogUtils

/**
 * メインメニューからの連携ログイン
 */
class PrintController extends AbstractOrderItYourselfController {

	/**
	 * 連携ログイン引用パラメータを削除します。
	 * @param params パラメータ
	 */
	private removeRelayLoginInfo(params) {
		if (params) {
			['dtime', 'clientId', 'relayUserId'].each {
				params.remove(it);
			}
		}
	}

	// ｢P-2印刷会社メニュー画面｣から｢P-3受注管理画面｣の呼出
	def recievedOrder = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'recievedOrder', action:'index'); 
	}

}
