package jp.co.jpmd.oiy.dmolbiz.controllers.office

import java.text.SimpleDateFormat;

import jp.co.reso.oiy.dmol.domain.user.User
import jp.co.reso.oiy.core.domain.system.SystemMaintenanceState;
import jp.co.reso.oiy.core.domain.user.Role
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.layoutlogic.util.TempFileUtil
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController;

class OpLogSearchController  extends AbstractOrderItYourselfController {
	
	private static String DMOL_FILENAME = "DMF_dmol_OpeLog";
	private static String DMPAYMENT_FILENAME = "DMF_dmpayment_OpeLog";
	def opLogSearchService;
	SimpleDateFormat dateFomat = new SimpleDateFormat("yyyy/MM/dd");

	def index = {

		Date dateNow = new Date();
		def yearNow = Integer.valueOf(dateFomat.format(dateNow).toString().substring(0,4));
		def monthNow = dateFomat.format(dateNow).toString().substring(5,7);
		def years = [];
		years << yearNow;
		for(int i = 1;i <= 5;i++){
			def yearGet = yearNow - i;
			years << yearGet;
		}
		return  ['years':years,'monthNow':monthNow];
	}
	
	def list={
		def result = [result:'error'];

		log.debug("params=$params")
		
		def year = params?.year?:"2000"
		def month = params?.month?:"01"
		flash.message='';
		def yearMonth = year+month;
		def templateFile = TempFileUtil.createTempFile("DMF_dmol_OpeLog", ".log")

		def param = [yearMonths:yearMonth
			, template:templateFile];

		try {
			def  dmolPathName = 'logs/dmfadmin/'+DMOL_FILENAME + '_'+yearMonth+'.log'
			String stime = new SimpleDateFormat("yyyyMM").format(new Date());
			if (stime.equals(yearMonth)) {
				dmolPathName = 'logs/dmfadmin/'+ DMOL_FILENAME+'.log'
			}
	
			def  dmpaymentPathName = 'logs/dmfadmin/'+DMPAYMENT_FILENAME + '_'+yearMonth+'.log'
			String dmpaymentStime = new SimpleDateFormat("yyyyMM").format(new Date());
			if (dmpaymentStime.equals(yearMonth)) {
				dmpaymentPathName = 'logs/dmfadmin/'+ DMPAYMENT_FILENAME+'.log';
			}

			File dmolFile = new File(dmolPathName);
			File dmpayFile = new File(dmpaymentPathName);
			if (dmolFile.exists() || dmpayFile.exists())
			{
				opLogSearchService.outputLOGTitle(param);
				String tilleStr = "DMF_dmol_OpeLog_" +  yearMonth.toString() + ".log";
				HttpUtils.output(request, response, 'application/octet-stream', tilleStr, templateFile);
			}
			else
			{
				flash.message = "該当する年月のログ・ファイルは存在しません。";
				redirect(action:'index');
			}

		} catch (Exception e) {
			log.warn("該当する年月のログ・ファイルは存在しません。", e);
		}
	}
}
