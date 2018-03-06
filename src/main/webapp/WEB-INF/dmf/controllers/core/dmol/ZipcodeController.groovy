/**
 * Created on 2011/04/12
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers

import grails.converters.JSON
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.utils.LogUtils

import org.apache.commons.lang.StringUtils

/**
 * 郵便番号から住所を取得
 */
class ZipcodeController extends AbstractOrderItYourselfController {

	/** 郵便番号サービス */
	def zipcodeService;

	// 郵便番号から住所を取得
	def toAddress = {
		assert zipcodeService;

		HttpUtils.nocache(response);

		def result = [result:'notFound'];
		try {
			def zipcode = StringUtils.stripToEmpty(params.zipcode);
			if (!zipcode) {
				zipcode = StringUtils.stripToEmpty(params.id);
			}
			def zinfo = zipcodeService.lookup(zipcode);
			if (zinfo) {
				result.result = 'found';
				result.zipcode = zinfo.zipcode;
				result.addressState = zinfo.addressState;
				result.address1 = zinfo.address1;
				result.address2 = zinfo.address2;
				result.address3 = zinfo.address3;
				result.address4 = zinfo.address4;
			}
			
		} catch (ex) {
			LogUtils.info(log, ex);
			// ignore.
		}
		render result as JSON;
	}

}
