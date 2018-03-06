package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.dmol.domain.jpost.JpostSalesBranch
import jp.co.reso.oiy.dmol.domain.jpost.JpostDivision
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.core.utils.ConvertUtils
import jp.co.reso.layoutlogic.util.TempFileUtil;
//import jp.co.jpmd.oiy.dmolbiz.services.office.CreateXlsDMFService;

class PerformanceAggregateController extends AbstractOrderItYourselfController {

	//年のフォーマット
	static final String YEAR_FORMAT = "yyyy";
	//月のフォーマット
	static final String MONTH_FORMAT = "MM";
	//日報
	static final String DAILY_REPORT = "daily";
	//月報
	static final String MONTHLY_REPORT = "monthly";
	//事務局ユーザ
	static final String ROLE_OFFICE_USER = "ROLE_OFFICE_USER";
	//支店ユーザ
	static final String ROLE_JPOST_BRANCH_USER = "ROLE_JPOST_BRANCH_USER";
	//支社ユーザ
	static final String ROLE_JPOST_REGIONAL_USER = "ROLE_JPOST_REGIONAL_USER";
	// 支店のラジオボタン
	static final String BRANCH = "Branch";
	// 支社・本社
	static final String BRANCHOFFICE = "BranchOffice";
		
	def systemMasterService;
	def recievedOrderService;
	def localSettingsService;
	def editFileService;
	def branchSearchService;
	def createXlsDMFService;
	
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
	
	//支社リスト
	def jpostDivision = {
		def jpostDivision = JpostDivision.list();
		def codeList = [];
		for (itt in jpostDivision){
			if (itt.divisionId == '019000') continue; //本社を除外
			def ret = [:]
			ret.id = itt.divisionId;
			ret.name = itt.divisionName;
			codeList << ret;
		}
		return codeList;		
	}
	
	def index = {
		//ログインユーザがＪＰ本社かどうか判断用
		def self = null;
		self = this.currentUser(false);
		def roleFlag = self.role.roleId;
		return [roleFlag:roleFlag] 
	}
	
	//実績集計初期表示
	def performanceInitialView = {
		
		HttpUtils.nocache(response);
		
		setPathFile2Session("", "");
		params.orderDateFrom = new Date().format(ConvertUtils.DEFAULT_DATE_FORMAT);
		params.orderDateTo = new Date().format(ConvertUtils.DEFAULT_DATE_FORMAT);
		// 支社リスト
		def codeList = jpostDivision();
		//　遷移元IDを取得
		
		// 支社、本社向けのラジオボタン
		def radioSelect;
		def self = null;
		//ログイン中のユーザ情報の取得
		self = this.currentUser(false);
		//JPユーザのための局所コード
		def kyokusyoCd = self?.kyokusyoCd;
		// ロール情報を取得
		def roleFlag = self.role.roleId;
		// 支店コード
		def salesBranchId;
		// 支店名
		def salesBranchName;
		//　支社コード
		def divisionId;
		def year = new Date().format(YEAR_FORMAT);
		def month = new Date().format(MONTH_FORMAT);
		if (roleFlag.equals (ROLE_JPOST_BRANCH_USER)){
		// 支店コード
			salesBranchId = kyokusyoCd;
		// 支店名
			salesBranchName = JpostSalesBranch?.findBySalesBranchId(salesBranchId)?.salesBranchName;
		}else{
		// 支店のラジオボタン
			radioSelect = BRANCHOFFICE;
			if (roleFlag.equals (ROLE_JPOST_REGIONAL_USER)){
					divisionId = kyokusyoCd;
			}
		}
		//月リスト
		def addMonthList = monothList();
		//年リスト
		def addYearList = yearList();
		//画面制御
		def screenControl = roleFlag;
		//支店コード
		def code = salesBranchId;
		def requestRetMap = [addMonthList:addMonthList];
		def result = [year:year,month:month,screenControl:screenControl,addMonthList:addMonthList,addYearList:addYearList,codeList:codeList];
		return [radioSelect:radioSelect,result:result,salesBranchName:salesBranchName,salesBranchId:salesBranchId,divisionName:divisionId];
	}
	
