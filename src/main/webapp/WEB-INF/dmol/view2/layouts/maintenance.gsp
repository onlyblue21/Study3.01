<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><g:layoutTitle default="DMファクトリ" /></title>
	<g:layoutHead />
	<r:require module="jquery" />
	<r:require module="jquery-all" />
	<r:require module="css-dmol-kanri" />
	<r:require module="ico-favicon" />
<r:layoutResources />
</head>
<body class="body_kanri">
<g:render template="/common/fragment/spinner" />
<a id="pageTop"></a>
<!-- header -->
	<div id="header">
		<img src="${r.resource(dir:'static/dmol/kanri/images/kanri',file:'logo.gif')}" alt="DM Factory.jp 管理画面" class="logo" />
<sec:ifLoggedIn>
		<div class="loginName">
			<g:link controller="systemProfile" action="show" class="transition"><strong>${loginUserInfo?.familyName?.encodeAsHTML()}${loginUserInfo?.firstName?.encodeAsHTML()}</strong></g:link>　さま
		</div>
		<div class="box1">
			<p class="link"><g:link controller="logout" class="logout transition">ログアウト</g:link></p>
			<div class="boxRight"></div>
		</div>
</sec:ifLoggedIn>
	</div>
<!-- /header END -->
	<div style="clear:both;"></div>
<g:layoutBody />
<g:render template="/common/fragment/maintenancefooter" />
<g:render template="/common/fragment/oiydialog" />
<g:render template="/common/fragment/keepalive" />
<g:render template="/common/fragment/setupbuttonstyle" />
<g:render template="/common/fragment/setupToastmessage" />
<g:render template="/common/fragment/googleanalyticsadmin" />
<r:layoutResources />
</body>
</html>