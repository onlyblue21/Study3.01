package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON

import java.util.List
import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

//import jp.co.reso.logic.laml.GLAMLTool
import jp.co.reso.layoutlogic.util.TempFileUtil;
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.system.TagData
import jp.co.reso.oiy.core.domain.user.Role
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.exception.NLMExitControllerException
import jp.co.reso.oiy.core.utils.ContentTypeUtils
import jp.co.reso.oiy.core.utils.ConvertUtils
import jp.co.reso.oiy.core.utils.DateUtils
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.dmol.domain.user.User
import jp.co.reso.oiy.dmol.domain.user.UserGroup

import org.codehaus.groovy.grails.commons.GrailsApplication

import jp.co.reso.oiy.dmol.domain.item.ItemGenre;
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail
import jp.co.jpmd.oiy.dmolbiz.service.office.*
import jp.co.jpmd.oiy.dmolbiz.services.office.CreateXlsRecievedOrderService

class RecievedOrderController extends AbstractOrderItYourselfController {

	/** grailsApplication */
	GrailsApplication grailsApplication;

	def localSettingsService;
	def recievedOrderService;
	/** ロールを操作するサービス */
	def roleService;
	/** アイテム区分を操作するサービス */
	def itemGenreService;
	def createXlsRecievedOrderService;

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
		def items = [] as grails.converters.JSON;
		log.debug("reqparams=$params")

