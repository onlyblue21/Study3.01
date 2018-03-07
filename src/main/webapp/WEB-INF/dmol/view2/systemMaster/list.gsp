<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>システムマスター一覧</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>システムマスター一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>システムマスター一覧</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="editBtn" class="button"><span class="icon-edit">システムマスターの更新</span></a></span>
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
						<td class="name">${fieldNames?.SystemMaster?.uniqueId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="128" id="uniqueId" name="uniqueId" value="${params.uniqueId?.encodeAsHTML()}"/>
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
						<g:sortableColumn property="uniqueId" title="${fieldNames?.SystemMaster?.uniqueId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="description" title="${fieldNames?.SystemMaster?.description?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastUpdated" title="${fieldNames?.SystemMaster?.lastUpdated?.encodeAsHTML()}" params="${params}" />
						<th class="vhcenter">ダウンロード</th>
						<th class="vhcenter">削除</th>
					</tr>
				</thead>

				<tbody>
<g:if test="${!systemMasterList || (systemMasterList.size() <= 0)}">
					<tr>
						<td colspan="5" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
				<g:each in="${systemMasterList}" status="i" var="systemMaster">
					<tr>
						<td>
							${fieldValue(bean:systemMaster, field:'uniqueId')}
						</td>
						<td>${fieldValue(bean:systemMaster, field:'description')}</td>
						<td class="timestampCell"><g:formatDate format="${timestampFormat}" date="${systemMaster?.lastUpdated}" /></td>
						<td class="vhcenter image6btnCell" style="padding: 8px 0 8px 0;">
<g:if test="${systemMaster.props}">
							<g:link action="download" id="${systemMaster.id?.encodeAsHTML()}" target="_blank" class="button"><span class="icon-download">ダウンロード</span></g:link>
</g:if>
<g:else>
							空
</g:else>
						</td>
						<td class="vhcenter image2btnCell" style="padding: 8px 0 8px 0;">
							<a href="javascript:void(0)" id="delete_${systemMaster?.id?.encodeAsHTML()}" class="button"><span class="icon-delete">削除</span></a>
						</td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

	</div>

<g:form method="get" action="edit" name="editForm"></g:form>
<g:form action="delete" name="deleteForm">
<input type="hidden" name="id" value="" />
</g:form>
<r:script>
;jQuery(function(){
$('#editBtn').click(function() {
	document.editForm.submit();
	return false;
});
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
var onClickDeleteBtn = function(id) {
	document.deleteForm.id.value = id;
	return confirmRemove(document.deleteForm);
};
<g:each in="${systemMasterList}" status="i" var="systemMaster">
$("#delete_${systemMaster?.id?.encodeAsHTML()}").click(function() {
	return onClickDeleteBtn("${systemMaster?.id?.encodeAsHTML()}");
});
</g:each>
$('#searchBtn').click(function() {
	document.searhCondition.submit();
	return false;
});
$("#clearSearchConditionBtn").click(function() {
	document.searhCondition.uniqueId.value = '';
	return false;
});
});</r:script>
</body>
</html>