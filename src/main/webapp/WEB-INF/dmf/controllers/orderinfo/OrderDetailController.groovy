package jp.co.jpmd.oiy.dmolbiz.controllers.orderinfo

import grails.converters.JSON
import jp.co.reso.oiy.core.services.utils.ServiceUtils
import jp.co.reso.oiy.dmol.domain.user.UserGroup
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.dmol.services.LocalSettingsService
import jp.co.jpmd.oiy.dmolbiz.services.office.OrderDetailService;

import jp.co.reso.oiy.dmol.domain.item.ItemGenre;
import jp.co.reso.oiy.dmol.domain.mydata.MyProduct;
import jp.co.reso.oiy.dmol.domain.orderinfo.ExaminationStatus
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo;
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail;
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderStatus
import jp.co.reso.oiy.dmol.domain.orderinfo.SettlementStatus
import jp.co.reso.oiy.core.utils.LogUtils

class OrderDetailController extends AbstractOrderItYourselfController {

	def localSettingsService;
	def poiManagementService;
	def orderDetailService;
	def orderDetailStatusService
	def cancelRequestService
	
	//　郵便番号フォーマット
	def zipcode(destinationZipcode) {
		if(destinationZipcode != null && destinationZipcode.length() == 7){
			destinationZipcode = destinationZipcode.substring(0,3) + "-" + destinationZipcode.substring(3,7) ;
		}
		return destinationZipcode;
	}
    def show = {
		
		def self = this.currentUser(false);
		def role = "";
		def userGroup = self.userGroup;
		def deliveryorderUrl;// 差出票Url
		if (userGroup) {
			switch (userGroup.groupType) {
			case UserGroup.GROUP_TYPE_OFFICE:
				role = "office";
				deliveryorderUrl = "s17deliveryorder"
				break;
			case UserGroup.GROUP_TYPE_JPOST:
				role = "jpost";
				deliveryorderUrl = "jpdeliveryorder"
				break;
			case UserGroup.GROUP_TYPE_PRINT:
				role = "print";
				deliveryorderUrl = "p11deliveryorder"
				break;
			case UserGroup.GROUP_TYPE_JPMD:
				role = "office";
				deliveryorderUrl = "s17deliveryorder"
				break;
			case UserGroup.GROUP_TYPE_SYSTEM:
				role = "";
				deliveryorderUrl = ""
				break;
			default:
				role = "";
				deliveryorderUrl = ""
				break;
			}
		}
		if (params.id == "goBack"){
			def result = [:];
			if(session.getAttribute("controller")){
				def addList = session.getAttribute("controller");
				if (addList != null) {
					if(addList.addController.size == 1){
						session.removeAttribute("controller");
					}else{
						addList.addController.remove(addList.addController.size -1);
						addList.addAction.remove(addList.addAction.size -1);
						addList.addAction2.remove(addList.addAction2.size -1);
						session.removeAttribute("controller");
						session.setAttribute("controller",addList);
					}
				}
				result.result = "ok";
			}else{
				result.result = "ng";
			}
			render result as JSON;
		}
		else if (params.id == "goForward"){
			def result = [:];
			if(session.getAttribute("controller")){
				def addList = session.getAttribute("controller");
				if (addList != null) {
					addList.addController << "orderDetail";
					addList.addAction << "show";
					addList.addAction2 << session.getAttribute("orderDetailId");
					session.removeAttribute("orderDetailId");
					session.removeAttribute("controller");
					session.setAttribute("controller",addList);
				}
				result.result = "ok";
			}else{
				result.result = "ng";
			}
			render result as JSON;
		}
		//注文キャンセル
		// ・注文ステータスをキャンセルに変更
		// ・キャンセル時印刷ステータス変更 [2013.3.24 add]
		else if(params.id.split(",")[0]== "orderCancel"){
			def detailData = OrderDetail.findWhere(id:session.getAttribute("orderDetailId"));
			def detailData2 = detailData;
			def infoData = detailData.orderInfo;
			def infoDetailNo = infoData.orderNo + "-" + detailData.detailNo;

			//審査ステータス更新判定
			def withExaminationStatus;
			if(detailData.examinationStatus != OrderDetail.EXAMINATION_STATUS_NONE){
				//審査ステータスが "審査不要" 以外の場合は「キャンセル済み」へ更新
				withExaminationStatus = true;
			}else{
				withExaminationStatus = false;
			}
			
			//NP社電文連携 since 2015.05
			if (detailData.orderInfo?.settlementMethodId == OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE) {
				if (detailData.settlementStatus != OrderDetail.SETTLEMENT_STATUS_BILL_ENTRY_NG) {
					try {
						cancelRequestService.TransactionCancelRequest(detailData)
					}catch(ex) {
						flash.message = ex.message
						log.warn("orderDetail($detailData.id) NP電文処理エラー", ex)
					}
				}else{
					log.info("注文は請求書払いだが、決済ステータスが $detailData.settlementStatus の為行わない")
				}
			}
			
			// update detail
			try {
				detailData.orderStatus = OrderDetail.ORDER_STATUS_CANCELED;
				detailData.orderStatusUpdated = new Date();
				detailData.readyToOrderFlg = false;
				
				if(withExaminationStatus){
					detailData.examinationStatus = OrderDetail.EXAMINATION_STATUS_CANCELED;
					detailData.examinationStatusUpdated = new Date();
				}
				
				detailData.save(flush:true);
			}catch (ex) {
				if(detailData.hasErrors()){
					flash.message = "この注文明細が他の担当者に更新されたため、内容を確認して再実行ください。";
				}else{
					flash.message = "登録できませんでした。";
				}
				LogUtils.error(log, message(code:"BA03E001", args:['注文キャンセル',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}
			
			// 注文ステータス履歴の追加
			if(!orderDetailStatusService.updateOrderStatus(detailData)) {
				flash.message = "登録できませんでした。";
				LogUtils.error(log, message(code:"BA03E002", args:['注文キャンセル','注文ステータス',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}

			// 審査ステータス履歴追加
			if(withExaminationStatus) {
				if(!orderDetailStatusService.updateExaminationStatus(detailData)) {
					flash.message = "登録できませんでした。";
					LogUtils.error(log, message(code:"BA03E002", args:['注文キャンセル','審査ステータス',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
				}
			}
			
			def result = [:];
			result.result = "ok";
			render result as JSON;
		}
		//入金取消
		else if(params.id.split(",")[0]== "moneyCancel"){
			def detailData = OrderDetail.findWhere(id:session.getAttribute("orderDetailId"));
			def detailData2 = detailData;
			def infoData = detailData.orderInfo;
			def infoDetailNo = infoData.orderNo + "-" + detailData.detailNo;
			def orderInfo = detailData.orderInfo;
			try {
				//決済ステータス
				switch (infoData.settlementMethodId) {
					case OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER:
						// 銀行振り込み：未確認に戻す
						detailData.settlementStatus = OrderDetail.SETTLEMENT_STATUS_NONE;
						//決済ステータス変更日付：システム時間
						detailData.settlementStatusUpdated = new Date();
						//注文ステータス：決済中
						detailData.orderStatus = OrderDetail.ORDER_STATUS_IN_SETTLEMENT;
						//注文ステータス変更日付：システム時間
						detailData.orderStatusUpdated = detailData.settlementStatusUpdated;
						detailData.recieptDate = null;
						detailData.readyToOrderFlg = false;
						detailData.orderFixedDate = null;
						try {
							// 注文ステータス履歴の追加
							if(orderInfo.settlementMethodId == OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER){
								def historyOrder = new OrderStatus();
								historyOrder.orderDetail = detailData;
								historyOrder.orderStatus = detailData.orderStatus;
								historyOrder.statusUpdate = detailData.orderStatusUpdated;
								historyOrder.dateCreated = detailData.orderStatusUpdated;
								historyOrder.lastUpdated = detailData.orderStatusUpdated;
								historyOrder.save();
							}
						}catch (ex) {
							flash.message = "登録できませんでした。";
							LogUtils.error(log, message(code:"BA03E002", args:['入金取消','注文ステータス',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
						}
						break;
					case OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE:
						// 請求書決済：請求済に戻す
						detailData.settlementStatus = OrderDetail.SETTLEMENT_STATUS_BILL_ADDING;
						//決済ステータス変更日付：システム時間
						detailData.settlementStatusUpdated = new Date();
						//入金日をクリア
						detailData.recieptDate = null;
						break;
					case OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY:
						// 代金引換：未確認に戻す
						detailData.settlementStatus = OrderDetail.SETTLEMENT_STATUS_NONE;
						//決済ステータス変更日付：システム時間
						detailData.settlementStatusUpdated = new Date();
						//入金日をクリア
						detailData.recieptDate = null;
						break;
					default:
						break;
				}
				ServiceUtils.versionCheck(detailData2, params.id.split(",")[1], detailData, true);
				detailData.save(flush:true);
			}catch (ex) {
				if(detailData.hasErrors()){
					flash.message = "他の担当者に更新されたため、内容を再度確認してください。";
				}else{
					flash.message = "登録できませんでした。";
				}
				LogUtils.error(log, message(code:"BA03E001", args:['入金取消',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}
			
			try {
				// 決済ステータス履歴の追加
				def history = new SettlementStatus();
				history.orderDetail = detailData;
				history.settlementStatus = detailData.settlementStatus;
				history.statusUpdate = detailData.settlementStatusUpdated;
				history.dateCreated = detailData.settlementStatusUpdated;
				history.lastUpdated = detailData.settlementStatusUpdated;
				history.save();
			}catch (ex) {
				flash.message = "登録できませんでした。";
				LogUtils.error(log, message(code:"BA03E002", args:['入金取消','決済ステータス',infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}
			
			def result = [:];
			result.result = "ok";
			render result as JSON;
		}
		//審査OK
		else if(params.id.split(",")[0]== "OK"){
			def detailData = OrderDetail.findWhere(id:session.getAttribute("orderDetailId"));
			def orderInfo = detailData.orderInfo
			def updDate = new Date()
			try {
				detailData.examinationStatus = OrderDetail.EXAMINATION_STATUS_OK
				detailData.examinationStatusUpdated = updDate
				orderDetailStatusService.updateExaminationStatus(detailData)
				
				if(orderDetailStatusService.isSettlementCompleted(detailData, orderInfo)) {
					
					detailData.orderStatus = OrderDetail.ORDER_STATUS_ORDERED
					detailData.orderStatusUpdated = updDate
					orderDetailStatusService.updateOrderStatus(detailData)
					
					detailData.readyToOrderFlg = true
					detailData.orderFixedDate = updDate
				}
				
				detailData.save(flush:true)
			}catch (ex) {
				if(detailData.hasErrors()){
					flash.message = "他の担当者に更新されたため、内容を再度確認してください。";
				}else{
					flash.message = "登録できませんでした。";
				}
				LogUtils.error(log, message(code:"BA03E001", args:['審査OK',orderInfo.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}
			
			def result = [:];
			result.result = "ok";
			render result as JSON;
		}
		//審査NG & 保留への変更処理
		else if(params.id.split(",")[0] in ["NG1", "NG2", "HOLD"]){
			def actParam = params.id.split(",")[0]
			def ssval
			switch(actParam){
				case "NG1": ssval = OrderDetail.EXAMINATION_STATUS_NG_NOTIFY; break
				case "NG2": ssval = OrderDetail.EXAMINATION_STATUS_NG_NOT_NOTIFY; break
				case "HOLD": ssval = OrderDetail.EXAMINATION_STATUS_IN_RESERVATION; break
			}
			
			def detailData = OrderDetail.findWhere(id:session.getAttribute("orderDetailId"));
			def infoData = detailData.orderInfo;
			def updDate = new Date()
			try {
				detailData.examinationStatus = ssval
				detailData.examinationStatusUpdated = updDate
				orderDetailStatusService.updateExaminationStatus(detailData)
				
				detailData.readyToOrderFlg = false
				detailData.save(flush:true);
			}catch (ex) {
				if(detailData.hasErrors()){
					flash.message = "他の担当者に更新されたため、内容を再度確認してください。";
				}else{
					flash.message = "登録できませんでした。";
				}
				LogUtils.error(log, message(code:"BA03E001", args:[actParam, infoData.orderNo,detailData.detailNo]) + '\n'+ex.message);
			}
			
			def result = [:];
			result.result = "ok";
			render result as JSON;
		}
		else if(params.id.split(",")[0]== "ssBillOK"){
			this.doAuthority(OrderDetail.SETTLEMENT_STATUS_BILL_OK);
		}
		else if(params.id.split(",")[0]== "ssBillInCreditlimit"){
			this.doAuthority(OrderDetail.SETTLEMENT_STATUS_BILL_IN_CREDITLIMIT);
		}
		else if(params.id.split(",")[0]== "ssBillInExamination"){
			this.doAuthority(OrderDetail.SETTLEMENT_STATUS_BILL_IN_EXAMINATION);
		}
		else if(params.id.split(",")[0]== "ssBillInReservation"){
			this.doAuthority(OrderDetail.SETTLEMENT_STATUS_BILL_IN_RESERVATION);
		}
		else if(params.id.split(",")[0]== "ssBillNG"){
			this.doAuthority(OrderDetail.SETTLEMENT_STATUS_BILL_NG);
		}
		else{
			session.removeAttribute("orderDetailId");
			session.setAttribute("orderDetailId",params.id);

			//表示対象注文データ
			def orderData = orderDetailService.search(params.id);
			if(!orderData.existsData){
				flash.errormessage = "${message(code: 'default.not.found.message', args: [message(code: 'orderDetail.label', default: 'OrderDetail'), params.id])}"
			}
			OrderDetail od = orderData.orderDetailInstance;
			def oi = od.orderInfo;
			def odp = orderData.orderDetailInstancePlus;
			def trackingNumberSplit = orderData.trackingNumberSplit;
			
			// データ状態 alias
			def canceled = od.orderStatus == OrderDetail.ORDER_STATUS_CANCELED // 注文キャンセルされていない
			def isPoi = oi.settlementMethodId == OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE //決済方法が請求書払い
			def isCre = oi.settlementMethodId == OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD //決済方法がクレカ
			
			//ページ遷移情報の更新
			def addList = session.getAttribute("controller");
			def gControll = "";
			def gAction = "";
			def gAction2 = "";
			if (addList != null) {
				gControll = addList.addController[addList.addController.size - 1];
				gAction = addList.addAction[addList.addAction.size - 1];
				gAction2 = addList.addAction2[addList.addAction2.size - 1];
			}
			if(gAction2 != ""){
				gAction2 = "/" + gAction2;
			}

			//決済エラー ・・・請求書払い  | クレカのみ表示
			if(isPoi || isCre) {
				od.settlementError = od.settlementError?.replaceAll(/\||\//) {it == '|'? '<br>': ':'}
			}else{
				od.settlementError = null
			}
	
			//ステータス変更ボタン情報
			def buttonDisplay = [:];
			buttonDisplay.searchDetailNo = oi.orderNo + "-" + od.detailNo;
			buttonDisplay.isFuTai = od.serviceDivision == OrderDetail.SERVICE_DIVISION_FUTAI
			//「注文キャンセル」 ボタン表示条件
			buttonDisplay.cancel = od.orderStatus != OrderDetail.ORDER_STATUS_CANCELED // 注文キャンセルされていない
			if (isPoi) {
				buttonDisplay.cancel = buttonDisplay.cancel && od.settlementStatus >= OrderDetail.SETTLEMENT_STATUS_BILL_ENTRY_NG // 請求書払いは、取引登録が済んでいる
			}
			//「審査XXボタン」群の表示条件
			def fromAdReview = "adReview" in (addList?.addController?:[]) //1.広告審査画面からの遷移時に限る
			def notPrinted = od.printStatus == 0 //2.印刷ステータス 0(未設定) に限る
			// 審査OK
			buttonDisplay.esOK = !canceled && fromAdReview && notPrinted &&
				od.examinationStatus in [OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION
											, OrderDetail.EXAMINATION_STATUS_NG_NOTIFY
											, OrderDetail.EXAMINATION_STATUS_NG_NOT_NOTIFY
											, OrderDetail.EXAMINATION_STATUS_IN_RESERVATION]
			// 審査保留
			buttonDisplay.esInReservation = !canceled && fromAdReview && notPrinted && 
				od.examinationStatus in [OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION
											, OrderDetail.EXAMINATION_STATUS_OK
											, OrderDetail.EXAMINATION_STATUS_NG_NOTIFY
											, OrderDetail.EXAMINATION_STATUS_NG_NOT_NOTIFY]
			// 審査NG(通知不要)
			buttonDisplay.esNGNotNotify = !canceled && fromAdReview && notPrinted && 
				od.examinationStatus in [OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION
											, OrderDetail.EXAMINATION_STATUS_OK
											, OrderDetail.EXAMINATION_STATUS_NG_NOTIFY
											, OrderDetail.EXAMINATION_STATUS_IN_RESERVATION]
			// 審査NG(通知要)
			buttonDisplay.esNGNotify = !canceled && fromAdReview && notPrinted &&
				od.examinationStatus in [OrderDetail.EXAMINATION_STATUS_IN_EXAMINATION
											, OrderDetail.EXAMINATION_STATUS_OK
											, OrderDetail.EXAMINATION_STATUS_NG_NOT_NOTIFY
											, OrderDetail.EXAMINATION_STATUS_IN_RESERVATION]
	
			// 「審査用帳票再印刷」ボタン：「未審査」、「不要」以外の状態
			buttonDisplay.examinationPrint = fromAdReview && 
				od.examinationStatus !=OrderDetail.EXAMINATION_STATUS_NONE &&
				od.examinationStatus !=OrderDetail.EXAMINATION_STATUS_NO_EXAMINATION

			//OrderDetail#myProduct#pageCount
			//pageCount
			def productMine = od.myProduct;
			//サムネイルページ数
			def myPic = [];
			if(productMine){
				if(productMine.pageCount){
					if(productMine.pageCount && productMine.pageCount != 0){
						for(int i = 1;i<=productMine.pageCount;i++){
							myPic << i;
						}
					}
				}
			}
			[orderDetailInstance: od, orderDetailInstancePlus:odp, detailId:params.id
				,gControll:gControll, gAction:gAction, gAction2:gAction2
				, buttonDisplay:buttonDisplay, role:role
				, trackingNumberSplit:trackingNumberSplit, myPic:myPic
				, deliveryorderUrl:deliveryorderUrl]
		}
    }
	/**
	 * 注文ステータス画面：表示アクション
	 */
	def status = {
		if(params.id == "goBack"){
			def result = [:];
			if(session.getAttribute("controller")){
				def addList = session.getAttribute("controller");
				if (addList != null) {
					if(addList.addController.size == 1){
						session.removeAttribute("controller");
					}else{
						addList.addController.remove(addList.addController.size -1);
						addList.addAction.remove(addList.addAction.size -1);
						addList.addAction2.remove(addList.addAction2.size -1);
						session.removeAttribute("controller");
						session.setAttribute("controller",addList);
					}
				}
				result.result = "ok";
			}else{
				result.result = "ng";
			}
			render result as JSON;
		}else{
			def self = this.currentUser(false);
			def role = "";
			def userGroup = self.userGroup;
			if (userGroup) {
				switch (userGroup.groupType) {
				case UserGroup.GROUP_TYPE_OFFICE:
					role = "office";
					break;
				case UserGroup.GROUP_TYPE_JPOST:
					role = "jpost";
					break;
				case UserGroup.GROUP_TYPE_PRINT:
					role = "print";
					break;
				case UserGroup.GROUP_TYPE_JPMD:
					role = "";
					break;
				case UserGroup.GROUP_TYPE_SYSTEM:
					role = "";
					break;
				default:
					role = "";
					break;
				}
			}
			def orderDetailInstance = OrderDetail.get(params.id)
			if (!orderDetailInstance) {
				orderDetailInstance = new OrderDetail()
				orderDetailInstance.orderInfo = new OrderInfo()
				flash.errormessage = "${message(code: 'default.not.found.message', args: [message(code: 'orderDetail.label', default: 'OrderDetail'), params.id])}"
				LogUtils.info(log, e);
				return;
			}
		
			// 注文ステータス
			def orderStatusInstanceList = orderDetailInstance.orderStatusList
			List orderStatusNameList = new ArrayList();
			for(int i=0;i<orderStatusInstanceList.orderStatus.size();i++) {
				def name = localSettingsService.getOrderStatusName(orderStatusInstanceList.orderStatus[i])
				orderStatusNameList.add(name)
			}
			
			// 決済ステータス
			def settlementStatusInstanceList = orderDetailInstance.settlementStatusList
			List settlementStatusNameList = new ArrayList();
			for(int i=0;i<settlementStatusInstanceList.settlementStatus.size();i++) {
				switch(orderDetailInstance.orderInfo.settlementMethodId) {
					case OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER:
						settlementStatusNameList.add(localSettingsService.getSettlementStatusBankName(settlementStatusInstanceList.settlementStatus[i]));
						break;
					case OrderInfo.SETTLEMENT_METHOD_CREDIT_CARD:
						settlementStatusNameList.add(localSettingsService.getSettlementStatusCreditName(settlementStatusInstanceList.settlementStatus[i]));
						break;
					case OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY:
						settlementStatusNameList.add(localSettingsService.getSettlementStatusCodName(settlementStatusInstanceList.settlementStatus[i]));
						break;
					case OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE:
						settlementStatusNameList.add(localSettingsService.getSettlementStatusPoiName(settlementStatusInstanceList.settlementStatus[i]));
						break;
					default:
						settlementStatusNameList.add("");
				}
			}
	
			// 審査ステータス
			def examinationStatusInstanceList = orderDetailInstance.examinationStatusList
			List examinationStatusNameList = new ArrayList();
			for(int i=0;i<examinationStatusInstanceList.examinationStatus.size();i++) {
				def name = localSettingsService.getExaminationStatusName(examinationStatusInstanceList.examinationStatus[i])
				examinationStatusNameList.add(name)
			}
	
			// 印刷ステータス
			def printStatusInstanceList = orderDetailInstance.printStatusList
			List printStatusNameList = new ArrayList();
			for(int i=0;i<printStatusInstanceList.printStatus.size();i++) {
				def name = localSettingsService.getPrintStatusName(printStatusInstanceList.printStatus[i])
				printStatusNameList.add(name)
			}
	
			// 戻り先設定
			def addList = session.getAttribute("controller");
			def gControll = "";
			def gAction = "";
			def gAction2 = "";
			if (addList != null) {
				gControll = addList.addController[addList.addController.size - 1];
				gAction = addList.addAction[addList.addAction.size - 1];
				gAction2 = addList.addAction2[addList.addAction2.size - 1];
			}
			if(gAction2 != ""){
				gAction2 = "/" + gAction2;
			}
			
			[orderInfoData: orderDetailInstance.orderInfo,
				orderStatusInstanceList: orderStatusInstanceList,
				orderStatusNameList: orderStatusNameList,
				settlementStatusInstanceList: settlementStatusInstanceList,
				settlementStatusNameList: settlementStatusNameList,
				examinationStatusInstanceList: examinationStatusInstanceList,
				examinationStatusNameList: examinationStatusNameList,
				printStatusInstanceList: printStatusInstanceList,
				printStatusNameList: printStatusNameList,
				gControll:gControll,
				gAction:gAction,
				gAction2:gAction2,
				role:role
				]
		}
	}

	private doAuthority(int authCD) {
		def detail = OrderDetail.findWhere(id:session.getAttribute("orderDetailId"));
		def result = [:];
		def error = poiManagementService.doAuthorityCommon(detail, authCD, true);
		if (error!=null) {
			result.message = error;
			result.result = "ng";
		}
		else {
			result.result = "ok";
		}
		render result as JSON;
	}
}