		if(session.getAttribute("para") && session.getAttribute("myPage") == "recievedOrder"){
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
			//params.orderStatus = para.orderStatus;
			//第三期 2012/03/16 by A&I Start
			// 決済中
			params.isSettlemented = checkTF(para.isSettlemented);
			//注文済
			params.isPreOrder = checkTF(para.isPreOrder);
			//印刷中
			params.isPrinting = checkTF(para.isPrinting);
			//出荷済み
			params.isShipmented = checkTF(para.isShipmented);
			//キャンセル済み
			params.isCanceled=checkTF(para.isCanceled);
			//第三期 2012/03/16 by A&I End
			// 審査ステータス
			params.examinationStatus = para.examinationStatus;
			// 印刷ステータス
			params.printStatus = para.printStatus;
			// ソート順
			params.sortKey = para.sortKey;
			params.sortOrder = para.sortOrder;
			// 自動検索
			params.autoSearch = "true";
			params.offset = para.offset;
			// 日付検索
			params.dateGroup = para.dateGroup;
			params.dateFilterType = para.dateFilterType;
			// ステータス更新日
			params.statusUpdDateFrom = para.statusUpdDateFrom;
			params.statusUpdDateTo = para.statusUpdDateTo;
			// アイテム
			params.itemGenre = (java.util.List)para.itemGenre;

			def itemList = [];
			session.getAttribute("excludeDlItems").each {
				itemList.add(it);
			}
			items = itemList as grails.converters.JSON;
			// 検索モード
			params.searchMode = para.searchMode;
		}
		else{
			session.removeAttribute("controller");
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			params.dateFilterType = "0";
			params.orderDateFrom = new Date().format(ConvertUtils.DEFAULT_DATE_FORMAT);
			params.orderDateTo = params.orderDateFrom;
			params.statusUpdDateFrom = params.orderDateFrom;
			params.statusUpdDateTo = params.orderDateFrom;
			// ソート順
			params.sortKey = "orderDate";
			params.sortOrder = "desc";
			// 決済中
			params.isSettlemented = "true";
			//注文済
			params.isPreOrder = "true";
			//印刷中
			params.isPrinting = "true";
			//出荷済み
			params.isShipmented = "true";
			//キャンセル済み
			params.isCanceled = "true";
			//検索モード
			params.searchMode = "0";
		}
		def self = userService.getSelf();
		def role = "";
		def userGroup = self.userGroup;
		if (userGroup) {
			role = getRole(userGroup.groupType)
		}
		def user  = User.findById(self.id);
		def roleData = user.role
		session.setAttribute("authorities", roleData.authorities);
		//createLink controller='toDmfApplication' action='s17thumbnail'
		def thumbnailAction;
		def previewpdfAction;
		def showUserAction;
		switch(role){
			case "office":
			thumbnailAction = "s17thumbnail";
			previewpdfAction = "s17previewpdf";
			showUserAction = "s3s13";
			break
			case "jpmd":
			thumbnailAction = "s17thumbnail";
			previewpdfAction = "s17previewpdf";
			showUserAction = "s3s13";
			break
			case "print":
			thumbnailAction = "p11thumbnail";
			previewpdfAction = "p11previewpdf";
			showUserAction = "p3p13";
			break
			case "jpost":
			thumbnailAction = "jpthumbnail";
			previewpdfAction = "jppreviewpdf";
			showUserAction = "jpedituser";
			break
			default:
			thumbnailAction = "";
			previewpdfAction = "";
		}
		def result = [
			'settlementStatusCreditList':localSettingsService.settlementStatusCreditList(),
			'settlementStatusBankList':localSettingsService.settlementStatusBankList(),
			'settlementStatusCodList':localSettingsService.settlementStatusCodList(),
			'settlementStatusPoiList':localSettingsService.settlementStatusPoiList(),
			'examinationStatusList':localSettingsService.examinationStatusList(),
			'printStatusList':localSettingsService.printStatusList(),
			'role':role
			, 'thumbnailAction':thumbnailAction
			, 'previewpdfAction':previewpdfAction
			, 'showUserAction':showUserAction
			, 'itemGenreList':listAllItemGenres()
			, 'excludeDlItemList':items];
	}
	def test = {
		def addList = [:];
		addList.addController = [];
		addList.addAction = [];
		addList.addAction2 = [];
		addList.addController << "recievedOrder";
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
	/**
	 * アイテム区分のリストを取得します。
	 * @param serviceDivision サービス区分
	 */
	private listAllItemGenres() {
		return ItemGenre.findAll("from ${ItemGenre.class.name} as genre where genre.serviceDivision != 9999 order by genre.dispOrder, genre.genreId");
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

		assert recievedOrderService;
		log.debug("reqParams=$params")

		HttpUtils.nocache(response);
		def self = userService.getSelf();
		def role = "";
		def userGroup = self.userGroup;
		if (userGroup) {
			role = getRole(userGroup.groupType)
		}
		def result = [offset:params.offset, list:null, totalCount:0,params:params,sumTotalAmount:0];
		result.role = role;
		try {
			def sparams = [offset:params.offset, max:params.pageMax, sortKey:params.sortKey, sortOrder:params.sortOrder];
			// 注文No
			sparams.orderNo = params.orderNo.replace("'","''").replace("%","[%]");
			// 日付検索タイプ
			sparams.dateFilterType = params.dateFilterType;
			// 注文日From
			sparams.orderDateFrom = params.orderDateFrom.replace("'","''").replace("%","[%]");
			// 注文日To
			sparams.orderDateTo = params.orderDateTo.replace("'","''").replace("%","[%]");
			// ST更新日From
			sparams.statusUpdDateFrom = params.statusUpdDateFrom.replace("'","''").replace("%","[%]");
			// ST更新日To
			sparams.statusUpdDateTo = params.statusUpdDateTo.replace("'","''").replace("%","[%]");
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
			if(role !="print"){
				// 決済方法：クレジットカード
				sparams.settlementMethodCredit = params.settlementMethodCredit
				// 決済ステータス：クレジットカード
				sparams.settlementStatusCredit = params.list('settlementStatusCredit[]')
				// 決済方法：銀行振込
				sparams.settlementMethodBank = params.settlementMethodBank;
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
				// 注文ステータス
				//sparams.orderStatus = params.orderStatus.replace("'","''").replace("%","[%]");
				//第三期 2012/03/16 by A&I Start
				// 決済中
				sparams.isSettlemented = params.isSettlemented;
				//注文済
				sparams.isPreOrder = params.isPreOrder;
				//印刷中
				sparams.isPrinting = params.isPrinting;
				//出荷済み
				sparams.isShipmented = params.isShipmented;
				//キャンセル済み
				sparams.isCanceled=params.isCanceled;
				//第三期 2012/03/16 by A&I End
				// 審査ステータス
				sparams.examinationStatus = params.list('examinationStatus[]')
				
			}
			// サービス区分：DMオンライン
			sparams.serviceDivisionDMOnline = params.serviceDivisionDMOnline;
			// サービス区分：オリジナル年賀
			sparams.serviceDivisionNewYearCard = params.serviceDivisionNewYearCard;
			// サービス区分：オリジナルかもめ～る
			sparams.serviceDivisionKamoMail = params.serviceDivisionKamoMail;
			// 付帯サービス
			sparams.serviceDivisionFuTai = params.serviceDivisionFuTai;
			// 印刷ステータス
			sparams.printStatus = params.list('printStatus[]')
			// アイテム 
			//def itemCount = Integer.decode(params.itemGenreCount);
			//if(itemCount < 1){
			//	sparams.itemGenre = [];
			//}else if(itemCount == 1){
			//	sparams.itemGenre = [];
			//	sparams.itemGenre << params.'itemGenre[]';
			//}else{
			//	sparams.itemGenre = params['itemGenre[]'];
			//}
			sparams.itemGenre = params.list('itemGenre[]')
			// 検索モード
			sparams.searchMode = params.searchMode;
			
			sparams.search = true;
			sparams.role=role;
			this.setupSearchParams(sparams);
			def holder = recievedOrderService.search(sparams);
			session.removeAttribute("para");
			session.removeAttribute("myPage");
			session.setAttribute("para",sparams);
			session.setAttribute("myPage","recievedOrder");
			if (holder) {
				
				result.totalCount = holder.totalCount;
				result.sumTotalAmount = holder.sumTotalAmount;
				result.list = [];
				def mySettlementMethodId = "";
				// option service info
				def optionList = localSettingsService.listOptionService();
				def townsendList = localSettingsService.listOptionTownSend(optionList);
				SimpleDateFormat dft = new SimpleDateFormat("yyyy/MM/dd");
				SimpleDateFormat dftMd = new SimpleDateFormat("M/d");
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
						info.orderDate = dft.format(it.orderDate);
					}
					// 更新日
					if(it.lastUpdated){
						info.lastUpdated = dft.format(it.lastUpdated)
					}else{
						info.lastUpdated = ''
					}
					
					// ご注文者
					info.name = turnNull(it.familyName) + "　" + turnNull(it.firstName);
					// E-Mail
					info.email = turnNull(it.email);
					// 電話番号
					info.telno = turnNull(it.telno);
					// 送付先住所
					info.destinationAddressState = turnNull(it.destinationAddressState);
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
							detail.printStatusOrg = it.printStatus;
							detail.trackingNumber = it.trackingNumber;
							
							// 宛名
							detail.addressPrintFlg = it.addressPrintFlg;
							detail.addressPrintQuantity = it.addressPrintQuantity;
							// 差出
							detail.postingProxyFlg = it.postingProxyFlg;
							detail.postingProxyQuantity = it.postingProxyQuantity;
							if(!it.postingProxyFlg){
								//   タウン差出を加味    //***2013.05 hiro@4t add
								def townPostingProxyQty = 0.0G;
								townsendList.each { op ->
									(1..5).each { num ->
										// check id
										if(it?.getProperty("optionId"+num) == op.graphicOptionId){
											townPostingProxyQty += ConvertUtils.toBigDecimal(
												it?.getProperty("optionQuantity"+num), 0.0G);
										}
									}
								}
								if(townPostingProxyQty){
									detail.postingProxyFlg = true;
									detail.postingProxyQuantity = townPostingProxyQty; 
								}								
							}
							// ST更新日
							detail.orderStatusUpdated = turnNull(it.orderStatusUpdated);
							if(detail.orderStatusUpdated){
								detail.orderStatusUpdated = dftMd.format(it.orderStatusUpdated);
							}
							detail.printStatusUpdated = turnNull(it.printStatusUpdated);
							if(detail.printStatusUpdated){
								detail.printStatusUpdated = dftMd.format(it.printStatusUpdated);
							}
							detail.settlementStatusUpdated = turnNull(it.settlementStatusUpdated);
							if(detail.settlementStatusUpdated){
								detail.settlementStatusUpdated = dftMd.format(it.settlementStatusUpdated);
							}
							detail.examinationStatusUpdated = turnNull(it.examinationStatusUpdated);
							if(detail.examinationStatusUpdated){
								detail.examinationStatusUpdated = dftMd.format(it.examinationStatusUpdated);
							}
							// アイテム名称
							def iGenre;
							if(it.itemGenreId){
								iGenre = ItemGenre.findByGenreId(it.itemGenreId);
								detail.itemGenreName = turnNull(iGenre?.genreName);
							}else{
								detail.itemGenreName = '';
							}
							// サムネ件数
							detail.thumbnailCount = turnZero(it.myProduct?.pageCount);
							
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

	private String getRole(String userGroupType) {
		String role;
		switch (userGroupType) {
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
				role = "office";
				break;
			case UserGroup.GROUP_TYPE_SYSTEM:
				role = "office";
				break;
			default:
				role = "office";
				break;
		}
		return role
	}
	//　郵便番号フォーマット
	def zipcode(destinationZipcode) {
		if(destinationZipcode != null && destinationZipcode.length() == 7){
			destinationZipcode = destinationZipcode.substring(0,3) + "-" + destinationZipcode.substring(3,7) ;
		}
		return destinationZipcode;
	}
	
	def fileDownload(url){
	}

	private List getExcludeDlItemData(){
		List items;
		def itemCount = Integer.decode(turnZero(params.excludeDlItemssCount));
		if(itemCount > 1){
			items = params['excludeDlItems[]'];
		}else if(itemCount == 1){
			items = [];
			items.add(params['excludeDlItems[]']);
		}else{
			items = [];
		}
		
		return items
	}
	// 明細出力対象外Id保存
	def saveExcludeDlItem = {
		def items;
		//除外設定の受取
		items = this.getExcludeDlItemData();
		
		//update session
		session.removeAttribute("excludeDlItems");
		session.setAttribute("excludeDlItems", items);
		
		def result = [result:"OK"];
		render result as JSON;
	}

	def downloadDetailData ={
		HttpUtils.nocache(response);
		
		//対象OrderDetailのIdを取得
		def spara = session.getAttribute("para");
		def roleAuthorities = session.getAttribute("authorities");
		def tarIds = recievedOrderService.searchAll(spara);
		//除外設定の受取
		def excludeIds = [];
		session.getAttribute("excludeDlItems").each {
			excludeIds.add(it);
		}
		//明細ふぁいるのTemplateふぁいる
		def templateFile = systemMasterService.getResourceFile("template", "orderDetailTemplate.xlsx");
		//出力するTemporaryファイル
		def outFile = TempFileUtil.createTempFile("odl_download", ".xlsx");

		//明細ファイル作成
		def param = [targetDetailIds:tarIds
						, excludeIds:excludeIds
						, template:templateFile
						, outpath:outFile
						,role:roleAuthorities];
		createXlsRecievedOrderService.core(param);

		//★エラー処理		
		//LogUtils.warn(log, ex);
		//flash.message = "エラーが発生しました。";
		//render(text:flash.message, contentType:'text/plain', encoding:'UTF-8');

		//reply
		//HttpUtils.output(request, response, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', "注文明細票.xlsx", outFile);
		HttpUtils.output(request, response, 'application/octet-stream', "注文明細票.xlsx", outFile);
	}
	
	def downloadDetailDataCsv ={
		HttpUtils.nocache(response);
		SimpleDateFormat dateFomat = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat dft = new SimpleDateFormat("yyyyMMddHHmmss");
		//対象OrderDetailのIdを取得
		def spara = session.getAttribute("para");
		def roleAuthorities = session.getAttribute("authorities");
		def tarIds = recievedOrderService.searchAll(spara);
		//除外設定の受取
		def excludeIds = [];
		session.getAttribute("excludeDlItems").each {
			excludeIds.add(it);
		}
		//明細ふぁいるのTemplateふぁいる
		def templateFile = TempFileUtil.createTempFile("orderInfo", ".csv")
		//出力するTemporaryファイル
		def outFile = TempFileUtil.createTempFile("odl_download", ".xlsx");

		//明細ファイル作成
		def param = [targetDetailIds:tarIds
						, excludeIds:excludeIds
						, template:templateFile
						, outpath:outFile
						,role:roleAuthorities];


		//★エラー処理
		try {
		createXlsRecievedOrderService.coreCsv(param);
			
			// ファイルの出力
			def titleDate  = dft.format(new Date());
			String tilleStr = "OrderInfo_" +  titleDate.toString() + ".csv";
			HttpUtils.output(request, response, 'application/octet-stream', tilleStr, templateFile);
		} catch (Exception e) {
			log.warn("明細ダウンロードに失敗しました", e);
		}
	}
	/**
	 * 検索パラメータの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setupSearchParams(params) {
		SearchParamUtils.setupSearchParams(session, 'SearchParams', params); // 検索パラメータの設定
	}
}
