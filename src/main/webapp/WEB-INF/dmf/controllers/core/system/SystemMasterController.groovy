/**
 * Created on 2011/03/31
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers.system

import jp.co.reso.logic.laml.GLAMLTool
import jp.co.reso.logic.laml.LamlElement
import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.system.SystemMaster
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.services.utils.LastUpdatedTimestampUtils
import jp.co.reso.oiy.core.utils.LogUtils

/**
 * システムマスター
 */
class SystemMasterController extends AbstractOrderItYourselfController {
	
	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete:'POST', update:'POST'];
	
	/**
	 * beforeInterceptorから呼び出すメソッドです。
	 * @param locale ロケール
	 */
	def before(locale) {
		super.before(locale);
		this.setDomainClazzName('SystemMaster', SystemMaster.getClazzName(locale));
		this.setDomainFieldNameMap('SystemMaster', SystemMaster.getFieldNameMap(locale));
	}
	
	// 一覧表示にリダイレクト
	def index = {
		redirect(action:'list', params:params);
	}
	
	// 一覧
	def list = {
		assert systemMasterService != null;
		
		HttpUtils.nocache(response);
		
		SearchParamUtils.setupSearchParams(session, 'systemMasterSearchParams', params); // 検索パラメータの設定
		def holder = systemMasterService.search(params); // 検索実行
		return ['systemMasterList':holder.list, 'totalCount':holder.totalCount];
	}
	
	// 編集画面の表示
	def edit = {
		assert systemMasterService != null;
		
		HttpUtils.nocache(response);
		
		return [:];
	}
	
	// 更新実行
	def update = {
		assert systemMasterService != null;
		
		HttpUtils.nocache(response);
		
		try {
			def file = request.getFile('settingfile');
			def root = GLAMLTool.load(file.inputStream);
			
			systemMasterService.update(root);
			flash.message = "システムマスターを更新しました。";
			redirect(action:'list');
			
		} catch (NLMValidationFailureException ex) {
			LogUtils.info(log, ex);
			flash.message = "システムマスターを更新できませんでした。";
			render(view:'edit');
			
		} catch (ex) {
			LogUtils.error(log, ex);
			flash.message = "システムマスターの更新に失敗しました。";
			render(view:'edit');
		}
	}
	
	// 削除実行
	def delete = {
		assert systemMasterService != null;
		
		HttpUtils.nocache(response);
		
		try {
			def systemMaster = systemMasterService.delete(params.id);
			flash.message = "システムマスター( ${systemMaster.uniqueId} )を削除しました。";
			redirect(action:'list');
			
		} catch (NLMNotFoundException ex) {
			LogUtils.info(log, ex);
			flash.message = "指定されたシステムマスター( ${params.id} )が見つかりませんでした。";
			redirect(action:'list');
			//			redirect(action:'list', params:params);
			
		} catch (ex) {
			LogUtils.error(log, ex);
			flash.message = "システムマスターを削除できませんでした。";
			redirect(action:'list');
		}
	}
	
	// ダウンロード
	def download = {
		assert systemMasterService != null;
		
		HttpUtils.nocache(response);
		
		def systemMaster = systemMasterService.get( params.id );
		if (!systemMaster) {
			render("指定された設定ファイル( ${params.id} )が見つかりませんでした。");
			return;
		}
		
		def fname = systemMaster.uniqueId;
		if (!fname.endsWith('.laml')) {
			fname += '.laml';
		}
		
		def root = GLAMLTool.fromLAML(systemMaster.props);
		root.key = systemMaster.uniqueId;
		root.value = systemMaster.description;
		LastUpdatedTimestampUtils.removeLastUpdatedTimestamp(root);
		def holder = new LamlElement();
		holder.addChild(root);
		HttpUtils.downloadText(request, response, fname, holder.toLaml());
	}
	
}
