<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><g:layoutTitle default="Grails" /></title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'maintenance.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css/pepper-grinder',file:'jquery-ui-1.8.11.custom.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'simplemodal.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'spinner.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'validator.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'evenodd.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css/toastmessage/css',file:'jquery.toastmessage.css')}" />
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<link rel="stylesheet" href="${resource(dir:'static/dmol/kanri/css',file:'common.css')}" />
	<link rel="stylesheet" href="${resource(dir:'static/dmol/kanri/css',file:'layout.css')}" />
	<g:layoutHead />
	<g:javascript library="jquery" plugin="jquery" />
	<jq:plugin name="ui" />
	<jq:plugin name="uidatepickeri18nja" />
	<jq:plugin name="bgiframe" />
	<jq:plugin name="blockUI" />
	<jq:plugin name="json" />
	<jq:plugin name="simplemodal" />
	<jq:plugin name="timers" />
	<jq:plugin name="toastmessage" />
	<jq:plugin name="validate" />
	<jq:plugin name="validateja" />
	<jq:plugin name="oiydialog" />
<g:if test="${false}">
	<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'rollover.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'scrollsmoothly.js')}"></script>
</g:if>
<g:render template="/common/fragment/simplemodalie6style" />
</head>
<body class="body_kanri">
<g:render template="/common/fragment/spinner" />
<a id="pageTop"></a>
<!-- header -->
	<div id="header">
		<img src="${resource(dir:'static/dmol/kanri/images/kanri',file:'logo.gif')}" alt="DM Factory.jp 管理画面" class="logo" />
<sec:ifLoggedIn>
		<div class="loginName">
			<g:link controller="profile" action="show" class="transition"><strong>${loginUserInfo?.familyName?.encodeAsHTML()}${loginUserInfo?.firstName?.encodeAsHTML()}</strong></g:link>　さま
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
<jq:plugin name="localutils" />
<g:if test="${jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils.isProductionEnvironment()}">
<g:render template="/common/fragment/googleanalyticsadmin" />
</g:if>
</body>
</html>