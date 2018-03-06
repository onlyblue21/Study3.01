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
class UserController extends AbstractOrderItYourselfController {

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

	// ｢C-1B氏名住所編集確認選択画面｣から｢C-2決済方法選択画面｣の呼出
	def settlement = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		setOrderNo2Session(params?.orderNo);
		redirect(controller:'settlement', action:'index'); // FIXME
	}

	/**
	 * 注文Noパラメータの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setOrderNo2Session(orderNo) {
		if (!session || orderNo == null) {
			return;
		}
		
		session["SettlementParams.OrderNo"] = orderNo;
	}
	
}
