<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテム区分一覧</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>アイテム区分一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>アイテム区分一覧</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="createBtn" class="button"><span class="icon-create">アイテム区分の追加</span></a></span>
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

					<tr class="prop">
						<td class="name">${fieldNames?.ItemGenre?.serviceDivision?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="serviceDivision" from="${[[key:'1',value:'DMオンライン'],[key:'2',value:'オリジナル年賀はがき'],[key:'3',value:'オリジナルかもめ～る']]}" optionKey="key" optionValue="value" value="${params.serviceDivision}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.ItemGenre?.genreId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="genreId" name="genreId" value="${params.genreId?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.ItemGenre?.genreName?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="genreName" name="genreName" value="${params.genreName?.encodeAsHTML()}"/>
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
						<g:sortableColumn rowspan="2" property="serviceDivision" title="${fieldNames?.ItemGenre?.serviceDivision?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="genreId" title="${fieldNames?.ItemGenre?.genreId?.encodeAsHTML()}" params="${params}" />
						<th class="vhcenter">${fieldNames?.ItemGenre?.enabled?.encodeAsHTML()}</th>
						<g:sortableColumn property="dateCreated" title="${fieldNames?.ItemGenre?.dateCreated?.encodeAsHTML()}" params="${params}" />
						<th rowspan="2" class="vhcenter">詳細</th>
					</tr>
					<tr>
						<g:sortableColumn property="genreName" title="${fieldNames?.ItemGenre?.genreName?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="dispOrder" class="vhcenter" title="${fieldNames?.ItemGenre?.dispOrder?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastUpdated" title="${fieldNames?.ItemGenre?.lastUpdated?.encodeAsHTML()}" params="${params}" />
						</tr>
					</thead>

					<tbody>
<g:if test="${!itemGenreList || (itemGenreList.size() <= 0)}">
						<tr>
							<td colspan="5" class="vhcenter">見つかりませんでした</td>
						</tr>
</g:if>
					<g:each in="${itemGenreList}" status="i" var="itemGenre">
					<tr>
						<td style="width:10em;"><g:if test="${itemGenre.serviceDivision == 1}">DMオンライン</g:if><g:elseif test="${itemGenre.serviceDivision == 2}">オリジナル年賀はがき</g:elseif><g:elseif test="${itemGenre.serviceDivision == 3}">オリジナルかもめ～る</g:elseif><g:elseif test="${itemGenre.serviceDivision == 9999}">デザイン面</g:elseif><g:else>不明</g:else></td>
						<td>
							<div class="tbpadding tbunderline">${fieldValue(bean:itemGenre, field:'genreId')}</div>
							<div class="tbpadding">${fieldValue(bean:itemGenre, field:'genreName')}</div>
						</td>
						<td class="vhcenter flagCell">
							<div class="tbpadding tbunderline"><g:if test="${itemGenre?.enabled}">有効</g:if><g:else>無効</g:else></div>
							<div class="tbpadding">${fieldValue(bean:itemGenre, field:'dispOrder')}</div>
						</td>
						<td class="timestampCell">
							<div class="tbpadding tbunderline"><g:formatDate format="${timestampFormat}" date="${itemGenre?.dateCreated}" /></div>
							<div class="tbpadding"><g:formatDate format="${timestampFormat}" date="${itemGenre?.lastUpdated}" /></div>
							
						</td>
						<td class="vhcenter char2btnCell"><g:link action="edit" id="${itemGenre.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link></td>
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
	$('#serviceDivision').val("");
	$('#genreId').val("");
	$('#genreName').val("");
	return false;
});
$(".searchConditionFormArea table tbody tr.prop").evenodd();
});</r:script>
</body>
</html>
