<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>商品一覧</title>
	<link rel="stylesheet" href="${r.resource(dir:'static/dmol/css',file:'common.css')}" />
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
<style type="text/css">
.pagination{
	max-width:500px!important;
}
</style>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
			<li>商品一覧</li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>商品一覧</h1>

		<div class="buttons">
			<span class="button"><g:link action="bundle" class="button">一括アップロード</g:link></span>
		</div>

<g:render template="/common/fragment/flashmessages" />

		<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
			<g:form method="get" action="list" name="searhCondition" onsubmit="return false;">
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.goodsNo?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="conditionGoodsNo" name="goodsNo" value="${params.goodsNo?.encodeAsHTML()}" size="40" maxlength="20" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">アイテム:</td>
						<td class="value">
							<g:select name="conditionGenreUniqueId" from="${itemGenreList}" optionKey="id" optionValue="genreName" value="${params.genreUniqueId}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.paperSizeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="conditionPaperSizeId" from="${paperSizeList}" optionKey="paperSizeId" optionValue="paperSizeName" value="${params.paperSizeId}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.paperTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="conditionPaperTypeId" from="${paperTypeList}" optionKey="paperTypeId" optionValue="paperTypeName" value="${params.paperTypeId}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.colorTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="conditionColorTypeId" from="${colorTypeList}" optionKey="colorTypeId" optionValue="colorTypeName" value="${params.colorTypeId}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.deliveryTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="conditionDeliveryTypeId" from="${deliveryTypeList}" optionKey="deliveryTypeId" optionValue="deliveryTypeName" value="${params.deliveryTypeId}" noSelection="['':'全て']" />
						</td>
					</tr>

					<tr class="prop">
						<td colspan="2" style="text-align: center;">
							<div class="searchButtons">
								<button id="searchBtn">&nbsp;検索&nbsp;</button>
								<button id="clearSearchConditionBtn">&nbsp;クリア&nbsp;</button>
							</div>
						</td>
					</tr>

				</tbody>
			</table>
			</g:form>
		</div>

		<div id="listArea">
			<div class="bgGray" style="float:none; width:100%; height:34px;">
				<g:render template="/common/pagination/pagination" />
			</div>

			<div style="float:none; width:100%;">
				<table style="width:100%;">
					<thead>
						<tr class="odd">
							<th class="alignCenter"><input type="checkbox" id="selectAllCheckbox" /></th>
							<th class="alignCenter">商品No.</th>
							<th class="alignCenter">アイテム</th>
							<th class="alignCenter">サイズ</th>
							<th class="alignCenter">用紙</th>
							<th class="alignCenter">印刷面・色数</th>
							<th class="alignCenter">納期</th>
							<th class="alignCenter">最小申込数量</th>
							<th class="alignCenter">最大申込数量</th>
							<th class="alignCenter">ロット数</th>
							<th class="alignCenter">売価</th>
							<th class="alignCenter">郵券代</th>
							<th class="alignCenter">あて名印字</th>
							<th class="alignCenter">発送（差出）代行</th>
							<th class="alignCenter">加工</th>
							<th class="alignCenter">有効</th>
							<th class="alignCenter">コピー</th>
						</tr>
					</thead>
					<tbody id="goodsInfoTable">
					</tbody>
				</table>
			</div>
		</div>

		<div class="buttons">
			<button id="deleteBtn">&nbsp;削除&nbsp;</button>
			<button id="enableBtn" style="margin-left: 2em;">&nbsp;有効&nbsp;</button>
			<button id="disableBtn" style="margin-right: 2em;">&nbsp;無効&nbsp;</button>
			<button id="createBtn">&nbsp;新規&nbsp;</button>
		</div>

