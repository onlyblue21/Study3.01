/**
 * Created on 2011/05/19
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */

package jp.co.jpmd.oiy.dmolbiz.controllers.orderinfo

import jp.co.reso.layoutlogic.util.TempFileUtil
import java.text.SimpleDateFormat

import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.dmol.domain.user.User
import jp.co.reso.oiy.core.domain.user.Role
/**
 * OrderInfo出力
 */
class OrderInfoNewController extends AbstractOrderItYourselfController {
	def orderInfoNewService;
	SimpleDateFormat dateFomat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat dft = new SimpleDateFormat("yyyyMMddHHmmss");
	def createCsvOrderInfoService;
	def createXlsRecievedOrderService;
	def index = {
		Date dateNow = new Date();
		def yearNow = Integer.valueOf(dateFomat.format(dateNow).toString().substring(0,4));
		def monthNow = Integer.valueOf(dateFomat.format(dateNow).toString().substring(5,7));
		def years = [];
		years << yearNow;
		for(int i = 1;i <= 5;i++){
			def yearGet = yearNow - i;
			years << yearGet;
		}
		Calendar calender = Calendar.getInstance();
		calender.setTime(dateNow);
		calender.add(Calendar.MONTH, -1);
		calender.add(Calendar.DAY_OF_MONTH, 1);
		def dateMonthAgo = calender.getTime();
		def dateNowf = dateNow.format("yyyy/MM/dd");
		def dateMonthAgof = dateMonthAgo.format("yyyy/MM/dd");
		def self = userService.getSelf();
		def user  = User.findById(self.id);
		def roleData = user.role
		
		session.setAttribute("authorities", roleData.authorities);
		return  ['years':years,'dateNow':dateNowf,'dateMonthAgo':dateMonthAgof,'monthNow':monthNow];
	}
	private deDays(year , month){
		def days;
//		month = month + 1;
		switch(month){
			case 1: days = 31; break;
			case 2: days = 30; break;
			case 3: days = 31; break;
			case 4: days = 30; break;
			case 5: days = 31; break;
			case 6: days = 30; break;
			case 7: days = 31; break;
			case 8: days = 31; break;
			case 9: days = 30; break;
			case 10: days = 31; break;
			case 11: days = 30; break;
			case 12: days = 31; break;
		}
		if(Integer.valueOf(year) % 4 == 0 && month == 2){
			days = 29;
		}else if(month == 2){
			days = 28;
		}
		return days;
	}
	def output = {
		log.debug("params=$params")
		def sparams = [:]
		//期間指定方法
		if("1".equals(params?.outPutGroup?:"1")){
			sparams.outPutGroup = "1"
		}else{
			sparams.outPutGroup = "0"
		}
		// 出力期間
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		if("0".equals(params?.dateGroup?:"")){
			def year = params?.year?:"2000"
			def month = params?.month?:"01"
			def day = deDays(Integer.valueOf(year), Integer.valueOf(month))
			sparams.targetBeginDate = "${year}/${month}/01 00:00:00"
			sparams.targetEndDate = "${year}/${month}/${day} 23:59:59"
		}else{
			sparams.targetBeginDate = "${params.orderDateFrom} 00:00:00";
			sparams.targetEndDate = "${params.orderDateTo} 23:59:59";
		}
		
		def templateFile = TempFileUtil.createTempFile("orderInfo", ".csv")
		//出力するTemporaryファイル
		def outFile = TempFileUtil.createTempFile("odl_download", ".xlsx");
		
		def roleAuthorities = session.getAttribute("authorities");

		def excludeIds = [];
		session.getAttribute("excludeDlItems").each {
			excludeIds.add(it);
		}
//		def param = [:]
//		param.logFileName = null
//		param.csvFile = tmpFile
//		param.sparams = sparams
		
		 def  tarIds =createCsvOrderInfoService.selectDataOrderInfo(sparams);
		 def orderDetails = []
		 def list = []
		 orderDetails = tarIds.list
		 orderDetails.each {
			list.add(it.id);
		 }
		 //明細ファイル作成
		 def param = [targetDetailIds:list
						 , excludeIds:excludeIds
						 , template:templateFile
						 , outpath:outFile
						 ,role:roleAuthorities];
		try {
			//def result = createCsvOrderInfoService.core(param)
			createXlsRecievedOrderService.coreCsv(param);
			// ファイルの出力
			def titleDate  = dft.format(new Date());
			String tilleStr = "OrderInfo_" +  titleDate.toString() + ".csv";
			HttpUtils.output(request, response, 'application/octet-stream', tilleStr, templateFile);
		} catch (Exception e) {
			log.warn("明細ダウンロードに失敗しました", e);
		}
		
	}
}
