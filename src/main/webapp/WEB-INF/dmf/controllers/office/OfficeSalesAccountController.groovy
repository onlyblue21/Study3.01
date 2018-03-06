package jp.co.jpmd.oiy.dmolbiz.controllers.office

import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletResponse

//import jp.co.reso.logic.laml.GLAMLTool
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.system.TagData
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.utils.ContentTypeUtils
import jp.co.reso.oiy.core.utils.ConvertUtils
import jp.co.reso.oiy.core.utils.DateUtils
import jp.co.reso.oiy.core.utils.LogUtils

import org.codehaus.groovy.grails.commons.GrailsApplication

import jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo
import jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail
import jp.co.jpmd.oiy.dmolbiz.service.office.*

class OfficeSalesAccountController {

	/** grailsApplication */
	GrailsApplication grailsApplication;

	def systemMasterService;
	def recievedOrderService;
	
	def index = {
		println("");
	}
}
