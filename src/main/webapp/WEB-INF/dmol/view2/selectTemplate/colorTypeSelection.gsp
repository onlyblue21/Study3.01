<html>
<head>
	<title>DM Factory.jp</title>
	<meta name="layout" content="main" />
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':false,'showUserInfo':false]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>
				<div class="floatleft">印刷する紙面とカラーを選ぶ</div>
				<span class="floatright fontN pT3">印刷領域のカラーをボタンでお選びください。<br />
					あて名印字の有無は、デザインを編集した後に指定することができます。（会員の方のみ）</span>
				<div class="clear"></div>
			</h2>

<g:set var="omoteTitleImage" value="left_atena.gif" /><g:set var="uraTitleImage" value="left_design.gif" />
<g:set var="omoteTitleAlt" value="あて名面" /><g:set var="uraTitleAlt" value="デザイン面" />
<g:set var="designSidePosition" value="floatleft" /><g:set var="addressSidePosition" value="floatright" />
<g:if test="${genrePattern == 'dmol_enclosed_leaf'}">
<g:set var="omoteTitleImage" value="left_omote.gif" /><g:set var="uraTitleImage" value="left_ura.gif" />
<g:set var="omoteTitleAlt" value="表面" /><g:set var="uraTitleAlt" value="裏面" />
<g:set var="designSidePosition" value="floatright" /><g:set var="addressSidePosition" value="floatleft" />
</g:if>
<g:if test="${false}">プレビュー画像ファイル名の設定</g:if>
<g:if test="${false}">オリジナル年賀ハガキ</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_01b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_01b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_01b_non.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
<g:if test="${genrePattern == 'special_original_card'}"><g:if test="${false}">限定オリジナルはがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_01b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_01b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_01b_non.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:if>
<g:elseif test="${genrePattern == 'original_kamomail'}"><g:if test="${false}">オリジナルかもめ～る</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_05b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_05b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_05b_m.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard'}"><g:if test="${false}">私製はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_10b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxas_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_10b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxas_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_10b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxas_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard_long3'}"><g:if test="${false}">私製はがき（長３）</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_11b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxan_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_11b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxan_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_11b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxan_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard_a4'}"><g:if test="${false}">A4はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_20b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxas_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_20b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxas_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_20b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxas_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus'}"><g:if test="${false}">タウンプラス</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_12b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxas_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_12b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_12b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus_long3'}"><g:if test="${false}">タウンプラス（長３）</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_13b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxan_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_13b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxan_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_13b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxan_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus_a4'}"><g:if test="${false}">タウンプラス（A4）</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_21b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxas_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_21b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxas_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_21b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxas_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_enclosed_leaf'}"><g:if test="${false}">封入チラシ</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_xxas_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_14b_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_xxas_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_14b_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_xxas_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_14b_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyearcard'}"><g:if test="${false}">年賀はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_02b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_02b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_02b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail'}"><g:if test="${false}">かもめ～る</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_06b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_06b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_06b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_normal_postcard'}"><g:if test="${false}">郵便はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_09b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_09b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_09b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_mochu_postcard'}"><g:if test="${false}">喪中はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_15b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_15b_c.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_15b_c.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyeartown_single'}"><g:if test="${false}">年賀タウンメール</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_03b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_03b_c.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_03b_c.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail_single'}"><g:if test="${false}">かもめタウン</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_07b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_07b_c.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_07b_c.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyeartown_both'}"><g:if test="${false}">年賀タウンメール（両面）</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_04b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_04b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_04b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail_both'}"><g:if test="${false}">かもめタウン（両面）</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_08b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxak_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_08b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxak_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_08b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxak_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'original_newyearcard_4'}"><g:if test="${false}">四面オリジナル年賀はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_16b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxa4_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_16b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxa4_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_16b_m.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxa4_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'original_kamomail_4'}"><g:if test="${false}">四面オリジナルかもめ～る</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_18b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxa4_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_18b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxa4_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_18b_m.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxa4_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyearcard_4'}"><g:if test="${false}">四面年賀はがき</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_17b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxa4_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_17b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxa4_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_17b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxa4_np.jpg" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail_4'}"><g:if test="${false}">四面かもめ～る</g:if>
<g:set var="omoteImageNameColor" value="va2_bt36_19b_c.jpg" /><g:set var="uraImageNameColor" value="va2_bt36_xxa4_c.jpg" />
<g:set var="omoteImageNameMono" value="va2_bt36_19b_m.jpg" /><g:set var="uraImageNameMono" value="va2_bt36_xxa4_m.jpg" />
<g:set var="omoteImageNameNone" value="va2_bt36_19b_np.jpg" /><g:set var="uraImageNameNone" value="va2_bt36_xxa4_np.jpg" />
</g:elseif>
<g:if test="${false}">プレビュー初期表示画像ファイル名の設定</g:if>
<g:set var="addressSidePreviewSrc" value="${omoteImageNameColor}" />
<g:if test="${addressSideSelectedColor == '1c'}"><g:set var="addressSidePreviewSrc" value="${omoteImageNameMono}" /></g:if>
<g:elseif test="${addressSideSelectedColor == '0c'}"><g:set var="addressSidePreviewSrc" value="${omoteImageNameNone}" /></g:elseif>
<g:set var="designSidePreviewSrc" value="${uraImageNameColor}" />
<g:if test="${designSideSelectedColor == '1c'}"><g:set var="designSidePreviewSrc" value="${uraImageNameMono}" /></g:if>
<g:elseif test="${designSideSelectedColor == '0c'}"><g:set var="designSidePreviewSrc" value="${uraImageNameNone}" /></g:elseif>
			<div class="sentakuVa2">

				<div class="sentakuVa2In ${designSidePosition}">
					<div class="bgTop"></div>
					<div class="bgMid">
						<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:uraTitleImage)}" alt="${uraTitleAlt}" /></h3>
						<div class="view">
							<img id="designSidePreview" src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:designSidePreviewSrc)}" alt="プレビュー" />
						</div>
						<h4 class="midashiGuide mL25 pB0">カラーを選択して下さい</h4>
						<div class="sentaku" id="designSideRadios">
							<ul>
								<li>
