/**
* 作成日:		2011/12/02
* 機能記述:		管理側の請求書払い管理画面表示用コントローラ
* 変更履歴:
* Copyright (C) A&I System Inc.
*/

package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse

import jp.co.reso.commons.file.FileUtils
import jp.co.reso.layoutlogic.util.TempFileUtil
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
import jp.co.jpmd.oiy.dmolbiz.services.office.CreateCsvPoiAddingService;
import jp.co.jpmd.oiy.dmolbiz.services.office.CreateCsvPoiTransactionService;

class PoiManagementController  extends AbstractOrderItYourselfController{

	/** grailsApplication */
	GrailsApplication grailsApplication;

	def localSettingsService;
	def poiManagementService;
	def createCsvPoiAddingService;
	def createCsvPoiTransactionService;
	
	/**
	 * beforeInterceptorから呼び出すメソッドです。
	 * @param locale ロケール
	 */
	def before(locale) {
		super.before(locale);
		this.setDomainClazzName('OrderInfo', OrderInfo.getClazzName(locale));
		this.setDomainFieldNameMap('OrderInfo', OrderInfo.getFieldNameMap(locale));
	}

	// 一覧表示にリダイレクト
	def index = {
		
		if(session.getAttribute("para") && session.getAttribute("myPage") == "poiManagement"){
			def para = session.getAttribute("para");
			def hh=1;
			params.autoSearch = "true";	
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
			// ご注文者会社名
			params.corporateName = para.corporateName;
			// E-Mail
			params.email = para.email;
			// 電話番号
			params.telno = para.telno;
			// 送付先住所
			params.destinationAddress = para.destinationAddress;
			// 決済ステータス：請求書支払い
			params.settlementStatusPoi = para.settlementStatusPoi;
			// サービス区分：DMオンライン
			params.serviceDivisionDMOnline = checkTF(para.serviceDivisionDMOnline);
			// サービス区分：オリジナル年賀
			params.serviceDivisionNewYearCard = checkTF(para.serviceDivisionNewYearCard);
			// サービス区分：オリジナルかもめ～る
			params.serviceDivisionKamoMail = checkTF(para.serviceDivisionKamoMail);
			// サービス区分：付帯サービス
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
			'settlementStatusPoiList':localSettingsService.settlementStatusPoiList(),
			//決済中を除外
			'orderStatusList':localSettingsService.orderStatusList(),
			'examinationStatusList':localSettingsService.examinationStatusList(),
			'printStatusList':localSettingsService.printStatusList()];
	}
	private checkTF(para){
		if(para == "false"){
			para = "";
		}
		return para;
	}
	def setSession = {
		def addList = [:];
		addList.addController = [];
		addList.addAction = [];
		addList.addAction2 = [];
		addList.addController << "poiManagement";
		addList.addAction << "index";
		addList.addAction2 << "";
		session.setAttribute("controller", addList);
		def result = [:];
		result.result = "ok";
		render result as JSON;
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
	def search = {

		assert poiManagementService;

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
			// ご注文者会社名
			sparams.corporateName = params.corporateName.replace("'","''").replace("%","[%]");
			// E-Mail
			sparams.email = params.email.replace("'","''").replace("%","[%]");
			// 電話番号
			sparams.telno = params.telno.replace("'","''").replace("%","[%]");
			// 送付先住所
			sparams.destinationAddress = params.destinationAddress.replace("'","''").replace("%","[%]");
			// 決済ステータス：請求書払い
			sparams.settlementStatusPoi = params.settlementStatusPoi.replace("'","''").replace("%","[%]");
			// サービス区分：DMオンライン
			sparams.serviceDivisionDMOnline = params.serviceDivisionDMOnline.replace("'","''").replace("%","[%]");
			// サービス区分：オリジナル年賀
			sparams.serviceDivisionNewYearCard = params.serviceDivisionNewYearCard.replace("'","''").replace("%","[%]");
			// サービス区分：オリジナルかもめ～る
			sparams.serviceDivisionKamoMail = params.serviceDivisionKamoMail.replace("'","''").replace("%","[%]");
			// サービス区分：付帯サービス
			sparams.serviceDivisionFuTai = params.serviceDivisionFuTai.replace("'","''").replace("%","[%]");
			// 注文ステータス
			sparams.orderStatus = params.orderStatus.replace("'","''").replace("%","[%]");
			// キャンセルを除く
			sparams.isExcludeCancel = params.isExcludeCancel;
			// 審査ステータス
			sparams.examinationStatus = params.examinationStatus.replace("'","''").replace("%","[%]");
			// 印刷ステータス
			sparams.printStatus = params.printStatus.replace("'","''").replace("%","[%]");
			sparams.search = true;
			this.setupSearchParams(sparams);
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.setAttribute("para",sparams);
			session.setAttribute("myPage","poiManagement");
			def holder = poiManagementService.search(sparams);
			if (holder) {
				
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
					
					// ご注文者
					info.name = turnNull(it.familyName) + " " + turnNull(it.firstName);
					// 注文者会社名
					info.corporateName = turnNull(it.corporateName);
					// E-Mail
					info.email = turnNull(it.email);
					// 電話番号
					info.telno = turnNull(it.telno);
					// 送付先住所
					info.destinationAddress1 = 
									turnNull(it.destinationAddressState) + " " +
									turnNull(it.destinationAddress1) + " " +
									turnNull(it.destinationAddress2) + " " +
									turnNull(it.destinationAddress3);
					info.destinationAddress2 = turnNull(it.destinationAddress4);
					// 合計金額
					info.totalAmount = turnZero(it.totalAmount);
					// 決済方法
					info.settlementMethodId = localSettingsService.getSettlementMethodName(turnNull(it.settlementMethodId));
					info.details = [];
					it.details.each {
						def detail = [:];
						detail.id = turnNull(it.id);
						detail.detailNo = turnNull(it.detailNo);

						detail.quantity = turnZero(it.quantity);
						detail.totalAmount = turnZero(it.totalAmount);
						detail.serviceDivision = localSettingsService.getServiceDivisionName(it.serviceDivision);
						detail.orderStatus = localSettingsService.getOrderStatusName(it.orderStatus);
						detail.settlementStatus = localSettingsService.getSettlementStatusPoiName(it.settlementStatus);
						detail.examinationStatus = localSettingsService.getExaminationStatusName(it.examinationStatus);
						detail.printStatus = localSettingsService.getPrintStatusName(it.printStatus);
						detail.trackingNumber = turnZero(it.trackingNumber);
						detail.settlementError = it.settlementError
						info.details << detail;
					}
					// 注文明細リスト
					//info.details = it.details;
					
					result.list << info;
				}
			}

		} catch (ex) {
			LogUtils.warn(log, ex);
		}
		render result as JSON;
	}

