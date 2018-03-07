<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ja" xml:lang="ja" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<title><g:layoutTitle default="DMファクトリ" /></title>
	<g:layoutHead />
	<r:require module="jquery" />
	<r:require module="jquery-all" />
	<r:require module="css-dmol-user" />
	<g:if test="${macintoshBrowser}"><r:require module="css-dmol-user-mac" /></g:if>
	<r:require module="js-dmol-user" />
	<r:require module="ico-favicon" />
	<r:layoutResources />
</head>
<body>
<g:render template="/common/fragment/googletagmanager" />
<g:render template="/common/fragment/spinner" />
<a id="pageTop"></a>
<g:layoutBody />
<g:render template="/common/fragment/footer" />
<g:render template="/common/fragment/oiydialog" />
<g:render template="/common/fragment/keepalive" />
<g:render template="/common/fragment/setupbuttonstyle" />
<g:render template="/common/fragment/setupToastmessage" />
<g:render template="/common/fragment/googleanalyticsuser" />
<g:render template="/common/fragment/aladurasitenet" />
<r:layoutResources />
<g:render template="/common/fragment/yjtag" />
</body>
</html>