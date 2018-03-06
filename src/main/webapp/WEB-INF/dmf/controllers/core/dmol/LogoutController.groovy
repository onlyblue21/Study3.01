/**
 * Created on 2011/03/15
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

/**
 * Logout Controller
 */
class LogoutController {

	def localSettingsService;

	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
		this.logout();
	}

	// ログアウト
	def logout = {
		redirect(url:localSettingsService.getToDmfRelayURL('top', 'logoutURL'));
		session.invalidate();
	}
}
