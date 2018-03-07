<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>付帯サービス</title>
<style type="text/css">
table#servicingInfoTable {
	margin-top:4px;
}
table#reviewInfoTable {
	margin-top:8px;
}
th, td {
	padding: 2px 4px;
}
th.infotype {
	width:1em;
	text-align:center;
	vertical-align:middle;
}
th.infoheader {
	width:8em;
	text-align:center;
}
td.infodata {
	width:auto;
}
th.reviewheader {
	width:14em;
	text-align:center;
}
td.reviewdata {
	width:auto;
}
div.destinationAddress {
	width:410px;
	height:80px;
	overflow:auto;
}
div.reviewMessage {
	width:410px;
	height:120px;
	overflow:auto;
}
input#designfile, input#designgscalefile {
	width:300px;
}
textarea.confirmMessage {
	width:410px;
	height:120px;
}
div.okcancelbuttons {
	margin-top:8px;
}
</style>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li><g:link class="list transition" action="list">付帯サービス管理</g:link></li>
			<li>付帯サービス</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>付帯サービス</h1>

		<table id="servicingInfoTable">
			<tr>
				<th class="infotype" rowspan="3"></th>
				<th class="infoheader">注文No.</th>
				<td class="infodata">${orderDetail.orderNo?.encodeAsHTML()}-${orderDetail.detailNo?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">サービス名</th>
				<td class="infodata">${orderDetail.serviceName?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">校正回数</th>
				<td class="infodata">${reviewCountMessage?.encodeAsHTML()}</td>
			</tr>
<g:if test="${servicingOrderDetailLogoTrace}">
			<tr>
				<th class="infotype" rowspan="2">注文内容</th>
				<th class="infoheader">入稿データ</th>
				<td class="infodata"><g:link action="downloadLogoTrace" id="${servicingOrderDetailLogoTrace.id}" params="${[now:System.currentTimeMillis()]}">${servicingOrderDetailLogoTrace.filename?.encodeAsHTML()}</g:link></td>
			</tr>
</g:if>
<g:if test="${servicingOrderDetailMapDrawup}">
			<tr>
				<th class="infotype" rowspan="11">注文内容</th>
				<th class="infoheader">地図のデザイン</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.mapDesignType?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目的地名称</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.destinationName?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目的地住所</th>
				<td class="infodata">
					<div class="destinationAddress"><pre>${servicingOrderDetailMapDrawup.destinationAddress?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="infoheader">目印１</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark1?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目印２</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark2?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目印３</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark3?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目印４</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark4?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目印５</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark5?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">目印６</th>
				<td class="infodata">${servicingOrderDetailMapDrawup.landmark6?.encodeAsHTML()}</td>
			</tr>
			<tr>
				<th class="infoheader">マップエリア</th>
				<td class="infodata">およそ半径${servicingOrderDetailMapDrawup.areaType?.encodeAsHTML()}のエリア</td>
			</tr>
</g:if>
			<tr>
				<th class="infoheader">コメント</th>
				<td class="infodata">
					<div class="reviewMessage"><pre>${orderDetail.orderMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
<g:if test="${servicingReviewLog0}">
			<tr>
				<th class="infotype" rowspan="4">校正１回目</th>
				<th class="infoheader">サンプル</th>
				<td class="infodata"><g:if test="${servicingReviewLog0.reviewFileExists}"><g:link action="downloadReviewData" id="${servicingReviewLog0.id}" params="${[now:System.currentTimeMillis()]}">確認用デザイン</g:link></g:if><g:else>未登録</g:else></td>
			</tr>
			<tr>
				<th class="infoheader">確認事項</th>
				<td class="infodata">
					<div class="reviewMessage"><pre>${servicingReviewLog0.confirmMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="infoheader">メッセージ</th>
				<td class="infodata">
					<div class="reviewMessage"><pre>${servicingReviewLog0.reviewMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="infoheader">判定</th>
				<td class="infodata">${servicingReviewLog0.reviewTitle?.encodeAsHTML()}</td>
			</tr>
</g:if>
<g:if test="${servicingReviewLog1 && showServicingReviewLog1}">
			<tr>
				<th class="infotype" rowspan="4">校正２回目</th>
				<th class="infoheader">サンプル</th>
				<td class="infodata"><g:if test="${servicingReviewLog1.reviewFileExists}"><g:link action="downloadReviewData" id="${servicingReviewLog1.id}" params="${[now:System.currentTimeMillis()]}">確認用デザイン</g:link></g:if><g:else>未登録</g:else></td>
			</tr>
			<tr>
				<th class="infoheader">確認事項</th>
				<td class="infodata">
					<div class="reviewMessage"><pre>${servicingReviewLog1.confirmMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="infoheader">メッセージ</th>
				<td class="infodata">
					<div class="reviewMessage"><pre>${servicingReviewLog1.reviewMessage?.encodeAsHTML()}</pre></div>
				</td>
			</tr>
			<tr>
				<th class="infoheader">判定</th>
				<td class="infodata">${servicingReviewLog1.reviewTitle?.encodeAsHTML()}</td>
			</tr>
</g:if>
		</table>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

<sec:ifNotGranted roles="AUTHORITY_PRINT_USER">
<g:set var="uploadable" value="${false}" />
</sec:ifNotGranted>
		<div>
<g:if test="${uploadable}">
			<g:uploadForm action="upload" id="${orderDetail.id}" name="uploadForm" onsubmit="return false;">
			<input type="hidden" name="servicingReviewLogId" value="${lastServicingReviewLog.id}" />
			<input type="hidden" name="material" value="${material}" />
			<table id="reviewInfoTable">
				<tr>
					<th class="reviewheader">デザインファイル<g:if test="${material}">（カラー）</g:if></th>
					<td class="reviewdata">
						<input type="file" id="designfile" name="designfile" maxlength="256" value="" />
<g:if test="${material && false}">
						<g:if test="${lastServicingReviewLog.reviewFileExists}"><g:link action="downloadReviewData" id="${lastServicingReviewLog.id}" params="${[now:System.currentTimeMillis()]}" target="_blank">確認用デザイン</g:link></g:if><g:else>未登録</g:else>
</g:if>
					</td>
				</tr>
<g:if test="${material}">
				<tr>
					<th class="reviewheader">デザインファイル（モノクロ）</th>
					<td class="reviewdata">
						<input type="file" id="designgscalefile" name="designgscalefile" maxlength="256" value="" />
					</td>
				</tr>
</g:if>
<g:if test="${!material}">
				<tr>
					<th class="reviewheader">お客さまへの確認事項</th>
					<td class="reviewdata"><textarea name="confirmMessage" cols="" rows="" class="confirmMessage" >${params.confirmMessage?.encodeAsHTML()}</textarea></td>
				</tr>
</g:if>
			</table>
			</g:uploadForm>
</g:if>
			<div class="okcancelbuttons">
				<button id="cancelBtn"><g:if test="${uploadable}">キャンセル</g:if><g:else>戻る</g:else></button>
<g:if test="${uploadable}">
				<button id="uploadBtn">送信</button>
</g:if>
			</div>
		</div>

	</div>

<g:form method="get" action="list" name="cancelForm" />
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#servicingInfoTable tr").evenodd();
$("#cancelBtn").button().click(function() {
	document.cancelForm.submit();
	return false;
});
<g:if test="${uploadable}">
var formValidator = $("#uploadForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		designfile:{
			required:function() {
<g:if test="${material}">
				return $.isNull($("#designgscalefile").val());
</g:if>
<g:else>
				return true;
</g:else>
			},
			maxlength:256,
			extension:"${material ? 'zip' : 'pdf'}"
		}
<g:if test="${material}">
		,
		designgscalefile:{
			required:function() {
				return $.isNull($("#designfile").val());
			},
			maxlength:256,
			extension:"${material ? 'zip' : 'pdf'}"
		}
</g:if>
<g:if test="${!material}">
		,
		confirmMessage:{
			required:true,
			maxlength:1000
		}
</g:if>
	},
	messages:{
		designfile:{
			required:"デザインファイル<g:if test="${material}">（カラー）</g:if>を指定してください。",
			maxlength:"デザインファイル<g:if test="${material}">（カラー）</g:if>は256文字以内でお願いいたします。",
			extension:"デザインファイル<g:if test="${material}">（カラー）</g:if>には${material ? 'backstage形式の素材ファイル' : '表示用PDF'}を指定してください。"
		}
<g:if test="${material}">
		,
		designgscalefile:{
			required:"デザインファイル（モノクロ）を指定してください。",
			maxlength:"デザインファイル（モノクロ）は256文字以内でお願いいたします。",
			extension:"デザインファイル（モノクロ）にはbackstage形式の素材ファイルを指定してください。"
		}
</g:if>
<g:if test="${!material}">
		,
		confirmMessage:{
			required:"お客さまへの確認事項を指定してください。",
			maxlength:"お客さまへの確認事項は1000文字以内でお願いいたします。"
		}
</g:if>
	}
});
$("#uploadBtn").button().click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.uploadForm.submit();
	}
	return false;
});
</g:if>
});</r:script>
</body>
</html>
