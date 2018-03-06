<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<title><g:layoutTitle default="Grails" /></title>
	<link rel="stylesheet" href="${resource(dir:'static/dmol/css',file:'common.css')}" />
	<link rel="stylesheet" href="${resource(dir:'static/dmol/css',file:'folder.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css/pepper-grinder',file:'jquery-ui-1.8.11.custom.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'simplemodal.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'spinner.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'validator.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'evenodd.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css/toastmessage/css',file:'jquery.toastmessage.css')}" />
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
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
<g:render template="/common/fragment/simplemodalie6style" />
</head>
<body>
<g:render template="/common/fragment/spinner" />
<a id="pageTop"></a>
<g:layoutBody />
<g:render template="/common/fragment/footer" />
<g:render template="/common/fragment/oiydialog" />
<g:render template="/common/fragment/keepalive" />
<g:render template="/common/fragment/setupbuttonstyle" />
<g:render template="/common/fragment/setupToastmessage" />
<jq:plugin name="localutils" />
<g:if test="${jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils.isProductionEnvironment()}">
<g:render template="/common/fragment/googleanalyticsuser" />
</g:if>
</body>
</html>