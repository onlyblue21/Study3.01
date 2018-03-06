package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

//import jp.co.reso.logic.laml.GLAMLTool
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.system.TagData
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.exception.NLMExitControllerException
import jp.co.reso.oiy.core.utils.ContentTypeUtils
import jp.co.reso.oiy.core.utils.ConvertUtils
import jp.co.reso.oiy.core.utils.DateUtils
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.dmol.domain.user.UserGroup


import org.codehaus.groovy.grails.commons.GrailsApplication

import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail
import jp.co.jpmd.oiy.dmolbiz.service.office.*

class UserOrderInfoController extends AbstractOrderItYourselfController {

	/** grailsApplication */
	GrailsApplication grailsApplication;

	def localSettingsService;
	def UserOrderInfoService;
	/** ロールを操作するサービス */
	def roleService;
	
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
		//社員名表示用
		def userName='';
		//他画面から戻るとき
		if(session.getAttribute("para") && session.getAttribute("myPage") == "userOrderInfo"
			&& session.getAttribute("userName")){
			def para = session.getAttribute("para");
			params.orderInfoUserId = para.orderInfoUserId;
			params.autoSearch = "true";
			userName=session.getAttribute("userName");
		}else{
			//初期
			session.removeAttribute("controller");
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.removeAttribute("userName");
		    def checkUserId = getUserOrderInfoFromSession();
			if(checkUserId){
				if(checkUserId.matches("[0-9a-zA-Z]+")){
					params.orderInfoUserId = checkUserId;
					def user=userService.get(params.orderInfoUserId);
					if(user){
						userName = turnNull(user.familyName) + " " + turnNull(user.firstName);
					}
				}else{
					params.orderInfoUserId = '';
				}
			}else{
				params.orderInfoUserId = '';
			}
			
			session.setAttribute("userName",userName);
		}
		return[userName:userName];
	}
	def test = {
		def addList = [:];
		addList.addController = [];
		addList.addAction = [];
		addList.addAction2 = [];
		addList.addController << "userOrderInfo";
		addList.addAction << "index";
		addList.addAction2 << "";
		session.setAttribute("controller", addList);
		def result = [:];
		result.result = "ok";
		render result as JSON;
	}
	// 一覧表示
	def list = {
	}
	private checkTF(para){
		if(para == "false"){
			para = "";
		}
		return para;
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

		assert UserOrderInfoService;
		HttpUtils.nocache(response);
		def result = [offset:params.offset, list:null, totalCount:0,params:params];
		try {
			def sparams = [offset:params.offset, max:params.pageMax, sortKey:params.sortKey, sortOrder:params.sortOrder];
			sparams.orderInfoUserId = params.orderInfoUserId;
			sparams.search = true;
			this.setupSearchParams(sparams);
			def holder = UserOrderInfoService.search(sparams);
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.setAttribute("para",sparams);
			session.setAttribute("myPage","userOrderInfo");
			if (holder) {
				
				result.totalCount = holder.totalCount;
				result.list = [];
				def mySettlementMethodId = "";
				holder.list?.each {
					def info = [:];
					// id
					info.id = it.id;
					// owner
					def owner = it.owner;
					info.owner = owner.id;
					// 注文No
					info.orderNo = turnNull(it.orderNo);
					// 注文受付日時
					info.orderDate = turnNull(it.orderDate);
					if(info.orderDate){
						SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
						info.orderDate = dft.format(it.orderDate);
					}
					
					// ご注文者
					info.name = turnNull(it.familyName) + "　" + turnNull(it.firstName);
					// E-Mail
					info.email = turnNull(it.email);
					// 電話番号
					info.telno = turnNull(it.telno);
					// 送付先住所
					info.destinationAddress1 = 
									turnNull(it.destinationAddressState) + "　" +
									turnNull(it.destinationAddress1) + "　" +
									turnNull(it.destinationAddress2) + "　" +
									turnNull(it.destinationAddress3);
					info.destinationAddress2 = turnNull(it.destinationAddress4);
					// 合計金額
					info.totalAmount = turnZero(it.totalAmount);
					// 決済方法
					info.settlementMethodId = localSettingsService.getSettlementMethodName(turnNull(it.settlementMethodId));
					mySettlementMethodId = it.settlementMethodId;
										
					info.details = [];
					it.details.each {
						if (it) {
							def detail = [:];
							detail.id = turnNull(it.id);
							detail.detailNo = turnNull(it.detailNo);
//							it.targetProduct = turnNull(it.targetProduct);
							detail.quantity = turnZero(it.quantity);
							detail.totalAmount = turnZero(it.totalAmount);
							detail.serviceDivision = localSettingsService.getServiceDivisionName(it.serviceDivision);
							detail.orderStatus = localSettingsService.getOrderStatusName(it.orderStatus);
							
							if(mySettlementMethodId==OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD){
								detail.settlementStatus = localSettingsService.getSettlementStatusCreditName(it.settlementStatus);								
							}else if(mySettlementMethodId==OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER){
								detail.settlementStatus = localSettingsService.getSettlementStatusBankName(it.settlementStatus);	
							}else if(mySettlementMethodId==OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY){
								detail.settlementStatus = localSettingsService.getSettlementStatusCodName(it.settlementStatus);
							}else if(mySettlementMethodId==OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE){
								detail.settlementStatus = localSettingsService.getSettlementStatusPoiName(it.settlementStatus);
							}else{
								detail.settlementStatus = "";
							}
							
							detail.examinationStatus = localSettingsService.getExaminationStatusName(it.examinationStatus);
							detail.printStatus = localSettingsService.getPrintStatusName(it.printStatus);
							detail.trackingNumber = it.trackingNumber;
							info.details << detail;
						}
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
	
	def fileDownload(url){
		
		
		
	}
	private getUserOrderInfoFromSession() {
		if (!session) {
			return null;
		}
		return session["userOrderInfoParams.orderInfoUserId"];
	}
	/**
	 * 検索パラメータの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setupSearchParams(params) {
		SearchParamUtils.setupSearchParams(session, 'SearchParams', params); // 検索パラメータの設定
	}
}
