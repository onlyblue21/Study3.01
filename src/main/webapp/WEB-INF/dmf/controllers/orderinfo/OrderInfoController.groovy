package jp.co.jpmd.oiy.dmolbiz.controllers.orderinfo

import grails.converters.JSON
import jp.co.reso.oiy.dmol.domain.user.UserGroup
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo

class OrderInfoController extends AbstractOrderItYourselfController {
	def localSettingsService;
	def show = {
		
		def self = userService.getSelf();
		def role = "";
		def userGroup = self.userGroup;
		if (userGroup) {
			switch (userGroup.groupType) {
			case UserGroup.GROUP_TYPE_OFFICE:
				role = "office";
				break;
			case UserGroup.GROUP_TYPE_JPOST:
				role = "office";
				break;
			case UserGroup.GROUP_TYPE_PRINT:
				role = "print";
				break;
			case UserGroup.GROUP_TYPE_JPMD:
				role = "office";
				break;
			case UserGroup.GROUP_TYPE_SYSTEM:
				role = "office";
				break;
			default:
				role = "office";
				break;
			}
		}
		if (params.id == "goForward"){
			def result = [:];
			if(session.getAttribute("controller")){
				def addList = session.getAttribute("controller");
				addList.addController << "orderInfo";
				addList.addAction << "show";
				addList.addAction2 << session.getAttribute("infoID");
				session.removeAttribute("infoID");
				session.removeAttribute("controller");
				session.setAttribute("controller",addList);
				
				result.result = "ok";
			}else{
				result.result = "ng";
			}
			render result as JSON;
		}
		else if (params.id == "goBack"){
			def result = [:];
			if(session.getAttribute("controller")){
				def addList = session.getAttribute("controller");
				if (addList == null) {
					result.result = "ng";
				}
				else {
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
		else{
			def orderInfoInstance = OrderInfo.get(params.id);
			session.setAttribute("infoID",params.id);
			if (!orderInfoInstance) {
				orderInfoInstance = new OrderInfo()
				flash.errormessage = "${message(code: 'default.not.found.message', args: [message(code: 'orderInfo.label', default: 'OrderInfo'), params.id])}"
			}
			def orderInfoInstancePlus = [:];
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
			orderInfoInstance.zipcode = zipcode(orderInfoInstance.zipcode);
			orderInfoInstancePlus.settlementMethodName = localSettingsService.getSettlementMethodName(orderInfoInstance.settlementMethodId);
			[orderInfoInstance: orderInfoInstance, orderInfoInstancePlus: orderInfoInstancePlus,gControll:gControll,gAction:gAction,role:role]
		}
	}
	
	/**
	 * 送付先編集：入力画面表示
	 */
	def edit = {
		assert localSettingsService;


		// 注文情報取得
		def orderInfoInstance = OrderInfo.get(params.id)
		if (!orderInfoInstance) {
			flash.errormessage = "${message(code: 'default.not.found.message', args: [message(code: 'orderInfo.label', default: 'OrderInfo'), params.id])}"
		} else {
			// 戻り先設定
			def addList = session.getAttribute("controller");
			def gControll = addList?.addController[addList.addController.size - 1]?:'';
			def gAction = addList?.addAction[addList.addAction.size - 1]?:'';

			return [
				orderInfoInstance: orderInfoInstance,
				'stateList': localSettingsService.listAddressState(),
				'destinationStateId': localSettingsService.getAddressStateId(orderInfoInstance.destinationAddressState),
				gControll:gControll,
				gAction:gAction
				]
		}
	}

	/**
	 * 送付先更新処理
	 */
	def updateInfo = {
		assert localSettingsService;
		def orderInfoInstance = OrderInfo.get(params.id)
		try {
			def version = params.version.toLong()
			if (orderInfoInstance.version > version) {
					// エラー：データの更新重複
					flash.errormessage = "送付先情報更新処理中にエラーが発生しました。";
					render(view: "edit", model: [orderInfoInstance: orderInfoInstance,
						'stateList': localSettingsService.listAddressState(),
						'destinationStateId': localSettingsService.getAddressStateId(orderInfoInstance.destinationAddressState)])
					return
			}
			params.destinationAddressState = localSettingsService.getAddressStateName(params.destinationAddressStateCode)
			orderInfoInstance.properties = params
			orderInfoInstance.save(flush: true)
			
			redirect(controller:'recievedOrder',action:'index')
		} catch (Exception ex) {
			LogUtils.error(log, message(code:"BA04E001", args:[orderInfoInstance.orderNo]) + '\n'+ex.message);
			flash.errormessage = "更新処理中にエラーが発生しました。";
			return;
		}
	}
	//　郵便番号フォーマット
	def zipcode(destinationZipcode) {
		if(destinationZipcode != null && destinationZipcode.length() == 7){
			destinationZipcode = destinationZipcode.substring(0,3) + "-" + destinationZipcode.substring(3,7) ;
		}
		return destinationZipcode;
	}
	/**
	* 送付先編集：入力画面表示
	*/
	def view = {
		assert localSettingsService;

		// 注文情報取得
		def orderInfoInstance = OrderInfo.get(params.id)
		if (!orderInfoInstance) {
			flash.errormessage = "${message(code: 'default.not.found.message', args: [message(code: 'orderInfo.label', default: 'OrderInfo'), params.id])}"
		} else {
			// 戻り先設定
			def addList = session.getAttribute("controller");
			def gControll = addList?.addController[addList.addController.size - 1]?:'';
			def gAction = addList?.addAction[addList.addAction.size - 1]?:'';
			
			return [
				orderInfoInstance: orderInfoInstance,
				gControll:gControll,
				gAction:gAction]
		}
	}
}
