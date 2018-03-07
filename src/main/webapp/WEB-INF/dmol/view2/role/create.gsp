<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>ロールの追加</title>
</head>

<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">ロール一覧</g:link></li>
			<li>ロールの追加</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>ロールの追加</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="addBtn" class="button"><span class="icon-save">追加</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>
		<g:hasErrors bean="${role}">
		<div class="errors">
			<g:renderErrors bean="${role}" as="list" />
		</div>
		</g:hasErrors>

		<g:form action="save" method="post" name="addForm" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td class="name">${fieldNames?.Role?.groupType?.encodeAsHTML()}:</td>
							<td class="value">
								<g:select name="groupType" from="${groupTypeList}" optionKey="key" optionValue="value" value="${role.groupType}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="roleId">${fieldNames?.Role?.roleId?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:role,field:'roleId','errors')}">
								<input type="text" size="40" maxlength="256" id="roleId" name="roleId" value="${fieldValue(bean:role,field:'roleId')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="roleName">${fieldNames?.Role?.roleName?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:role,field:'roleName','errors')}">
								<input type="text" size="40" maxlength="256" id="roleName" name="roleName" value="${fieldValue(bean:role,field:'roleName')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="description">${fieldNames?.Role?.description?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:role,field:'description','errors')}">
								<textarea rows="5" cols="40" name="description">${fieldValue(bean:role, field:'description')}</textarea>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="authorities">${fieldNames?.Role?.authorities?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:role,field:'authorities','errors')}">
								<ul>
								<g:each var="authority" in="${authorityList}">
<g:if test="${!authority.internal}">
									<li>
										<g:checkBox name="${authority.authority.encodeAsHTML()}" value="true" checked="${role?.authorities4Acegi?.contains(authority)}" />
										<label for="${authority.authority.encodeAsHTML()}">${authority.authority.encodeAsHTML()} <g:if test="${authority?.authorityName}">(${authority?.authorityName?.encodeAsHTML()})</g:if></label>
									</li>
</g:if>
								</g:each>
								</ul>
							</td>
						</tr> 

					</tbody>
				</table>
			</div>
		</g:form>

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
