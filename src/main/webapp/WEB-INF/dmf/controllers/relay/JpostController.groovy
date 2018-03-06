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

/**
 * メインメニューからの連携ログイン
 */
class JpostController extends AbstractOrderItYourselfController {

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

	// ｢J-2JPメニュー画面｣から｢J-4実績集計画面｣の呼出
	def performanceSummary = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'performanceAggregate', action:'index'); // FIXME
	}

	// ｢JPメニュー画面｣から｢受注管理画面｣の呼出
	def recievedOrder = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'recievedOrder', action:'index');
	}
}
