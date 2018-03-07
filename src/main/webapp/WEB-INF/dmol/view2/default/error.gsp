<html>
<head>
<g:if test="${(request.'javax.servlet.error.status_code' == 404) && request.'javax.servlet.error.request_uri' && (request.'javax.servlet.error.request_uri'.startsWith(request.contextPath + '/help'))}">
	<meta name="layout" content="contentonly" />
</g:if>
<g:elseif test="${jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils.isAdminEnvironment()}">
	<meta name="layout" content="maintenance" />
</g:elseif>
<g:else>
	<meta name="layout" content="main" />
</g:else>
<g:if test="${request.'javax.servlet.error.status_code' == 404}">
	<title>${request.'javax.servlet.error.message' ? request.'javax.servlet.error.message'?.encodeAsHTML() : '見つかりませんでした。'}</title>
</g:if>
<g:elseif test="${request.'javax.servlet.error.status_code' == 403}">
	<title>${request.'javax.servlet.error.message' ? request.'javax.servlet.error.message'?.encodeAsHTML() : 'アクセスできませんでした。'}</title>
</g:elseif>
<g:else>
	<title>システムエラー</title>
</g:else>
	<style type="text/css">
		.message {
			border: 1px solid black;
			padding: 5px;
			background-image: none;
			background-color:#E9E9E9;
		}
		.stack {
			border: 1px solid black;
			padding: 5px;
			overflow:auto;
			height: 300px;
		}
		.snippet {
			padding: 5px;
			background-color:white;
			border:1px solid black;
			margin:3px;
			font-family:courier;
		}
	</style>
</head>

<body>
<g:if test="${!((request.'javax.servlet.error.status_code' == 404) && request.'javax.servlet.error.request_uri' && (request.'javax.servlet.error.request_uri'.startsWith(request.contextPath + '/help')))}">
<g:if test="${!jp.co.reso.oiy.core.utils.RuntimeEnvironmentUtils.isAdminEnvironment()}">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />
</g:if>
</g:if>

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents">

<g:if test="${request.'javax.servlet.error.status_code' < 500}">
			<div class="message">
				<strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'?.encodeAsHTML()}<br/>
				<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
			</div>
</g:if>
<g:else>
<g:if env="development">
			<h1>システムエラー</h1>
			<h2>Error Details</h2>
		
			<div class="message">
				<strong>システムエラーが発生しました。</strong><br/>
				<strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'?.encodeAsHTML()}<br/>
				<strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
				<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
				<g:if test="${exception}">
					<strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br />
					<strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br />
					<strong>Class:</strong> ${exception.className} <br />
					<strong>At Line:</strong> [${exception.lineNumber}] <br />
					<strong>Code Snippet:</strong><br />
					<div class="snippet">
						<g:each var="cs" in="${exception.codeSnippet}">
							${cs?.encodeAsHTML()}<br />
						</g:each>
					</div>
				</g:if>
			</div>
			<g:if test="${exception}">
				<h2>Stack Trace</h2>
				<div class="stack">
					<pre><g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each></pre>
				</div>
			</g:if>
</g:if>
<g:else>
			<h1>システムエラー</h1>
		
			<div class="message">
				<strong>システムエラーが発生しました。</strong><br/>
				<strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'?.encodeAsHTML()}<br/>
				<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
			</div>
</g:else>
</g:else>

		</div>
<!-- commonContents END -->

	</div>
<!-- mainBlock END -->
</body>
</html>