	//受注一覧をダウロード
	def downloadOrder = {
		HttpUtils.nocache(response);
		
		//送付ファイル情報
		def filePathName = this.getPathFromSession();
		def fileName = this.getFileFromSession();
		//ダウンロード時のファイル名
		def dlFileSetting = localSettingsService.getCreateCsvOrderDataSettings("OrderInfoJP");
		def dlFileDefaultName = dlFileSetting?.file;

		if(filePathName !=null && !filePathName.equals("")){
			try {
				def file =new File(filePathName);
				// ファイルの出力
				HttpUtils.output(request, response, 'application/octet-stream', dlFileDefaultName, file);
			} catch (ex) {
				LogUtils.error(log, message(code:"BA13E001") + '\n'+ex.message);
				flash.message = "エラーが発生しました。";
				return;
	
			}
			
		}
	
	}

	//受注一覧ファイル存在チェック
	def searchOrder = {
		assert editFileService;
		assert localSettingsService;
		HttpUtils.nocache(response);
		setPathFile2Session("", "");
		def self = this.currentUser(false);
		def retFilePathName;
		//対象ファイルの決定
		// 個人情報取扱権限の有無によって対象ファイルを決定
		if (self?.role?.hasAuthority('AUTHORITY_PERSONAL_DATA')) {
			retFilePathName = localSettingsService.getCreateCsvOrderDataSettings("OrderInfoJP");
		} else {
			retFilePathName = localSettingsService.getCreateCsvOrderDataSettings("OrderInfoJP_Masked");
		}
		
		def filePath = retFilePathName.path;
		def fileName=retFilePathName.file;
		
		def listFiles = editFileService.listFiles(filePath,fileName);
		def filePathName;
		def fileSize=listFiles.size();
		def result;
		if(listFiles.size()==0){
			result = [fileSize:fileSize];
			render result as JSON;
			
		}else{
			for (itt in listFiles){
				def file = itt.filePathName;
				filePathName = itt.filePathName.absolutePath;
			}
			setPathFile2Session(filePathName, fileName);
			result = [fileSize:fileSize];
			render result as JSON;
		}
	}
		// 検索
	def search = {
		assert editFileService;
		assert localSettingsService;
		
		HttpUtils.nocache(response);
		def radioSelect = request.getParameter("myGroup");
		
		setPathFile2Session("", "");
		
		//月リスト
		def addMonthList = monothList();
		//年リスト
		def addYearList = yearList();
		//画面制御
		def screenControl = this.currentUser(false)?.role?.roleId;
		// 年
		def year = request.getParameter("year");
		// 月
		def month = request.getParameter("month");
		// 月
		def date = year + month;
		// 支店コード
		def salesBranchId = request.getParameter("salesBranchId");
		// 支店名
		def salesBranchName = request.getParameter("salesBranchName");
		// 支社、本社コード
		def divisionId = request.getParameter("divisionName");
		// コード
		def code;
		// フォルダ
		def folder;
		def codeList = jpostDivision();
		def result;
		result = [codeList:codeList,year:year,month:month,screenControl:screenControl,addMonthList:addMonthList,addYearList:addYearList];
		if (radioSelect.equals(BRANCH)||screenControl.equals(ROLE_JPOST_BRANCH_USER)){
			if(salesBranchId == null||salesBranchId.equals("")){
				flash.message = "支店を検索してください。";
				render (view:'performanceInitialView',model:[radioSelect:radioSelect,result:result,
					salesBranchName:salesBranchName,salesBranchId:salesBranchId,divisionName:divisionId]);
				return;
			}else{
			code = salesBranchId;
			folder = DAILY_REPORT;
			}
		}else{
			code = divisionId;
			folder = MONTHLY_REPORT;
		}
		// ファイルを検索
		def retFilePathName;
		try{
			retFilePathName = localSettingsService.getCreateCsvSalesDataSettings(folder,date,code);
		}catch(Exception e){
			LogUtils.error(log, e);
			return;
		}
		
		def filePath = retFilePathName.path;
		def fileName = retFilePathName.file;
		def listFiles = editFileService.listFiles(filePath,fileName);
		def filePathName;
		
		if(listFiles.size()==0){
			flash.message = "ファイルが見つかりません。";
			
			render (view:'performanceInitialView',model:[radioSelect:radioSelect,result:result,
													salesBranchName:salesBranchName,
													salesBranchId:salesBranchId,divisionName:divisionId]);
			return;
		}
		for (itt in listFiles){
			def file = itt.filePathName;
			filePathName = itt.filePathName.absolutePath;
		}
		
		setPathFile2Session(filePathName, fileName);
		
		render (view:'performanceInitialView',model:[radioSelect:radioSelect,
			fileName:fileName,filePathName:filePathName,
			result:result,salesBranchName:salesBranchName,
			salesBranchId:salesBranchId,divisionName:divisionId]);
	}
	