//***Rev12.NP電文対応	
//	// 決済状態を更新
//	def update = {
//		assert poiManagementService;
//		HttpUtils.nocache(response);
//		def result = [:];
//		try {
//			def arrOrderNo = params.arrOrderNo;
//			def getResult = "";
//			getResult = poiManagementService.updateStatus(arrOrderNo);
//			result.getResult = getResult;
//			
//		} catch (ex) {
//		}
//		render result as JSON;
//	}
	
	def uploadFile = {
		HttpUtils.nocache(response);
		['category':params?.category?:'authority'];
	}
	// 与信結果CSVファイルをアップロード
	def upload = {
		assert poiManagementService;

		HttpUtils.nocache(response);

		def model = [:];
		try {
			def csvFile = UploadedFileUtils.getFile(request, "csvFile");
			def category = params.category;
			if (!csvFile) {
				flash.message = "CSVファイルを指定してください。";
				throw new NLMExitControllerException("empty csv file.");
			}
			if (category == 'authority') {
				model = poiManagementService.uploadAuthority(csvFile.inputStream);
			}
			else if (category == 'transfer'){
				model = poiManagementService.uploadTransfer(csvFile.inputStream);
			}

		} catch (NLMExitControllerException ex) {
			// ignore

		} catch (ex) {
			flash.message = "登録できませんでした。";
		}
		model.category = params?.category?:'authority';
		render(view:'uploadFile', model:model);
	}
	
	def downloadFile = {
		HttpUtils.nocache(response);
	}
	// CSVファイルのダウンロード
	def download = {

		def toDay = new Date().format("yyyyMMdd");
		
		def csvFile = null;
		HttpUtils.nocache(response);

		try {
			csvFile = TempFileUtil.createTempFile("poi_download", ".csv");
			def category = params.category;
			if (category == "transaction") {
				assert createCsvPoiTransactionService;

				def settlementStatus = [];
				if (params.ssNone=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_NONE;
				}
				if (params.ssBillInCreditlimit=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_IN_CREDITLIMIT;
				}
				if (params.ssBillInExamination=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_IN_EXAMINATION;
				}
				if (params.ssBillInReservation=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_IN_RESERVATION;
				}
				if (params.ssBillNG=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_NG;
				}
				def model = createCsvPoiTransactionService.core(['settlementStatus':settlementStatus, 'csvFile':csvFile]);
				// ファイルの出力
				HttpUtils.output(request, response, 'text/csv; charset=Windows-31J', "取引登録_${toDay}.csv", csvFile);
			}
			else if (category == "adding"){
				assert createCsvPoiAddingService;
				def settlementStatus = [];
				if (params.ssBillOK=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_OK;
				}
				if (params.ssBillAdding=='true') {
					settlementStatus << OrderDetail.SETTLEMENT_STATUS_BILL_ADDING;
				}
				def model = createCsvPoiAddingService.core(['settlementStatus':settlementStatus, 'csvFile':csvFile]);
				// ファイルの出力
				HttpUtils.output(request, response, 'text/csv; charset=Windows-31J', "売上報告_${toDay}.csv", csvFile);
			}
			
			return; // 正常終了

		} catch (NLMExitControllerException ex) {
			// ignore.

		} catch (ex) {
			LogUtils.warn(log, ex);
			flash.message = "エラーが発生しました。";
		} finally {
			if (csvFile) {
//				FileUtils.delete(csvFile);
			}
		}
		// ここまで来たらエラー
		render(text:flash.message, contentType:'text/plain', encoding:'UTF-8');
	}

	//　郵便番号フォーマット
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
	// 一覧表示
	def list = {
	}
}
