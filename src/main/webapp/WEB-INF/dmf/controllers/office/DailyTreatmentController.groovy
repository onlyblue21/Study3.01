package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils;
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.layoutlogic.util.TempFileUtil
import jp.co.reso.commons.file.FileUtils
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo

class DailyTreatmentController extends AbstractOrderItYourselfController {
	
	/**
	* デフォルトの日付フォーマット
	*/
	static final String DATE_FORMAT = "yyyy/MM/dd";
	def systemMasterService;
	def localSettingsService;
	def editFileService;
	def createCsvBankTransferRecieptListService;
	//　メニュー表示
	def index = {

	}
	// 当日入金一覧CSV作成の初期表示
	def bankTransferInitialView = {
		HttpUtils.nocache(response);
		def targetDay = new Date().format(DATE_FORMAT);
		flash.message = "";
		return [targetDay:targetDay, settlementMethod:OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER];
	}
	
	// 検索
	def search = {
		assert editFileService;
		assert localSettingsService;
		
		HttpUtils.nocache(response);
		def csvFileSetting;
		try{
			def settlementMethod = params.settlementMethod;
			switch (settlementMethod) {
				case OrderInfo.SETTLEMENT_METHOD_BANK_TRANSFER:
					csvFileSetting = localSettingsService.getCreateCsvBankTransferSettings();
					break;
				case OrderInfo.SETTLEMENT_METHOD_PAYMENT_ON_INVOICE:
					csvFileSetting = localSettingsService.getCreateCsvPaymentOnInvoiceSettings();
					break;
				case OrderInfo.SETTLEMENT_METHOD_CASH_ON_DELIVERY:
					csvFileSetting = localSettingsService.getCreateCsvCashOnDeliverySettings();
					break;
				default:
					break;
			}
		}catch(Exception e){
			return;
		}
		def filePath = csvFileSetting.path;
		def fileName = csvFileSetting.file;
		def listFiles = editFileService.listFiles(filePath,fileName);
		def filePathName;
		def result;
		if(listFiles.size()==0){
			
			fileName = "";
			result = [fileName:fileName,filePathName:filePathName];
			render result as JSON;
			return;
		}
		for (itt in listFiles){
			def file = itt.filePathName;
			filePathName = itt.filePathName.absolutePath;
		}
		result = [fileName:fileName,filePathName:filePathName];
		render result as JSON;
	}
	
	// ダウンロード
	def download = {
		HttpUtils.nocache(response);
		def targetDay = request.getParameter("targetDay");
		def fileName = request.getParameter("fileName");
		def filePathName = request.getParameter("filePathName");
		def settlementMethod = request.getParameter("settlementMethod");
		//editFileService.fileDownLoad(fileName,filePathName,response);
		if(fileName != null && !fileName.equals("")){
			try {
				def filepath = new File(filePathName);
				// ファイルの出力
				HttpUtils.output(request, response, 'application/octet-stream', fileName, filepath);
			} catch (ex) {
				LogUtils.error(log, message(code:"BA15E001") + '\n'+ex.message);
				flash.message = "エラーが発生しました。";
				return;
			} 
		}
		render(view:'bankTransferInitialView',model:[targetDay:targetDay,fileName:fileName,filePathName:filePathName,settlementMethod:settlementMethod]);
		
	}
	
	//　CSVファイルを作成
	def creatingCSVForm = {
		assert systemMasterService;
		assert createCsvBankTransferRecieptListService;
		def targetDay = request.getParameter("targetDay");
		def settlementMethod = request.getParameter("settlementMethod");
		try{
			def result = createCsvBankTransferRecieptListService.core([targetDay:targetDay, settlementMethod:settlementMethod]);
			if (result <= 0) {
				flash.message = "指定された日付に該当するデータがありません。";
			}
			else {
				flash.message = "当日入金一覧CSVファイルが作成されました。";
			}
		}catch(Exception e){
			LogUtils.error(log, message(code:"BA15E002") + '\n'+e.message);
			flash.message = "エラーが発生しました。";
		}
		render(view:'bankTransferInitialView',model:[targetDay:targetDay, settlementMethod:settlementMethod]);
		
	}
}
