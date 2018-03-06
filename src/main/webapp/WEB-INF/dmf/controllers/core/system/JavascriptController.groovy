/**
 * Created on 2011/04/13
 * By Ryuichi Ohtaki <ryuichi.ohtaki@gmail.com>
 *
 * dmol
 * Copyright (C) RESOLOGIC Inc., 2004-2011
 */
package jp.co.reso.oiy.core.controllers.system

import javax.servlet.http.HttpServletResponse;

import jp.co.reso.oiy.core.controllers.utils.HttpUtils;

/**
 * 動的に生成するJavaScriptです。
 */
class JavascriptController {

	// 無指定
	def index = {
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	}

	/**
	 * JavaScriptの出力
	 */
	private renderJavascript() {
		if (!params.id) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		render(view:params.id, contentType:'text/javascript', encoding:'UTF-8');
	}

	// キャッシュ可
	def cacheable = {
		this.renderJavascript();
	}

	// キャッシュ不可
	def nochache = {
		HttpUtils.nocache(response);
		this.renderJavascript();
	}

}