<g:render template="/common/fragment/validatormessages" />

		<div class="dialog">
			<g:form method="get" action="list" name="updateForm" onsubmit="return false;">
			<input type="hidden" id="id" name="id" value="" />
			<input type="hidden" id="version" name="version" value="" />
			<table>
				<tbody>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.goodsNo?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="goodsNo" name="goodsNo" value="" size="40" maxlength="20" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name"><label for="enabled">${fieldNames?.GoodsInfo?.enabled?.encodeAsHTML()}:</label></td>
						<td class="value">
							<input type="checkbox" id="enabled" name="enabled" value="true" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">アイテム:</td>
						<td class="value">
							<g:select name="genreUniqueId" from="${itemGenreList}" optionKey="id" optionValue="genreName" value="" noSelection="['':'']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.paperSizeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="paperSizeId" from="${paperSizeList}" optionKey="paperSizeId" optionValue="paperSizeName" value="" noSelection="['':'']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.paperTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="paperTypeId" from="${paperTypeList}" optionKey="paperTypeId" optionValue="paperTypeName" value="" noSelection="['':'']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.colorTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="colorTypeId" from="${colorTypeList}" optionKey="colorTypeId" optionValue="colorTypeName" value="" noSelection="['':'']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.deliveryTypeId?.encodeAsHTML()}:</td>
						<td class="value">
							<g:select name="deliveryTypeId" from="${deliveryTypeList}" optionKey="deliveryTypeId" optionValue="deliveryTypeName" value="" noSelection="['':'']" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.minQuantity?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="minQuantity" name="minQuantity" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.maxQuantity?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="maxQuantity" name="maxQuantity" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.lotSize?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="lotSize" name="lotSize" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.sellingPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="sellingPrice" name="sellingPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.sellingStepPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="sellingStepPrice" name="sellingStepPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.stepUnit?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="stepUnit" name="stepUnit" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.postcardPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="postcardPrice" name="postcardPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.jpmdSellingPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="jpmdSellingPrice" name="jpmdSellingPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.jpmdSellingStepPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="jpmdSellingStepPrice" name="jpmdSellingStepPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.jpmdPostcardPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="jpmdPostcardPrice" name="jpmdPostcardPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.optionAddressPrint?.encodeAsHTML()}:</td>
						<td class="value" id="optionAddressPrintParent" style="white-space: normal;">
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.optionSend?.encodeAsHTML()}:</td>
						<td class="value" id="optionSendParent">
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.optionFoldReprocesses?.encodeAsHTML()}:</td>
						<td class="value" id="optionFoldReprocessesParent">
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.graphicPrintSetId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="graphicPrintSetId" name="graphicPrintSetId" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.graphicNoukiId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="graphicNoukiId" name="graphicNoukiId" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.graphicColorId?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="graphicColorId" name="graphicColorId" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.graphicBasePrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="graphicBasePrice" name="graphicBasePrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.graphicUnitPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="graphicUnitPrice" name="graphicUnitPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.goodsSortOrder?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="goodsSortOrder" name="goodsSortOrder" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.firstTimeSellingPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="firstTimeSellingPrice" name="firstTimeSellingPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.firstTimeSellingStepPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="firstTimeSellingStepPrice" name="firstTimeSellingStepPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">大口会員売価:</td>
						<td class="value">
							<div class="dialog">
								<table style="width:auto;border:none;">
									<tbody>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice01?.encodeAsHTML()}:</td>
											<td style="padding-right:4em;"><input type="text" id="largeICustomerSellingPrice01" name="largeICustomerSellingPrice01" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice01?.encodeAsHTML()}:</td>
											<td style="padding-right:4em;"><input type="text" id="largeICustomerSellingStepPrice01" name="largeICustomerSellingStepPrice01" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice02?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice02" name="largeICustomerSellingPrice02" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice02?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice02" name="largeICustomerSellingStepPrice02" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice03?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice03" name="largeICustomerSellingPrice03" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice03?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice03" name="largeICustomerSellingStepPrice03" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice04?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice04" name="largeICustomerSellingPrice04" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice04?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice04" name="largeICustomerSellingStepPrice04" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice05?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice05" name="largeICustomerSellingPrice05" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice05?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice05" name="largeICustomerSellingStepPrice05" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice06?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice06" name="largeICustomerSellingPrice06" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice06?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice06" name="largeICustomerSellingStepPrice06" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice07?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice07" name="largeICustomerSellingPrice07" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice07?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice07" name="largeICustomerSellingStepPrice07" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice08?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice08" name="largeICustomerSellingPrice08" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice08?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice08" name="largeICustomerSellingStepPrice08" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice09?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice09" name="largeICustomerSellingPrice09" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice09?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice09" name="largeICustomerSellingStepPrice09" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingPrice10?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingPrice10" name="largeICustomerSellingPrice10" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice10?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICustomerSellingStepPrice10" name="largeICustomerSellingStepPrice10" value="" size="10" maxlength="10" /></td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>

					<tr class="prop">
						<td class="name">キャンペーン期間:</td>
						<td class="value">
							<input type="text" id="campaignStartDate" name="campaignStartDate" value="" size="10" maxlength="10" readonly="readonly" />～<input type="text" id="campaignEndDate" name="campaignEndDate" value="" size="10" maxlength="10" readonly="readonly" />
							<button id="clearCampaignBtn">キャンペーン期間をクリア</button>
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.campaignSellingPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="campaignSellingPrice" name="campaignSellingPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">${fieldNames?.GoodsInfo?.campaignSellingStepPrice?.encodeAsHTML()}:</td>
						<td class="value">
							<input type="text" id="campaignSellingStepPrice" name="campaignSellingStepPrice" value="" size="10" maxlength="10" />
						</td>
					</tr>

					<tr class="prop">
						<td class="name">大口会員キャンペーン売価:</td>
						<td class="value">
							<div class="dialog">
								<table style="width:auto;border:none;">
									<tbody>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice01?.encodeAsHTML()}:</td>
											<td style="padding-right:4em;"><input type="text" id="largeICCampaignSellingPrice01" name="largeICCampaignSellingPrice01" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice01?.encodeAsHTML()}:</td>
											<td style="padding-right:4em;"><input type="text" id="largeICCampaignSellingStepPrice01" name="largeICCampaignSellingStepPrice01" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice02?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice02" name="largeICCampaignSellingPrice02" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice02?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice02" name="largeICCampaignSellingStepPrice02" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice03?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice03" name="largeICCampaignSellingPrice03" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice03?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice03" name="largeICCampaignSellingStepPrice03" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice04?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice04" name="largeICCampaignSellingPrice04" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice04?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice04" name="largeICCampaignSellingStepPrice04" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice05?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice05" name="largeICCampaignSellingPrice05" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice05?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice05" name="largeICCampaignSellingStepPrice05" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice06?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice06" name="largeICCampaignSellingPrice06" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice06?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice06" name="largeICCampaignSellingStepPrice06" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice07?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice07" name="largeICCampaignSellingPrice07" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice07?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice07" name="largeICCampaignSellingStepPrice07" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice08?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice08" name="largeICCampaignSellingPrice08" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice08?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice08" name="largeICCampaignSellingStepPrice08" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice09?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice09" name="largeICCampaignSellingPrice09" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice09?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice09" name="largeICCampaignSellingStepPrice09" value="" size="10" maxlength="10" /></td>
										</tr>
										<tr>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice10?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingPrice10" name="largeICCampaignSellingPrice10" value="" size="10" maxlength="10" /></td>
											<td>${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice10?.encodeAsHTML()}:</td>
											<td><input type="text" id="largeICCampaignSellingStepPrice10" name="largeICCampaignSellingStepPrice10" value="" size="10" maxlength="10" /></td>
										</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>

					<tr class="prop">
						<td colspan="2" style="text-align: center;">
							<div class="searchButtons">
								<button id="updateBtn" style="width: 8em;">追加</button>
							</div>
						</td>
					</tr>

				</tbody>
			</table>
			</g:form>
		</div>

	</div>

