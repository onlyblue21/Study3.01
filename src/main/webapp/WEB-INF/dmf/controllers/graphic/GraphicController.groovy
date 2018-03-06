/**
 * Created on 2011/05/27
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.jpmd.oiy.dmolbiz.controllers.graphic

import grails.converters.JSON;

import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils
import net.sf.json.groovy.JsonSlurper;
import net.sf.json.JSONNull

import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.exception.NLMExitControllerException;
import jp.co.reso.oiy.core.exception.NLMNotFoundException;
import jp.co.reso.commons.MessageDigestUtils
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils
import jp.co.reso.oiy.core.utils.LogUtils

/**
 * グラフィック社印刷状況通知コントローラ
 */
class GraphicController extends AbstractOrderItYourselfController {

	private static final String JOB_LOG_TYPE = "graphic";
	private static final String JOB_LOG_NAME = "printStateNotice_%s.log";
	private static String JOB_LOG_FILE = "";
	
	private static final String RETURN_STATUS_OK = "00";
	private static final String RETURN_STATUS_AUTH_NG = "01";
	private static final String RETURN_STATUS_COUNT_NG = "02";
	private static final String RETURN_STATUS_FORMAT_NG = "03";
	private static final String RETURN_STATUS_NG = "99";

	static Map allowedMethods = [printStateNotice:'POST'];

	/** POST送信元区分 : グラフィック社 */
	static final String DM_POST_KBN_GRAPHIC = "01";

	/** ログ出力サービス */
	def logService;

	/** DMオンライン専用の設定 */
	def localSettingsService;

	/** 印刷状況通知処理サービス */
	def printStateNoticeService;

