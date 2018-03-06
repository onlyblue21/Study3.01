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
class OfficeController extends AbstractOrderItYourselfController {

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

	// ｢S-2事務局メニュー画面｣から｢S-3受注管理画面｣の呼出
	def recievedOrder = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'recievedOrder', action:'index'); 
	}

	// ｢S-2事務局メニュー画面｣から｢S-7クレジット管理画面｣の呼出
	def credit = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'creditManagement', action:'index'); 
	}

	// ｢S-2事務局メニュー画面｣から｢S-8銀行振込管理画面｣の呼出
	def bankTransfer = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'bankManagement', action:'index'); 
	}

	// ｢S-2事務局メニュー画面｣から｢S-9代引き管理画面｣の呼出
	def cashOnDelivery = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'codManagement', action:'index'); 
	}

	// ｢S-2事務局メニュー画面｣から｢S-10請求書払管理画面｣の呼出
	def invoicePayment = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'poiManagement', action:'index');
	}

	// ｢S-2事務局メニュー画面｣から｢S-11広告審査画面｣の呼出
	def reviewAd = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'adReview', action:'index'); 
	}

	// ｢S-2事務局メニュー画面｣から｢S-14売上管理画面｣の呼出
	def salesRecord = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'salesManagement', action:'index'); 
	}
	//第三期 2012/03/16 by A&I Start
	//ユーザ一覧画面から注文履歴画面
	def userOrderInfo = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		setUserIdSession(params.orderInfoUserId);
		redirect(controller:'userOrderInfo', action:'index');
	}
	/** 「S-2事務局メニュー画面」から「OrderInfo出力画面」の呼出 */
	def dlOrderInfo = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'orderInfoNew', action:'index');
	}
	
	/** 「S-2事務局メニュー画面」から「OrderInfo出力画面」の呼出 */
	def orderInfoNew = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		redirect(controller:'orderInfoNew', action:'index');
	}
	
	//ユーザ一覧画面から売掛金残高一覧
	def accountReceivable = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		setUserIdSession(params.orderInfoUserId);
		redirect(controller:'accountReceivable', action:'index');
	}
	
	//ユーザ一覧画面から操作ログ出力
	def opLogSearch = {
		HttpUtils.nocache(response);
		this.removeRelayLoginInfo(params);
		setUserIdSession(params.orderInfoUserId);
		redirect(controller:'opLogSearch', action:'index');
	}
	private setUserIdSession(orderInfoUserId) {
		if (!session || orderInfoUserId == null) {
			return;
		}
		
		session["userOrderInfoParams.orderInfoUserId"] = orderInfoUserId;
		
	}
	//第三期 2012/03/16 by A&I End
}