	// ダウンロード
	def download = {
		assert editFileService;
		assert localSettingsService;
		HttpUtils.nocache(response);
		def radioSelect = request.getParameter("radioSelect");
		//月リスト
		def addMonthList = monothList();
		//年リスト
		def addYearList = yearList();
		//画面制御
		def screenControl = this.currentUser(false)?.role?.roleId;
		// 年
		def year = request.getParameter("year");
		// 月
		def month = request.getParameter("month");
		// 月
		def date = year + month;
		// 支店コード
		def salesBranchId = request.getParameter("salesBranchId");
		// 支店名
		def salesBranchName = request.getParameter("salesBranchName");
		// 支社、本社コード
		def divisionId = request.getParameter("divisionName");
		def codeList = jpostDivision();
		def result;
		result = [codeList:codeList,year:year,month:month,screenControl:screenControl,addMonthList:addMonthList,addYearList:addYearList];
				
		def filePathName = this.getPathFromSession();
		def fileName = this.getFileFromSession();
		if(fileName != null && !fileName.equals("")){
			try {
				def filepath = new File(filePathName);
				// ファイルの出力
				HttpUtils.output(request, response, 'application/octet-stream', fileName, filepath);
			} catch (ex) {
				LogUtils.error(log, message(code:"BA13E001") + '\n'+ex.message);
				flash.message = "エラーが発生しました。";
				return;
	
			}
		}
		else {
			flash.message = "ファイルが見つかりません。";
		}
		render(view:'performanceInitialView',model:[radioSelect:radioSelect,
			fileName:fileName,filePathName:filePathName,
			result:result,salesBranchName:salesBranchName,
			salesBranchId:salesBranchId,divisionName:divisionId]);
	}
	
	//支店検索画面
	def officeSearch = {
		def result = ['listAddressState':localSettingsService.listAddressState()];
	}
	
	//支店検索画面
	def officeSearchBtn = {
		assert branchSearchService;

		def retList = branchSearchService.selectData(params);
		def result = [];
		if (retList) {
			retList.list?.each {
				def jpostSalesBranch = [:];
				jpostSalesBranch.salesBranchStateName = it.salesBranchStateName;
				jpostSalesBranch.salesBranchName = it.salesBranchName;
				jpostSalesBranch.salesBranchId = it.salesBranchId;		
				result << jpostSalesBranch;
			}
		};
		render result as JSON;
	}
	
	//戻る
	def back ={
		HttpUtils.nocache(response);
		def self = null;
		//ログイン中のユーザ情報の取得
		self = this.currentUser(false);
		// ロール情報を取得
		def roleFlag = self.role.roleId;
		
		if(roleFlag.equals(ROLE_OFFICE_USER)){
			redirect(controller:'salesManagement', action:'index');
		}else{
			redirect(controller:'performanceAggregate', action:'index');
		}

	}

	/**
	 * ファイルパスを取得する。
	 * @param params リクエストパラメータ
	 */
	private getPathFromSession() {
		if (!session) {
			return null;
		}
		
		return session["PerformanceAggregateParams.Path"];
	}
	/**
	 * ファイルパスを取得する。
	 * @param params リクエストパラメータ
	 */
	private getFileFromSession() {
		if (!session) {
			return null;
		}
		
		return session["PerformanceAggregateParams.File"];
	}
	/**
	 * ファイルパスの設定を行います。
	 * @param params リクエストパラメータ
	 */
	private setPathFile2Session(path, file) {
		if (!session) {
			return;
		}
		
		session["PerformanceAggregateParams.Path"] = path;
		session["PerformanceAggregateParams.File"] = file;
	}
	def hidukeLoad = {
		HttpUtils.nocache(response);
		
		def dateFrom = params.orderDateFrom;
		def dateTo = params.orderDateTo;
		
		//明細ふぁいるのTemplateふぁいる
		def templateFile = systemMasterService.getResourceFile("template", "DMFtemplate.xls");
		//出力するTemporaryファイル
		def outFile = TempFileUtil.createTempFile("odl_download", ".xls");

		//明細ファイル作成
		def param = [template:templateFile, outpath:outFile,dateF:dateFrom,dateT:dateTo];
		createXlsDMFService.core(param);

		HttpUtils.output(request, response, 'application/octet-stream', "DMF申込状況.xls", outFile);
	}
}
