/**
 * 作成日:			2011/04/11
 * 機能記述:		管理側の広告審査画面表示用コントローラ
 * 変更履歴:		代引き対応
 * Copyright (C) A&I System Inc.
 * 
 * 
 */


package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse
import jp.co.reso.oiy.dmol.domain.orderinfo.ExaminationStatus

//import jp.co.reso.logic.laml.GLAMLTool
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.system.TagData
import jp.co.reso.oiy.core.exception.NLMExitControllerException
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.utils.ContentTypeUtils
import jp.co.reso.oiy.core.utils.ConvertUtils
import jp.co.reso.oiy.core.utils.DateUtils
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.core.utils.UploadedFileUtils;

import org.codehaus.groovy.grails.commons.GrailsApplication

import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail
import jp.co.reso.oiy.dmol.domain.user.UserGroup;
import jp.co.jpmd.oiy.dmolbiz.service.office.*

class AdReviewController  extends AbstractOrderItYourselfController{
	
	/** grailsApplication */
	GrailsApplication grailsApplication;

	def localSettingsService;
	def adReviewService;
	
	/**
	 * beforeInterceptorから呼び出すメソッドです。
	 * @param locale ロケール
	 */
	def before(locale) {
		super.before(locale);
		this.setDomainClazzName('OrderInfo', OrderInfo.getClazzName(locale));
		this.setDomainFieldNameMap('OrderInfo', OrderInfo.getFieldNameMap(locale));
	}
	
	private checkTF(para){
		if(para == "false"){
			para = "";
		}
		return para;
	}
	// 一覧表示にリダイレクト
	def index = {
		
		if(session.getAttribute("para") && session.getAttribute("myPage") == "adReview"){
			def para = session.getAttribute("para");
			def hh=1;
			// 注文No
			params.orderNo = para.orderNo;
			// 注文日From
			params.orderDateFrom = para.orderDateFrom;
			// 注文日To
			params.orderDateTo = para.orderDateTo;
			// ご注文者・姓
			params.familyName = para.familyName;
			// ご注文者・名
			params.firstName = para.firstName;
			// E-Mail
			params.email = para.email;
			// 電話番号
			params.telno = para.telno;
			// 送付先住所
			params.destinationAddress = para.destinationAddress;
			// 決済方法：クレジットカード
			params.settlementMethodCredit = checkTF(para.settlementMethodCredit);
			// 決済ステータス：クレジットカード
			params.settlementStatusCredit = para.settlementStatusCredit;
			// 決済方法：銀行振込
			params.settlementMethodBank = checkTF(para.settlementMethodBank);
			// 決済ステータス：銀行振込
			params.settlementStatusBank = para.settlementStatusBank;
			// 決済方法：代引き
			params.settlementMethodCod = checkTF(para.settlementMethodCod);
			// 決済ステータス：代引き
			params.settlementStatusCod = para.settlementStatusCod;
			// 決済方法：請求書払い
			params.settlementMethodPoi = checkTF(para.settlementMethodPoi);
			// 決済ステータス：請求書払い
			params.settlementStatusPoi = para.settlementStatusPoi;
			// サービス区分：DMオンライン
			params.serviceDivisionDMOnline = checkTF(para.serviceDivisionDMOnline);
			// サービス区分：オリジナル年賀
			params.serviceDivisionNewYearCard = checkTF(para.serviceDivisionNewYearCard);
			// サービス区分：オリジナルかもめ～る
			params.serviceDivisionKamoMail = checkTF(para.serviceDivisionKamoMail);
			// 付帯サービス
			params.serviceDivisionFuTai = checkTF(para.serviceDivisionFuTai);
			// 注文ステータス
			params.orderStatus = para.orderStatus;
			// キャンセルを除く
			params.isExcludeCancel = para.isExcludeCancel;
			// 審査ステータス
			params.examinationStatus = para.examinationStatus;
			// 印刷ステータス
			params.printStatus = para.printStatus;
			// ソート順
			params.sortKey = para.sortKey;
			params.sortOrder = para.sortOrder;
			// 自動検索
			params.autoSearch = "true";		
		}
		else{
			session.removeAttribute("controller");
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			params.orderDateFrom = new Date().format(ConvertUtils.DEFAULT_DATE_FORMAT);
			params.orderDateTo = params.orderDateFrom;
			// ソート順
			params.sortKey = "orderDate";
			params.sortOrder = "desc";
		}
		def result = [
			'settlementStatusCreditList':localSettingsService.settlementStatusCreditList(),
			'settlementStatusBankList':localSettingsService.settlementStatusBankList(),
			'settlementStatusCodList':localSettingsService.settlementStatusCodList(),
			'settlementStatusPoiList':localSettingsService.settlementStatusPoiList(),
			'orderStatusList':localSettingsService.orderStatusList(),
			'examinationStatusList':localSettingsService.examinationStatusList(),
			'printStatusList':localSettingsService.printStatusList()];
	}
	def setSession = {
		def addList = [:];
		addList.addController = [];
		addList.addAction = [];
		addList.addAction2 = [];
		addList.addController << "adReview";
		addList.addAction << "index";
		addList.addAction2 << "";
		session.setAttribute("controller", addList);
		def result = [:];
		result.result = "ok";
		render result as JSON;
	}
	def uploadFile = {

		HttpUtils.nocache(response);
	}
	// 一覧表示
	def list = {
	}
	private turnNull(para){
		if(!para){
			para = '';
		}
		return para;
	}
	private turnZero(para){
		if(!para){
			para = 0;
		}
		return para;
	}
	
