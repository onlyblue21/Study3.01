package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON

import java.awt.TexturePaintContext.Int;
import java.text.DecimalFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat

import jp.co.reso.oiy.core.utils.ConvertUtils

import com.sun.org.apache.bcel.internal.generic.RETURN;

import jp.co.reso.oiy.dmol.controllers.DefaultController;
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.domain.system.SystemMaintenanceState;



class AccountReceivableController extends AbstractOrderItYourselfController {

	def accountReceivableService;
	def localSettingsService;
	//年のフォーマット
	static final String YEAR_FORMAT = "yyyy";
	//月のフォーマット
	static final String MONTH_FORMAT = "MM";
	//月
	def monothList() {
		return ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
	}
	//年
	def yearList(){
		int year = new Date().format(YEAR_FORMAT).asType(int)+1;
		def yearList =[];
		for (int i=0;i<9;i++){
			year = year - 1;
			yearList << year;
		}
		return yearList;
	}
	
	// 一覧表示にリダイレクト
	def index = {
		def oparams =[:];
		this.setupSearchParams(oparams);
		params.year = new Date().format(YEAR_FORMAT);
		params.month = new Date().format(MONTH_FORMAT);
		//月リスト
		params.addMonthList = monothList();
		//年リスト
		params.addYearList = yearList();
		
		if(params.prevFlg){
			params.autoSearch = "true";
			params.year = oparams.year;
			params.month = oparams.month;
			params.isCreditCard = oparams.isCreditCard;
			params.isPaymentOnInvoice = oparams.isPaymentOnInvoice;
			params.isBank = oparams.isBank;
			params.isCashOnDelivery = oparams.isCashOnDelivery;
			// 決済方法：クレジットカード
			params.settlementMethodCredit = checkTF(oparams.isCreditCard);
			// 決済方法：請求書払い
			params.settlementMethodPoi = checkTF(oparams.isPaymentOnInvoice);
			// 決済方法：銀行振込
			params.settlementMethodBank = checkTF(oparams.isBank);
			// 決済方法：代引き
			params.settlementMethodCash = checkTF(oparams.isCashOnDelivery);
		} else {
			// 決済方法：クレジットカード
			params.settlementMethodCredit = OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD;
			// 決済方法：請求書払い
			params.settlementMethodPoi = OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE;
			// 決済方法：銀行振込
			params.settlementMethodBank = OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER;
			// 決済方法：代引き
			params.settlementMethodCash = OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY;
			// 売掛金合計（クレジット決済）
			params.totalAmount1 = 0;
			// 売掛金合計（請求書払い）
			params.totalAmount2 = 0;
			// 売掛金合計（銀行振込）
			params.totalAmount3 = 0;
			// 売掛金合計（代引き）
			params.totalAmount4 = 0;
			// 売掛金合計
			params.totalAmount5 = 0;
		}
	}
	def searchList = {
		assert accountReceivableService;
		

		try {
			def sparams = [:];
			// 注文ステータス
			sparams.yearMonth = params.yearMonth;
			sparams.isCreditCard = params.isCreditCard;
			sparams.isPaymentOnInvoice = params.isPaymentOnInvoice;
			sparams.isBank = params.isBank;
			sparams.isCashOnDelivery = params.isCashOnDelivery;
			sparams.totalAmount1 = 0;
			sparams.totalAmount2 = 0;
			sparams.totalAmount3 = 0;
			sparams.totalAmount4 = 0;
			sparams.totalAmount5 = 0;
			def settlementMethodId;
			// 決済方法：クレジット決済
			if (sparams.isCreditCard == "true") {
				settlementMethodId = OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD;
				sparams.totalAmount1 = accountReceivableService.sumTotalAmount(settlementMethodId,sparams.yearMonth);
			}
			// 決済方法：請求書払い
			if (sparams.isPaymentOnInvoice == "true") {
				settlementMethodId = OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE;
				sparams.totalAmount2 = accountReceivableService.sumTotalAmount(settlementMethodId,sparams.yearMonth);
			}
			// 決済方法：銀行振込
			if (sparams.isBank == "true") {
				settlementMethodId = OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER;
				sparams.totalAmount3 = accountReceivableService.sumTotalAmount(settlementMethodId,sparams.yearMonth)*-1;
			}
			// 決済方法：代引き
			if (sparams.isCashOnDelivery == "true") {
				settlementMethodId = OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY;
				sparams.totalAmount4 = accountReceivableService.sumTotalAmount(settlementMethodId,sparams.yearMonth);
			}
			sparams.totalAmount5 = sparams.totalAmount1 + sparams.totalAmount2 + sparams.totalAmount3 + sparams.totalAmount4; 
			this.setupSearchParams(sparams);
			render sparams as JSON;
			
		}catch (ex) {
			LogUtils.warn(log, ex);
		}
		
		
				
	}
	def search = {
		assert accountReceivableService;

		HttpUtils.nocache(response);

		def result = [offset:params.offset, list:null, totalCount:0,params:params];
		try {
			def sparams = [offset:params.offset, max:params.pageMax, sortKey:params.sortKey, sortOrder:params.sortOrder];
			//決済方法
			def settlementMethodId;
			// 注文ステータス
			sparams.year = params.year;
			sparams.month = params.month;
			sparams.yearMonth = params.yearMonth;
			sparams.isCreditCard = params.isCreditCard;
			sparams.isPaymentOnInvoice = params.isPaymentOnInvoice;
			sparams.isBank = params.isBank;
			sparams.isCashOnDelivery = params.isCashOnDelivery;
			sparams.search = true;
			
			this.setupSearchParams(sparams);
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.setAttribute("para",sparams);
			session.setAttribute("myPage","accountReceivable");

			def holder = accountReceivableService.search(sparams);

			if (holder) {
				result.totalCount = holder.totalCount;
				result.list = [];

				holder.list?.each {
					def info = [:];

					// id
					//info.id = it.id;
					// 注文No
					info.orderNo = turnNull(it[0]);
					// 決済方法
					info.settlementMethodId = localSettingsService.getSettlementMethodName(turnNull(it[1]));
					settlementMethodId = it[1];
					//明細No
					info.detailNo = turnNull(it[2]);

					//入金日
					info.recieptDate = turnNull(it[3]);
					if(info.recieptDate){
						SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
						info.recieptDate = dft.format(it[3]);
					}
					//出荷日
					info.shippingDate = turnNull(it[4]);
					if(info.shippingDate){
						SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
						info.shippingDate = dft.format(it[4]);
					}
					// 注文受付日時
					info.orderDate = turnNull(it[5]);
					if(info.orderDate){
						SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
						info.orderDate = dft.format(it[5]);
					}
					// 合計金額
					if(settlementMethodId == "01") {
						info.totalAmount = turnZero(it[6]) * -1;
					}else {
						info.totalAmount = turnZero(it[6]);
					}

					// 注文明細リスト

					result.list << info;
				}
			}

		} catch (ex) {
			LogUtils.warn(log, ex);
		}
		
		render result as JSON;
	}
	
	

	// 一覧表示
	def list = {	
		
	}

	/**
	 * 検索パラメータの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setupSearchParams(params) {
		SearchParamUtils.setupSearchParams(session, 'SearchParams', params); // 検索パラメータの設定
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

}
