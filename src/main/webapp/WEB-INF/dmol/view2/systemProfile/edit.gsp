<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>登録情報変更</title>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="transition" action="show">登録情報確認</g:link></li>
			<li>登録情報変更</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>登録情報変更</h1>

		<div style="text-align: left;">
			内容を入力して、「次へ進む」ボタンを押してください。
		</div>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<g:form name="updateForm" action="confirm" onsubmit="return false;">
			<table>
				<tbody>
					<tr class="prop">
						<td class="name">ユーザID</td>
						<td class="value">${userInfo?.userId?.encodeAsHTML()}</td>
					</tr>
					<tr class="prop">
						<td class="name">メールアドレス</td>
						<td class="value">
							<input type="text" id="email" name="email" size="50" maxlength="128" value="${userInfo?.email?.encodeAsHTML()}" />
						</td>
					</tr>
					<tr class="prop">
						<td class="name">お名前／漢字（全角）</td>
						<td class="value">
							<table style="width:auto; border: none;">
								<tbody>
									<tr>
										<td>姓</td>
										<td>
											<input type="text" name="familyName" size="40" maxlength="128" value="${userInfo?.familyName?.encodeAsHTML()}" />
										</td>
										<td>名</td>
										<td>
											<input type="text" name="firstName" size="40" maxlength="128" value="${userInfo?.firstName?.encodeAsHTML()}" />
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
<g:if test="${userInfo.jpostUser}">
					<tr class="prop">
						<td class="name">局所コード</td>
						<td class="value">
							<input type="text" id="kyokusyoCd" name="kyokusyoCd" size="10" maxlength="6" value="${userInfo?.kyokusyoCd?.encodeAsHTML()}" />
						</td>
					</tr>
</g:if>
				</tbody>
			</table>
			<div style="margin: 4px;">
				<button id="prevBtn">戻る</button>
				<button id="nextBtn">次へ進む</button>
			</div>
			</g:form>
		</div>
	</div>

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<g:form method="get" name="prevForm" action="show" />
<r:script>
;jQuery(function(){
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		email:{
<g:if test="${!userInfo.jpostUser}">
			required:true,
</g:if>
			email:true,
			nozenkaku:true
		},
		familyName:{
			required:true
<g:if test="${userInfo.jpostUser}">
		},
		kyokusyoCd:{
			required:true,
			minlength:6,
			digits:true
</g:if>
		}
	},
	messages:{
		email:{
<g:if test="${!userInfo.jpostUser}">
			required:"メールアドレスを指定してください。",
</g:if>
			email:"メールアドレスが正しくありません。",
			nozenkaku:"メールアドレスには全角文字をご利用になれません。"
		},
		familyName:{
			required:"お名前／漢字姓を指定してください。"
<g:if test="${userInfo.jpostUser}">
		},
		kyokusyoCd:{
			required:"局所コードを指定してください。",
			minlength:"6桁の局所コードを指定してください。",
			digits:"局所コードが正しくありません。"
</g:if>
		}
	}
});
$("#nextBtn").button().click(function() {
	if (formValidator.form()) {
		document.updateForm.submit();
	}
	return false;
});
$("#prevBtn").button().click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>