	//注文情報検索
	def search = {

		assert adReviewService;

		HttpUtils.nocache(response);

		def result = [offset:params.offset, list:null, totalCount:0,params:params];
		try {
			def sparams = [offset:params.offset, max:params.pageMax, sortKey:params.sortKey, sortOrder:params.sortOrder];
			// 注文No
			sparams.orderNo = params.orderNo.replace("'","''").replace("%","[%]");
			// 注文日From
			sparams.orderDateFrom = params.orderDateFrom.replace("'","''").replace("%","[%]");
			// 注文日To
			sparams.orderDateTo = params.orderDateTo.replace("'","''").replace("%","[%]");
			// ご注文者・姓
			sparams.familyName = params.familyName.replace("'","''").replace("%","[%]");
			// ご注文者・名
			sparams.firstName = params.firstName.replace("'","''").replace("%","[%]");
			// E-Mail
			sparams.email = params.email.replace("'","''").replace("%","[%]");
			// 電話番号
			sparams.telno = params.telno.replace("'","''").replace("%","[%]");
			// 送付先住所
			sparams.destinationAddress = params.destinationAddress.replace("'","''").replace("%","[%]");
			// 決済方法：クレジットカード
			sparams.settlementMethodCredit = params.settlementMethodCredit
			// 決済ステータス：クレジットカード
			sparams.settlementStatusCredit = params.list('settlementStatusCredit[]')
			// 決済方法：銀行振込
			sparams.settlementMethodBank = params.settlementMethodBank
			// 決済ステータス：銀行振込
			sparams.settlementStatusBank = params.list('settlementStatusBank[]')
			// 決済方法：代引き
			sparams.settlementMethodCod = params.settlementMethodCod
			// 決済ステータス：代引き
			sparams.settlementStatusCod = params.list('settlementStatusCod[]')
			// 決済方法：請求書払い
			sparams.settlementMethodPoi = params.settlementMethodPoi
			// 決済ステータス：請求書払い
			sparams.settlementStatusPoi = params.list('settlementStatusPoi[]')
			// サービス区分：DMオンライン
			sparams.serviceDivisionDMOnline = params.serviceDivisionDMOnline.replace("'","''").replace("%","[%]");
			// サービス区分：オリジナル年賀
			sparams.serviceDivisionNewYearCard = params.serviceDivisionNewYearCard.replace("'","''").replace("%","[%]");
			// サービス区分：オリジナルかもめ～る
			sparams.serviceDivisionKamoMail = params.serviceDivisionKamoMail.replace("'","''").replace("%","[%]");
			// 付帯サービス
			sparams.serviceDivisionFuTai = params.serviceDivisionFuTai.replace("'","''").replace("%","[%]");
			// 注文ステータス
			sparams.orderStatus = params.list('orderStatus[]')
			// キャンセルを除く
			//sparams.isExcludeCancel = params.isExcludeCancel;
			// 審査ステータス
			sparams.examinationStatus = params.list('examinationStatus[]')
			// 印刷ステータス
			sparams.printStatus = params.list('printStatus[]')
			sparams.search = true;
			this.setupSearchParams(sparams);
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.setAttribute("para",sparams);
			session.setAttribute("myPage","adReview");

			def holder = adReviewService.search(sparams);
			if (holder) {
				def self = this.currentUser();
				// 個人情報表示判定
				def showPersonalData = self?.role?.authorities?.contains('AUTHORITY_PERSONAL_DATA');
				
				result.totalCount = holder.totalCount;
				result.list = [];
				holder.list?.each {
					def info = [:];
					// id
					info.id = it.id;
					// 注文No
					info.orderNo = turnNull(it.orderNo);
					// 注文受付日時
					info.orderDate = turnNull(it.orderDate);
					if(info.orderDate){
						SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
						info.orderDate = dft.format(it.orderDate);
					}
					if (showPersonalData) {
						info.name = turnNull(it.familyName) + " " + turnNull(it.firstName);
						info.email = turnNull(it.email);
						info.telno = turnNull(it.telno);
						info.destinationAddress1 = 
										turnNull(it.destinationAddressState) + " " +
										turnNull(it.destinationAddress1) + " " +
										turnNull(it.destinationAddress2) + " " +
										turnNull(it.destinationAddress3);
						info.destinationAddress2 = turnNull(it.destinationAddress4);
					} else {
						info.name = "**********";// ご注文者
						info.email = "**********";// E-Mail
						info.telno = "**********";
						info.destinationAddress1 = "**********";// 電話番号
						info.destinationAddress2 = "";// 送付先住所
					}
					// 合計金額
					info.totalAmount = turnNull(it.totalAmount);
					// 決済方法
					info.settlementMethodId = localSettingsService.getSettlementMethodName(turnNull(it.settlementMethodId));
					def settInfo = it.settlementMethodId;
					info.details = [];
					it.details.each {
						if (it) {
							def detail = [:];
							def showCheckBox = "";
							detail.id = turnNull(it.id);
							detail.detailNo = turnNull(it.detailNo);
							//it.targetProduct = turnNull(it.targetProduct);
							detail.quantity = turnZero(it.quantity);
							detail.totalAmount = turnZero(it.totalAmount);
							detail.serviceDivision = localSettingsService.getServiceDivisionName(it.serviceDivision);
							detail.orderStatus = localSettingsService.getOrderStatusName(it.orderStatus);
//							//銀行振込、カード決済の決済ステータスを取得、代引きは不要
//							if(localSettingsService.getSettlementStatusBankName(it.settlementStatus)==""){
//								detail.settlementStatus = localSettingsService.getSettlementStatusCreditName(it.settlementStatus);								
//							}else{
//								detail.settlementStatus = localSettingsService.getSettlementStatusBankName(it.settlementStatus);	
//							}
							detail.examinationStatus = localSettingsService.getExaminationStatusName(it.examinationStatus);
							detail.printStatus = localSettingsService.getPrintStatusName(it.printStatus);
							detail.trackingNumber = turnZero(it.trackingNumber);
							
							switch (settInfo) {
								case OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER:
									detail.settlementStatus = localSettingsService.getSettlementStatusBankName(it.settlementStatus);								
									//銀行振込:　以下の状態でチェックボックスを表示
									//決済ステータス：未確認、且つ　審査ステータス：未審査、且つ　注文ステータス：決済中
									if(it.settlementStatus == OrderDetail.SETTLEMENT_STATUS_NONE 
										&& it.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
										&& it.orderStatus == OrderDetail.ORDER_STATUS_IN_SETTLEMENT){
										detail.showCheckBox = "show";
									}
									break;
								case OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD:
									detail.settlementStatus = localSettingsService.getSettlementStatusCreditName(it.settlementStatus);								
									//カード決済
							    	//決済ステータス：与信済、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
									if(it.settlementStatus == OrderDetail.SETTLEMENT_STATUS_CREDIT_OK
										&& it.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
										&& it.orderStatus == OrderDetail.ORDER_STATUS_ORDERED){
										detail.showCheckBox = "show";
									}
									break;
								case OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE:
									detail.settlementStatus = localSettingsService.getSettlementStatusPoiName(it.settlementStatus);								
									//請求書払い
									//決済ステータス：与信済、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
									//***2013.04.22 hiro@4t edit 条件変更
									if(//it.settlementStatus == OrderDetail.SETTLEMENT_STATUS_BILL_OK && 
										it.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
										&& [OrderDetail.ORDER_STATUS_ORDERED, OrderDetail.ORDER_STATUS_IN_SETTLEMENT].contains(it.orderStatus)
										&& (it.settlementStatus != OrderDetail.SETTLEMENT_STATUS_BILL_ENTRY_NG)
										&& (it.settlementStatus != OrderDetail.SETTLEMENT_STATUS_BILL_NG)){
										detail.showCheckBox = "show";
									}
									break;
								case OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY:
									detail.settlementStatus = localSettingsService.getSettlementStatusCodName(it.settlementStatus);								
									//代金引換
									//決済ステータス：未確認、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
									if(it.settlementStatus == OrderDetail.SETTLEMENT_STATUS_NONE
										&& it.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
										&& it.orderStatus == OrderDetail.ORDER_STATUS_ORDERED){
										detail.showCheckBox = "show";
									}
									break;
							}
							info.details << detail;
						}
					}
					// 注文明細リスト
					//info.details = it.details;
					result.list << info;
				}
			}

		} catch (ex) {
			log.warn("spawn error by search", ex)
		}
		render result as JSON;
	}
	
