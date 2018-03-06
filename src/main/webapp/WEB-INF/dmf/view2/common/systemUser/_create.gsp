<g:if test="${false}">
/**
 * @param targetName 対象の名前:"JPOST"|"印刷会社"|"JPMD"|"管理者"
 * @param jpostUser	true|false JPユーザ識別フラグ
 */
</g:if>
<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>${targetName}ユーザの追加</title>
	<g:javascript library="jquery" plugin="jquery" />
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${resource(dir:'')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">${targetName}ユーザ一覧</g:link></li>
			<li>${targetName}ユーザの追加</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>${targetName}ユーザの追加</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="addBtn" class="button"><span class="icon-save">追加</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />
		<g:hasErrors bean="${user}">
		<div class="errors">
			<g:renderErrors bean="${user}" as="list" />
		</div>
		</g:hasErrors>

		<g:form name="addForm" action="save" method="post" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name"><label for="roleId">${clazzNames?.Role?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'role','errors')}">
								<g:select id="roleId" name="roleId" from="${roleList}" value="${user?.role}" optionKey="id" optionValue="roleName" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="userId">${fieldNames?.User?.userId?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'userId','errors')}">
								<input type="text" size="40" maxlength="64" id="userId" name="userId" value="${user.userId?.encodeAsHTML()}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="passwd">${fieldNames?.User?.passwd?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'passwd','errors')}">
								<input type="text" size="40" maxlength="64" id="passwd" name="passwd" style="ime-mode:disabled" value="${user.passwd?.encodeAsHTML()}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="enabled">${fieldNames?.User?.enabled?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'enabled','errors')}">
								<g:checkBox name="enabled" value="${user.enabled}" ></g:checkBox>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="familyName">${fieldNames?.User?.familyName?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'familyName','errors')}">
								<input type="text" size="40" maxlength="128" id="familyName" name="familyName" value="${user.familyName?.encodeAsHTML()}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="firstName">${fieldNames?.User?.firstName?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'firstName','errors')}">
								<input type="text" size="40" maxlength="128" id="firstName" name="firstName" value="${user.firstName?.encodeAsHTML()}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="email">${fieldNames?.User?.email?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'email','errors')}">
								<input type="text" size="40" maxlength="512" id="email" name="email" value="${user.email?.encodeAsHTML()}"/>
							</td>
						</tr>

<g:if test="${jpostUser}">
						<tr class="prop">
							<td valign="top" class="name"><label for="kyokusyoCd">${fieldNames?.User?.kyokusyoCd?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'kyokusyoCd','errors')}">
								<input type="text" size="10" maxlength="6" id="kyokusyoCd" name="kyokusyoCd" value="${user.kyokusyoCd?.encodeAsHTML()}"/>
							</td>
						</tr>
</g:if>

					</tbody>
				</table>
			</div>
		</g:form>

<jq:jquery>
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
</jq:jquery>
<g:form method="get" action="list" name="cancelForm"></g:form>

	</div>
</body>
</html>
