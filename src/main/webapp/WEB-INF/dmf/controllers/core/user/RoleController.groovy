/**
 * Created on 2011/03/30
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers.user

import jp.co.reso.oiy.core.controllers.AbstractOrderItYourselfController
import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.controllers.utils.SearchParamUtils
import jp.co.reso.oiy.core.domain.user.Role
import jp.co.reso.oiy.core.exception.NLMNotFoundException
import jp.co.reso.oiy.core.exception.NLMValidationFailureException
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.dmol.domain.user.UserGroup

class RoleController extends AbstractOrderItYourselfController {

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete:'POST', save:'POST', update:'POST'];

	/** グループ種別のリスト */
	static final GROUP_TYPE_LIST = [
			[key:UserGroup.GROUP_TYPE_USER, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_USER)],
			[key:UserGroup.GROUP_TYPE_OFFICE, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_OFFICE)],
			[key:UserGroup.GROUP_TYPE_JPOST, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_JPOST)],
			[key:UserGroup.GROUP_TYPE_PRINT, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_PRINT)],
			[key:UserGroup.GROUP_TYPE_JPMD, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_JPMD)],
			[key:UserGroup.GROUP_TYPE_SYSTEM, value:UserGroup.getGroupTypeName(UserGroup.GROUP_TYPE_SYSTEM)],
		];

	/** Roleを操作するサービス */
	def roleService;

	/**
	 * beforeInterceptorから呼び出すメソッドです。
	 * @param locale ロケール
	 */
	def before(locale) {
		super.before(locale);
		this.setDomainClazzName('Role', Role.getClazzName(locale));
		this.setDomainFieldNameMap('Role', Role.getFieldNameMap(locale));
	}

	/**
	 * afterInterceptorから呼び出すメソッドです。
	 * afterInterceptorと同じ条件で呼び出してください。
	 * @param locale ロケール
	 * @param model ビューに渡されるモデル
	 * @param modelAndView Spring MVC ModelAndView
	 */
	def after(locale, model, modelAndView) {
		super.after(locale, model, modelAndView);
		model.groupTypeList = GROUP_TYPE_LIST;
	}

	// 一覧表示にリダイレクト
	def index = {
		redirect(action:'list', params:params);
	}

	// 一覧表示
	def list = {
		assert roleService != null;

		HttpUtils.nocache(response);

		SearchParamUtils.setupSearchParams(session, 'roleSearchParams', params); // 検索パラメータの設定
		def holder = roleService.search(params);
		return ['roleList':holder.list, 'totalCount':holder.totalCount];
	}

	// 追加画面の表示
	def create = {
		assert systemMasterService != null;

		HttpUtils.nocache(response);

		def role = new Role(params);
		def authorityList = systemMasterService.listAuthority();
		return ['role':role, 'authorityList':authorityList];
	}

	// 追加実行
	def save = {
		assert roleService != null;
		assert systemMasterService != null;

		HttpUtils.nocache(response);

		def role = new Role(params);
		try {
			role = roleService.add(role, params, this.locale);
			flash.message = "ロール( ${role.roleName} )を追加しました。";
			redirect(action:'list');

		} catch (ex) {
			LogUtils.warn(log, ex);
			flash.message = "ロールを追加できませんでした。";
			def authorityList = systemMasterService.listAuthority();
			render(view:'create', model:['role':role, 'authorityList':authorityList]);
		}
	}

	// 編集画面の表示
	def edit = {
		assert roleService != null;
		assert systemMasterService != null;

		HttpUtils.nocache(response);

		def role = roleService.get(params.id);
		if (!role) {
			flash.message = "指定されたロール( ${params.id} )が見つかりませんでした。";
			redirect(action:'list');
			return;
		}

		def authorityList = systemMasterService.listAuthority();
		return ['role':role, 'authorityList':authorityList];
	}

	// 更新実行
	def update = {
		assert roleService != null;
		assert systemMasterService != null;

		HttpUtils.nocache(response);

		def role = new Role(params);
		def authorityList = systemMasterService.listAuthority();
		try {
			role = roleService.update(params.id, params.version, role, params, this.locale);
			flash.message = "ロール( ${role.roleName} )を更新しました。";
			redirect(action:'list');

		} catch (NLMNotFoundException ex) {
			LogUtils.info(log, ex);
			flash.message = "指定されたロール( ${params.id} )が見つかりませんでした。";
			redirect(action:'list');
			//			redirect(action:'list', params:params);

		} catch (NLMValidationFailureException ex) {
			LogUtils.info(log, ex);
			flash.message = "ロールを更新できませんでした。";
			render(view:'edit', model:['role':role, 'authorityList':authorityList]);

		} catch (ex) {
			LogUtils.error(log, ex);
			flash.message = "ロールの更新に失敗しました。";
			render(view:'edit', model:['role':role, 'authorityList':authorityList]);
		}
	}

	// 削除実行
	def delete = {
		assert roleService != null;

		HttpUtils.nocache(response);

		try {
			def role = roleService.delete(params.id, this.locale);
			flash.message = "ロール( ${role.roleName} )を削除しました。";
			redirect(action:'list');

		} catch (NLMNotFoundException ex) {
			LogUtils.info(log, ex);
			flash.message = "指定されたロール( ${params.id} )が見つかりませんでした。";
			redirect(action:'list');

		} catch (NLMValidationFailureException ex) {
			LogUtils.info(log, ex);
			flash.message = "必須ロール、または、ユーザから参照されているため削除できません。";
			redirect(action:'edit', id:params.id);

		} catch (ex) {
			LogUtils.error(log, ex);
			flash.message = "削除できませんでした。";
			redirect(action:'edit', id:params.id);
		}
	}

}
