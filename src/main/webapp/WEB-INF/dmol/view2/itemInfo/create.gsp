<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>アイテム（テンプレート）の追加</title>
	<r:require module="application-templateDialog" />
	<r:require module="application-utils" />
	<r:require module="application-js-listfunc" />
</head>

<body>
    <div id="panel" style="display:none;text-align:left;"></div>

<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">アイテム（テンプレート）一覧</g:link></li>
			<li>アイテム（テンプレート）の追加</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>アイテム（テンプレート）の追加</h1>

		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="addBtn" class="button"><span class="icon-save">追加</span></a></span>
			<span class="button"><a href="javascript:void(0)" id="cancelBtn" class="button"><span class="icon-cancel">キャンセル</span></a></span>
		</div>

<g:render template="/common/fragment/flashmessages" />
		<g:hasErrors bean="${itemInfo}">
		<div class="errors">
			<g:renderErrors bean="${itemInfo}" as="list" />
		</div>
		</g:hasErrors>
<g:render template="/common/fragment/validatormessages" />

		<g:form action="save" method="post" name="addForm" onsubmit="return false;">
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="genreId">${fieldNames?.ItemInfo?.itemGenre?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'itemGenre.id','errors')}">
								<g:select id="genreId" name="itemGenre.id" from="${itemGenreList}" optionKey="id" optionValue="genreName" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="itemNo">${fieldNames?.ItemInfo?.itemNo?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'itemNo','errors')}">
								<input type="text" size="40" maxlength="128" id="itemNo" name="itemNo" value="${fieldValue(bean:itemInfo,field:'itemNo')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="itemName">${fieldNames?.ItemInfo?.itemName?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'itemName','errors')}">
								<input type="text" size="40" maxlength="128" id="itemName" name="itemName" value="${fieldValue(bean:itemInfo,field:'itemName')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name"><label for="enabled">${fieldNames?.ItemInfo?.enabled?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'enabled','errors')}">
								<g:checkBox name="enabled" value="${itemInfo.enabled}" ></g:checkBox>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="templateType">${fieldNames?.ItemInfo?.templateType?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'templateType','errors')}">
<g:render template="/common/fragment/templateTypeList" model="[templateTypeValue:itemInfo.templateType]"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="paperSizeId">${fieldNames?.ItemInfo?.paperSizeId?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'paperSizeId','errors')}">
								<g:select id="paperSizeId" name="paperSizeId" from="${paperSizeList}" value="${itemInfo?.paperSizeId}" optionKey="paperSizeId" optionValue="paperSizeDispName" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="printFace">${fieldNames?.ItemInfo?.printFace?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'printFace','errors')}">
								<g:select id="printFace" name="printFace" from="${printFaceList}" value="${itemInfo?.printFace}" optionKey="printFace" optionValue="printFaceName" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								<label for="numberOfColors">${fieldNames?.ItemInfo?.numberOfColors?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'numberOfColors','errors')}">
								<g:select id="numberOfColors" name="numberOfColors" from="${numberOfColorsList}" value="${itemInfo?.numberOfColors}" optionKey="numberOfColors" optionValue="numberOfColorsName" />
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name"><label for="addPartsDisabled">${fieldNames?.ItemInfo?.addPartsDisabled?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'addPartsDisabled','errors')}">
								<g:checkBox name="addPartsDisabled" value="${itemInfo.addPartsDisabled}" ></g:checkBox>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="dispOrder">${fieldNames?.ItemInfo?.dispOrder?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'dispOrder','errors')}">
								<input type="text" size="20" maxlength="10" id="dispOrder" name="dispOrder" value="${fieldValue(bean:itemInfo,field:'dispOrder')}"/>
							</td>
						</tr> 

						<tr class="prop">
							<td valign="top" class="name">
								カラー:
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'tag','errors')}">
<g:each in="${colorCategoryList}" status="i" var="colorCategory">
								<input type="checkbox" id="colorCategory_${i}" name="tag" value="${colorCategory.category}" ${params.tagmap[colorCategory.category] ? 'checked="checked"' : '' }/> <label for="colorCategory_${i}">${colorCategory.categoryName}</label> 
</g:each>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								季節・イベント:
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'tag','errors')}">
<g:each in="${seasonCategoryList}" status="i" var="seasonCategory">
								<input type="checkbox" id="seasonCategory_${i}" name="tag" value="${seasonCategory.category}" ${params.tagmap[seasonCategory.category] ? 'checked="checked"' : '' }/> <label for="seasonCategory_${i}">${seasonCategory.categoryName}</label> 
