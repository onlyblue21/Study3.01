package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.utils.LogUtils

class MonthlyTreatmentController extends AbstractOrderItYourselfController {

	static final String YEAR_FORMAT = "yyyy";
	static final String MONTH_FORMAT = "MM";
	def systemMasterService;
	def localSettingsService;
	def editFileService;
	def createCsvCreditCardSalesDataService;	
	
	//月
	def monothList(locale = null) {
		return ['01','02','03','04','05','06','07','08','09','10','11','12'];
	}
	//年
	def yearList(locale = null){
		int year = new Date().format(YEAR_FORMAT).asType(int) - 2;
		def yearList =[];
		for (int i=0;i<2;i++){
			year = year + 1;
			yearList << year;
		}
		return yearList;
	}
	
	//　メニュー表示
	def index = {
		
	}
	
	//クレジット売上げデータCSV作成の初期表示
	def creditsSalesInitialView = {
		//月
		def addMonthList = monothList();
		//年
		def addYearList = yearList();
		def month;
		def year;
		def today = new Date();
		use(org.codehaus.groovy.runtime.TimeCategory) {
			today -= 1.month;
			month = today.format(MONTH_FORMAT);
			year = today.format(YEAR_FORMAT);
		}
		
		return [addYearList:addYearList,
			addMonthList:addMonthList,year:year,month:month];
	}
	
	// 検索
	def search = {
		assert editFileService;
		assert localSettingsService;
		
		HttpUtils.nocache(response);
		def reportingDate = request.getParameter("reportingDate");
		def ret;
		try{
			ret = localSettingsService.getCreateCsvCreditCardSalesDataSettings();
		}catch(Exception e){
			return;
		}
		def filePath = ret.path;
		def fileName = ret.file;
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
		assert editFileService;
		assert localSettingsService;
		
		//月
		def addMonthList = monothList();
		//年
		def addYearList = yearList();
		def year = request.getParameter("year");
		def month = request.getParameter("month");
		def fileName = request.getParameter("fileName");
		def filePathName = request.getParameter("filePathName");
		if(fileName != null && !fileName.equals("")){
			try {
				def filepath = new File(filePathName);
				// ファイルの出力
				HttpUtils.output(request, response, 'application/octet-stream', fileName, filepath);
			} catch (ex) {
				LogUtils.error(log, message(code:"BA16E001") + '\n'+ex.message);
				flash.message = "エラーが発生しました。";
				return;
	
			}
		}
		render(view:'creditsSalesInitialView',model:[fileName:fileName,
			filePathName:filePathName,year:year,month:month,addMonthList:addMonthList,addYearList:addYearList]);
	}
	
	//　CSVファイルを作成
	def creatingCSVForm = {
		assert systemMasterService;
		assert createCsvCreditCardSalesDataService;
		//月
		def addMonthList = monothList();
		//年
		def addYearList = yearList();
		def year = request.getParameter("year");
		def month = request.getParameter("month");
		def targetBeginDate = year + "/" + month + "/01";
		try{
			def result = createCsvCreditCardSalesDataService.core([targetBeginDate:targetBeginDate]);
			if (result <= 0) {
				flash.message = "指定された年月に該当するデータがありません。";
			}
			else {
				flash.message = "クレジット売上げデータCSVファイルが作成されました。";
			}
		}catch(Exception e){
			LogUtils.error(log, message(code:"BA16E002") + '\n'+e.message);
			flash.message = "エラーが発生しました。";
			return;
		}
		render(view:'creditsSalesInitialView',model:[year:year,month:month,addMonthList:addMonthList,addYearList:addYearList]);
	}
}
