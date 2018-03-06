<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<title><g:layoutTitle default="Grails" /></title>
	<link rel="stylesheet" href="${resource(dir:'css/pepper-grinder',file:'jquery-ui-1.8.11.custom.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'simplemodal.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'spinner.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'validator.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'evenodd.css')}" />
	<link rel="stylesheet" href="${resource(dir:'css/toastmessage/css',file:'jquery.toastmessage.css')}" />
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<link rel="stylesheet" href="${resource(dir:'static/dmol/users/css',file:'common.css')}" />
	<g:if test="${macintoshBrowser}"><link rel="stylesheet" href="${resource(dir:'static/dmol/users/css',file:'common_mac_diff.css')}" /></g:if>
	<link rel="stylesheet" href="${resource(dir:'static/dmol/users/css',file:'layout.css')}" />
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
	<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'rollover.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'scrollsmoothly.js')}"></script>
<g:render template="/common/fragment/simplemodalie6style" />
</head>
<body class="body_a ${pageProperty(name:'body.class')}">
<g:render template="/common/fragment/googleanalyticsuser" />
<!-- ClickTale Top part -->
<script type="text/javascript">
var WRInitTime=(new Date()).getTime();
</script>
<!-- ClickTale end of Top part -->
<g:render template="/common/fragment/spinner" />
<a id="pageTop"></a>
<g:layoutBody />
<g:render template="/common/fragment/relaylogin" />
<g:render template="/common/fragment/footer" />
<g:render template="/common/fragment/oiydialog" />
<g:render template="/common/fragment/keepalive" />
<g:render template="/common/fragment/setupbuttonstyle" />
<g:render template="/common/fragment/setupToastmessage" />
<jq:plugin name="localutils" />
<!-- ClickTale Bottom part -->

<script type='text/javascript'>
// The ClickTale Balkan Tracking Code may be programmatically customized using hooks:
// 
//   function ClickTalePreRecordingHook() { /* place your customized code here */  }
//
// For details about ClickTale hooks, please consult the wiki page http://wiki.clicktale.com/Article/Customizing_code_version_2

document.write(unescape("%3Cscript%20src='"+
(document.location.protocol=='https:'?
"https://clicktalecdn.sslcs.cdngc.net/www07/ptc/533f2b18-f860-488a-980f-d4e4a10c24e1.js":
"http://cdn.clicktale.net/www07/ptc/533f2b18-f860-488a-980f-d4e4a10c24e1.js")+"'%20type='text/javascript'%3E%3C/script%3E"));
</script>

<!-- ClickTale end of Bottom part -->
<g:if env="production">
<script type="text/javascript">
(function () {
    var tagjs = document.createElement("script");
    var s = document.getElementsByTagName("script")[0];
    tagjs.async = true;
    tagjs.src = "//s.yjtag.jp/tag.js#site=evY69Kv";
    s.parentNode.insertBefore(tagjs, s);
}());
</script>
<noscript><iframe src="//b.yjtag.jp/iframe?c=evY69Kv" width="1" height="1" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
</noscript>
</g:if><g:else><!-- 本番環境ではここにYTMタグを出力します --></g:else>
</body>
</html>