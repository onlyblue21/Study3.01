<g:if test="${false}">
/**
 * @param targetName 対象の名前:"事務局"|"JP"|"印刷会社"|"JPMD"|"管理者"
 * @param jpostUser	true|false JPユーザ識別フラグ
 */
</g:if>
<html>
<head>
	<meta name="layout" content="maintenance" />
		<r:require module="jquery-validate"/>
	<title>ユーザの追加</title>
</head>
<body>

<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">ユーザ一覧</g:link></li>
			<li>ユーザの追加</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>ユーザの追加</h1>

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
<g:render template="/common/fragment/validatormessages" />
		<g:form name="addForm" action="save" method="post" onsubmit="return false;">
	
			<div class="dialog">
				<table>
					<tbody>

						<tr class="prop">
							<td valign="top" class="name"><label for="roleId">${clazzNames?.Role?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'role','errors')}">
								<g:select id="roleId" name="roleId" from="${roleList}" value="${user?.role}" onChange="selectRole()" optionKey="id" optionValue="roleName"/>
								<input type="hidden" id="idSelected" name="idSelected" value="${user.role?.id?.encodeAsHTML()}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name"><label for="email">${fieldNames?.User?.email?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'email','errors')}">
								<input type="text"  size="40" maxlength="512" id="email" name="email" value="${user.email?.encodeAsHTML()}"/>						
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

						<tr id="jpostUserId" class="prop" style="display: none">
							<td valign="top" class="name"><label for="kyokusyoCd">${fieldNames?.User?.kyokusyoCd?.encodeAsHTML()}:</label></td>
							<td valign="top" class="value ${hasErrors(bean:user,field:'kyokusyoCd','errors')}">
								<input type="text" size="10" maxlength="6" id="kyokusyoCd" name="kyokusyoCd" value="${user.kyokusyoCd?.encodeAsHTML()}"/>
							</td>
						</tr>


					</tbody>
				</table>
			</div>
		</g:form>

	</div>

<g:form method="get" action="list" name="cancelForm"></g:form>
<%
	String selected = request.getParameter("idSelected");
	if (selected != null && selected !='') 
	{
		selected = request.getParameter("idSelected");
	}
	else
	{
		selected = '0';
	}
 %>
<r:script>
function selectRole(){
	var roleId=$("#roleId").val();
    var sparams = {roleId:roleId};

	$.ajax({
		url: "${createLink(action:'select')}",
		data: sparams,
		success: function(data) {
			if(data.groupType == "jpost") {
				 $("#jpostUserId").show();  
			} else {
				 $("#jpostUserId").hide();  
			}
		}
	});
	document.getElementById("idSelected").value = document.getElementById("roleId").value;
}
function setSelected()
{
	var rolen = document.getElementById("roleId").value;
	var selectedLen = <%=selected%>;
	if (selectedLen !=''&& selectedLen!=null && selectedLen!=0)
	{
	   selectedLen = Array(rolen.length>selectedLen?(rolen.length-(''+selectedLen).length+1):0).join(0)+selectedLen;
	   document.getElementById("idSelected").value = selectedLen;
	   document.getElementById("roleId").value = selectedLen;
	}
	else
	{
		document.getElementById("idSelected").value = document.getElementById("roleId").value;
	}
}
$(document).ready(setSelected);
;jQuery(function(){

selectRole();
var formValidator = $("#addForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		email:{
			required:true,
			email:true,
			nozenkaku:true,
			noktaiemail:true
		},
		familyName:{
			required:true
		}
	},
	messages:{
		email:{
			required:"メールアドレスを入力して下さい。",
			email:"メールアドレスを正しく入力して下さい。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。",
			noktaiemail:"携帯メールアドレスでの登録は出来ません"
		},
		familyName:{
			required:"氏名(漢字) を入力して下さい。"
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

});

</r:script>
</body>
</html>
