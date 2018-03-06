/**
 * Created on 2011/05/10
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */

package jp.co.jpmd.oiy.dmolbiz.controllers.relay

import grails.converters.JSON
import groovyx.net.http.*
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.exception.NLMExitControllerException
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.core.utils.RelayLoginUtils
import jp.co.reso.oiy.dmol.domain.user.UserGroup;
/**
 * ユーザアプリケーションとの連携ログイン
 */
class ToDmfApplicationController extends AbstractOrderItYourselfController {

	def localSettingsService;
	
	// 共通：会員情報編集
	def systemProfile = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('top', 'profileURL');
		render relayParams as JSON;
	}

	// 共通：メインメニュー
	def mainMenu = {

		HttpUtils.nocache(response);

		try {
			// 認証情報
			def self = this.currentUser(false);
			def relayParams = this.setRelayLoginInfo(params);
			def userGroup = self.userGroup;
			if (userGroup) {
				relayParams.url = localSettingsService.getToDmfRelayURL('office', 'backToS2URL');
			}
			//sessionクリア
			session.removeAttribute("controller");
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			render relayParams as JSON;
		} catch (NLMExitControllerException ex) {
		} catch (ex) {
			result.message = "";
			LogUtils.info(log, ex);
		}
	}
	
	// 一般ユーザ：ホームに戻る
	def toHome = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('user', 'homeURL');
		render relayParams as JSON;
	}

	// 一般ユーザ：C-2決済方法選択画面から戻り
	def backToUser = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('user', 'backToUserURL');
		def orderNo = this.getOrderNoFromSession();
		relayParams.params.orderNo = orderNo;
		removeOrderNoFromSession();
		render relayParams as JSON;
	}

	// 一般ユーザ：決済完了後にC-5注文受付完了画面へ遷移
	def returnToUser = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('user', 'returnToUserURL');
		def orderNo = this.getOrderNoFromSession();
		relayParams.params.orderNo = orderNo;
		removeOrderNoFromSession();
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-2事務局メニュー画面へ戻る
	def backToS2 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 'backToS2URL');
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-3受注管理画面からS-13会員情報の編集画面の呼び出し
	def s3s13 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's3s13URL');
		relayParams.params.userId = params.id;
		render relayParams as JSON;
	}
	//第三期 2012/04/16 by A&I Start
	// 事務局ユーザ：注文履歴画面からS-12会員管理画面へ戻る
	def s12list = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's12listURL');
		session.removeAttribute("controller");
		session.removeAttribute("para");
		session.removeAttribute("myPage");
		session.removeAttribute("userName");
		render relayParams as JSON;
	}
	//第三期 2012/04/16 by A&I End
	
	// 事務局ユーザ：S-4注文詳細画面からS-13会員情報の編集画面の呼び出し
	def s4s13 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's4s13URL');
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-11広告審査画面から審査帳票のダウンロード
	def s11review = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's11reviewURL');
		relayParams.params.orderDetailNo = params.orderDetailNo.split(",");
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-17注文明細画面からページ毎のサムネイルの取得
	def s17thumbnail = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's17thumbnailURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		relayParams.params.pageNo = params.pageNo;
		Integer sleepTime = (Integer.parseInt(params.pageNo) - 1)*200;
		Thread.sleep(sleepTime);
		getFileFromDmf(relayParams);
	}

	// 事務局ユーザ：S-17注文明細画面から閲覧用PDFのダウンロード
	def s17previewpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's17previewpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-17注文明細画面から入稿データ(印刷用PDF)のダウンロード
	def s17printpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's17printpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 事務局ユーザ：S-17注文明細画面から宛名印字用CSVデータのダウンロード
	def s17addresslist = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's17addresslistURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 事務局ユーザー：S-17注文明細画面から差出票のダウンロード
	def s17deliveryorder = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('office', 's17deliveryorderURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 印刷会社ユーザ：P-2印刷会社メニュー画面へ戻る
	def backToP2 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'backToP2URL');
		render relayParams as JSON;
	}

	// 印刷会社ユーザ：P-3受注管理画面からP-13会員情報の表示画面の呼び出し
	def p3p13 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p3p13URL');
		relayParams.params.userId = params.id;
		render relayParams as JSON;
	}

	// 印刷会社ユーザ：P-11注文明細画面からページ毎のサムネイルの取得
	def p11thumbnail = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p11thumbnailURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		relayParams.params.pageNo = params.pageNo;
		//Integer sleepTime = (Integer.parseInt(params.pageNo) - 1)*200;
		//Thread.sleep(sleepTime);
		getFileFromDmf(relayParams);
	}

	// 印刷会社ユーザ：P-11注文明細画面から閲覧用PDFのダウンロード
	def p11previewpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p11previewpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 印刷会社ユーザ：P-11注文明細画面から入稿データ(印刷用PDF)のダウンロード
	def p11printpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p11printpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// 印刷会社ユーザ：P-11注文明細画面から宛名印字用CSVデータのダウンロード
	def p11addresslist = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p11addresslistURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}
	// 印刷会社ユーザー：P-11注文明細画面から差出票のダウンロード
	def p11deliveryorder = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('print', 'p11deliveryorderURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	// JPユーザ：J-2JPメニュー画面へ戻る
	def backToJ2 = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'backToJ2URL');
		render relayParams as JSON;
	}

	/** JPユーザ:注文明細画面からページ毎のサムネイルの取得 */
	def jpthumbnail = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jpthumbnailURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		relayParams.params.pageNo = params.pageNo;
		getFileFromDmf(relayParams);
	}
	
	/** JPユーザ:注文明細画面から閲覧用PDFのダウンロード */
	def jppreviewpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jppreviewpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	/** JPユーザ:注文明細画面から入稿データ(印刷用)PDFのダウンロード */
	def jpprintpdf = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jpprintpdfURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}
	
	/** JPユーザ:注文明細画面から宛名印字用CSVデータのダウンロード */
	def jpaddresslist = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jpaddresslistURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	/** JPユーザー：注文明細画面から差出票のダウンロード */
	def jpdeliveryorder = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jpdeliveryorderURL');
		relayParams.params.orderDetailNo = params.orderDetailNo;
		render relayParams as JSON;
	}

	/** JPユーザ：受注管理画面から会員情報の表示画面の呼び出し **/
	def jpedituser = {
		HttpUtils.nocache(response);
		def relayParams = this.setRelayLoginInfo(params);
		relayParams.url = localSettingsService.getToDmfRelayURL('jpost', 'jpedituserURL');
		relayParams.params.userId = params.id;
		render relayParams as JSON;
	}
	/**
	 * 連携ログイン用パラメータを追加します。
	 * @param params パラメータ
	 */
	private setRelayLoginInfo(params) {
		def result = [result:'error', message:'', url:'', params:[:]];
		def self = null;
		try {
			// 認証情報
			self = this.currentUser(false);

			// 認証情報の生成
			def dtime = new Date(); // 現在日時
			dtime = RelayLoginUtils.toDateString(dtime); // 文字列に変換
			def commonKey = localSettingsService.getSettlementCommonKey();
			def clientId = RelayLoginUtils.sign(dtime, commonKey); // クライアントID

			// 結果の出力
			result.params.relayUserId = self.userId;
			result.params.dtime = dtime;
			result.params.clientId = clientId;
			result.result = 'success';
			
		} catch (NLMExitControllerException ex) {
//			LogUtils.info(log, ex);
		} catch (ex) {
			result.message = "";
			LogUtils.info(log, ex);
		}
		return result;
	}

	private getFileFromDmf(relayParams) {
	
		def http = new HTTPBuilder(relayParams.url);
		def rs = response;
		def os = response.outputStream;
		http.request( Method.POST ) {
			requestContentType = ContentType.URLENC
			body = relayParams.params;
			
			// 成功の場合：
			response.success = { resp, InputStream reader->
				if (resp.status == 301 || resp.status == 302) {
					redirect (url:resp.headers.Location);
				} else {
//					resp.headers.each {
//						println "${it.name} : ${it.value}"
//					}
					rs.setHeader("Content-Type", resp.headers."Content-Type");
					rs.setHeader("Content-Disposition", resp.headers."Content-Disposition");
					rs.setHeader("Content-Length", resp.headers."Content-Length");
					os << reader;
				}
			}
			// handler for any failure status code:
			response.failure = { resp ->
				println "Unexpected error: ${resp.statusLine.statusCode} : ${resp.statusLine.reasonPhrase}"
			}
			http.handler.failure = { resp ->
				println "Unexpected failure: ${resp.statusLine}"
			}
		}
	}
	/**
	 * 注文Noパラメータを取得する。
	 * @param params リクエストパラメータ
	 */
	private getOrderNoFromSession() {
		if (!session) {
			return null;
		}
		
		return session["SettlementParams.OrderNo"];
	}
	
	private removeOrderNoFromSession() {
		if (!session) {
			return null;
		}
		session.removeAttribute('SettlementParams.OrderNo');
	}
}