<form>
<input type="hidden" id="ccGoodsNo" name="ccGoodsNo" value="${params.goodNo?.encodeAsHTML()}" />
<input type="hidden" id="ccGenreUniqueId" name="ccGenreUniqueId" value="${params.genreUniqueId?.encodeAsHTML()}" />
<input type="hidden" id="ccPaperSizeId" name="ccPaperSizeId" value="${params.paperSizeId?.encodeAsHTML()}" />
<input type="hidden" id="ccPaperTypeId" name="ccPaperTypeId" value="${params.paperTypeId?.encodeAsHTML()}" />
<input type="hidden" id="ccColorTypeId" name="ccColorTypeId" value="${params.colorTypeId?.encodeAsHTML()}" />
<input type="hidden" id="ccDeliveryTypeId" name="ccDeliveryTypeId" value="${params.deliveryTypeId?.encodeAsHTML()}" />
</form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
var goodsInfoListFunc = null;
;jQuery(function(){
var optionAddressPrintList = null;
var optionSendList = null;
var optionFoldReprocessesList = null;
var appendOptionCheckbox = function(parentId, optionName, optionClass, optionList) {
	var parent = $("#" + parentId);
	parent.empty();
	if (!optionList) {
		return false;
	}
	for (var index = 0;index < optionList.length; index++) {
		var opt = optionList[index];
		var elementId = optionName + index;
		var chkbx = $('<input type="checkbox" />').addClass("mR3 optionCheckBox").addClass(optionClass).attr('name', optionName).attr('id', elementId).val(opt.optionServiceId);
		var lbl = $('<label></label>').addClass('mR20').attr('for', elementId).text(opt.optionServiceName); // dispnameはユーザ画面での表示用
		parent.append(chkbx).append(lbl);
	}
	return false;
};
var updateOptionList = function() {
	$.ajax({
		url: "${createLink(action:'listOptions')}",
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				optionAddressPrintList = data.optionAddressPrintList;
				optionSendList = data.optionSendList;
				optionFoldReprocessesList = data.optionFoldReprocessesList;
				appendOptionCheckbox('optionAddressPrintParent', 'optionAddressPrint', 'optionAddressPrint', optionAddressPrintList);
				appendOptionCheckbox('optionSendParent', 'optionSend', 'optionSend', optionSendList);
				appendOptionCheckbox('optionFoldReprocessesParent', 'optionFoldReprocesses', 'optionFoldReprocesses', optionFoldReprocessesList);
			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "追加サービスの選択肢を取得できませんでした。");
			}
			return false;
		}
	});
	return false;
};
var searchGoodsInfo = function() {
	$("#ccGoodsNo").val($("#conditionGoodsNo").val());
	$("#ccGenreUniqueId").val($("#conditionGenreUniqueId").val());
	$("#ccPaperSizeId").val($("#conditionPaperSizeId").val());
	$("#ccPaperTypeId").val($("#conditionPaperTypeId").val());
	$("#ccColorTypeId").val($("#conditionColorTypeId").val());
	$("#ccDeliveryTypeId").val($("#conditionDeliveryTypeId").val());
	updateGoodsInfoList(0);
	return false;
}
$("#searchBtn").button().click(searchGoodsInfo);
$("#clearSearchConditionBtn").button().click(function() {
	$("#conditionGoodsNo").val('');
	$("#conditionGenreUniqueId").val('');
	$("#conditionPaperSizeId").val('');
	$("#conditionPaperTypeId").val('');
	$("#conditionColorTypeId").val('');
	$("#conditionDeliveryTypeId").val('');
	return false;
});
$("#selectAllCheckbox").click(function() {
	$("input:checkbox.selectGoodsInfoCheckbox").setChecked($(this).isChecked());
	return true;
});
goodsInfoListFunc = new listFunc("goodsInfoListFunc", 10, "goodsNo", "asc");
var updateGoodsInfoList = function(offset) {
	clearUpdateFormFunc();
	if (!$.isNaN(offset)) {
		goodsInfoListFunc.offset = offset;
	}
	if (goodsInfoListFunc.offset < 0) {
		goodsInfoListFunc.offset = 0;
	}
	var goodsNo = $("#ccGoodsNo").val();
	var genreUniqueId = $("#ccGenreUniqueId").val();
	var paperSizeId = $("#ccPaperSizeId").val();
	var paperTypeId = $("#ccPaperTypeId").val();
	var colorTypeId = $("#ccColorTypeId").val();
	var deliveryTypeId = $("#ccDeliveryTypeId").val();
	var pparams = goodsInfoListFunc.getPageSortParam(null);
	var sparams = { goodsNo:goodsNo, genreUniqueId:genreUniqueId, paperSizeId:paperSizeId, paperTypeId:paperTypeId, colorTypeId:colorTypeId, deliveryTypeId:deliveryTypeId };
	sparams.offset = pparams.offset;
	sparams.max = pparams.pageMax;
	sparams.sort = pparams.sortKey;
	sparams.order = pparams.sortOrder;
	$.ajax({
		url: "${createLink(action:'listGoodsInfo')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				goodsInfoListFunc.updatePagination(data.totalCount, data.offset);
				var goodsInfoTable = $("#goodsInfoTable");
				goodsInfoTable.empty();
				$("#selectAllCheckbox").setChecked(false);
				var goodsInfoList = data.list;
				if (goodsInfoList && (goodsInfoList.length > 0)) {
					var td0Attr = { style:"text-align:center; vertical-align:middle; width:2em;" };
					var td1Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td2Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td3Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td4Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td5Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td6Attr = { style:"text-align:left; vertical-align:middle; width:auto;" };
					var td7Attr = { style:"text-align:right; vertical-align:middle; width:auto;" };
					var td8Attr = { style:"text-align:right; vertical-align:middle; width:auto;" };
					var td9Attr = { style:"text-align:right; vertical-align:middle; width:auto;" };
					var td10Attr = { style:"text-align:right; vertical-align:middle; width:auto;" };
					var td11Attr = { style:"text-align:right; vertical-align:middle; width:auto;" };
					var td12Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					var td13Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					var td14Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					var td15Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					var td16Attr = { style:"text-align:center; vertical-align:middle; width:auto;" };
					for (var index = 0; index < goodsInfoList.length; index++) {
						var goodsInfo = goodsInfoList[index];
						// ダイアログの一覧
						var removeCheckbox = $('<input type="checkbox" />').addClass('selectGoodsInfoCheckbox').data(goodsInfo);
						var td0 = $('<td />', td0Attr).append(removeCheckbox);
						var goodsNo = $('<a href="javascript:void(0)" ></a>').addClass('goodsInfoEditBtn').text(goodsInfo.goodsNo).data(goodsInfo);
						var td1 = $('<td />', td1Attr).append(goodsNo);
						var td2 = $('<td />', td2Attr).text(goodsInfo.genreName);
						var td3 = $('<td />', td3Attr).text(goodsInfo.paperSizeName);
						var td4 = $('<td />', td4Attr).text(goodsInfo.paperTypeName);
						var td5 = $('<td />', td5Attr).text(goodsInfo.colorTypeName);
						var td6 = $('<td />', td6Attr).text(goodsInfo.deliveryTypeName);
						var td7 = $('<td />', td7Attr).text(goodsInfo.minQuantity);
						var td8 = $('<td />', td8Attr).text(goodsInfo.maxQuantity);
						var td9 = $('<td />', td9Attr).text(goodsInfo.lotSize);
						var td10 = $('<td />', td10Attr).text(goodsInfo.sellingPrice);
						var td11 = $('<td />', td11Attr).text(goodsInfo.postcardPrice);
						var td12 = $('<td />', td12Attr).text($.isNull(goodsInfo.optionAddressPrint) ? 'なし' : 'あり');
						var td13 = $('<td />', td13Attr).text($.isNull(goodsInfo.optionSend) ? 'なし' : 'あり');
						var td14 = $('<td />', td14Attr).text($.isNull(goodsInfo.optionFoldReprocesses) ? 'なし' : 'あり');
						var td15 = $('<td />', td15Attr).text(goodsInfo.enabled ? '有効' : '無効');
						var copyImg = $('<img alt="コピー" />').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_file.gif");
						var copyBtn = $('<a href="javascript:void(0)" ></a>').addClass('goodsInfoCopyBtn').append(copyImg).data(goodsInfo);
						var td16 = $('<td />', td16Attr).append(copyBtn);
						var tr = $('<tr />').append(td0).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6).append(td7).append(td8).append(td9).append(td10).append(td11).append(td12).append(td13).append(td14).append(td15).append(td16);
						goodsInfoTable.append(tr);
					}
					$("tr", goodsInfoTable).evenodd();
					$(".goodsInfoEditBtn", goodsInfoTable).click(function() {
						var goodsInfo = $(this).data();
						setupGoodsInfoForEditFunc(goodsInfo, true);
						return false;
					});
					$(".goodsInfoCopyBtn", goodsInfoTable).click(function() {
						var goodsInfo = $(this).data();
						setupGoodsInfoForEditFunc(goodsInfo, false);
						return false;
					});
				} else {
					var td = $('<td />', { 'colspan':'17', style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					goodsInfoTable.append(tr);
				}

			} else {
				goodsInfoListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "商品一覧を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var selectedGoodsInfoIds = function() {
	var ids = Array();
	$("input:checkbox:checked.selectGoodsInfoCheckbox").each(function(index, element) {
		var goodsInfo = $(this).data();
		ids.push(goodsInfo.id);
	});
	return ids;
};
$("#deleteBtn").button().click(function() {
	var ids = selectedGoodsInfoIds();
	if (ids.length <= 0) {
		$().toastmessage('showErrorToast', "削除する商品を選択してください。");
		return false;
	}
	return oiyConfirm("選択した商品を削除しますか？", function() {
		pleaseWait();
		var rparams = { ids:ids };
		$.ajax({
			url: "${createLink(action:'removeGoodsInfos')}",
			data: rparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if ((data.result == "success") && (data.removed > 0)) {
					$().toastmessage('showSuccessToast', data.removed + "件の商品を削除しました。");
					updateGoodsInfoList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "商品を削除出来ませんでした。");
				}
				return false;
			}
		});
		return false;
	});
});
var enableSelected = function(enabled) {
	var ids = selectedGoodsInfoIds();
	if (ids.length <= 0) {
		$().toastmessage('showErrorToast', "商品を選択してください。");
		return false;
	}
	var uparams = { ids:ids, enabled:enabled };
	pleaseWait();
	$.ajax({
		url: "${createLink(action:'enableGoodsInfos')}",
		data: uparams,
		success: function(data, textStatus, jqXHR) {
			closeWait();
			if ((data.result == "success") && (data.updated > 0)) {
				$().toastmessage('showSuccessToast', data.updated + "件の商品を更新しました。");
				updateGoodsInfoList();
			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "商品を更新出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
$("#enableBtn").button().click(function() {
	return enableSelected(true);
});
$("#disableBtn").button().click(function() {
	return enableSelected(false);
});
$("#clearCampaignBtn").button().click(function() {
	$("#campaignStartDate").val('');
	$("#campaignEndDate").val('');
	return false;
});
$.validator.addMethod("validateCampaignPeriod", function(value, element, param) {
	var startDateStr = param.val();
	if ($.isNull(value) || $.isNull(startDateStr)) {
		return true;
	}
	return startDateStr < value;
},"キャンペーン期間が正しくありません。");
var formValidator = $("#updateForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		goodsNo:{
			required:true
		},
		genreUniqueId:{
			required:true
		},
		paperSizeId:{
			required:true
		},
		paperTypeId:{
			required:true
		},
		colorTypeId:{
			required:true
		},
		deliveryTypeId:{
			required:true
		},
		minQuantity:{
			required:true,
			digits:true,
			range:[0,99999999]
		},
		maxQuantity:{
			required:true,
			digits:true,
			range:[0,99999999]
		},
		lotSize:{
			required:true,
			digits:true,
			range:[0,99999999]
		},
		sellingPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		sellingStepPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		stepUnit:{
			required:true,
			digits:true,
			range:[0,99999999]
		},
		postcardPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		jpmdSellingPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		jpmdSellingStepPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		jpmdPostcardPrice:{
			required:true,
			number:true,
			range:[0.0,99999999.99]
		},
		graphicPrintSetId:{
			required:true
		},
		graphicNoukiId:{
			required:true
		},
		graphicColorId:{
			required:true
		},
		graphicBasePrice:{
			required:true
		},
		graphicUnitPrice:{
			required:true
		},
		goodsSortOrder:{
			required:true,
			digits:true
		},
		firstTimeSellingPrice:{
			number:true,
			range:[0.0,99999999.99]
		},
		firstTimeSellingStepPrice:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice01:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice02:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice03:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice04:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice05:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice06:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice07:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice08:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice09:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingPrice10:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice01:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice02:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice03:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice04:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice05:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice06:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice07:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice08:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice09:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICustomerSellingStepPrice10:{
			number:true,
			range:[0.0,99999999.99]
		},
		campaignStartDate:{
			required:function() {
				var endDate = $("#campaignEndDate").val();
				return !$.isNull(endDate);
			},
			date:true
		},
		campaignEndDate:{
			required:function() {
				var startDate = $("#campaignStartDate").val();
				return !$.isNull(startDate);
			},
			validateCampaignPeriod:$("#campaignStartDate"),
			date:true
		},
		campaignSellingPrice:{
			number:true,
			range:[0.0,99999999.99]
		},
		campaignSellingStepPrice:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice01:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice02:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice03:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice04:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice05:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice06:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice07:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice08:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice09:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingPrice10:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice01:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice02:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice03:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice04:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice05:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice06:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice07:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice08:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice09:{
			number:true,
			range:[0.0,99999999.99]
		},
		largeICCampaignSellingStepPrice10:{
			number:true,
			range:[0.0,99999999.99]
		}
	},
	messages:{
		goodsNo:{
			required:"${fieldNames?.GoodsInfo?.goodsNo?.encodeAsHTML()}を指定してください。"
		},
		genreUniqueId:{
			required:"アイテムを選択してください。"
		},
		paperSizeId:{
			required:"${fieldNames?.GoodsInfo?.paperSizeId?.encodeAsHTML()}を選択してください。"
		},
		paperTypeId:{
			required:"${fieldNames?.GoodsInfo?.paperTypeId?.encodeAsHTML()}を選択してください。"
		},
		colorTypeId:{
			required:"${fieldNames?.GoodsInfo?.colorTypeId?.encodeAsHTML()}を選択してください。"
		},
		deliveryTypeId:{
			required:"${fieldNames?.GoodsInfo?.deliveryTypeId?.encodeAsHTML()}を選択してください。"
		},
		minQuantity:{
			required:"${fieldNames?.GoodsInfo?.minQuantity?.encodeAsHTML()}を指定してください。",
			digits:"${fieldNames?.GoodsInfo?.minQuantity?.encodeAsHTML()}には整数を指定してください。",
			range:"${fieldNames?.GoodsInfo?.minQuantity?.encodeAsHTML()}の値をご確認ください。"
		},
		maxQuantity:{
			required:"${fieldNames?.GoodsInfo?.maxQuantity?.encodeAsHTML()}を指定してください。",
			digits:"${fieldNames?.GoodsInfo?.maxQuantity?.encodeAsHTML()}には整数を指定してください。",
			range:"${fieldNames?.GoodsInfo?.maxQuantity?.encodeAsHTML()}の値をご確認ください。"
		},
		lotSize:{
			required:"${fieldNames?.GoodsInfo?.lotSize?.encodeAsHTML()}を指定してください。",
			digits:"${fieldNames?.GoodsInfo?.lotSize?.encodeAsHTML()}には整数を指定してください。",
			range:"${fieldNames?.GoodsInfo?.lotSize?.encodeAsHTML()}の値をご確認ください。"
		},
		sellingPrice:{
			required:"${fieldNames?.GoodsInfo?.sellingPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.sellingPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.sellingPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		sellingStepPrice:{
			required:"${fieldNames?.GoodsInfo?.sellingStepPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.sellingStepPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.sellingStepPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		stepUnit:{
			required:"${fieldNames?.GoodsInfo?.stepUnit?.encodeAsHTML()}を指定してください。",
			digits:"${fieldNames?.GoodsInfo?.stepUnit?.encodeAsHTML()}には整数を指定してください。",
			range:"${fieldNames?.GoodsInfo?.stepUnit?.encodeAsHTML()}の値をご確認ください。"
		},
		postcardPrice:{
			required:"${fieldNames?.GoodsInfo?.postcardPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.postcardPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.postcardPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		jpmdSellingPrice:{
			required:"${fieldNames?.GoodsInfo?.jpmdSellingPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.jpmdSellingPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.jpmdSellingPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		jpmdSellingStepPrice:{
			required:"${fieldNames?.GoodsInfo?.jpmdSellingStepPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.jpmdSellingStepPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.jpmdSellingStepPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		jpmdPostcardPrice:{
			required:"${fieldNames?.GoodsInfo?.jpmdPostcardPrice?.encodeAsHTML()}を指定してください。",
			number:"${fieldNames?.GoodsInfo?.jpmdPostcardPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.jpmdPostcardPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		graphicPrintSetId:{
			required:"${fieldNames?.GoodsInfo?.graphicPrintSetId?.encodeAsHTML()}を指定してください。"
		},
		graphicNoukiId:{
			required:"${fieldNames?.GoodsInfo?.graphicNoukiId?.encodeAsHTML()}を指定してください。"
		},
		graphicColorId:{
			required:"${fieldNames?.GoodsInfo?.graphicColorId?.encodeAsHTML()}を指定してください。"
		},
		graphicBasePrice:{
			required:"${fieldNames?.GoodsInfo?.graphicBasePrice?.encodeAsHTML()}を指定してください。"
		},
		graphicUnitPrice:{
			required:"${fieldNames?.GoodsInfo?.graphicUnitPrice?.encodeAsHTML()}を指定してください。"
		},
		goodsSortOrder:{
			required:"${fieldNames?.GoodsInfo?.goodsSortOrder?.encodeAsHTML()}を指定してください。",
			digits:"${fieldNames?.GoodsInfo?.goodsSortOrder?.encodeAsHTML()}には整数を指定してください。"
		},
		firstTimeSellingPrice:{
			number:"${fieldNames?.GoodsInfo?.firstTimeSellingPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.firstTimeSellingPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		firstTimeSellingStepPrice:{
			number:"${fieldNames?.GoodsInfo?.firstTimeSellingStepPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.firstTimeSellingStepPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice01:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice01?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice01?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice02:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice02?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice02?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice03:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice03?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice03?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice04:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice04?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice04?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice05:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice05?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice05?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice06:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice06?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice06?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice07:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice07?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice07?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice08:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice08?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice08?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice09:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice09?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice09?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingPrice10:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice10?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingPrice10?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice01:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice01?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice01?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice02:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice02?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice02?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice03:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice03?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice03?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice04:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice04?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice04?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice05:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice05?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice05?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice06:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice06?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice06?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice07:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice07?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice07?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice08:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice08?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice08?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice09:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice09?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice09?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICustomerSellingStepPrice10:{
			number:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice10?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICustomerSellingStepPrice10?.encodeAsHTML()}の値をご確認ください。"
		},
		campaignStartDate:{
			required:"${fieldNames?.GoodsInfo?.campaignStartDate?.encodeAsHTML()}を指定してください。",
			date:"${fieldNames?.GoodsInfo?.campaignStartDate?.encodeAsHTML()}には日付を指定してください。"
		},
		campaignEndDate:{
			required:"${fieldNames?.GoodsInfo?.campaignEndDate?.encodeAsHTML()}を指定してください。",
			date:"${fieldNames?.GoodsInfo?.campaignEndDate?.encodeAsHTML()}には日付を指定してください。"
		},
		campaignSellingPrice:{
			number:"${fieldNames?.GoodsInfo?.campaignSellingPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.campaignSellingPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		campaignSellingStepPrice:{
			number:"${fieldNames?.GoodsInfo?.campaignSellingStepPrice?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.campaignSellingStepPrice?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice01:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice01?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice01?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice02:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice02?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice02?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice03:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice03?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice03?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice04:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice04?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice04?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice05:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice05?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice05?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice06:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice06?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice06?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice07:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice07?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice07?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice08:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice08?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice08?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice09:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice09?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice09?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingPrice10:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice10?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingPrice10?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice01:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice01?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice01?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice02:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice02?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice02?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice03:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice03?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice03?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice04:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice04?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice04?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice05:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice05?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice05?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice06:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice06?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice06?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice07:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice07?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice07?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice08:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice08?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice08?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice09:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice09?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice09?.encodeAsHTML()}の値をご確認ください。"
		},
		largeICCampaignSellingStepPrice10:{
			number:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice10?.encodeAsHTML()}には金額を指定してください。",
			range:"${fieldNames?.GoodsInfo?.largeICCampaignSellingStepPrice10?.encodeAsHTML()}の値をご確認ください。"
		}
	}
});
var clearUpdateFormFunc = function() {
	formValidator.resetForm();
	$("#id").val('');
	$("#version").val('');
	$("#goodsNo").val('');
	$("#enabled").setChecked(false);
	$("#genreUniqueId").val('');
	$("#paperSizeId").val('');
	$("#paperTypeId").val('');
	$("#colorTypeId").val('');
	$("#deliveryTypeId").val('');
	$("#minQuantity").val('');
	$("#maxQuantity").val('');
	$("#lotSize").val('');
	$("#sellingPrice").val('');
	$("#sellingStepPrice").val('');
	$("#stepUnit").val('');
	$("#postcardPrice").val('');
	$("#jpmdSellingPrice").val('');
	$("#jpmdSellingStepPrice").val('');
	$("#jpmdPostcardPrice").val('');
	$("input:checkbox.optionCheckBox").setChecked(false);
	$("#graphicPrintSetId").val('');
	$("#graphicNoukiId").val('');
	$("#graphicColorId").val('');
	$("#graphicBasePrice").val('');
	$("#graphicUnitPrice").val('');
	$("#goodsSortOrder").val('');
	$("#firstTimeSellingPrice").val('');
	$("#firstTimeSellingStepPrice").val('');
	$("#largeICustomerSellingPrice01").val('');
	$("#largeICustomerSellingPrice02").val('');
	$("#largeICustomerSellingPrice03").val('');
	$("#largeICustomerSellingPrice04").val('');
	$("#largeICustomerSellingPrice05").val('');
	$("#largeICustomerSellingPrice06").val('');
	$("#largeICustomerSellingPrice07").val('');
	$("#largeICustomerSellingPrice08").val('');
	$("#largeICustomerSellingPrice09").val('');
	$("#largeICustomerSellingPrice10").val('');
	$("#largeICustomerSellingStepPrice01").val('');
	$("#largeICustomerSellingStepPrice02").val('');
	$("#largeICustomerSellingStepPrice03").val('');
	$("#largeICustomerSellingStepPrice04").val('');
	$("#largeICustomerSellingStepPrice05").val('');
	$("#largeICustomerSellingStepPrice06").val('');
	$("#largeICustomerSellingStepPrice07").val('');
	$("#largeICustomerSellingStepPrice08").val('');
	$("#largeICustomerSellingStepPrice09").val('');
	$("#largeICustomerSellingStepPrice10").val('');
	$("#campaignStartDate").val('');
	$("#campaignEndDate").val('');
	$("#campaignSellingPrice").val('');
	$("#campaignSellingStepPrice").val('');
	$("#largeICCampaignSellingPrice01").val('');
	$("#largeICCampaignSellingPrice02").val('');
	$("#largeICCampaignSellingPrice03").val('');
	$("#largeICCampaignSellingPrice04").val('');
	$("#largeICCampaignSellingPrice05").val('');
	$("#largeICCampaignSellingPrice06").val('');
	$("#largeICCampaignSellingPrice07").val('');
	$("#largeICCampaignSellingPrice08").val('');
	$("#largeICCampaignSellingPrice09").val('');
	$("#largeICCampaignSellingPrice10").val('');
	$("#largeICCampaignSellingStepPrice01").val('');
	$("#largeICCampaignSellingStepPrice02").val('');
	$("#largeICCampaignSellingStepPrice03").val('');
	$("#largeICCampaignSellingStepPrice04").val('');
	$("#largeICCampaignSellingStepPrice05").val('');
	$("#largeICCampaignSellingStepPrice06").val('');
	$("#largeICCampaignSellingStepPrice07").val('');
	$("#largeICCampaignSellingStepPrice08").val('');
	$("#largeICCampaignSellingStepPrice09").val('');
	$("#largeICCampaignSellingStepPrice10").val('');
	$("#updateBtn").text('追加');
	return false;
};
var setupOptionCheckbox = function(optionList, optionClass) {
	var optionServiceIdList = null;
	if (optionList) {
		optionServiceIdList = optionList.split(',');
	}
	if (optionServiceIdList && (optionServiceIdList.length > 0)) {
		for (var index = 0; index < optionServiceIdList.length; index++) {
			var optionServiceId = optionServiceIdList[index];
			$("input:checkbox." + optionClass + "[value=" + optionServiceId + "]").setChecked(true);
		}
	}
	return false;
};
var setupGoodsInfoForEditFunc = function(goodsInfo, editFlg) {
	clearUpdateFormFunc();
	if (editFlg) {
		$("#id").val(goodsInfo.id);
		$("#version").val(goodsInfo.version);
		$("#goodsNo").val(goodsInfo.goodsNo);
		$("#minQuantity").val(goodsInfo.minQuantity);
		$("#maxQuantity").val(goodsInfo.maxQuantity);
		$("#lotSize").val(goodsInfo.lotSize);
		$("#updateBtn").text('更新');
	}

	$("#enabled").setChecked(goodsInfo.enabled);
	$("#genreUniqueId").val(goodsInfo.genreUniqueId);
	$("#paperSizeId").val(goodsInfo.paperSizeId);
	$("#paperTypeId").val(goodsInfo.paperTypeId);
	$("#colorTypeId").val(goodsInfo.colorTypeId);
	$("#deliveryTypeId").val(goodsInfo.deliveryTypeId);
	$("#sellingPrice").val(goodsInfo.sellingPrice);
	$("#sellingStepPrice").val(goodsInfo.sellingStepPrice);
	$("#stepUnit").val(goodsInfo.stepUnit);
	$("#postcardPrice").val(goodsInfo.postcardPrice);
	$("#jpmdSellingPrice").val(goodsInfo.jpmdSellingPrice);
	$("#jpmdSellingStepPrice").val(goodsInfo.jpmdSellingStepPrice);
	$("#jpmdPostcardPrice").val(goodsInfo.jpmdPostcardPrice);
	setupOptionCheckbox(goodsInfo.optionAddressPrint, 'optionAddressPrint');
	setupOptionCheckbox(goodsInfo.optionSend, 'optionSend');
	setupOptionCheckbox(goodsInfo.optionFoldReprocesses, 'optionFoldReprocesses');
	$("#graphicPrintSetId").val(goodsInfo.graphicPrintSetId);
	$("#graphicNoukiId").val(goodsInfo.graphicNoukiId);
	$("#graphicColorId").val(goodsInfo.graphicColorId);
	$("#graphicBasePrice").val(goodsInfo.graphicBasePrice);
	$("#graphicUnitPrice").val(goodsInfo.graphicUnitPrice);
	$("#goodsSortOrder").val(goodsInfo.goodsSortOrder);

	$("#firstTimeSellingPrice").val(goodsInfo.firstTimeSellingPrice);
	$("#firstTimeSellingStepPrice").val(goodsInfo.firstTimeSellingStepPrice);
	$("#largeICustomerSellingPrice01").val(goodsInfo.largeICustomerSellingPrice01);
	$("#largeICustomerSellingPrice02").val(goodsInfo.largeICustomerSellingPrice02);
	$("#largeICustomerSellingPrice03").val(goodsInfo.largeICustomerSellingPrice03);
	$("#largeICustomerSellingPrice04").val(goodsInfo.largeICustomerSellingPrice04);
	$("#largeICustomerSellingPrice05").val(goodsInfo.largeICustomerSellingPrice05);
	$("#largeICustomerSellingPrice06").val(goodsInfo.largeICustomerSellingPrice06);
	$("#largeICustomerSellingPrice07").val(goodsInfo.largeICustomerSellingPrice07);
	$("#largeICustomerSellingPrice08").val(goodsInfo.largeICustomerSellingPrice08);
	$("#largeICustomerSellingPrice09").val(goodsInfo.largeICustomerSellingPrice09);
	$("#largeICustomerSellingPrice10").val(goodsInfo.largeICustomerSellingPrice10);
	$("#largeICustomerSellingStepPrice01").val(goodsInfo.largeICustomerSellingStepPrice01);
	$("#largeICustomerSellingStepPrice02").val(goodsInfo.largeICustomerSellingStepPrice02);
	$("#largeICustomerSellingStepPrice03").val(goodsInfo.largeICustomerSellingStepPrice03);
	$("#largeICustomerSellingStepPrice04").val(goodsInfo.largeICustomerSellingStepPrice04);
	$("#largeICustomerSellingStepPrice05").val(goodsInfo.largeICustomerSellingStepPrice05);
	$("#largeICustomerSellingStepPrice06").val(goodsInfo.largeICustomerSellingStepPrice06);
	$("#largeICustomerSellingStepPrice07").val(goodsInfo.largeICustomerSellingStepPrice07);
	$("#largeICustomerSellingStepPrice08").val(goodsInfo.largeICustomerSellingStepPrice08);
	$("#largeICustomerSellingStepPrice09").val(goodsInfo.largeICustomerSellingStepPrice09);
	$("#largeICustomerSellingStepPrice10").val(goodsInfo.largeICustomerSellingStepPrice10);
	$("#campaignStartDate").val(goodsInfo.campaignStartDate);
	$("#campaignEndDate").val(goodsInfo.campaignEndDate);
	$("#campaignSellingPrice").val(goodsInfo.campaignSellingPrice);
	$("#campaignSellingStepPrice").val(goodsInfo.campaignSellingStepPrice);
	$("#largeICCampaignSellingPrice01").val(goodsInfo.largeICCampaignSellingPrice01);
	$("#largeICCampaignSellingPrice02").val(goodsInfo.largeICCampaignSellingPrice02);
	$("#largeICCampaignSellingPrice03").val(goodsInfo.largeICCampaignSellingPrice03);
	$("#largeICCampaignSellingPrice04").val(goodsInfo.largeICCampaignSellingPrice04);
	$("#largeICCampaignSellingPrice05").val(goodsInfo.largeICCampaignSellingPrice05);
	$("#largeICCampaignSellingPrice06").val(goodsInfo.largeICCampaignSellingPrice06);
	$("#largeICCampaignSellingPrice07").val(goodsInfo.largeICCampaignSellingPrice07);
	$("#largeICCampaignSellingPrice08").val(goodsInfo.largeICCampaignSellingPrice08);
	$("#largeICCampaignSellingPrice09").val(goodsInfo.largeICCampaignSellingPrice09);
	$("#largeICCampaignSellingPrice10").val(goodsInfo.largeICCampaignSellingPrice10);
	$("#largeICCampaignSellingStepPrice01").val(goodsInfo.largeICCampaignSellingStepPrice01);
	$("#largeICCampaignSellingStepPrice02").val(goodsInfo.largeICCampaignSellingStepPrice02);
	$("#largeICCampaignSellingStepPrice03").val(goodsInfo.largeICCampaignSellingStepPrice03);
	$("#largeICCampaignSellingStepPrice04").val(goodsInfo.largeICCampaignSellingStepPrice04);
	$("#largeICCampaignSellingStepPrice05").val(goodsInfo.largeICCampaignSellingStepPrice05);
	$("#largeICCampaignSellingStepPrice06").val(goodsInfo.largeICCampaignSellingStepPrice06);
	$("#largeICCampaignSellingStepPrice07").val(goodsInfo.largeICCampaignSellingStepPrice07);
	$("#largeICCampaignSellingStepPrice08").val(goodsInfo.largeICCampaignSellingStepPrice08);
	$("#largeICCampaignSellingStepPrice09").val(goodsInfo.largeICCampaignSellingStepPrice09);
	$("#largeICCampaignSellingStepPrice10").val(goodsInfo.largeICCampaignSellingStepPrice10);

	$("#goodsNo").focus();
	return false;
};
$("#createBtn").button().click(clearUpdateFormFunc);
var getOptionServiceSelection = function(optionClass) {
	var selectedServiceIdList = Array();
	$("input:checkbox." + optionClass + ":checked").each(function(index, element) {
		selectedServiceIdList.push($(this).val());
	});
	if (selectedServiceIdList.length > 0) {
		return selectedServiceIdList.join(',');
	}
	return '';
};
$("#updateBtn").button().click(function() {
	if (formValidator.form()) {
		var id = $("#id").val();
		var version = $("#version").val();
		var goodsNo = $("#goodsNo").val();
		var enabled = $("#enabled").isChecked();
		var genreUniqueId = $("#genreUniqueId").val();
		var paperSizeId = $("#paperSizeId").val();
		var paperTypeId = $("#paperTypeId").val();
		var colorTypeId = $("#colorTypeId").val();
		var deliveryTypeId = $("#deliveryTypeId").val();
		var minQuantity = $("#minQuantity").val();
		var maxQuantity = $("#maxQuantity").val();
		var lotSize = $("#lotSize").val();
		var sellingPrice = $("#sellingPrice").val();
		var sellingStepPrice = $("#sellingStepPrice").val();
		var stepUnit = $("#stepUnit").val();
		var postcardPrice = $("#postcardPrice").val();
		var jpmdSellingPrice = $("#jpmdSellingPrice").val();
		var jpmdSellingStepPrice = $("#jpmdSellingStepPrice").val();
		var jpmdPostcardPrice = $("#jpmdPostcardPrice").val();
		var optionAddressPrint = getOptionServiceSelection('optionAddressPrint');
		var optionSend = getOptionServiceSelection('optionSend');
		var optionFoldReprocesses = getOptionServiceSelection('optionFoldReprocesses');
		var graphicPrintSetId = $("#graphicPrintSetId").val();
		var graphicNoukiId = $("#graphicNoukiId").val();
		var graphicColorId = $("#graphicColorId").val();
		var graphicBasePrice = $("#graphicBasePrice").val();
		var graphicUnitPrice = $("#graphicUnitPrice").val();
		var goodsSortOrder = $("#goodsSortOrder").val();
		var firstTimeSellingPrice = $("#firstTimeSellingPrice").val();
		var firstTimeSellingStepPrice = $("#firstTimeSellingStepPrice").val();
		var largeICustomerSellingPrice01 = $("#largeICustomerSellingPrice01").val();
		var largeICustomerSellingPrice02 = $("#largeICustomerSellingPrice02").val();
		var largeICustomerSellingPrice03 = $("#largeICustomerSellingPrice03").val();
		var largeICustomerSellingPrice04 = $("#largeICustomerSellingPrice04").val();
		var largeICustomerSellingPrice05 = $("#largeICustomerSellingPrice05").val();
		var largeICustomerSellingPrice06 = $("#largeICustomerSellingPrice06").val();
		var largeICustomerSellingPrice07 = $("#largeICustomerSellingPrice07").val();
		var largeICustomerSellingPrice08 = $("#largeICustomerSellingPrice08").val();
		var largeICustomerSellingPrice09 = $("#largeICustomerSellingPrice09").val();
		var largeICustomerSellingPrice10 = $("#largeICustomerSellingPrice10").val();
		var largeICustomerSellingStepPrice01 = $("#largeICustomerSellingStepPrice01").val();
		var largeICustomerSellingStepPrice02 = $("#largeICustomerSellingStepPrice02").val();
		var largeICustomerSellingStepPrice03 = $("#largeICustomerSellingStepPrice03").val();
		var largeICustomerSellingStepPrice04 = $("#largeICustomerSellingStepPrice04").val();
		var largeICustomerSellingStepPrice05 = $("#largeICustomerSellingStepPrice05").val();
		var largeICustomerSellingStepPrice06 = $("#largeICustomerSellingStepPrice06").val();
		var largeICustomerSellingStepPrice07 = $("#largeICustomerSellingStepPrice07").val();
		var largeICustomerSellingStepPrice08 = $("#largeICustomerSellingStepPrice08").val();
		var largeICustomerSellingStepPrice09 = $("#largeICustomerSellingStepPrice09").val();
		var largeICustomerSellingStepPrice10 = $("#largeICustomerSellingStepPrice10").val();
		var campaignStartDate = $("#campaignStartDate").val();
		var campaignEndDate = $("#campaignEndDate").val();
		var campaignSellingPrice = $("#campaignSellingPrice").val();
		var campaignSellingStepPrice = $("#campaignSellingStepPrice").val();
		var largeICCampaignSellingPrice01 = $("#largeICCampaignSellingPrice01").val();
		var largeICCampaignSellingPrice02 = $("#largeICCampaignSellingPrice02").val();
		var largeICCampaignSellingPrice03 = $("#largeICCampaignSellingPrice03").val();
		var largeICCampaignSellingPrice04 = $("#largeICCampaignSellingPrice04").val();
		var largeICCampaignSellingPrice05 = $("#largeICCampaignSellingPrice05").val();
		var largeICCampaignSellingPrice06 = $("#largeICCampaignSellingPrice06").val();
		var largeICCampaignSellingPrice07 = $("#largeICCampaignSellingPrice07").val();
		var largeICCampaignSellingPrice08 = $("#largeICCampaignSellingPrice08").val();
		var largeICCampaignSellingPrice09 = $("#largeICCampaignSellingPrice09").val();
		var largeICCampaignSellingPrice10 = $("#largeICCampaignSellingPrice10").val();
		var largeICCampaignSellingStepPrice01 = $("#largeICCampaignSellingStepPrice01").val();
		var largeICCampaignSellingStepPrice02 = $("#largeICCampaignSellingStepPrice02").val();
		var largeICCampaignSellingStepPrice03 = $("#largeICCampaignSellingStepPrice03").val();
		var largeICCampaignSellingStepPrice04 = $("#largeICCampaignSellingStepPrice04").val();
		var largeICCampaignSellingStepPrice05 = $("#largeICCampaignSellingStepPrice05").val();
		var largeICCampaignSellingStepPrice06 = $("#largeICCampaignSellingStepPrice06").val();
		var largeICCampaignSellingStepPrice07 = $("#largeICCampaignSellingStepPrice07").val();
		var largeICCampaignSellingStepPrice08 = $("#largeICCampaignSellingStepPrice08").val();
		var largeICCampaignSellingStepPrice09 = $("#largeICCampaignSellingStepPrice09").val();
		var largeICCampaignSellingStepPrice10 = $("#largeICCampaignSellingStepPrice10").val();
		var uparams = { id:id, version:version,
				goodsNo:goodsNo, enabled:enabled, 'itemGenre.id':genreUniqueId, paperSizeId:paperSizeId, paperTypeId:paperTypeId,
				colorTypeId:colorTypeId, deliveryTypeId:deliveryTypeId, minQuantity:minQuantity, maxQuantity:maxQuantity, lotSize:lotSize, 
				sellingPrice:sellingPrice, sellingStepPrice:sellingStepPrice, stepUnit:stepUnit, postcardPrice:postcardPrice,
				jpmdSellingPrice:jpmdSellingPrice, jpmdSellingStepPrice:jpmdSellingStepPrice, jpmdPostcardPrice:jpmdPostcardPrice,
				optionAddressPrint:optionAddressPrint, optionSend:optionSend,
				optionFoldReprocesses:optionFoldReprocesses, graphicPrintSetId:graphicPrintSetId,
				graphicNoukiId:graphicNoukiId, graphicColorId:graphicColorId,
				graphicBasePrice:graphicBasePrice, graphicUnitPrice:graphicUnitPrice,
				goodsSortOrder:goodsSortOrder,
				firstTimeSellingPrice:firstTimeSellingPrice,
				firstTimeSellingStepPrice:firstTimeSellingStepPrice,
				largeICustomerSellingPrice01:largeICustomerSellingPrice01,
				largeICustomerSellingPrice02:largeICustomerSellingPrice02,
				largeICustomerSellingPrice03:largeICustomerSellingPrice03,
				largeICustomerSellingPrice04:largeICustomerSellingPrice04,
				largeICustomerSellingPrice05:largeICustomerSellingPrice05,
				largeICustomerSellingPrice06:largeICustomerSellingPrice06,
				largeICustomerSellingPrice07:largeICustomerSellingPrice07,
				largeICustomerSellingPrice08:largeICustomerSellingPrice08,
				largeICustomerSellingPrice09:largeICustomerSellingPrice09,
				largeICustomerSellingPrice10:largeICustomerSellingPrice10,
				largeICustomerSellingStepPrice01:largeICustomerSellingStepPrice01,
				largeICustomerSellingStepPrice02:largeICustomerSellingStepPrice02,
				largeICustomerSellingStepPrice03:largeICustomerSellingStepPrice03,
				largeICustomerSellingStepPrice04:largeICustomerSellingStepPrice04,
				largeICustomerSellingStepPrice05:largeICustomerSellingStepPrice05,
				largeICustomerSellingStepPrice06:largeICustomerSellingStepPrice06,
				largeICustomerSellingStepPrice07:largeICustomerSellingStepPrice07,
				largeICustomerSellingStepPrice08:largeICustomerSellingStepPrice08,
				largeICustomerSellingStepPrice09:largeICustomerSellingStepPrice09,
				largeICustomerSellingStepPrice10:largeICustomerSellingStepPrice10,
				campaignStartDate:campaignStartDate,
				campaignEndDate:campaignEndDate,
				campaignSellingPrice:campaignSellingPrice,
				campaignSellingStepPrice:campaignSellingStepPrice,
				largeICCampaignSellingPrice01:largeICCampaignSellingPrice01,
				largeICCampaignSellingPrice02:largeICCampaignSellingPrice02,
				largeICCampaignSellingPrice03:largeICCampaignSellingPrice03,
				largeICCampaignSellingPrice04:largeICCampaignSellingPrice04,
				largeICCampaignSellingPrice05:largeICCampaignSellingPrice05,
				largeICCampaignSellingPrice06:largeICCampaignSellingPrice06,
				largeICCampaignSellingPrice07:largeICCampaignSellingPrice07,
				largeICCampaignSellingPrice08:largeICCampaignSellingPrice08,
				largeICCampaignSellingPrice09:largeICCampaignSellingPrice09,
				largeICCampaignSellingPrice10:largeICCampaignSellingPrice10,
				largeICCampaignSellingStepPrice01:largeICCampaignSellingStepPrice01,
				largeICCampaignSellingStepPrice02:largeICCampaignSellingStepPrice02,
				largeICCampaignSellingStepPrice03:largeICCampaignSellingStepPrice03,
				largeICCampaignSellingStepPrice04:largeICCampaignSellingStepPrice04,
				largeICCampaignSellingStepPrice05:largeICCampaignSellingStepPrice05,
				largeICCampaignSellingStepPrice06:largeICCampaignSellingStepPrice06,
				largeICCampaignSellingStepPrice07:largeICCampaignSellingStepPrice07,
				largeICCampaignSellingStepPrice08:largeICCampaignSellingStepPrice08,
				largeICCampaignSellingStepPrice09:largeICCampaignSellingStepPrice09,
				largeICCampaignSellingStepPrice10:largeICCampaignSellingStepPrice10
				};
		pleaseWait();
		$.ajax({
			url: "${createLink(action:'setGoodsInfo')}",
			data: uparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					updateGoodsInfoList();
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "商品を追加／更新出来ませんでした。");
				}
				return false;
			}
		});
	}
	return false;
});
$("#campaignStartDate").datepicker({changeYear:true, showOn:'both', buttonImage:"${r.resource(dir:'images/skin',file:'btn_calendar.gif')}", buttonImageOnly:true, duration:'fast', dateFormat:"${jqDateFormat?.encodeAsHTML()}"});
$("#campaignEndDate").datepicker({changeYear:true, showOn:'both', buttonImage:"${r.resource(dir:'images/skin',file:'btn_calendar.gif')}", buttonImageOnly:true, duration:'fast', dateFormat:"${jqDateFormat?.encodeAsHTML()}"});
goodsInfoListFunc.initList();
goodsInfoListFunc.addEventListner(updateGoodsInfoList, updateGoodsInfoList);
searchGoodsInfo();
updateOptionList();
});</r:script>
</body>
</html>
