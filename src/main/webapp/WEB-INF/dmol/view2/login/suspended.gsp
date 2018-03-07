<html>
<head>
	<meta name='layout' content='main' />
	<title>メンテナンス中</title>
</head>
<body class="myPage">
	<div class='body'>
		<div class='message'>ただいまメンテナンスを行っております。</div>
<g:if test="${msg}">
		<div class='errors'><ul><li>${msg}</li></ul></div>
</g:if>
		<div style="padding-top: 12px; padding-bottom: 8px; text-align: center;">
			<g:link action="full" class="button"><span class="nowrap">システム管理</span></g:link>
		</div>
	</div>
</body>
</html>
