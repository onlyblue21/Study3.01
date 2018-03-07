<%@page import="jp.co.reso.oiy.dmol.domain.user.UserGroup" %>
<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>ロール一覧</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>ロール一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>ロール一覧</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="createBtn" class="button"><span class="icon-create">ロールの追加</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<div class="searchConditiontoggler"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
		<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="display:none;">
			<g:form method="get" action="list" name="searhCondition">
			<g:hiddenField name="sort" value="${params.sort?.encodeAsHTML()}" />
			<g:hiddenField name="order" value="${params.order?.encodeAsHTML()}" />
			<g:hiddenField name="search" value="true" />
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.Role?.groupType?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="groupType" from="${groupTypeList}" optionKey="key" optionValue="value" value="${params.groupType}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.Role?.roleId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="roleId" name="roleId" value="${params.roleId?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.Role?.roleName?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="roleName" name="roleName" value="${params.roleName?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.Role?.description?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="description" name="description" value="${params.description?.encodeAsHTML()}"/>
							(部分一致)
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
						<g:sortableColumn property="groupType" title="${fieldNames?.Role?.groupType?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="roleId" title="${fieldNames?.Role?.roleId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="roleName" title="${fieldNames?.Role?.roleName?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="dateCreated" title="${fieldNames?.Role?.dateCreated?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastUpdated" title="${fieldNames?.Role?.lastUpdated?.encodeAsHTML()}" params="${params}" />
						<th class="vhcenter">詳細</th>
					</tr>
				</thead>

				<tbody>
<g:if test="${!roleList || (roleList.size() <= 0)}">
					<tr>
						<td colspan="6" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
				<g:each in="${roleList}" status="i" var="role">
					<tr>
						<td>${UserGroup.getGroupTypeName(role.groupType)?.encodeAsHTML()}</td>
						<td>${fieldValue(bean:role, field:'roleId')}</td>
						<td>${fieldValue(bean:role, field:'roleName')}</td>
						<td class="timestampCell"><g:formatDate format="${timestampFormat}" date="${role?.dateCreated}" /></td>
						<td class="timestampCell"><g:formatDate format="${timestampFormat}" date="${role?.lastUpdated}" /></td>
						<td class="vhcenter char2btnCell"><g:link action="edit" id="${role.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

	</div>

<g:form method="get" action="create" name="createForm"></g:form>
<r:script>
;jQuery(function(){
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
	$('#groupType').val("");
	$('#roleId').val("");
	$('#roleName').val("");
	$('#description').val("");
	return false;
});
$(".searchConditionFormArea table tbody tr.prop").evenodd();
});</r:script>
</body>
</html>
