<g:form controller="myProduct" action="productPreviewPdf" name="myProductDetailDialogPreviewForm" onsubmit="return false;">
<input type="hidden" name="id" value="" />
</g:form>
<div id="myProductDetailDialog" title="詳細" class="popBox" style="background-color:white; display:none;">
	<g:form controller="myProduct" action="productThumbnail" name="myProductDetailDialogForm" onsubmit="return false;">
	<div class="left" style="width:340px;">
		<table cellpadding="0" cellspacing="0" class="listTable">
			<tr>
				<th width="140" class="align_right">プロダクトNo.</th>
				<td width="200" class="align_left"><span id="myProductDetailDialogMyProductNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">プロダクト名称</th>
				<td class="align_left"><span id="myProductDetailDialogMyProductName"></span></td>
			</tr>
			<tr>
				<th class="align_right">スペックNo.</th>
				<td class="align_left"><span id="myProductDetailDialogMySpecNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">ライブラリNo.</th>
				<td class="align_left"><span id="myProductDetailDialogMyLibraryNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">リストNo.</th>
				<td class="align_left"><span id="myProductDetailDialogMyAddressListNo"></span></td>
			</tr>
			<tr>
				<th class="align_right">アイテム</th>
				<td class="align_left"><span id="myProductDetailDialogGenreName"></span></td>
			</tr>
			<tr>
				<th class="align_right">サイズ</th>
				<td class="align_left"><span id="myProductDetailDialogPaperSizeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">色数</th>
				<td class="align_left"><span id="myProductDetailDialogColorTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">用紙</th>
				<td class="align_left"><span id="myProductDetailDialogPaperTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">出荷日<br /><a href="/about/delivery.html" target="_blank" class="fontN">出荷日について</a></th>
				<td class="align_left"><span id="myProductDetailDialogDeliveryTypeName"></span></td>
			</tr>
			<tr>
				<th class="align_right">枚数</th>
				<td class="align_left"><span id="myProductDetailDialogQuantity"></span></td>
			</tr>
			<tr>
				<th class="align_right">あて名印字</th>
				<td class="align_left"><span id="myProductDetailDialogOptionAddressPrint"></span>　<span id="myProductDetailDialogOptionAddressPrintQuantityArea"><span id="myProductDetailDialogOptionAddressPrintQuantity"></span>件</span></td>
			</tr>
			<tr>
				<th class="align_right">発送（差出）代行</th>
				<td class="align_left"><span id="myProductDetailDialogOptionSend"></span></td>
			</tr>
			<tr style="display:none;">
				<th class="align_right">加工</th>
				<td class="align_left"><span id="myProductDetailDialogOptionFoldReprocess"></span></td>
			</tr>
			<tr>
				<th class="align_right">印刷料金小計</th>
				<td class="align_left"><span id="myProductDetailDialogPrintSubtotal"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">郵便はがき代金</th>
				<td class="align_left"><span id="myProductDetailDialogMailAmount"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">追加サービス料金小計</th>
				<td class="align_left"><span id="myProductDetailDialogOptionSubtotal"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">郵便料金相当額</th>
				<td class="align_left"><span id="myProductDetailDialogOptionMailAmount"></span>円（税込）</td>
			</tr>
			<tr>
				<th class="align_right">見積合計</th>
				<td class="align_left"><span id="myProductDetailDialogTotalAmount"></span>円（税込）</td>
			</tr>
		</table>
	</div>
	<div class="right w250 align_left" style="overflow:hidden;">
		<ul>
			<li>ライブラリNo.：<span id="myProductDetailDialogMyLibraryNo2"></span></li>
			<li><span id="myProductDetailDialogMyLibraryName2"></span></li>
		</ul>
		<div class="align_center"">
			<table cellpadding="0" cellspacing="0" class="mT20 mB20" style="margin-left:auto; margin-right:auto;">
				<tr>
					<td style="width:130px; height:130px; text-align:center; vertical-align:middle; padding:5px; overflow:hidden;"><div id="myProductDetailDialogImg1"></div></td>
				</tr>
				<tr>
					<td style="width:130px; height:130px; text-align:center; vertical-align:middle; padding:5px; overflow:hidden;"><div id="myProductDetailDialogImg2"></div></td>
				</tr>
			</table>
		</div>

		<div class="align_center"><input type="image" id="myProductDetailDialogPreviewBtn" src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_preview.gif" alt="プレビュー" /></div>
	</div>

	<div class="align_center clearboth mB10">
		<a href="javascript:void(0)" id="myProductDetailDialogCloseBtn"><img src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_tojiruB2.gif" width="112" height="33" alt="閉じる" /></a>
		<input type="image" id="myProductDetailDialogOrderBtn" src="${resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_g_order-off.gif" alt="注文" style="display:none;" />
	</div>
	</g:form>
</div>