<g:if test="${designSideColorFlg}">
									<input type="radio" id="designSideColor" name="designSide" value="4c" title="フルカラー" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_c-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_c-selected.gif'}" />
</g:if><g:else>
									<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'bt36_c.gif')}" />
</g:else>
								</li>
								<li>
<g:if test="${designSideGrayscaleFlg}">
									<input type="radio" id="designSideGrayscale" name="designSide" value="1c" title="モノクロ" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_m-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_m-selected.gif'}" />
</g:if><g:else>
									<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'bt36_m.gif')}" />
</g:else>
								</li>
								<li class="last">
<g:if test="${designSideNoneFlg}">
									<input type="radio" id="designSideNone" name="designSide" value="0c" title="印刷しない" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_np-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_np-selected.gif'}" />
</g:if><g:else>
									<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'bt36_np.gif')}" />
</g:else>
								</li>
							</ul>
						</div>
					</div>
					<div class="bgBot"></div>
				</div>

				<div class="sentakuVa2In ${addressSidePosition}">
					<div class="bgTop"></div>
					<div class="bgMid">
						<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:omoteTitleImage)}" alt="${omoteTitleAlt}" /></h3>
<g:if test="${(genrePattern == 'dmol_newyeartown_single')}">
						<div class="view">
							<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'va2_bt36_03b_non.jpg')}" alt="年賀タウンメール" />
						</div>
</g:if><g:elseif test="${(genrePattern == 'dmol_kamomail_single')}">
						<div class="view">
							<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'va2_bt36_07b_non.jpg')}" alt="かもめタウン" />
						</div>
</g:elseif><g:elseif test="${(genrePattern == 'dmol_mochu_postcard')}">
						<div class="view">
							<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'va2_bt36_15b_non.jpg')}" alt="喪中はがき" />
						</div>
</g:elseif><g:elseif test="${(genrePattern == 'special_original_card')}">
						<div class="view">
							<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'va2_bt36_22.jpg')}" alt="限定オリジナルはがき" />
						</div>
</g:elseif><g:else>
						<div class="view">
							<img id="addressSidePreview" src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:addressSidePreviewSrc)}" alt="プレビュー" />
						</div>
						<h4 class="midashiGuide mL25 pB0">カラーを選択して下さい</h4>
						<div class="sentaku" id="addressSideRadios">
							<ul>
<g:if test="${addressSideColorFlg}">
								<li>
									<input type="radio" id="addressSideColor" name="addressSide" value="4c" title="フルカラー" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_c-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_c-selected.gif'}" />
								</li>
								<li>
<g:if test="${addressSideGrayscaleFlg}">
									<input type="radio" id="addressSideGrayscale" name="addressSide" value="1c" title="モノクロ" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_m-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_m-selected.gif'}" />
</g:if><g:else>
									<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'bt36_m.gif')}" />
</g:else>
								</li>
								<li class="last">
<g:if test="${addressSideNoneFlg}">
									<input type="radio" id="addressSideNone" name="addressSide" value="0c" title="印刷しない" class="{src:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_np-off.gif',checked:'${r.resource(dir:'/static/dmol/users/images/3rd',file:'va2')}/bt36_np-selected.gif'}" />
</g:if><g:else>
									<img src="${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:'bt36_np.gif')}" />
</g:else>
								</li>
</g:if><g:else>
</g:else>
							</ul>
						</div>