	//審査結果を「審査中」に更新
	def updateStatus = {
			
			assert adReviewService;	
			HttpUtils.nocache(response);
			def detailNo = params.detailNo.split(",");
			def detailData;
			def examinationHistory;
			for(def i=0;i<detailNo.length;i++){
				def myInfoNo = detailNo[i].split("-")[0];
				def myDetailNo = detailNo[i].split("-")[1];
				def infolist = OrderInfo.findByOrderNo(myInfoNo);
				def detaillist = OrderDetail.findWhere(orderInfo:infolist, detailNo:myDetailNo);
				
				def isTarget = false;
				detailData = OrderDetail.findWhere(id:detaillist.id);
				switch (infolist.settlementMethodId) {
					case OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER:
						//銀行振込:　以下の状態でチェックボックスを表示
						//決済ステータス：未確認、且つ　審査ステータス：未審査、且つ　注文ステータス：決済中
						if(detailData.settlementStatus == OrderDetail.SETTLEMENT_STATUS_NONE 
							&& detailData.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
							&& detailData.orderStatus == OrderDetail.ORDER_STATUS_IN_SETTLEMENT){
							isTarget = true;
						}
						break;
					case OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD:
						//カード決済
				    	//決済ステータス：与信済、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
						if(detailData.settlementStatus == OrderDetail.SETTLEMENT_STATUS_CREDIT_OK
							&& detailData.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
							&& detailData.orderStatus == OrderDetail.ORDER_STATUS_ORDERED){
							isTarget = true;
						}
						break;
					case OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE:
						//請求書払い
						//決済ステータス：与信済、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
						//***2013.04.22 hiro@4t 条件変更
						if(//detailData.settlementStatus == OrderDetail.SETTLEMENT_STATUS_BILL_OK &&
							detailData.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
							&& [OrderDetail.ORDER_STATUS_ORDERED, OrderDetail.ORDER_STATUS_IN_SETTLEMENT].contains(detailData.orderStatus)){
							isTarget = true;
						}
						break;
					case OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY:
						//代金引換
						//決済ステータス：未確認、且つ　審査ステータス：未審査、且つ　注文ステータス：注文済
						if(detailData.settlementStatus == OrderDetail.SETTLEMENT_STATUS_NONE
							&& detailData.examinationStatus == OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION
							&& detailData.orderStatus == OrderDetail.ORDER_STATUS_ORDERED){
							isTarget = true;
						}
						break;
				}
					
				// 更新対象の場合、DB更新を行う
				if (isTarget == true) {
					try {
							detailData.examinationStatus = OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION;
							detailData.examinationStatusUpdated = new Date();
							detailData.save();
					}catch (ex) {
						LogUtils.error(log, message(code:"BA08E001", args:[myInfoNo,myDetailNo]) + '\n'+ex.message);
						flash.message = "登録できませんでした。";
					}
					try {
						//審査ステータス追加
						examinationHistory = new ExaminationStatus();
						examinationHistory.orderDetail = detaillist;
						examinationHistory.examinationStatus = OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION;
						examinationHistory.statusUpdate = new Date();
						examinationHistory.dateCreated = new Date();
						examinationHistory.lastUpdated = new Date();
						examinationHistory.save();
					}catch (ex) {
						LogUtils.error(log, message(code:"BA08E002", args:['審査ステータス',myInfoNo,myDetailNo]) + '\n'+ex.message);
						flash.message = "登録できませんでした。";
					}
				}
			}
			def result = [:];
			result.result = "ok";
			render result as JSON;
		
	}
	
	// 審査結果CSVファイルをアップロード
	def upload = {
		assert adReviewService;

		HttpUtils.nocache(response);

		def model = null;
		try {
			def csvFile = UploadedFileUtils.getFile(request, "csvFile");
			if (!csvFile) {
				flash.message = "CSVファイルを指定してください。";
				throw new NLMExitControllerException("empty csv file.");
			}
			model = adReviewService.update(csvFile.inputStream);

		} catch (NLMExitControllerException ex) {
			// ignore

		} catch (ex) {
			flash.message = "登録できませんでした。";
		}
		render(view:'uploadFile', model:model);
	}
	// 郵便番号フォーマット
	def zipcode(destinationZipcode) {
		if(destinationZipcode != null && destinationZipcode.length() == 7){
			destinationZipcode = destinationZipcode.substring(0,3) + "-" + destinationZipcode.substring(3,7) ;
		}
		return destinationZipcode;
	}
	/**
	 * 検索パラメータの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setupSearchParams(params) {
		SearchParamUtils.setupSearchParams(session, 'SearchParams', params); // 検索パラメータの設定
	}
}
