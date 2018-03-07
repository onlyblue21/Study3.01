<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテム区分の追加</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">アイテム区分一覧</g:link></li>
			<li>アイテム区分の追加</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>アイテム区分の追加</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="addBtn" class="button"><span class="icon-save">追加</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />
		<g:hasErrors bean="${itemGenre}">
		<div class="errors">
			<g:renderErrors bean="${itemGenre}" as="list" />
		</div>
		</g:hasErrors>

		<g:uploadForm action="save" method="post" name="addForm" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="genreId">${fieldNames?.ItemGenre?.serviceDivision?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'serviceDivision','errors')}">
								<g:select name="serviceDivision" from="${[[key:'1',value:'DMオンライン'],[key:'2',value:'オリジナル年賀はがき'],[key:'3',value:'オリジナルかもめ～る'],[key:'9999',value:'デザイン面']]}" optionKey="key" optionValue="value" value="${fieldValue(bean:itemGenre,field:'serviceDivision')}" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="genreId">${fieldNames?.ItemGenre?.genreId?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'genreId','errors')}">
								<input type="text" size="40" maxlength="256" id="genreId" name="genreId" value="${fieldValue(bean:itemGenre,field:'genreId')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="genreName">${fieldNames?.ItemGenre?.genreName?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'genreName','errors')}">
								<input type="text" size="40" maxlength="256" id="genreName" name="genreName" value="${fieldValue(bean:itemGenre,field:'genreName')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name"><label for="enabled">${fieldNames?.ItemGenre?.enabled?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'enabled','errors')}">
								<g:checkBox name="enabled" value="${itemGenre.enabled}" ></g:checkBox>
							</td>
						</tr>

<g:if test="${false}">
						<tr class="prop">
							<td valign="top" class="name"><label for="layoutEditable">${fieldNames?.ItemGenre?.layoutEditable?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'layoutEditable','errors')}">
								<g:checkBox name="layoutEditable" value="${itemGenre.layoutEditable}" ></g:checkBox>
							</td>
						</tr>
</g:if>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="description">${fieldNames?.ItemGenre?.description?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'description','errors')}">
								<textarea rows="5" cols="40" name="description">${fieldValue(bean:itemGenre, field:'description')}</textarea>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="dispOrder">${fieldNames?.ItemGenre?.dispOrder?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemGenre,field:'dispOrder','errors')}">
								<input type="text" size="20" maxlength="10" id="dispOrder" name="dispOrder" value="${fieldValue(bean:itemGenre,field:'dispOrder')}"/>
							</td>
						</tr> 

					</tbody>
				</table>
			</div>
		</g:uploadForm>

	</div>

<g:form method="get" action="list" name="cancelForm"></g:form>
<r:script>
;jQuery(function(){
$("#addBtn").click(function() {
	pleaseWait();
	document.addForm.submit();
	return false;
});
$('#cancelBtn').click(function() {
	document.cancelForm.submit();
	return false;
});
$("a.transition").click(function() {
	return confirmTransition(this.href);
});
});</r:script>
</body>
</html>
