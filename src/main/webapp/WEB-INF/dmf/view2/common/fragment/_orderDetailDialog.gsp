<g:form controller="myProduct" action="productPreviewPdf" name="orderDetailDialogPreviewForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
</g:form>
<g:form controller="myProduct" action="downloadMyAddressList" name="orderDetailDialogDownloadMyListForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
</g:form>
<div id="orderDetailDialog" title="注文明細" class="popBox" style="background-color:white; display:none;">
	<g:form controller="myProduct" action="productThumbnail" name="orderDetailDialogForm" onsubmit="return false;">
	<div class="left" style="width:350px;">
		<table cellpadding="0" cellspacing="0" class="listTable">
			<tr>
				<th width="150" class="align_right">注文No.</th>
				<td width="200" class="align_left"><span id="orderDetailDialogOrderNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">明細No.</th>
				<td class="align_left"><span id="orderDetailDialogDetailNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">プロダクトNo.</th>
				<td class="align_left"><span id="orderDetailDialogMyProductNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">プロダクト名称</th>
				<td class="align_left"><span id="orderDetailDialogMyProductName"></span></td>
			</tr>
			<tr>
				<th class="align_right">スペックNo.</th>
				<td class="align_left"><span id="orderDetailDialogMySpecNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">ライブラリNo.</th>
				<td class="align_left"><span id="orderDetailDialogMyLibraryNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">リストNo.</th>
				<td class="align_left"><span id="orderDetailDialogMyAddressListNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">アイテム</th>
				<td class="align_left"><span id="orderDetailDialogGenreName"></span></td>
			</tr>
			<tr>
				<th class="align_right">サイズ</th>
				<td class="align_left"><span id="orderDetailDialogPaperSizeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">色数</th>
				<td class="align_left"><span id="orderDetailDialogColorTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">用紙</th>
				<td class="align_left"><span id="orderDetailDialogPaperTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">出荷日<br /><a href="/about/delivery.html" target="_blank" class="fontN">出荷日について</a></th>
				<td class="align_left"><span id="orderDetailDialogDeliveryTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">枚数</th>
				<td class="align_left"><span id="orderDetailDialogQuantity"></span></td>
			</tr>
			<tr>
				<th class="align_right">あて名印字</th>
				<td class="align_left"><span id="orderDetailDialogOptionAddressPrint"></span>　<span id="orderDetailDialogOptionAddressPrintQuantityArea"><span id="orderDetailDialogOptionAddressPrintQuantity"></span>件</span></td>
			</tr>
			<tr>
				<th class="align_right">発送（差出）代行</th>
				<td class="align_left"><span id="orderDetailDialogOptionSend"></span></td>
			</tr>
			<tr style="display:none;">
				<th class="align_right">加工</th>
				<td class="align_left"><span id="orderDetailDialogOptionFoldReprocess"></span></td>
			</tr>
			<tr>
				<th class="align_right">印刷料金小計</th>
				<td class="align_left"><span id="orderDetailDialogPrintSubtotal"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">郵便はがき代金</th>
				<td class="align_left"><span id="orderDetailDialogMailAmount"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">追加サービス料金小計</th>
				<td class="align_left"><span id="orderDetailDialogOptionSubtotal"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">郵便料金相当額</th>
				<td class="align_left"><span id="orderDetailDialogOptionMailAmount"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">合計金額</th>
				<td class="align_left"><span id="orderDetailDialogTotalAmount"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">注文ステータス</th>
				<td class="align_left"><span id="orderDetailDialogOrderStatus"></span></td>
			</tr>
		</table>
	</div>
	<div class="right w250 align_left" style="overflow:hidden;">
		<ul>
			<li>ライブラリNo.：<span id="orderDetailDialogMyLibraryNo2"></span></li>
			<li><span id="orderDetailDialogMyLibraryName2"></span></li>
		</ul>
		<div class="align_center"">
			<table cellpadding="0" cellspacing="0" class="mT20 mB20" style="margin-left:auto; margin-right:auto;">
				<tr>
					<td style="width:130px; height:130px; text-align:center; vertical-align:middle; padding:5px; overflow:hidden;"><div id="orderDetailDialogImg1"></div></td>
				</tr>
				<tr>
					<td style="width:130px; height:130px; text-align:center; vertical-align:middle; padding:5px; overflow:hidden;"><div id="orderDetailDialogImg2"></div></td>
				</tr>
			</table>
		</div>

		<div class="align_center"><input type="image" id="orderDetailDialogPreviewBtn" src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_preview.gif" alt="プレビュー" /></div>

		<div id="orderDetailDialogOptionAddressPrintFontArea" class="align_center mT10" style="display:none;">
			<span id="orderDetailDialogOptionAddressPrintFont" class="red size20 bold"></span>
		</div>
	</div>

	<div class="align_center clearboth mB10">
		<a href="javascript:void(0)" id="orderDetailDialogCloseBtn"><img src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_tojiruB2.gif" width="112" height="33" alt="閉じる" /></a>
		<input type="image" id="orderDetailDialogOrderBtn" src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_order-off.gif" alt="注文" style="display:none;" />
	</div>
	</g:form>
</div>
