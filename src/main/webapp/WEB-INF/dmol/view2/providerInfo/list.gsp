<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>プロバイダ一覧</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>プロバイダ</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>デフォルトプロバイダ</h1>

<g:render template="/common/fragment/flashmessages" />

		<div class="list">
			<table>
				<thead>
					<tr>
						<th></th>
						<th>プロバイダ名称</th>
						<th>プロバイダURLプレフィックス</th>
						<th>プロバイダユーザID</th>
						<th class="vhcenter">編集</th>
					</tr>
				</thead>
				<tbody>
					<tr class="prop">
						<td class="providerTypeName">テンプレートプロバイダ</td>
						<td class="providerName">${defaultTemplateProvider.providerName?.encodeAsHTML()}</td>
						<td class="providerURLPrefix">${defaultTemplateProvider.providerURLPrefix?.encodeAsHTML()}</td>
						<td class="providerUserId">${defaultTemplateProvider.providerUserId?.encodeAsHTML()}</td>
						<td class="vhcenter char2btnCell"><a href="javascript:void(0)" id="editDefaultTemplateProviderBtn" class="button">編集</a></td>
					</tr>
<g:if test="${false}">
					<tr class="prop">
						<td class="providerTypeName">カセットプロバイダ</td>
						<td class="providerName">${defaultCassetteProvider.providerName?.encodeAsHTML()}</td>
						<td class="providerURLPrefix">${defaultCassetteProvider.providerURLPrefix?.encodeAsHTML()}</td>
						<td class="providerUserId">${defaultCassetteProvider.providerUserId?.encodeAsHTML()}</td>
						<td class="vhcenter char2btnCell"><a href="javascript:void(0)" id="editDefaultCassetteProviderBtn" class="button">編集</a></td>
					</tr>
</g:if>
					<tr class="prop">
						<td class="providerTypeName">素材プロバイダ</td>
						<td class="providerName">${defaultMaterialProvider.providerName?.encodeAsHTML()}</td>
						<td class="providerURLPrefix">${defaultMaterialProvider.providerURLPrefix?.encodeAsHTML()}</td>
						<td class="providerUserId">${defaultMaterialProvider.providerUserId?.encodeAsHTML()}</td>
						<td class="vhcenter char2btnCell"><a href="javascript:void(0)" id="editDefaultMaterialProviderBtn" class="button">編集</a></td>
					</tr>
				</tbody>
			</table>
		</div>

