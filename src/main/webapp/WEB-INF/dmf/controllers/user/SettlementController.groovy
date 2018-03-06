package jp.co.jpmd.oiy.dmolbiz.controllers.user

import grails.converters.JSON
import grails.util.Environment

import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.controllers.utils.HttpUtils

import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.exception.NewLayoutMagicServiceException;
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail
import jp.co.reso.oiy.dmol.domain.user.NpCustomer

import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.SocketTimeoutException;

import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils;

class SettlementController extends AbstractOrderItYourselfController {

	
	/**
	* デフォルトの日付フォーマット
	*/
	static final String DATE_FORMAT = "yyyyMMdd";
	static final String YEAR_FORMAT = "yyyy";
	// logファイル定義
	private static final String LOG_TYPE = "settlement";
	private static final String LOG_NAME = "Settlement_%s.log";
	private static String LOG_FILE = "";
	def settlementService;
	def scottPlusService;
	def logService;
	def localSettingsService;
	def transactionRequestService //請求決済時 NP電文(取引登録依頼)ロジック
	def orderDetailStatusService
	
	private static final CHECK_NG_RESCD_LIST = ["K20","K21","K24","K27","K40","K41","C13","C16","C17","G12","G22","G30","G44","G45","G55","G56","G60","G61","G65","G68","G83","G96","G97","G98","G99"];

	
	//決済方法選択画面
	def index = {
		
		HttpUtils.nocache(response);
		def orderNo = getOrderNoFromSession();
		
		def isOK = checkOrderNoAuth(orderNo);
		
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		else {
			// 銀行振込対応
			def isBankOK = false;	// 第三期 2012/07/30 by LAC
			
			// 代引き対応
			def isCashOnDeliveryOK = false;

			// 請求書払い対応
			def isPaymentOnInvoiceOK = false;

			try {
				isBankOK = settlementService.checkBankOK(orderNo);	// 第三期 2012/07/30 by LAC
				isCashOnDeliveryOK = settlementService.checkCashOnDeliveryOK(orderNo);
				isPaymentOnInvoiceOK = settlementService.checkPaymentOnInvoiceOK(orderNo);
			}
			catch (ex) {
				LogUtils.error(log, message(code:"AA03E004", args:[orderNo]) + '\n' + ex.message);
			}
	
			return [orderNo:orderNo, isBankOK:isBankOK, isCashOnDeliveryOK:isCashOnDeliveryOK, isPaymentOnInvoiceOK:isPaymentOnInvoiceOK, isOK:true];	// 第三期 2012/07/30 by LAC
		
		}
	}
	//月
	def monothList(locale = null) {
		if (Environment.current == Environment.PRODUCTION) {
			return ['01','02','03','04','05','06','07','08','09','10','11','12'];
		}
		else {
			return ['01','02','03','04','05','06','07','08','09','10','11','12','99'];
		}
	}
	//年
	def yearList(locale = null){
		int year = new Date().format(YEAR_FORMAT).asType(int) - 1;
		def yearList =[];
		for (int i=0;i<10;i++){
			year = year + 1;
			yearList << year;
		}
		if (Environment.current != Environment.PRODUCTION) {
			yearList << 9999;
		}
		return yearList;
	}
	//日
	def dayList(locale = null){
		int day = 0;
		return ['01','02','03','04','05','06','07','08','09','10',
			'11','12','13','14','15','16','17','18','19','20',
			'21','22','23','24','25','26','27','28','29','30',
			'31'];
	}
	//requestから、値を取得
	def requestRet = {
		def requestRetMap = [orderNo:getOrderNoFromSession(),
			cardNo:request.getParameter("cardNo"),
			cardExpY:request.getParameter("cardExpY"),
			cardExpM:request.getParameter("cardExpM"),
			cardExp:request.getParameter("cardExp"),
			secCd:request.getParameter("secCd"),
			birthDayM:request.getParameter("birthDayM"),
			birthDayD:request.getParameter("birthDayD"),
			birthDay:request.getParameter("birthDay")
		   	];
		   return requestRetMap;
	}
	//カード番号入力画面
	def creditcard = {
		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		assert systemMasterService;
		
		HttpUtils.nocache(response);
		def requestRetMap = requestRet();
		//月
		def addMonthList = monothList();
		//年
		def addYearList = yearList();
		//日
		def addDayList = dayList();		
		
		return [requestRetMap:requestRetMap,
				addYearList:addYearList,
				addMonthList:addMonthList,
				addDayList:addDayList,isOK:true];
	}
	//カード番号確認
	def confirm = {
		assert scottPlusService;
		
		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		HttpUtils.nocache(response);
		def requestRetMap = requestRet();
		def addMonthList = monothList();
		def addYearList = yearList();
		def addDayList = dayList();
		// 処理日時を取得
		def transactionDate = new Date().format(DATE_FORMAT);
		// 有効期限（年）
		def cardExpYear;  
		if(requestRetMap.cardExpY != null){
		   cardExpYear = requestRetMap?.cardExpY.substring(2,4);
		}
		
		// 有効期限
		def cardExp =  cardExpYear + requestRetMap.cardExpM;
		// 生月日
		def birthDay = requestRetMap.birthDayM + requestRetMap.birthDayD;
		def args = [cardNo:requestRetMap.cardNo,
					cardExp:cardExp,
					secCd:requestRetMap.secCd,
					birthDay:birthDay];
				
		def responseList;
		try {
			// カード有効性を確認
			responseList = scottPlusService.check(args);
			
			} catch (Exception e) {
				LogUtils.error(log, message(code:"AA02E001", args:[requestRetMap.orderNo]) + '\n'+e.message);
			flash.message = "ただいま回線が混み合っています。しばらくしてから再度ご利用ください。";
			render(view:'creditcard',model:[requestRetMap:requestRetMap,
					addYearList:addYearList,
					addMonthList:addMonthList,
					addDayList:addDayList,isOK:true]);
			return;
			}
		if(responseList.ResponseCd == "OK"){
			// 注文情報と注文明細を取得
			def ret = settlementService.search(requestRetMap.orderNo);
			def info = ret.info;
			def details = ret.details;
			def countMax = details.detail.size;
			def cardNoM = requestRetMap.cardNo;
			def destinationZipcode = zipcode(info?.destinationZipcode);
			if(cardNoM != null && cardNoM.length() == 16){
				cardNoM = requestRetMap.cardNo.substring(0,4) + "********" + requestRetMap.cardNo.substring(12,16);
			}
			requestRetMap = requestRetMap + ([cardNoM:cardNoM]);
			requestRetMap = requestRetMap + ([cardExp:cardExp,birthDay:birthDay]);
			def screenCol;
			for(iit in details) {
				def serviceDivision = iit.serviceDivision;
				if(serviceDivision == OrderDetail.SERVICE_DIVISION_FUTAI){
					screenCol = "DIVISION_FUTAI";
				}
			}
			
			return [requestRetMap:requestRetMap,info:info,details:details,countMax:countMax,destinationZipcode:destinationZipcode,screenCol:screenCol,isOK:true];
		}else{
			if( CHECK_NG_RESCD_LIST.contains(responseList.ResponseCd)) {
				flash.message = "入力されたクレジットカードの情報に誤りがあるか、クレジットカードがご利用になれません。";
			}else{
				flash.message = "ただいま回線が混み合っています。しばらくしてから再度ご利用ください。";
			}
			
			render(view:'creditcard',model:[requestRetMap:requestRetMap,
					addYearList:addYearList,
					addMonthList:addMonthList,
					addDayList:addDayList,isOK:true],
					'stateList': localSettingsService.listAddressState());
			
		}
	}
	// クレジットカード決済
	def creditcardupdate = {

		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		
		assert settlementService;
		assert scottPlusService;
		assert logService;
		
		HttpUtils.nocache(response);
		// 処理日時を取得
		def transactionDate = new Date().format(DATE_FORMAT);
		// 注文情報と注文明細を取得
		def ret ;
		// 明細リスト
		def retDetailList = [];
		// 与信成功リスト
		def retSuccessList = [];
		// 与信エラー
		boolean errorFlg = false;
		// 与信結果コード
		def responseCd;
		/*#931 2012/02/21 by A&I Start*/
		//注文明細テーブルの代引き手数料を更新
		def retDetailCodList = [];
		retDetailCodList = settlementService.search(this.getOrderNoFromSession()).details;
		for(cit in retDetailCodList) {
			def id = cit.id;
			def version = cit.version;
			def detailCodParams = [cashOnDeliveryFee:0,
				jpmdCashOnDeliveryFee:0];
			def detailCod = new OrderDetail(detailCodParams);
			try {
			detailCod = settlementService.orderUpdateCodFee(id,version,detailCod);
			} catch (NLMNotFoundException ex) {
			LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
			return;
			} catch (NLMValidationFailureException ex) {
			LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
			return;
			} catch (ex) {
			LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
			return;
			}
		}
		//注文情報テーブルの代引き手数料を更新
		def codList = settlementService.search(this.getOrderNoFromSession());
		def orderInfoCod = codList.info;
		orderInfoCod.cashOnDeliveryFee=0;
		orderInfoCod.jpmdCashOnDeliveryFee=0;
		/*#931 2012/02/21 by A&I End*/
		// 第三期 2012/03/19 by A&I Start
		orderInfoCod.questionnaireResponse=params.settlementValue;
		orderInfoCod.orderComment=params.myValue;
		if(params.postCd?:'' != ''){
			orderInfoCod.salesBranchId=params.postCd;
		}
		orderInfoCod.salesPerson=params.postNm;
		
		orderInfoCod.normalize();
		// 第三期 2012/03/19 by A&I End
		orderInfoCod.save();
		
		retDetailList = settlementService.search(this.getOrderNoFromSession()).details;
		for(iit in retDetailList) {
			def id = iit.id;
			def version = iit.version;
			def detailNo = iit.detailNo;
			int settlementStatus = iit.settlementStatus.asType(int);
			def totalAmountId = iit.totalAmount+"";	
			def cardNo = params.cardNo;
			def args = [
						orderNo:this.getOrderNoFromSession(),
						detailNo:detailNo,
						cardNo:cardNo,
						cardExp:params.cardExp,
						secCd:params.secCd,
						birthDay:params.birthDay,
						amount:totalAmountId ];
			
			// クレジットカードの与信枠（承認番号）を取得する
			def responseList;
			if(settlementStatus != OrderDetail.SETTLEMENT_STATUS_CREDIT_OK){			
				try {
					responseList = scottPlusService.auth(args);				

					} catch (Exception e) {
					LogUtils.error(log, message(code:"AA03E002", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+e.message);
					def result = [result:'error',message:'ただいま回線が混み合っています。しばらくしてから再度ご利用ください。'];
					render result as JSON;
					return;
					}
					
				if(responseList?.ResponseCd == "OK"){
					settlementService.logFile([orderNo:this.getOrderNoFromSession(),detailNo:detailNo,message:"与信OK"]);
					def processId = responseList.ProcessId;
					def processPass = responseList.ProcessPass;
					def companyCd = responseList.CompanyCd;
					def detailParams = [processId:processId,
						processPass:processPass,
						cardCorporateId:companyCd,
						settlementStatus:OrderDetail.SETTLEMENT_STATUS_CREDIT_OK,
						settlementStatusUpdated:new Date()];
					// 注文明細テーブルを更新する
					def detail = new OrderDetail(detailParams);
					def detailVersion;
					try {
						
						detail = settlementService.updateCredit(id,version,detail);		
						detailVersion = detail.version;
						} catch (NLMNotFoundException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						} catch (NLMValidationFailureException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						} catch (ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						}
					def retMap = [processId:processId,processPass:processPass,id:id,version:detailVersion,detailNo:detailNo]
					retSuccessList << retMap;
				}else{
					settlementService.logFile([orderNo:this.getOrderNoFromSession(),detailNo:detailNo,message:"与信NG"]);
					def detailParams = [settlementStatus:OrderDetail.SETTLEMENT_STATUS_CREDIT_NG,
						settlementStatusUpdated:new Date(),settlementError:responseList?.ResponseCd];
					// 注文明細テーブルを更新する
					def detail = new OrderDetail(detailParams);
					try {
					detail = settlementService.updateSettlementStatus(id,version,detail);
					} catch (NLMNotFoundException ex) {
					LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
					return;	
					} catch (NLMValidationFailureException ex) {
					LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
					return;
					} catch (ex) {
					LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
					return;
					}		
					responseCd = responseList?.ResponseCd;
					errorFlg = true;
					break;
				}
			}
		}		
		if(errorFlg){			
			for(iit in retSuccessList) {
				def id = iit.id;
				def version = iit.version;
				def processId = iit.processId;
				def processPass = iit.processPass;
				def detailNo = iit.detailNo;
				def args = [processId:processId,processPass:processPass,orderNo:this.getOrderNoFromSession(),detailNo:detailNo];
				// 与信済の取引をキャンセルする。
				def responseList;
				try {
					responseList = scottPlusService.authCancel(args);

					} catch (Exception e) {
					LogUtils.error(log, message(code:"AA03E002", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+e.message);
					def result = [result:'error',message:'ただいま回線が混み合っています。しばらくしてから再度ご利用ください。'];
					render result as JSON;
					return;
					}
								
				if(responseList.ResponseCd == "OK"){
					settlementService.logFile([orderNo:this.getOrderNoFromSession(),detailNo:detailNo,message:"与信キャンセルOK"]);
					def companyCd = responseList.CompanyCd;					
					def detailParams = [processId:processId,
						processPass:processPass,
						cardCorporateId:companyCd,
						settlementStatus:OrderDetail.SETTLEMENT_STATUS_CREDIT_CANCEL,
						settlementStatusUpdated:new Date()];
					// 注文明細テーブルを更新する
					def detail = new OrderDetail(detailParams);
					try {
						detail = settlementService.updateCredit (id,version,detail);
						
						} catch (NLMNotFoundException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						} catch (NLMValidationFailureException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						} catch (ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						}										
				}else{
					settlementService.logFile([orderNo:this.getOrderNoFromSession(),detailNo:detailNo,message:"与信キャンセルNG"]);
					LogUtils.error(log, message(code:"AA03E003", args:[this.getOrderNoFromSession(),detailNo]));
					def detailParams = [settlementStatus:OrderDetail.SETTLEMENT_STATUS_CREDIT_CANCEL_NG,
						settlementStatusUpdated:new Date(),settlementError:responseList?.ResponseCd];	
					// 注文明細テーブルを更新する
					def detail = new OrderDetail(detailParams);
					try {
						detail = settlementService.updateSettlementStatus(id,version,detail);
						} catch (NLMNotFoundException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
		
						} catch (NLMValidationFailureException ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						} catch (ex) {
						LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
						return;
						}
				}
			}
			def result;
			if( CHECK_NG_RESCD_LIST.contains(responseCd)){
				result = [result:'error',message:'入力されたクレジットカードはご利用になれません。'];
			}else{
				result = [result:'error',message:'ただいま回線が混み合っています。しばらくしてから再度ご利用ください。'];
			}
			render result as JSON;
			return;
		}
		def retList = settlementService.search(this.getOrderNoFromSession());
		for(iit in retList.details) {
			def id = iit.id;
			def version = iit.version;
			def detailParams = [orderStatus:OrderDetail.ORDER_STATUS_ORDERED,
				orderStatusUpdated:new Date(),cashOnDeliveryFee:0,
				jpmdCashOnDeliveryFee:0,totalAmount:iit.totalAmount];
			def detailVersion;
			// 注文明細テーブルを更新する
			def detail = new OrderDetail(detailParams);
			
			try {
				detail = settlementService.orderUpdateStatus(id,version,detail);
				} catch (NLMNotFoundException ex) {
				LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				} catch (NLMValidationFailureException ex) {
				LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				} catch (ex) {
				LogUtils.error(log, message(code:"AA03E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				}
				
		}
		
		def orderInfo = retList.info;
		orderInfo.settlementMethodId = OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD;
		orderInfo.save();
		settlementService.receptionMail([orderNo:this.getOrderNoFromSession(), locale:this.locale]);
		redirect(controller:'toDmfApplication', action:'returnToUser', params:[orderNo:this.getOrderNoFromSession()]); 
		
	}
	
	// 銀行振込決済の内容確認
	def bank = {
		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		
		HttpUtils.nocache(response);
		def orderNo = getOrderNoFromSession();
		// 注文情報と注文明細を取得
		def ret = settlementService.search(orderNo);
		def info = ret.info;
		def details = ret.details;
		def screenCol;
		for(iit in details) {
			def serviceDivision = iit.serviceDivision;
			if(serviceDivision == OrderDetail.SERVICE_DIVISION_FUTAI){
				screenCol = "DIVISION_FUTAI";
			}
		}
		def destinationZipcode = zipcode(info?.destinationZipcode);			
 		return [orderNo:orderNo,info:info,details:details,destinationZipcode:destinationZipcode,screenCol:screenCol,isOK:true,'stateList': localSettingsService.listAddressState()];
		
	}
	
	def searchDate = {
		def result = [:];
		def postNo = params.searchNo;
		def type = params.type;
		def area = params.area;
		def holder = settlementService.searchPostOfficeCode(postNo,area,type);
		render holder as JSON;
	}
	
	
	// 銀行振込決済
	def bankupdate = {
		
		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		
		assert settlementService;
		HttpUtils.nocache(response);
		def orderNo = this.getOrderNoFromSession();
		// 明細リスト
		def retDetailList = [];
		// 注文情報、注文明細を取得
		def ret = settlementService.search(orderNo);
		retDetailList = ret.details;
		for(iit in retDetailList) {
			def id = iit.id;
			def version = iit.version;
			def detailNo = iit.detailNo;
			/*#931 2012/02/21 by A&I Start*/
			def detailParams = [settlementStatus:OrderDetail.SETTLEMENT_STATUS_NONE,
				settlementStatusUpdated:new Date(),orderStatus:OrderDetail.ORDER_STATUS_IN_SETTLEMENT,orderStatusUpdated:new Date(),cashOnDeliveryFee:0,
				jpmdCashOnDeliveryFee:0];
			/*#931 2012/02/21 by A&I End*/
			// 注文明細テーブルを更新する
			def detail = new OrderDetail(detailParams);
			try {
				detail = settlementService.bankUpdateStatus(id,version,detail);
				} catch (NLMNotFoundException ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				} catch (NLMValidationFailureException ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				} catch (ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[this.getOrderNoFromSession(),detailNo]) + '\n'+ex.message);
				return;
				}
		}
		def orderInfo = ret.info;
		orderInfo.settlementMethodId = OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER;
		/*#931 2012/02/21 by A&I Start*/
		orderInfo.cashOnDeliveryFee=0;
		orderInfo.jpmdCashOnDeliveryFee=0;
		/*#931 2012/02/21 by A&I End*/
		// 第三期 2012/03/19 by A&I Start
		orderInfo.questionnaireResponse=params.settlementValue;
		orderInfo.orderComment=params.myValue;
		if(params.postCd?:'' != ''){
			orderInfo.salesBranchId=params.postCd;
		}
		orderInfo.salesPerson=params.postNm;
		orderInfo.normalize();
		// 第三期 2012/03/19 by A&I End
		orderInfo.save();
		settlementService.receptionMail([orderNo:orderNo, locale:this.locale]);
		redirect(controller:'toDmfApplication', action:'returnToUser', params:[orderNo:orderNo]); 
	}

	// 代引き決済の内容確認
	def cashOnDelivery = {
		
		def isOK;
		
		isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		HttpUtils.nocache(response);
		def orderNo = this.getOrderNoFromSession();
		isOK=settlementService.checkCashOnDeliveryOK(orderNo);
		if (!isOK) {
			flash.message = "不正の画面遷移：代引決済を選択できません。";
			return [isOK:false];
		}
		// 注文情報と注文明細を取得
		def ret = settlementService.search(orderNo);
		def info = ret.info;
		def details = ret.details;
		def screenCol;
		for(iit in details) {
			def serviceDivision = iit.serviceDivision;
			if(serviceDivision == OrderDetail.SERVICE_DIVISION_FUTAI){
				screenCol = "DIVISION_FUTAI";
			}
		}
		
		def destinationZipcode = zipcode(info?.destinationZipcode);			
 		return [orderNo:orderNo,info:info,details:details,destinationZipcode:destinationZipcode,screenCol:screenCol,isOK:true,totalAmountFee:info.totalAmount + 360,'stateList': localSettingsService.listAddressState()];
		
	}
	
	// 代引き振込決済
	def cashOnDeliveryUpdate = {
		def isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		assert settlementService;
		HttpUtils.nocache(response);
		def orderNo = this.getOrderNoFromSession();
		// 明細リスト
		def retDetailList = [];
		// 注文情報、注文明細を取得
		def ret = settlementService.search(orderNo);
		retDetailList = ret.details;
		for(iit in retDetailList) {
			def id = iit.id;
			def version = iit.version;
			def detailNo = iit.detailNo;
			/*#931 2012/02/21 by A&I Start*/
			def detailParams = [settlementStatus:OrderDetail.SETTLEMENT_STATUS_NONE,
				settlementStatusUpdated:new Date(),orderStatus:OrderDetail.ORDER_STATUS_ORDERED, orderStatusUpdated:new Date(),cashOnDeliveryFee:360,
				jpmdCashOnDeliveryFee:0,totalAmount:iit.totalAmount];
			/*#931 2012/02/21 by A&I End*/
			// 注文明細テーブルを更新する
			def detail = new OrderDetail(detailParams);
			try {
				detail = settlementService.orderUpdateStatus(id,version,detail);
				} catch (NLMNotFoundException ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
				return;
				} catch (NLMValidationFailureException ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
				return;
				} catch (ex) {
				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
				return;
				}
		}
		def orderInfo = ret.info;
		orderInfo.settlementMethodId = OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY;
		/*#931 2012/02/21 by A&I Start*/
		orderInfo.cashOnDeliveryFee=360;
		orderInfo.jpmdCashOnDeliveryFee=0;
		orderInfo.totalAmount=orderInfo.totalAmount + orderInfo.cashOnDeliveryFee;
		/*#931 2012/02/21 by A&I End*/
		// 第三期 2012/03/19 by A&I Start
		orderInfo.questionnaireResponse=params.settlementValue;
		orderInfo.orderComment=params.myValue;
		if(params.postCd?:'' != ''){
			orderInfo.salesBranchId=params.postCd;
		}
		orderInfo.salesPerson=params.postNm;
		orderInfo.normalize();
		// 第三期 2012/03/19 by A&I End
		orderInfo.save();
		settlementService.receptionMail([orderNo:orderNo, locale:this.locale]);
		redirect(controller:'toDmfApplication', action:'returnToUser');
	}

	// 請求書払い決済の内容確認
	def paymentOnInvoice = {
		def isOK;
		isOK = checkOrderNoAuth(getOrderNoFromSession());
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。";
			return [isOK:false];
		}
		HttpUtils.nocache(response);
		def orderNo = this.getOrderNoFromSession();
		isOK=settlementService.checkPaymentOnInvoiceOK(orderNo);
		if (!isOK) {
			flash.message = "不正の画面遷移：請求書払い決済を選択できません。";
			return [isOK:false];
		}
		// 注文情報と注文明細を取得
		def model = createPoiModelData(orderNo);
		return model
	}

	private createPoiModelData(String orderNo) {
		def ret = settlementService.search(orderNo); //create ret.info, ret.details
		ret.orderNo = orderNo
		def info = ret.info;
		def details = ret.details;
		
		def screenCol;
		for(iit in details) {
			def serviceDivision = iit.serviceDivision;
			if(serviceDivision == OrderDetail.SERVICE_DIVISION_FUTAI){
				screenCol = "DIVISION_FUTAI";
			}
		}
		ret.screenCol = screenCol
		ret.destinationZipcode = zipcode(info?.destinationZipcode)
		ret.isOK = true
		ret.stateList = localSettingsService.listAddressState()
		
		return ret
	}
	
	def paymentOnInvoiceUpdate = {
		assert settlementService
		assert transactionRequestService
		
		def isOK = checkOrderNoAuth(getOrderNoFromSession())
		if (!isOK) {
			flash.message = "注文情報を取得できませんでした。"
			return [isOK:false]
		}
		HttpUtils.nocache(response)
		
		try{
			//対象注文取得
			def orderNo = this.getOrderNoFromSession()
			OrderInfo oi = OrderInfo.findByOrderNo(orderNo)
			if (!oi) {
				flash.message = "注文情報を取得できませんでした。"
				return [isOK:false]
			}
			// NP顧客情報
			def self = currentUser()
			def npCustomerInfo = settlementService.getOrCreateNpCustomer(self)
			// NP電文処理
			def npTelErrList = transactionRequestService.Entry(oi)
			if (npTelErrList?.size()) {
				// ユーザー通知のエラー発生
				flash.message = npTelErrList.join('<br>')
				//paymentOnInvoice 画面に戻る
				render view:'paymentOnInvoice', model:createPoiModelData(orderNo)
				return
			}
			// 注文情報更新
			oi.settlementMethodId = OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE
			oi.cashOnDeliveryFee = 0
			oi.jpmdCashOnDeliveryFee = 0
			oi.questionnaireResponse = params.settlementValue
			oi.orderComment = params.myValue
			if(params.postCd?:'' != ''){
				oi.salesBranchId = params.postCd
			}
			oi.salesPerson = params.postNm
			oi.normalize();
			oi.save();
			
			// 注文明細更新
			def stUpdateDate = new Date()
			for(OrderDetail od : oi.details) {
				od.orderStatus = OrderDetail.ORDER_STATUS_IN_SETTLEMENT
				od.orderStatusUpdated = stUpdateDate
				od.settlementStatus = OrderDetail.SETTLEMENT_STATUS_BILL_ENTRY_REQUEST
				od.settlementStatusUpdated = stUpdateDate
				od.cashOnDeliveryFee = 0
				od.jpmdCashOnDeliveryFee = 0
				if(!od.save()) {
					log.error("注文情報 明細NO：${od.detailNo} の更新に失敗しました save=false, validate=${od.validate()}")
				}
				// 履歴データ作成
				orderDetailStatusService.updateOrderStatus(od)
				orderDetailStatusService.updateSettlementStatus(od)
			}
	
			// 注文確定メール送信
			settlementService.receptionMail([orderNo:orderNo, locale:this.locale]);
			//遷移
			redirect(controller:'toDmfApplication', action:'returnToUser');
		}catch(NewLayoutMagicServiceException ex){
			log.error("注文確定エラー", ex)
			flash.message = ex.message
			render ([result:'error',message:ex.message] as JSON)
		}catch(ex){
			log.error("注文確定処理エラー", ex)
			render ([result:'error',message:'ただいま回線が混み合っています。しばらくしてから再度ご利用ください。'] as JSON)
		}
	}
//	// 請求書払い決済
//	def paymentOnInvoiceUpdateOld = {
//		def isOK = checkOrderNoAuth(getOrderNoFromSession());
//		if (!isOK) {
//			flash.message = "注文情報を取得できませんでした。";
//			return [isOK:false];
//		}
//		assert settlementService;
//		HttpUtils.nocache(response);
//		def orderNo = this.getOrderNoFromSession();
//		// 明細リスト
//		def retDetailList = [];
//		// 注文情報、注文明細を取得
//		def ret = settlementService.search(orderNo);
//		retDetailList = ret.details;
//		for(iit in retDetailList) {
//			def id = iit.id;
//			def version = iit.version;
//			def detailNo = iit.detailNo;
//			/*#931 2012/02/21 by A&I Start*/
//			def detailParams = [orderStatus:OrderDetail.ORDER_STATUS_IN_SETTLEMENT, orderStatusUpdated:new Date(),cashOnDeliveryFee:0,
//				jpmdCashOnDeliveryFee:0];
//			/*#931 2012/02/21 by A&I End*/
//			// 注文明細テーブルを更新する
//			def detail = new OrderDetail(detailParams);
//			try {
//				detail = settlementService.paymentOnInvoiceUpdateStatus(id,version,detail);
//				} catch (NLMNotFoundException ex) {
//				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
//				return;
//				} catch (NLMValidationFailureException ex) {
//				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
//				return;
//				} catch (ex) {
//				LogUtils.error(log, message(code:"AA04E001", args:[params.orderNo,detailNo]) + '\n'+ex.message);
//				return;
//				}
//		}
//		def orderInfo = ret.info;
//		orderInfo.settlementMethodId = OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE;
//		/*#931 2012/02/21 by A&I Start*/
//		orderInfo.cashOnDeliveryFee=0;
//		orderInfo.jpmdCashOnDeliveryFee=0;
//		/*#931 2012/02/21 by A&I End*/
//		// 第三期 2012/03/19 by A&I Start
//		orderInfo.questionnaireResponse=params.settlementValue;
//		orderInfo.orderComment=params.myValue;
//		if(params.postCd?:'' != ''){
//			orderInfo.salesBranchId=params.postCd;
//		}
//		orderInfo.salesPerson=params.postNm;
//		orderInfo.normalize();
//		// 第三期 2012/03/19 by A&I End
//		orderInfo.save();
//		// NP用顧客IDの採番
//		if (!this.currentUser().npCustomer) {
//			def npCustomer = new NpCustomer();
//			npCustomer.owner = this.currentUser();
//			npCustomer.npCustomerId = settlementService.nextCustomerId();
//			npCustomer.save();
//		}
//		settlementService.receptionMail([orderNo:orderNo, locale:this.locale]);
//		redirect(controller:'toDmfApplication', action:'returnToUser');
//	}
	
	//　郵便番号フォーマット
	private zipcode(code) {
		if (!code) ''
		else if(code.size() == 7) "${code[0..2]}-${code[3..6]}"
		else code
	}
	
	// 戻る
	def back = {
		def orderNo = getOrderNoFromSession();
		redirect(controller:'toDmfApplication', action:'backToUser');
		
	}
	// 決済選択画面に戻る
	def backMenu = {
		def orderNo = getOrderNoFromSession();
		redirect(controller:'settlement', action:'index');
		
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

	/**
	 * 注文パラメータを取得する。
	 * @param params リクエストパラメータ
	 */
	private checkOrderNoAuth(orderNo) {
		if (!orderNo) {
			return false;
		}
		
		def info = settlementService.search(orderNo);
		
		if (!info) {
			return false;
		}
		else {
			//ログイン中のユーザ情報の取得
			def self = this.currentUser(false);
			if (info?.info?.owner.id != self?.id) {
				return false;
			}
		}
		
		info?.details?.each() {
			if (info.orderStatus != OrderDetail.ORDER_STATUS_NONE) {
				return false;
			}
		}
		
		return true;
		
	}
}
