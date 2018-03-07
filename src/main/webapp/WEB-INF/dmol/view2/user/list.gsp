<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>会員一覧</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>会員一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>会員一覧</h1>

<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
		<div class="buttons">
			<span class="button"><a href="javascript:void(0)" id="downloadBtn" class="button">会員情報一括ダウンロード</a></span>
		</div>
</sec:ifAnyGranted>

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
						<td class="name">${fieldNames?.User?.email?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" size="40" maxlength="64" id="email" name="email" value="${params.email?.encodeAsHTML()}"/>
							(前方一致)
						</td>
					</tr>

					<tr class="prop">
						<td class="name">名前:</td>
						<td class="value">
							<input type="text" size="40" maxlength="128" id="eqFamilyName" name="eqFamilyName" value="${params.eqFamilyName?.encodeAsHTML()}"/>
							<input type="text" size="40" maxlength="128" id="eqFirstName" name="eqFirstName" value="${params.eqFirstName?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td class="name">会社名:</td>
						<td class="value">
							<input type="text" size="40" maxlength="256" id="eqCorporateName" name="eqCorporateName" value="${params.eqCorporateName?.encodeAsHTML()}"/>
						</td>
					</tr>

					<tr class="prop">
						<td class="name">本登録日:</td>
						<td class="value">
							<input type="text" id="condRegisteredDateStart" name="condRegisteredDateStart" value="" size="10" maxlength="10" readonly="readonly" />～<input type="text" id="condRegisteredDateEnd" name="condRegisteredDateEnd" value="" size="10" maxlength="10" readonly="readonly" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">郵送でのDM:</td>
						<td class="value">
							<input type="radio" id="optinDmByPostingNone" name="optinDmByPosting" value="both" ${org.apache.commons.lang.StringUtils.isEmpty(params.optinDmByPosting) ? 'checked' : ''} /><label for="optinDmByPostingNone">両方</label>
							　　
							<input type="radio" id="optinDmByPostingTrue" name="optinDmByPosting" value="true" ${org.apache.commons.lang.StringUtils.isNotEmpty(params.optinDmByPosting) && (params.optinDmByPosting == 'true') ? 'checked' : ''} /><label for="optinDmByPostingTrue">希望する</label>
							　　
							<input type="radio" id="optinDmByPostingFalse" name="optinDmByPosting" value="false" ${org.apache.commons.lang.StringUtils.isNotEmpty(params.optinDmByPosting) && (params.optinDmByPosting != 'true') ? 'checked' : ''} /><label for="optinDmByPostingFalse">希望しない</label>
						</td>
					</tr>

					<tr class="prop">
						<td class="name">eメールでのDM:</td>
						<td class="value">
							<input type="radio" id="optinDmByEmailNone" name="optinDmByEmail" value="both" ${org.apache.commons.lang.StringUtils.isEmpty(params.optinDmByEmail) ? 'checked' : ''} /><label for="optinDmByEmailNone">両方</label>
							　　
							<input type="radio" id="optinDmByEmailTrue" name="optinDmByEmail" value="true" ${org.apache.commons.lang.StringUtils.isNotEmpty(params.optinDmByEmail) && (params.optinDmByEmail == 'true') ? 'checked' : ''} /><label for="optinDmByEmailTrue">希望する</label>
							　　
							<input type="radio" id="optinDmByEmailFalse" name="optinDmByEmail" value="false" ${org.apache.commons.lang.StringUtils.isNotEmpty(params.optinDmByEmail) && (params.optinDmByEmail != 'true') ? 'checked' : ''} /><label for="optinDmByEmailFalse">希望しない</label>
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
						<g:sortableColumn property="email" title="${fieldNames?.User?.email?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="corporateName" title="${fieldNames?.User?.corporateName?.encodeAsHTML()}" params="${params}" />
						<g:sortableColumn property="registeredDate" title="本登録日時" params="${params}" />
						
						<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER">
							<th rowspan="2" class="vhcenter">詳細</th>
						</sec:ifAllGranted>
						<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER_SALES_BRANCH">
							<th rowspan="2" class="vhcenter">詳細</th>
						</sec:ifAllGranted>
						<sec:ifAllGranted roles="AUTHORITY_SELECT_USER">
							<th rowspan="2" class="vhcenter">詳細</th>
						</sec:ifAllGranted>
						
						<sec:ifNotGranted roles ="AUTHORITY_JPOST_USER">
							<th rowspan="2" class="vhcenter">注文<br />履歴</th>
						</sec:ifNotGranted>

					</tr>
					<tr>
						<g:sortableColumn property="familyName" title="名前" params="${params}" />
						<g:sortableColumn property="enabled" title="論理削除" params="${params}" />
						<g:sortableColumn property="lastLoginDate" title="最終ログイン日時" params="${params}" />
					</tr>
				</thead>

				<tbody>
<g:if test="${!userList || (userList.size() <= 0)}">
					<tr>
						<td colspan="5" class="vhcenter">見つかりませんでした</td>
					</tr>
</g:if>
<g:set var="editAction" value="edit" />
<sec:ifAllGranted roles="AUTHORITY_SELECT_USER">
<g:set var="editAction" value="show" />
</sec:ifAllGranted>
					<g:each in="${userList}" status="i" var="user">
					<tr>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td>
								<div class="tbpadding tbunderline">**********</div>
								<div class="tbpadding">**********</div>
							</td>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						<td>
							<div class="tbpadding tbunderline">${user.email?.encodeAsHTML()}</div>
							<div class="tbpadding">${user.familyName?.encodeAsHTML()}${user.firstName?.encodeAsHTML()}</div>
						</td>
						</sec:ifAnyGranted>
						<td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<div class="tbpadding tbunderline">**********</div>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<div class="tbpadding tbunderline">${user.corporateName?.encodeAsHTML()}</div>
							</sec:ifAnyGranted>
							<div class="tbpadding"><g:if test="${user.enabled}">未削除</g:if><g:else>論理削除済</g:else></div>
						</td>
						<td class="timestampCell">
							<div class="tbpadding tbunderline"><g:formatDate format="${timestampFormat}" date="${user?.registeredDate}" /></div>
							<div class="tbpadding"><g:formatDate format="${timestampFormat}" date="${user?.lastLoginDate}" /></div>
						</td>
						<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER">
							<td class="vhcenter char2btnCell">
								<g:link action="${editAction}" id="${user.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link>
							</td>
						</sec:ifAllGranted>
						<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER_SALES_BRANCH">
							<td class="vhcenter char2btnCell">
								<g:link action="${editAction}" id="${user.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link>
							</td>
						</sec:ifAllGranted>
						<sec:ifAllGranted roles="AUTHORITY_SELECT_USER">
							<td class="vhcenter char2btnCell">
								<g:link action="${editAction}" id="${user.id?.encodeAsHTML()}" class="button"><span class="nowrap">詳細</span></g:link>
							</td>
						</sec:ifAllGranted>
						
						<sec:ifNotGranted roles ="AUTHORITY_JPOST_USER">
							<td class="vhcenter char2btnCell">
								<a href="javascript:void(0)" id="${user.id?.encodeAsHTML()}" class="rirekiBtn button"><span class="nowrap">履歴</span></a>
							</td>
						</sec:ifNotGranted>
					</tr>
					</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons paginateBottomButtons">
			<oiy:paginate total="${totalCount?.encodeAsHTML()}" params="${params}" />
		</div>

	</div>

<sec:ifAnyGranted roles="AUTHORITY_MANAGE_USER,AUTHORITY_PERSONAL_DATA">
<g:form action="download" name="downloadForm">
<input type="hidden" name="dpasswd" value="" />
</g:form>
<div id="downloadPasswdDialog" title="会員情報一括ダウンロード" style="display:none;">
	<div>会員情報を一括ダウンロードするための<br />パスワードを入力してください。</div>
	<div>
		<input type="password" id="downloadPasswdDialogPasswd" name="downloadPasswdDialogPasswd" size="20" maxlength="20" value="" />
	</div>
</div>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
</sec:ifAnyGranted>
<sec:ifNotGranted roles ="AUTHORITY_JPOST_USER">
<form method="post" action="${userOrderInfoURL}" name="rirekiForm" onsubmit="return false;">
<input type="hidden" name="relayUserId" value="" />
<input type="hidden" name="dtime" value="" />
<input type="hidden" name="clientId" value="" />
<input type="hidden" name="orderInfoUserId" value="" />
</form>
</sec:ifNotGranted>
<r:script>
;jQuery(function(){
<sec:ifAnyGranted roles="AUTHORITY_MANAGE_USER,AUTHORITY_PERSONAL_DATA">
$("#downloadBtn").click(function() {
	var jqDialog = $("#downloadPasswdDialog");
	var focusFunc = function() {
		return $("#downloadPasswdDialogPasswd", jqDialog).focus();
	};
	jqDialog.dialog({
		autoOpen: false,
		resizable: true,
		width: 320,
		height: 180,
		minWidth: 320,
		minHeight: 180,
		modal: true,
		overley: { backGroundColor:'#000', opacity:0.5 },
		buttons: [
			{
				text:"ダウンロード",
				click:function() {
					var dpasswd = $("#downloadPasswdDialogPasswd", jqDialog).val();
					if ($.isNull(dpasswd)) {
						oiyAlert('パスワードを指定してください。', focusFunc);
						return;
					}
					var dparams = { 'dpasswd':dpasswd };
					$.ajax({
						url: "${createLink(action:'checkDownloadPasswd')}",
						data: dparams,
						success: function(data, textStatus, jqXHR) {
							if (data.result == 'success') {
								jqDialog.dialog('close');
								document.downloadForm.dpasswd.value = dpasswd;
								document.downloadForm.submit();
							} else {
								if ($.isNull(data.message)) {
									oiyAlert('パスワードを指定してください。', focusFunc);
								} else {
									oiyAlert(data.message, focusFunc);
								}
							}
							return false;
						}
					});
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
			focusFunc().val('');
		},
		close: function() {
			jqDialog.dialog('destroy');
		}
	});
	jqDialog.dialog('open');
	return false;
});
</sec:ifAnyGranted>
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
$('#searchBtn').click(function() {
	document.searhCondition.submit();
	return false;
});
$("#clearSearchConditionBtn").click(function() {
	$('#email').val("");
	$('#eqFamilyName').val("");
	$('#eqFirstName').val("");
	$('#eqCorporateName').val("");
	$("#condRegisteredDateStart").val('');
	$("#condRegisteredDateEnd").val('');
	return false;
});
$(".searchConditionFormArea table tbody tr.prop").evenodd();
$("#condRegisteredDateStart").datepicker({changeYear:true, showOn:'both', buttonImage:"${r.resource(dir:'images/skin',file:'btn_calendar.gif')}", buttonImageOnly:true, duration:'fast', dateFormat:"${jqDateFormat?.encodeAsHTML()}"});
$("#condRegisteredDateEnd").datepicker({changeYear:true, showOn:'both', buttonImage:"${r.resource(dir:'images/skin',file:'btn_calendar.gif')}", buttonImageOnly:true, duration:'fast', dateFormat:"${jqDateFormat?.encodeAsHTML()}"});
<g:if test="${params.condRegisteredDateStart}">$("#condRegisteredDateStart").datepicker('setDate', "${params.condRegisteredDateStart.encodeAsHTML()}");</g:if>
<g:if test="${params.condRegisteredDateEnd}">$("#condRegisteredDateEnd").datepicker('setDate', "${params.condRegisteredDateEnd.encodeAsHTML()}");</g:if>
<sec:ifNotGranted roles ="AUTHORITY_JPOST_USER">
var relayLogin = function(uid, form, title) {
	var params = { uid:uid };
	$.post("${createLink(controller:'user', action:'settlementRelayInfo')}", params, function(data, textStatus) {
		if (textStatus == 'success') {
			var result = data; //jQuery.secureEvalJSON(data);
			if (result.result == 'success') {
				pleaseWait();
				form.relayUserId.value = result.relayUserId;
				form.dtime.value = result.dtime;
				form.clientId.value = result.clientId;
				form.orderInfoUserId.value = result.orderInfoUserId;
				form.submit();
				return false;
			} else if (result.message) {
				oiyAlert(result.message);
				return false;
			}
		}
		oiyAlert(title + '画面を表示することができませんでした。');
		return false;
	});
	return false;
};
$(".rirekiBtn").click(function() {
	var uid = $(this).attr("id");
	return relayLogin(uid, document.rirekiForm, "注文履歴");
});
</sec:ifNotGranted>
});</r:script>
</body>
</html>