</g:each>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="templateName">テンプレート:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'trackingId','errors')}">
								<input type="hidden" id="selectedTemplateTrackingId" name="trackingId" value="${fieldValue(bean:itemInfo,field:'trackingId')}" />
								<input type="hidden" id="selectedTemplateName" name="templateName" value="${fieldValue(bean:itemInfo,field:'templateName')}" />
								<input type="hidden" id="selectedTemplatePageCount" name="pageCount" value="${fieldValue(bean:itemInfo,field:'pageCount')}" />
								<input type="hidden" id="selectedTemplateWidth" name="width" value="${fieldValue(bean:itemInfo,field:'width')}" />
								<input type="hidden" id="selectedTemplateHeight" name="height" value="${fieldValue(bean:itemInfo,field:'height')}" />
								<input type="hidden" id="selectedTemplateValidatedPeriodFrom" name="validatedPeriodFrom" value="${formatDate(format:'yyyy/MM/dd', date:itemInfo?.validatedPeriodFrom)}" />
								<input type="hidden" id="selectedTemplateValidatedPeriodTo" name="validatedPeriodTo" value="${formatDate(format:'yyyy/MM/dd', date:itemInfo?.validatedPeriodTo)}" />
								<span id="templateName">${fieldValue(bean:itemInfo,field:'templateName')}<g:if test="${itemInfo?.templateName}"> (<g:formatNumber format="###" number="${itemInfo?.width}" />mm x <g:formatNumber format="###" number="${itemInfo?.height}" />mm)</g:if></span>
								<a href="javascript:void(0)" id="selectTemplateBtn" class="button">テンプレートの選択</a>
							</td>
						</tr>

						<tr class="prop" style="display:none;">
							<td valign="top" class="name">
								<label for="templateName">テンプレートの有効期限:</label>
							</td>
							<td valign="top" class="value">
								<span id="dispValidationPeriod"><g:if test="${itemInfo?.validatedPeriodFrom || itemInfo?.validatedPeriodTo}">${formatDate(format:'yyyy/MM/dd', date:itemInfo?.validatedPeriodFrom)} ～ ${formatDate(format:'yyyy/MM/dd', date:itemInfo?.validatedPeriodTo)}</g:if></span>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="description">${fieldNames?.ItemInfo?.description?.encodeAsHTML()}:</label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:itemInfo,field:'description','errors')}">
								<textarea style="width:50em;height:8em;" name="description">${fieldValue(bean:itemInfo, field:'description')}</textarea>
							</td>
						</tr> 

					</tbody>
				</table>
			</div>

		</g:form>

	</div>

<g:form method="get" action="list" name="cancelForm"></g:form>
<g:render template="/common/fragment/templateDialog" />
<r:script>
;jQuery(function(){
var formValidator = $("#addForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		itemNo:{
			required:true
		},
		itemName:{
			required:true
		},
		paperSizeId:{
			required:true
		},
		dispOrder:{
			required:true,
			digits:true
		},
		trackingId:{
			required:true
		},
		description:{
			maxlength:500
		}
	},
	messages:{
		itemNo:{
			required:"アイテムNoを指定してください。"
		},
		itemName:{
			required:"アイテム名を指定してください。"
		},
		paperSizeId:{
			required:"用紙サイズを指定してください。"
		},
		dispOrder:{
			required:"表示順序を指定してください。",
			digits:"表示順序には整数を指定してください。"
		},
		trackingId:{
			required:"テンプレートを指定してください。"
		},
		description:{
			maxlength:"説明は500文字以内としてください。"
		}
	}
});
$("#addBtn").click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.addForm.submit();
	}
	return false;
});
$('#cancelBtn').click(function() {
	document.cancelForm.submit();
	return false;
});
$("a.transition").click(function() {
	return confirmTransition(this.href);
});
var selectTemplate = function(trackingId, templateName, extra) {
	$("#selectedTemplateTrackingId").val(trackingId);
	$("#selectedTemplateName").val(templateName);
	$("#selectedTemplatePageCount").val(extra.pageCount);
	$("#selectedTemplateWidth").val(extra.width);
	$("#selectedTemplateHeight").val(extra.height);
	$("#selectedTemplateValidatedPeriodFrom").val(extra.validatedPeriodFrom);
	$("#selectedTemplateValidatedPeriodTo").val(extra.validatedPeriodTo);
	var width = Math.round(extra.width * 1000) / 1000;
	var height = Math.round(extra.height * 1000) / 1000;
	var tname = templateName + " (" + width + "mm x " + height + "mm)";
	$("#templateName").text(tname);
	var vstr = '';
	if (extra.validatedPeriodFrom || extra.validatedPeriodTo) {
		if (extra.validatedPeriodFrom) {
			vstr += extra.validatedPeriodFrom;
		}
		vstr += ' ～ ';
		if (extra.validatedPeriodTo) {
			vstr += extra.validatedPeriodTo;
		}
	}
	$("#dispValidationPeriod").text(vstr);
	return false;
};
$("#selectTemplateBtn").click(function(){
	var trackingId = $("#selectedTemplateTrackingId").val();
	gTemplateDialog.showTemplateSelectDialog('', 'テンプレートの選択', trackingId, selectTemplate);
	return false;
});
gTemplateDialog.setup();
});</r:script>
</body>
</html>