</g:else>
					</div>
					<div class="bgBot"></div>
				</div>

			</div>

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
				<li class="floatright">
					<a href="javascript:void(0)" id="nextBtn" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
					<img id="disabledNextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-disable.gif" alt="次へ進む" />
				</li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<g:form action="selectColorType" name="nextForm">
<input type="hidden" name="colorTypeId" value="" />
<input type="hidden" name="addressSideSelectedColor" value="" />
<input type="hidden" name="designSideSelectedColor" value="" />
</g:form>
<form name="prevForm" action="${prevPath}"></form>
<r:script>
;jQuery(function(){
var omoteImageNameColor = new Image();
omoteImageNameColor.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:omoteImageNameColor)}";
var omoteImageNameMono = new Image();
omoteImageNameMono.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:omoteImageNameMono)}";
var omoteImageNameNone = new Image();
omoteImageNameNone.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:omoteImageNameNone)}";
var uraImageNameColor = new Image();
uraImageNameColor.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:uraImageNameColor)}";
var uraImageNameMono = new Image();
uraImageNameMono.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:uraImageNameMono)}";
var uraImageNameNone = new Image();
uraImageNameNone.src = "${r.resource(dir:'/static/dmol/users/images/3rd/va2',file:uraImageNameNone)}";
var designSidePreview = $("#designSidePreview");
var addressSidePreview = $("#addressSidePreview");
$("input:radio[name='addressSide']").filter("[value='${addressSideSelectedColor}']").setChecked(true);
$("input:radio[name='designSide']").filter("[value='${designSideSelectedColor}']").setChecked(true);
$("#addressSideRadios").imageradio();
$("#designSideRadios").imageradio();
var nextBtn = $("#nextBtn");
var disabledNextBtn = $("#disabledNextBtn");
var enableNextBtn = function(enable) {
	if (enable) {
		disabledNextBtn.hide();
		nextBtn.show();
	} else {
		nextBtn.hide();
		disabledNextBtn.show();
	}
	return false;
};
var addressSideSelected = function() {
<g:if test="${(genrePattern == 'special_original_card')}">
	return '4c';
</g:if><g:elseif test="${addressSideColorFlg}">
	return $("input:radio[name='addressSide']:checked").val();
</g:elseif><g:else>
	return '0c';
</g:else>
};
var designSideSelected = function() {
	return $("input:radio[name='designSide']:checked").val();
};
var updatePreviewImage = function() {
	var aside = addressSideSelected();
	switch (aside) {
	case '4c':
		addressSidePreview.attr('src', omoteImageNameColor.src);
		break;
	case '1c':
		addressSidePreview.attr('src', omoteImageNameMono.src);
		break;
	default:
		addressSidePreview.attr('src', omoteImageNameNone.src);
		break;
	}
	var dside = designSideSelected();
	switch (dside) {
	case '4c':
		designSidePreview.attr('src', uraImageNameColor.src);
		break;
	case '1c':
		designSidePreview.attr('src', uraImageNameMono.src);
		break;
	default:
		designSidePreview.attr('src', uraImageNameNone.src);
		break;
	}
};
var updateEnableNextBtn = function() {
	var addressSideValue = addressSideSelected();
	var designSideValue = designSideSelected();
	enableNextBtn(!$.isNull(addressSideValue) && !$.isNull(designSideValue));
	return true;
};
$("input:radio[name='addressSide'],input:radio[name='designSide']").change(function() {
	updatePreviewImage();
	return updateEnableNextBtn();
});
nextBtn.click(function() {
	var addressSideValue = addressSideSelected();
	var designSideValue = designSideSelected();
	if ($.isNull(addressSideValue) || $.isNull(designSideValue)) {
		oiyAlert("印刷面・色数を選択してください。");
		return false;
	}
	var colorTypeId = null;
	if (addressSideValue == '4c') {
		colorTypeId = addressSideValue + designSideValue;
	} else if (addressSideValue == '1c') {
		if (designSideValue == '0c') {
			colorTypeId = addressSideValue + designSideValue;
		} else {
			colorTypeId = designSideValue + addressSideValue;
		}
	} else if (addressSideValue == '0c') {
		colorTypeId = designSideValue + addressSideValue;
	}
	switch(colorTypeId) {
	case '4c0c':
	case '4c4c':
	case '1c0c':
	case '1c1c':
	case '4c1c':
		break;
	default:
		oiyAlert("印刷面・色数が正しくありません。");
		return false;
	}
	document.nextForm.colorTypeId.value = colorTypeId;
	document.nextForm.addressSideSelectedColor.value = addressSideValue;
	document.nextForm.designSideSelectedColor.value = designSideValue;
	document.nextForm.submit();
	return false;
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
updatePreviewImage();
updateEnableNextBtn();
});</r:script>
</body>
</html>
