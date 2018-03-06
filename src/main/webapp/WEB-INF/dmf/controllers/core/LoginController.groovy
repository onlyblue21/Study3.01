/**
 * Created on 2011/03/15
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers

import grails.converters.JSON

import javax.servlet.http.HttpServletResponse

import jp.co.reso.oiy.core.controllers.utils.HttpUtils
import jp.co.reso.oiy.core.utils.ContentTypeUtils
import jp.co.reso.oiy.core.utils.LogUtils
import jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils
import jp.co.reso.oiy.dmol.domain.user.UserGroup

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.authentication.DisabledException
import org.springframework.security.web.WebAttributes

/**
 * Login Controller (Example).
 */
class LoginController extends AbstractOrderItYourselfController {

	/**
	 * Dependency injection for the authentication service.
	 */
	def springSecurityService;

	/** ログイン情報サービス */
	def loginStateService;

	def localSettingsService;

	/**
	 * ログインの可否を判断し、ログイン不可の場合は停止中ページを表示します。
	 */
	private canLogin() {
		assert loginStateService;
		def info = loginStateService.loginInfo();
		if (info && info.shutdown) {
			render(view:'suspended', model:['msg':info.msg]);
			return false;
		}
		return true;
	}

	def index = {
		if (this.isLoggedIn()) {
			redirect(uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl);
		} else {
			redirect(action:'auth');
		}
	}

	/**
	 * Show the login page. --> DMF
	 */
	def auth = {
		HttpUtils.nocache(response);
		redirect(url:localSettingsService.getToDmfRelayURL('top', 'loginURL'));
	}

	/**
	 * Show denied page.
	 */
	def denied = {
		HttpUtils.nocache(response);
	}

	/**
	 * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
	 */
	def full = {

		HttpUtils.nocache(response);

		this.renderAuthPage(SpringSecurityUtils.securityConfig);
	}

	/**
	 * login failed
	 */
	def authfail = {

		def username = session[WebAttributes.LAST_USERNAME];
		def msg = '';
		def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION];
		if (exception) {
			if (exception instanceof DisabledException) {
				msg = "無効なユーザです。";
//				msg = SpringSecurityUtils.securityConfig.errors.login.disabled
//			} else if (exception instanceof AccountExpiredException) {
//				msg = SpringSecurityUtils.securityConfig.errors.login.expired
//			} else if (exception instanceof CredentialsExpiredException) {
//				msg = SpringSecurityUtils.securityConfig.errors.login.passwordExpired
//			} else if (exception instanceof LockedException) {
//				msg = SpringSecurityUtils.securityConfig.errors.login.locked
			} else {
				msg = "ユーザID、または、パスワードが正しくありません。";
//				msg = SpringSecurityUtils.securityConfig.errors.login.fail
			}
		}
		// ログインに失敗した場合はセッションを破棄する
		session.invalidate();

		if (isAjax()) {
			render([result:'error', message:msg] as JSON);
		} else {
			flash.message = msg;
			redirect(action:'auth', params:params);
		}
	}

	// keepalive
	def keepalive = {
		if (this.isLoggedIn()) {
			assert loginStateService;
			def info = loginStateService.alertInfo();
			if (info && info.shutdown) {
				render(text:info.msg, contentType:"text/plain", encoding:"UTF-8");
				
			} else {
				render(text:'OK', contentType:"text/plain", encoding:"UTF-8");
			}
			
		} else {
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			render(text:'Forbidden', contentType:"text/plain", encoding:"UTF-8");
		}
	}

	// ajaxSuccess
	def ajaxSuccess = {
		assert userService;

		HttpUtils.nocache(response);

		def result = [result:'error', message:'ユーザ情報を取得することが出来ませんでした。'];
		try {
			def self = userService.getSelf();
			if (self) {
				result.result = 'success';
				result.email = self.email;
				result.familyName = self.familyName;
				result.firstName = self.firstName;
				result.groupType = self.userGroup.groupType;
				result.reload = (self.userGroup.groupType != UserGroup.GROUP_TYPE_USER);
			}

		} catch (ex) {
			LogUtils.warn(log, ex);
		}
		render(result as JSON);
	}

	/**
	 * Check if logged in.
	 */
	private boolean isLoggedIn() {
		return springSecurityService.isLoggedIn();
	}

	private boolean isAjax() {
		return springSecurityService.isAjax(request);
	}

	/**
	 * 画像ファイルの出力
	 * @param imagePath コンテキストパスからの画像ファイルのパス
	 */
	private outputImage(imagePath) {
		def realPath = servletContext.getRealPath(imagePath);
		def realFile = new File(realPath);
		if (realFile && realFile.exists() && realFile.canRead()) {
			def contentType = ContentTypeUtils.getContentType(realFile.name);
			HttpUtils.output(request, response, contentType, realFile.name, realFile);
		} else {
			def now = System.currentTimeMillis();
			redirect(uri:"${imagePath}?now=${now.toString()}");
		}
	}

	// ログイン／ログアウト
	def loginLogout = {
		assert userService;

		HttpUtils.nocache(response);

		if (RuntimeEnvironmentUtils.isAdminEnvironment()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		try {
			if (this.isLoggedIn()) {
				// 登録情報の確認
				def self = userService.getSelf();
				if (self && self.registeredUser) {
					// 会員ユーザはログアウト
					redirect(controller:'logout', action:'logout');
					return;	
				}
//				// ログインしていても会員ユーザではないのでログアウト処理を行う
//				SecurityContextHolder.context.authentication = null; // 認証情報をクリア：認証し直すため
//				session.invalidate();
			}
			// ログインしていない、または、会員ユーザではない

		} catch (ex) {
			// do nothing.
		}
		redirect(action:'auth');
	}

	// ログイン／ログアウト用画像
	def loginLogoutImg = {
		assert userService;

		HttpUtils.nocache(response);

		if (RuntimeEnvironmentUtils.isAdminEnvironment()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		try {
			if (this.isLoggedIn()) {
				// 登録情報の確認
				def self = userService.getSelf();
				if (self && self.registeredUser) {
					// 会員ユーザ
					this.outputImage("/static/dmol/images/top/btn_logout.png");
					return;	
				}
			}
			// ログインしていない、または、会員ユーザではない

		} catch (ex) {
			// do nothing.
		}
		this.outputImage("/static/dmol/images/top/btn_login.png");
	}

}
