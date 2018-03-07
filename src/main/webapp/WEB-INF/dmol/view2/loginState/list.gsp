<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>ログインユーザ一覧</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>ログインユーザ一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>ログインユーザ一覧</h1>

		<div class="buttons">
			<span class="button"><g:link action="show" class="button"><span class="icon-create">メンテナンス状態表示</span></g:link></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<div class="paginateButtons paginateTopButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="httpSessionId" title="${fieldNames?.UserLoginState?.httpSessionId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastAccessDate" title="${fieldNames?.UserLoginState?.lastAccessDate?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="loginUserId" title="${fieldNames?.UserLoginState?.loginUserId?.encodeAsHTML()}" params="${params}" />
					</tr>
				</thead>

				<tbody>
<g:if test="${!userLoginStateList || (userLoginStateList.size() <= 0)}">
					<tr>
						<td colspan="3" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
				<g:each in="${userLoginStateList}" status="i" var="userLoginState">
					<tr>
						<td>${userLoginState?.httpSessionId?.encodeAsHTML()}</td>
						<td class="timestampCell"><g:formatDate format="${timestampFormat}" date="${userLoginState?.lastAccessDate}" /></td>
						<td>${userLoginState?.loginUserId?.encodeAsHTML()}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

	</div>
</body>
</html>