<g:if test="${false}">
		<h2 style="margin-top: 1em;">素材プロバイダ一覧</h2>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="createMaterialProviderBtn" class="button"><span class="icon-create">素材プロバイダの追加</span></a></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message">${flash.message?.encodeAsHTML()}</div>
		</g:if>

		<div class="searchConditiontoggler" style="margin-top: 0.5em;"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
		<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="display:none;">
			<g:form method="get" action="list" name="searhCondition">
			<g:hiddenField name="sort" value="${params.sort?.encodeAsHTML()}" />
			<g:hiddenField name="order" value="${params.order?.encodeAsHTML()}" />
			<g:hiddenField name="search" value="true" />
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.ProviderInfo?.providerId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="10" maxlength="3" id="providerId" name="providerId" value="${params.providerId?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.ProviderInfo?.providerName?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="128" id="providerName" name="providerName" value="${params.providerName?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.ProviderInfo?.providerURLPrefix?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="512" id="providerURLPrefix" name="providerURLPrefix" value="${params.providerURLPrefix?.encodeAsHTML()}"/>
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

<g:set var="columnCount" value="6" />
		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="providerId" title="${fieldNames?.ProviderInfo?.providerId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="providerName" title="${fieldNames?.ProviderInfo?.providerName?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn rowspan="2" class="vhcenter" property="providerUserId" title="${fieldNames?.ProviderInfo?.providerUserId?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="dateCreated" title="${fieldNames?.ProviderInfo?.dateCreated?.encodeAsHTML()}" params="${params}" />
						<th rowspan="2" class="vhcenter">編集</th>
						<th rowspan="2" class="vhcenter">削除</th>
					</tr>
					<tr>
						<g:sortableColumn property="enabled" title="${fieldNames?.ProviderInfo?.enabled?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="providerURLPrefix" title="${fieldNames?.ProviderInfo?.providerURLPrefix?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="lastUpdated" title="${fieldNames?.ProviderInfo?.lastUpdated?.encodeAsHTML()}" params="${params}" />
					</tr>
				</thead>

				<tbody>
<g:if test="${!providerList || (providerList.size() <= 0)}">
					<tr>
						<td colspan="${columnCount}" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
					<g:each in="${providerList}" status="i" var="provider">
					<tr>
						<td>
							<div class="tbpadding tbunderline">${provider.providerId?.encodeAsHTML()}</div>
							<div class="tbpadding"><g:if test="${provider.enabled}">有効</g:if><g:else>無効</g:else></div>
						</td>
						<td>
							<div class="tbpadding tbunderline">${provider.providerName?.encodeAsHTML()}</div>
							<div class="tbpadding">${provider.providerURLPrefix?.encodeAsHTML()}</div>
						</td>
						<td class="vhcenter">
							${provider.providerUserId?.encodeAsHTML()}
						</td>
						<td class="timestampCell">
							<div class="tbpadding tbunderline"><g:formatDate format="${timestampFormat}" date="${provider?.dateCreated}" /></div>
							<div class="tbpadding"><g:formatDate format="${timestampFormat}" date="${provider?.lastUpdated}" /></div>
						</td>
						<td class="vhcenter char2btnCell">
							<a href="javascript:void(0)" id="edit_${provider?.id?.encodeAsHTML()}" class="editMaterialProviderBtn button"><span class="nowrap">編集</span></a>
							<input type="hidden" id="materialVersion_${provider?.id?.encodeAsHTML()}" value="${provider?.version?.encodeAsHTML()}" />
							<input type="hidden" id="materialEnabled_${provider?.id?.encodeAsHTML()}" value="${provider?.enabled?.encodeAsHTML()}" />
							<input type="hidden" id="materialProviderId_${provider?.id?.encodeAsHTML()}" value="${provider?.providerId?.encodeAsHTML()}" />
							<input type="hidden" id="materialProviderName_${provider?.id?.encodeAsHTML()}" value="${provider?.providerName?.encodeAsHTML()}" />
							<input type="hidden" id="materialProviderURLPrefix_${provider?.id?.encodeAsHTML()}" value="${provider?.providerURLPrefix?.encodeAsHTML()}" />
							<input type="hidden" id="materialProviderUserId_${provider?.id?.encodeAsHTML()}" value="${provider?.providerUserId?.encodeAsHTML()}" />
						</td>
						<td class="vhcenter char2btnCell">
							<a href="javascript:void(0)"  id="remove_${provider?.id?.encodeAsHTML()}" class="removeMaterialProviderBtn button"><span class="nowrap">削除</span></a>
						</td>
					</tr>
					</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>
</g:if>

	</div>

<div id="defaultProviderDialog" title="デフォルトプロバイダの編集" style="display:none;">
	<div class="dialog">
		<form id="defaultProviderDialogForm" name="defaultProviderDialogForm">
		<table>
			<tbody>
				<tr class="props">
					<td class="name">プロバイダ名称</td>
					<td class="value"><input type="text" id="defaultProviderName" name="defaultProviderName" size="40" maxlength="128" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">プロバイダURLプレフィックス</td>
					<td class="value"><input type="text" id="defaultProviderURLPrefix" name="defaultProviderURLPrefix" size="70" maxlength="512" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">プロバイダユーザID</td>
					<td class="value"><input type="text" id="defaultProviderUserId" name="defaultProviderUserId" size="40" maxlength="64" value="" /></td>
				</tr>
			</tbody>
		</table>
		</form>

		<div class="errors" id="defaultValidatorMessageArea" style="display:none;">
			<ul id="defaultValidatorMessageBox"></ul>
		</div>
	</div>
</div>
<g:form name="editDefaultProviderForm" action="editDefaultProvider" onsubmit="return false;">
<input type="hidden" name="pid" value="" />
<input type="hidden" name="version" value="" />
<input type="hidden" name="providerType" value="" />
<input type="hidden" name="providerName" value="" />
<input type="hidden" name="providerURLPrefix" value="" />
<input type="hidden" name="providerUserId" value="" />
</g:form>
<r:script>
;jQuery(function(){
var defaultProviderFormValidator = $("#defaultProviderDialogForm").validate({
	errorContainer:"#defaultValidatorMessageArea",
	errorLabelContainer:"#defaultValidatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		defaultProviderName:{
			required:false,
			maxlength:128
		},
		defaultProviderURLPrefix:{
			required:true,
			looseurl:true,
			maxlength:512
		},
		defaultProviderUserId:{
			required:true,
			maxlength:64
		}
	}
});
var editDefaultProviderDialog = function(id,version,providerType) {
	var jqDialog = $("#defaultProviderDialog");
	jqDialog.dialog({
		autoOpen: false,
		resizable: true,
		width: 600,
		height: 260,
		minWidth: 480,
		minHeight: 220,
		modal: true,
		overley: { backGroundColor:'#000', opacity:0.5 },
		buttons: [
			{
				text:"更新",
				click:function() {
					if (defaultProviderFormValidator.form()) {
						jqDialog.dialog('close');
						document.editDefaultProviderForm.pid.value = id;
						document.editDefaultProviderForm.version.value = version;
						document.editDefaultProviderForm.providerType.value = providerType;
						document.editDefaultProviderForm.providerName.value = $("#defaultProviderName").val();
						document.editDefaultProviderForm.providerURLPrefix.value = $("#defaultProviderURLPrefix").val();
						document.editDefaultProviderForm.providerUserId.value = $("#defaultProviderUserId").val();
						document.editDefaultProviderForm.submit();
						pleaseWait();
					}
				}
			},
			{
				text:"キャンセル",
				click:function() {
					jqDialog.dialog('close');
				}
			}
		],
		open: function() {
			OIY.Dialog.closeOnEnterKeypressed(this);
			$("div.dialog table tbody tr:visible", jqDialog).removeClass('even odd').filter(":even").addClass('even').end().filter(':odd').addClass('odd');
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	defaultProviderFormValidator.resetForm();
	jqDialog.dialog('open');
	return false;
};
$("#editDefaultTemplateProviderBtn").click(function(){
	$("#defaultProviderName").val("${defaultTemplateProvider.providerName?.encodeAsHTML()}");
	$("#defaultProviderURLPrefix").val("${defaultTemplateProvider.providerURLPrefix?.encodeAsHTML()}");
	$("#defaultProviderUserId").val("${defaultTemplateProvider.providerUserId?.encodeAsHTML()}");
	return editDefaultProviderDialog("${defaultTemplateProvider.id?.encodeAsHTML()}", ${defaultTemplateProvider.version}, "${defaultTemplateProvider.providerType?.encodeAsHTML()}");
});
<g:if test="${false}">
$("#editDefaultCassetteProviderBtn").click(function(){
	$("#defaultProviderName").val("${defaultCassetteProvider.providerName?.encodeAsHTML()}");
	$("#defaultProviderURLPrefix").val("${defaultCassetteProvider.providerURLPrefix?.encodeAsHTML()}");
	$("#defaultProviderUserId").val("${defaultCassetteProvider.providerUserId?.encodeAsHTML()}");
	return editDefaultProviderDialog("${defaultCassetteProvider.id?.encodeAsHTML()}", ${defaultCassetteProvider.version}, "${defaultCassetteProvider.providerType?.encodeAsHTML()}");
});
</g:if>
$("#editDefaultMaterialProviderBtn").click(function(){
	$("#defaultProviderName").val("${defaultMaterialProvider.providerName?.encodeAsHTML()}");
	$("#defaultProviderURLPrefix").val("${defaultMaterialProvider.providerURLPrefix?.encodeAsHTML()}");
	$("#defaultProviderUserId").val("${defaultMaterialProvider.providerUserId?.encodeAsHTML()}");
	return editDefaultProviderDialog("${defaultMaterialProvider.id?.encodeAsHTML()}", ${defaultMaterialProvider.version}, "${defaultMaterialProvider.providerType?.encodeAsHTML()}");
});
});</r:script>

<g:if test="${false}">
<div id="materialProviderDialog" title="素材プロバイダの編集" style="display:none;">
	<div class="dialog">
		<form id="materialProviderDialogForm" name="materialProviderDialogForm">
		<table>
			<tbody>
				<tr class="props">
					<td class="name">プロバイダ識別子</td>
					<td class="value"><input type="text" id="materialProviderId" name="materialProviderId" size="10" maxlength="3" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">プロバイダ名称</td>
					<td class="value"><input type="text" id="materialProviderName" name="materialProviderName" size="40" maxlength="128" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">プロバイダURLプレフィックス</td>
					<td class="value"><input type="text" id="materialProviderURLPrefix" name="materialProviderURLPrefix" size="70" maxlength="512" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">プロバイダユーザID</td>
					<td class="value"><input type="text" id="materialProviderUserId" name="materialProviderUserId" size="40" maxlength="64" value="" /></td>
				</tr>
				<tr class="props">
					<td class="name">有効フラグ</td>
					<td class="value"><input type="checkbox" id="materialEnabled" name="materialEnabled" value="true" /></td>
				</tr>
			</tbody>
		</table>
		</form>

		<div class="errors" id="materialValidatorMessageArea" style="display:none;">
			<ul id="materialValidatorMessageBox"></ul>
		</div>
	</div>
</div>
<g:form name="editMaterialProviderForm" action="editMaterialProvider" onsubmit="return false;">
<input type="hidden" name="pid" value="" />
<input type="hidden" name="version" value="" />
<input type="hidden" name="providerType" value="${jp.co.reso.oiy.core.domain.system.ProviderInfo.PROVIDER_TYPE_MATERIAL}" />
<input type="hidden" name="enabled" value="" />
<input type="hidden" name="providerId" value="" />
<input type="hidden" name="providerName" value="" />
<input type="hidden" name="providerURLPrefix" value="" />
<input type="hidden" name="providerUserId" value="" />
</g:form>
<g:form name="removeMaterialProviderForm" action="removeMaterialProvider" onsubmit="return false;">
<input type="hidden" name="pid" value="" />
<input type="hidden" name="providerType" value="${jp.co.reso.oiy.core.domain.system.ProviderInfo.PROVIDER_TYPE_MATERIAL}" />
</g:form>
<r:script>
;jQuery(function(){
var materialProviderFormValidator = $("#materialProviderDialogForm").validate({
	errorContainer:"#materialValidatorMessageArea",
	errorLabelContainer:"#materialValidatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		materialProviderId:{
			required:true,
			alphanum:true,
			minlength:3,
			maxlength:3
		},
		materialProviderName:{
			required:true,
			maxlength:128
		},
		materialProviderURLPrefix:{
			required:true,
			looseurl:true,
			maxlength:512
		},
		materialProviderUserId:{
			required:true,
			maxlength:64
		}
	}
});
var editMaterialProviderSubmitHandler = function(dialog, id, version) {
	if (materialProviderFormValidator.form()) {
		dialog.dialog('close');
		document.editMaterialProviderForm.pid.value = id;
		document.editMaterialProviderForm.version.value = version;
		document.editMaterialProviderForm.providerId.value = $("#materialProviderId").val();
		document.editMaterialProviderForm.providerName.value = $("#materialProviderName").val();
		document.editMaterialProviderForm.providerURLPrefix.value = $("#materialProviderURLPrefix").val();
		document.editMaterialProviderForm.providerUserId.value = $("#materialProviderUserId").val();
		document.editMaterialProviderForm.enabled.value = $("#materialEnabled").isChecked() ? true : false;
		document.editMaterialProviderForm.submit();
		pleaseWait();
	}
};
var editMaterialProviderDialog = function(id, version, enabled, providerId, providerName, providerURLPrefix, providerUserId) {
	$("#materialProviderId").val(providerId);
	$("#materialProviderName").val(providerName);
	$("#materialProviderURLPrefix").val(providerURLPrefix);
	$("#materialProviderUserId").val(providerUserId);
	$("#materialEnabled").setChecked(enabled);
	var jqDialog = $("#materialProviderDialog");
	jqDialog.dialog({
		autoOpen: false,
		resizable: true,
		width: 600,
		height: 360,
		minWidth: 480,
		minHeight: 280,
		modal: true,
		overley: { backGroundColor:'#000', opacity:0.5 },
		buttons: [
			{
				text:"OK",
				click:function() {
					editMaterialProviderSubmitHandler(jqDialog, id, version);
				}
			},
			{
				text:"キャンセル",
				click:function() {
					jqDialog.dialog('close');
				}
			}
		],
		open: function() {
			OIY.Dialog.closeOnEnterKeypressed(this);
			$("div.dialog table tbody tr:visible", jqDialog).removeClass('even odd').filter(":even").addClass('even').end().filter(':odd').addClass('odd');
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	materialProviderFormValidator.resetForm();
	jqDialog.dialog('open');
	return false;
};

var getUniqueId = function(elementId) {
	if (elementId) {
		var pos = elementId.indexOf('_');
		if (pos > 0) {
			return elementId.substring(pos + 1);
		}
	}
	return null;
};
$("#createMaterialProviderBtn").click(function(){
	return editMaterialProviderDialog('', '', true, '', '', '', '');
});
$(".editMaterialProviderBtn").click(function(){
	var id = getUniqueId($(this).attr('id'));
	if (id) {
		var version = $("#materialVersion_" + id).val();
		var enabled = $("#materialEnabled_" + id).val() == 'true';
		var providerId = $("#materialProviderId_" + id).val();
		var providerName = $("#materialProviderName_" + id).val();
		var providerURLPrefix = $("#materialProviderURLPrefix_" + id).val();
		var providerUserId = $("#materialProviderUserId_" + id).val();
		return editMaterialProviderDialog(id, version, enabled, providerId, providerName, providerURLPrefix, providerUserId);
	}
});
$(".removeMaterialProviderBtn").click(function(){
	var id = getUniqueId($(this).attr('id'));
	if (id) {
		document.removeMaterialProviderForm.pid.value = id;
		return confirmRemove(document.removeMaterialProviderForm);
	}
});
});</r:script>
</g:if>

<r:script>
;jQuery(function(){
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
$('#searchBtn').click(function() {
	document.searhCondition.submit();
	return false;
});
$("#clearSearchConditionBtn").click(function() {
	$('#providerId').val("");
	$('#providerName').val("");
	$('#providerURLPrefix').val("");
	return false;
});
});</r:script>
</body>
</html>