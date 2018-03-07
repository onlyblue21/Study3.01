<html>
<head>
	<meta name="layout" content="uploaderrors" />
	<title>アップロードエラー</title>
<style type='text/css' media='screen'>
#uploadedErrorsArea td {
	background-color: transparent;
}
</style>
</head>
<body class="body_a">
<div class="popBox">

<g:if test="${totalCount && errorCount}">
	<div class="ecom">${totalCount?.encodeAsHTML()}件中${errorCount?.encodeAsHTML()}件のデータは、エラーのため登録できませんでした。</div>

	<table cellpadding="0" cellspacing="0" class="listTable mB20" width="650">
		<thead>
			<tr>
				<th width="50" class="pL10">行番号</th>
				<th width="150" class="pL10">あて名(会社名)</th>
				<th width="100" class="pL10">エラー発生項目</th>
				<th width="300" class="pL10">エラー発生理由</th>
			</tr>
		</thead>
		<tbody id="uploadedErrorsArea">
			<tr>
				<td colspan="4" class="align_center">
					<img src="${r.resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'エラー情報を取得しています。')}" />
					エラー情報を取得しています。
				</td>
			</tr>
		</tbody>
	</table>
</g:if>
<g:else>
	<div class="ecom">エラー情報が見つかりませんでした。</div>
</g:else>

	<a href="javascript:void(0)" id="closeBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_close.gif" alt="閉じる" /></a>
</div>

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'zipcode')}"></script>
<r:script>
;jQuery(function(){
$.ajax({
	url: "${createLink(action:'uploadedMyAddressErrors')}",
	success: function(data, textStatus, jqXHR) {
		if (textStatus == "success") {
			var uploadedErrorsArea = $("#uploadedErrorsArea");
			uploadedErrorsArea.empty();
			if (data.errors) {
				for (var index = 0; index < data.errors.length; index++) {
					var error = data.errors[index];
					var tr = $('<tr />');
					uploadedErrorsArea.append(tr);
					var td = $('<td class="align_right" />').text(error.lineNumber);
					tr.append(td);
					td = $('<td class="align_left" />').text(error.familyName);
					tr.append(td);
					td = $('<td class="align_left" />').text(error.fieldName);
					tr.append(td);
					td = $('<td class="align_left" />').text(error.message);
					tr.append(td);
				}
			}
		} else {
			oiyAlert("エラー情報を取得できませんでした。");
		}
		return false;
	}
});
$("#closeBtn").click(function() {
	window.close();
	return false;
});
});</r:script>
</body>
</html>