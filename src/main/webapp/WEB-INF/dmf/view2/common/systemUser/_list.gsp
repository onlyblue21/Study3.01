<g:if test="${false}">
/**
 * @param targetName 対象の名前:"事務局|JP"|"印刷会社"|"JPMD"|"管理者"
 * @param jpostUser	true|false JPユーザ識別フラグ
 */
</g:if>
<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>${targetName}ユーザ一覧</title>
	<g:javascript library="jquery" plugin="jquery" />
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${resource(dir:'')}">メインメニュー</a></li>
			<li>${targetName}ユーザ一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>${targetName}ユーザ一覧</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="createBtn" class="button"><span class="icon-create">${targetName}ユーザの追加</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />

		<div class="searchConditiontoggler"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
		<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="display:none;">
			<g:form method="get" action="list" name="searhCondition">
			<g:hiddenField name="sort" value="${params.sort?.encodeAsHTML()}" />
			<g:hiddenField name="order" value="${params.order?.encodeAsHTML()}" />
			<g:hiddenField name="search" value="true" />
			<table>
				<tbody>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_ROLE">
					<tr class="prop">
						<td class="name"><label for="roleId">${clazzNames?.Role?.encodeAsHTML()}:</label></td>
						<td class="value">
							<g:select name="roleId" from="${roleList}" optionKey="id" optionValue="roleName" noSelection="['':'全て']" />
						</td>
					</tr>
</sec:ifAllGranted>

					<tr class="prop">
						<td class="name">${fieldNames?.User?.userId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="64" id="userId" name="userId" value="${params.userId?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.User?.familyName?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="512" id="familyName" name="familyName" value="${params.familyName?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.User?.firstName?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="512" id="firstName" name="firstName" value="${params.firstName?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td colspan="2" style="text-align: center;">
							<div class="searchButtons">
								<a href="javascript:void(0)" id="searchBtn" class="button"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
								<a href="javascript:void(0)" id="clearSearchConditionBtn" class="button"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
							</div>
						</td>
					</tr>

				</tbody>
			</table>
			</g:form>
		</div>

		<div class="paginateButtons paginateTopButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="userId" title="${fieldNames?.User?.userId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="email" title="${fieldNames?.User?.email?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="dateCreated" title="${fieldNames?.User?.dateCreated?.encodeAsHTML()}" params="${params}" />
						<th rowspan="2" class="vhcenter">詳細</th>
					</tr>
					<tr>
						<g:sortableColumn property="familyName" title="${fieldNames?.User?.familyName?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="enabled" title="${fieldNames?.User?.enabled?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastUpdated" title="${fieldNames?.User?.lastUpdated?.encodeAsHTML()}" params="${params}" />
					</tr>
				</thead>

				<tbody>
<g:if test="${!userList || (userList.size() <= 0)}">
					<tr>
						<td colspan="4" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
					<g:each in="${userList}" status="i" var="user">
					<tr>
						<td>
							<div class="tbpadding tbunderline">${user.userId?.encodeAsHTML()}</div>
							<div class="tbpadding">${user.familyName?.encodeAsHTML()}${user.firstName?.encodeAsHTML()}</div>
						</td>
						<td>
							<div class="tbpadding tbunderline">${user.email?.encodeAsHTML()}</div>
							<div class="tbpadding"><g:if test="${user.enabled}">有効</g:if><g:else>無効</g:else></div>
						</td>
						<td class="timestampCell">
							<div class="tbpadding tbunderline"><g:formatDate format="${timestampFormat}" date="${user?.dateCreated}" /></div>
							<div class="tbpadding"><g:formatDate format="${timestampFormat}" date="${user?.lastUpdated}" /></div>
						</td>
						<td class="vhcenter char2btnCell">
							<g:link action="edit" id="${user.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link>
						</td>
					</tr>
					</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

<g:form method="get" action="create" name="createForm">
</g:form>
<jq:jquery>
$('#createBtn').click(function() {
	document.createForm.submit();
	return false;
});
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
$('#searchBtn').click(function() {
	document.searhCondition.submit();
	return false;
});
$("#clearSearchConditionBtn").click(function() {
	$('#roleId').val("");
	$('#userId').val("");
	$('#userName').val("");
	return false;
});
$(".searchConditionFormArea table tbody tr.prop").evenodd();
</jq:jquery>

	</div>
</body>
</html>