	// index
	def index = {
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

	// 印刷状況通知
	def printStateNotice = {

		JOB_LOG_FILE = logService.touchLogFile(JOB_LOG_TYPE, String.format(JOB_LOG_NAME, new Date().format("yyyyMMdd")));
		
		this.writeLog("▼----- 開　　始 -----▼");
		
		def respJson=[:];
		respJson.TransactionDate = new Date().format("yyyyMMdd");
		respJson.TransactionTime = new Date().format("HHmmss");
		respJson.TransactionResultCd = RETURN_STATUS_NG;
	
		try {

			HttpUtils.nocache(response);
	
			if (!RuntimeEnvironmentUtils.isAdminEnvironment()) {
				LogUtils.error(log, message(code:"CB02E001", args:["Environment"]));
				this.writeLog("■ Error： Is not Admin Environment.");
				throw new NLMExitControllerException();
			}
			// プロダクション環境ではポート番号での制限も行う
			if (RuntimeEnvironmentUtils.isAdminProductionEnvironment()) {
				switch (request.serverPort) {
					case 53135:
						break;
					default:
						LogUtils.error(log, message(code:"CB02E001", args:["server port"]));
						LogUtils.warn(log, "■ Error： server port is invalid. [${request.serverPort}].");
						this.writeLog("■ Error： server port is invalid. [${request.serverPort}].");
						throw new NLMExitControllerException();
				}
			}
	
			def paramJandG = params.JandG;
			def json;

			// パラメータチェック
			this.validateParamValue("JandG", paramJandG);

			// JSONの解釈
			def postKbn = null;
			def merchantId = null;
			def merchantPass = null;
			def transactionDate = null;
			def transactionTime = null;
			try {
				def slurper = new JsonSlurper();
				json = slurper.parseText(paramJandG);

				// 受信通信ログを記録
				writeReceivedLog(json);

				postKbn = this.getString(json, "PostKbn");
				merchantId = this.getString(json, "MerchantId");
				merchantPass = this.getString(json, "MerchantPass");
				transactionDate = this.getString(json, "TransactionDate");
				transactionTime = this.getString(json, "TransactionTime");

			} catch (ex) {
				LogUtils.error(log, String.format("%s\n%s", message(code:"CB02E002", args:["JSON"], ex.message)));
				this.writeLog("■ Error： [JSON] parameter is invalid.");
				throw new NLMExitControllerException(ex);
			}

			// POST送信元区分の確認：DMオンラインは「01」。それ以外はエラー
			if (postKbn != DM_POST_KBN_GRAPHIC) {
				this.writeLog("■ Error： [postKbn] parameter is invalid. ${postKbn}");
				LogUtils.error(log, String.format("%s\n%s", message(code:"CB02E003", args:["postKbn"], ex.message)));
				throw new NLMExitControllerException();
			}

			// パラメータチェック
			this.validateParamValue("MerchantId", merchantId);
			this.validateParamValue("MerchantPass", merchantPass);
			this.validateParamValue("TransactionDate", transactionDate);
			this.validateParamValue("TransactionTime", transactionTime);
			try {
				// 接続パスワードのチェック
				this.validateMerchantPass(merchantId, merchantPass, transactionDate, transactionTime);
			} catch (NLMExitControllerException ex) {
				LogUtils.error(log, String.format("%s\n%s", message(code:"CB02E004", args:["MerchantPass"], ex.message)));
				respJson.TransactionResultCd = RETURN_STATUS_AUTH_NG;
				throw ex;
			}

			// DBの印刷ステータスを更新
			assert printStateNoticeService;
			respJson = printStateNoticeService.receivePrintState(json, JOB_LOG_FILE);

		} catch (NLMExitControllerException ex) {
			// LogUtils.info(log, ex);
			// ignore.
		} catch (NLMNotFoundException ex) {
			LogUtils.warn(log, ex);
			LogUtils.error(log, String.format("%s\n%s", message(code:"CB02E004", args:["MerchantPass"], ex.message)));
			this.writeLog("■ Error： " + ex.getMessage());
		} catch (ex) {
			LogUtils.error(log, ex);
			this.writeLog("■ Error： " + ex.getMessage());
		} finally {

			def respJSON = respJson as JSON;

			// 返信通信ログを記録
			writeSentLog(respJSON);
			this.writeLog("▲----- 正常終了 -----▲\n");
			render 'JandG=' + respJSON.toString();
		}
	}

	/**
	 * パラメータが指定されていることを確認します。
	 * @param paramName パラメータ名
	 * @param paramValue パラメータの値
	 * @throws パラメータが未指定
	 */
	private validateParamValue(paramName, paramValue) {
		if (StringUtils.isEmpty(paramValue)) {
			LogUtils.error(log, message(code:"CB02E002", args:["${paramName}"]));
			this.writeLog("■ Error： [${paramName}] paramerter is empty.");
			throw new NLMExitControllerException();
		}
	}

	/**
	 * JSONObjectから文字列を取得します。
	 * @param json JSONObject
	 * @param key 属性名
	 * @return 値
	 */
	private String getString(json, key) {
		if (!json || !key || !json.has(key)) {
			return null;
		}
		def value = json.get(key);
		if (!value) {
			return null;
		}
		if (JSONNull.getInstance().equals(value)) {
			return null;
		}
		return value.toString();
	}

	/**
	 * 接続パスワードの確認を行います。
	 * @param merchantId 接続ID
	 * @param merchantPass 接続パスワード
	 * @param transactionDate 処理日
	 * @param transactionTime 処理時刻
	 * @throws 接続パスワードが正しくない
	 */
	private validateMerchantPass(merchantId, merchantPass, transactionDate, transactionTime) {
		assert localSettingsService;

		def cryptographyKeyMap = localSettingsService.getGraphicSettings();
		def srcword = "${cryptographyKeyMap.cryptographyKey1}${transactionDate}${transactionTime}${cryptographyKeyMap.cryptographyKey2}${merchantId}${cryptographyKeyMap.cryptographyKey3}";
		def hashed = MessageDigestUtils.md5(srcword);
		if (merchantPass != hashed) {
			LogUtils.error(log, message(code:"CB02E002", args:["merchantPass"]));
			this.writeLog("■ Error： [merchantPass] paramerter is invalid.");
			throw new NLMExitControllerException();
		}
	}

	private def writeReceivedLog(data) {
		this.writeLog("Received: " + data.toString());
	}

	private def writeSentLog(data) {
		this.writeLog("Sent: " + data.toString());
	}
	private def writeLog(msg) {
		logService.writeLog(JOB_LOG_FILE, msg.toString());
	}
}