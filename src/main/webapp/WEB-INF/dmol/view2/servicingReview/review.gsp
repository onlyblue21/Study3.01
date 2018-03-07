<html>
<head>
	<meta name="layout" content="main" />
	<title>校正</title>
<style type="text/css">
div.destinationAddress {
	width:410px;
	height:60px;
	overflow:auto;
}
div.reviewMessage {
	width:410px;
	height:70px;
	overflow:auto;
}
</style>
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

	<div class="mainBlock">
		<h1>校正</h1>

		<table cellpadding="0" cellspacing="0" class="listTable mT20 mB20" width="530">
			<tr>
				<th width="100" class="align_right">注文No.</th>
				<td class="align_left">${orderDetail.orderNo?.encodeAsHTML()}-${orderDetail.detailNo?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="align_right">サービス名</th>
				<td class="align_left">${orderDetail.serviceName?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="align_right">料金(税込)</th>
				<td class="align_left"><g:formatNumber format="###,###" number="${orderDetail.totalAmount}" />円</td>
			</tr>
			<tr>
				<th class="align_right">校正回数</th>
				<td class="align_left">${reviewCountMessage?.encodeAsHTML()}</td>
			</tr>
<g:if test="${servicingOrderDetailLogoTrace}">
			<tr>
				<th class="align_right">入稿データ</th>
				<td class="align_left"><g:link action="downloadLogoTrace" id="${servicingOrderInfo.id}" params="${[now:System.currentTimeMillis()]}">${servicingOrderDetailLogoTrace.filename?.encodeAsHTML()}</g:link></td>
			</tr>
</g:if>
<g:if test="${servicingOrderDetailMapDrawup}">
			<tr>
				<th class="align_right">地図のデザイン</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.mapDesignType?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="align_right">目的地名称</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.destinationName?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="align_right">目的地住所</th>
				<td class="align_left">
					<div class="destinationAddress"><pre>${servicingOrderDetailMapDrawup.destinationAddress?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="align_right">目印１</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark1?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">目印２</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark2?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">目印３</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark3?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">目印４</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark4?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">目印５</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark5?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">目印６</th>
				<td class="align_left">${servicingOrderDetailMapDrawup.landmark6?.encodeAsHTML() ?: '&nbsp;'}</td>
			</tr>
			<tr>
				<th class="align_right">マップエリア</th>
				<td class="align_left">およそ半径${servicingOrderDetailMapDrawup.areaType?.encodeAsHTML()}のエリア</td>
			</tr>
</g:if>
			<tr>
				<th class="align_right">コメント</th>
				<td class="align_left">
					<div class="reviewMessage"><pre>${orderDetail.orderMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
		</table>

<g:if test="${servicingReviewLog0}">
		<table cellpadding="0" cellspacing="0" class="listTable mB20" width="530">
			<tr>
				<th colspan="2" class="oya">校正１回目</th>
			</tr>
			<tr>
				<th width="100" class="align_right">サンプル</th>
				<td class="align_left"><g:if test="${servicingReviewLog0.reviewFileExists}"><g:link action="downloadReviewData" id="${servicingReviewLog0.id}" params="${[now:System.currentTimeMillis()]}" class="icoPdf">確認用デザイン</g:link></g:if><g:else>未登録</g:else></td>
			</tr>
<g:if test="${servicingReviewLog0.confirmMessage}">
			<tr>
				<th class="align_right">確認事項</th>
				<td class="align_left"><div class="reviewMessage"><pre>${servicingReviewLog0.confirmMessage?.encodeAsHTML()}</pre></div></td>
			</tr>
</g:if>
<g:if test="${servicingReviewLog0.reviewMessage}">
			<tr>
				<th class="align_right">メッセージ</th>
				<td class="align_left"><div class="reviewMessage"><pre>${servicingReviewLog0.reviewMessage?.encodeAsHTML()}</pre></div></td>
			</tr>
</g:if>
<g:if test="${servicingReviewLog0.reviewStatus != jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_NONE}">
			<tr>
				<th class="align_right">判定</th>
				<td class="align_left">${servicingReviewLog0.reviewTitle?.encodeAsHTML()}</td>
			</tr>
</g:if>
		</table>
</g:if>
<g:if test="${servicingReviewLog1 && showServicingReviewLog1}">
		<table cellpadding="0" cellspacing="0" class="listTable mB20" width="530">
			<tr>
				<th colspan="2" class="oya">校正２回目</th>
			</tr>
			<tr>
				<th width="100" class="align_right">サンプル</th>
				<td class="align_left"><g:if test="${servicingReviewLog1.reviewFileExists}"><g:link action="downloadReviewData" id="${servicingReviewLog1.id}" params="${[now:System.currentTimeMillis()]}" class="icoPdf">確認用デザイン</g:link></g:if><g:else>未登録</g:else></td>
			</tr>
<g:if test="${servicingReviewLog1.confirmMessage}">
			<tr>
				<th class="align_right">確認事項</th>
				<td class="align_left"><div class="reviewMessage"><pre>${servicingReviewLog1.confirmMessage?.encodeAsHTML()}</pre></div></td>
			</tr>
</g:if>
<g:if test="${servicingReviewLog1.reviewMessage}">
			<tr>
				<th class="align_right">メッセージ</th>
				<td class="align_left"><div class="reviewMessage"><pre>${servicingReviewLog1.reviewMessage?.encodeAsHTML()}</pre></div></td>
			</tr>
</g:if>
<g:if test="${servicingReviewLog1.reviewStatus != jp.co.reso.oiy.dmol.domain.orderinfo.ServicingReviewLog.REVIEW_STATUS_NONE}">
			<tr>
				<th class="align_right">判定</th>
				<td class="align_left">${servicingReviewLog1.reviewTitle?.encodeAsHTML()}</td>
			</tr>
</g:if>
		</table>
</g:if>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

<g:if test="${reviewStatusWait}">
		<div class="koseiMess">
			<g:form action="update" id="${orderDetail.id}" name="updateForm" onsubmit="return false;">
			<input type="hidden" name="servicingReviewLogId" value="${lastServicingReviewLog.id}" />
			<span class="size14">
				<input name="reviewResult" type="radio" value="accept" id="reviewResultAccept" /> <label for="reviewResultAccept">このデザインで確定する。</label><br />
				<input name="reviewResult" type="radio" value="reject" id="reviewResultReject" /> <label for="reviewResultReject">このデザインを校正する。<span class="red2">（全2回）</span></label>
			</span>
			<br /><br />

			<strong>メッセージ</strong><br />
			<textarea name="reviewMessage" rows="6" class="w450"></textarea>

			<p class="align_center mB15 mT15">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
				<input type="image" id="updatebtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_soushinw-off.gif" alt="送信する" />
			</p>
			</g:form>
		</div>
</g:if>
<g:elseif test="${reviewStatusReviewCompleted}">
		<div class="koseiMess2">
			<br />
			<p class="size14 bold align_center">校正終了しました。過去に追加した画像に登録作業中です。</p>
			<p class="align_center mB15 mT15">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
			</p>
		</div>
</g:elseif>
<g:elseif test="${reviewStatusCompleted}">
		<div class="koseiMess2">
			<br />
			<p class="red size14 bold align_center">上記の素材を登録いたしました。編集画面の挿入メニューから「過去に追加した画像」を選択してご利用下さい。</p>
			<p class="size14">
				<br />
				編集画面の「素材」⇒「過去に追加した画像」に『${orderDetail.orderNo?.encodeAsHTML()}-${orderDetail.detailNo?.encodeAsHTML()}』という名前で登録しています。
				<br />
				素材名はお客さまにて変更することができます。
			</p>
			<p class="align_center mB15 mT15">
				<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
			</p>
		</div>
</g:elseif>
<g:else>
		<p class="align_center mB15 mT15">
			<a href="javascript:void(0)" id="prevBtn" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></a>
		</p>
</g:else>

	</div>

<g:form method="get" controller="myPage" action="orderHistory" name="prevForm" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
<g:if test="${reviewStatusWait}">
var reviewResultRadios = $("input:radio[name='reviewResult']");
$.validator.addMethod("reviewResultValidator", function(value, element, params) {
	var result = reviewResultRadios.filter(":checked").val();
	if ($.isNull(result)) {
		params.data('reviewResultValidatorMessage', "校正結果を指定してください。");
		return false;
	}
	return true;
}, function(params) {
	var message = params.data('reviewResultValidatorMessage');
	return message;
});
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		reviewResult:{
			reviewResultValidator:reviewResultRadios
		},
		reviewMessage:{
			required:"#reviewResultReject:checked",
			maxlength:1000
		}
	},
	messages:{
		reviewMessage:{
			required:"メッセージを指定してください。",
			maxlength:"メッセージは1000文字以内でお願いいたします。"
		}
	}
});
reviewResultRadios.click(function() {
	formValidator.resetForm();
	formValidator.form();
	return true;
});
$("#updatebtn").click(function() {
	formValidator.resetForm();
	if (formValidator.form()) {
		pleaseWait();
		document.updateForm.submit();
	}
	return false;
});
</g:if>
});</r:script>
</body>
</html>
