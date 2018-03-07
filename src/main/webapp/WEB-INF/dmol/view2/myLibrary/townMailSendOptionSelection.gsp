<%@ page import="jp.co.reso.oiy.dmol.services.LocalSettingsService" %>
<html>
<head>
	<meta name="layout" content="main" />
	<title>オプションサービスを選ぶ</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
<div class="mainBlock">

	<!-- commonContents -->
	<div class="commonContents flow">
		<h2>オプションサービスを選ぶ<span>オプションサービスをお選びください。</span></h2>

		<g:render template="/common/fragment/flashmessages" />

		<div class="colorSen">
			<div class="bgStop"></div>
			<div class="bgSinB">

				<h3 class="colorH3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/h3_option.gif" alt="オプションサービスを選ぶ" /></h3>
				<div class="opRightTxt">※あとで変更することができます。</div>
				<div class="clear"></div>

				<div class="optionBox">
					<div class="boxTop"></div>
					<div class="boxMid">
						<div class="boxLeft">
							<img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b28_img.gif" alt="タウン差出代行" />
						</div>
						<div class="boxRight pT5">
							<p class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b28_txt.gif" alt="サービス利用上のご注意 タウン差出代行をご利用いただくためには、事前に、郵便局担当者との打合せが必要です。「配達地域」とそれに対する「配達通数」を相談の上、ご利用ください。" /></p>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td class="pR15 valignM"><label for="optionTwonMailSendNone"><input type="radio" name="optionTwonMailSendUsage" id="optionTwonMailSendNone" ${!params.optionTownMailSend ? 'checked="checked" ' : ''} /><span class="valignM size16">利用しない</span></label></td>
									<td class="pR15 valignM"><label for="optionTwonMailSendUse"><input type="radio" name="optionTwonMailSendUsage" id="optionTwonMailSendUse" ${params.optionTownMailSend ? 'checked="checked" ' : ''} /><span class="valignM size16">利用する</span></label></td>
									<td class="valignM">
										<img id="disabledSelectTownMailDeliveryAreaBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b28_bt-disable.gif" alt="配達地域を選ぶ" />
										<a href="javascript:void(0)" id="selectTownMailDeliveryAreaBtn" style="display: none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b28_bt.gif" alt="配達地域を選ぶ" /></a>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="boxBot"></div>
				</div>

				<div class="innnerBox1 w740" id="townMailDeliveryAreaListArea" style="display: none;">
					<h2 class="w725">配達地域リスト</h2>
					<div class="innnerBox1in">
						<div class="listTableHead listTableHeadS">
							<div class="leftBlock btnArea">
								<a href="javascript:void(0)" id="deleteBtn" class="btn1"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_sakujyo.gif" alt="削除" /></a>
								<a href="javascript:void(0)" id="deleteAllBtn" class="btn2"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_list_del.gif" alt="すべて削除" /></a>
							</div>
							<g:render template="/common/pagination/myaddresspagination" />
						</div>
						<table cellpadding="0" cellspacing="0" class="listTable1 w705 mB10">
							<thead>
								<tr>
									<th width="25" class="align_center"><input type="checkbox" id="deleteAllSelectedDeliveryAreaCheckbox" /></th>
									<th width="320" class="align_left">配達地域</th>
									<th class="align_left">配達事業者（郵便局）</th>
									<th width="40" class="align_center">通数</th>
									<th width="55" class="align_center">詳細</th>
								</tr>
							</thead>
							<tbody id="townMailDeliveryAreaList"></tbody>
						</table>

						<div class="align_right pR20 size16">
							合計通数：<span class="pL40"><span id="selectedTownMailDeliveryTotalQuantity">0</span>通</span>
						</div>
					</div>
				</div>

				<div class="w740">
					<h4 class="mB10"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/b28_midashi.gif" alt="タウン差出代行サービス（別途料金がかかります）" /></h4>
					<div class="pL30 mB30">
						<p class="mB10">印刷されたタウンメールを、指定された地域へ直接発送するサービスです。</p>
						<p class="mB10"><a href="https://dmfactory.biz.post.japanpost.jp/hagaki/town/index.html#daikou" class="listBlue" target="_blank">タウン差出代行サービスについて</a></p>
					</div>
				</div>

				<div class="bgSbtm"></div>
			</div>
			<!-- bgSinB END -->

		</div>
		<!-- colorSen END -->

	</div>
	<!-- commonContents END -->

	<!--btmNavi BEGIN-->
	<div class="btmNavi clearfix">
		<ul>
<g:if test="${prevBtnEnabled}">
			<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
</g:if>
			<li class="floatright">
				<a href="javascript:void(0)" id="nextBtn" style="display:none;"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-off.gif" alt="次へ進む" /></a>
				<img id="disabledNextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_next-disable.gif" alt="次へ進む" />
			</li>
		</ul>
	</div>
	<!--btmNavi END-->

</div>
<!-- /mainBlock END -->

<!-- town mail delivery area selection dialog -->
<div title="配達地域を選ぶ" id="townMailDeliveryAreaSelectDialog" style="display: none; cursor: default">
	<div class="popMapBox" id="nationalMapContent">
		<div class="mapBG">
			<div class="title"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'pop_map1_title.gif')}" alt="配達地域を選ぶ" /></div>
			<p class="read">都道府県名をクリックして、配達地域を選択してください。</p>

			<table cellpadding="0" cellspacing="0" class="area1">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="北海道">北海道</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area2">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="秋田県">秋田</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="青森県">青森</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="山形県">山形</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="岩手県">岩手</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="福島県">福島</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="宮城県">宮城</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area3">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="東京都">東京</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="茨城県">茨城</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="神奈川県">神奈川</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="栃木県">栃木</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="千葉県">千葉</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="群馬県">群馬</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="山梨県">山梨</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="埼玉県">埼玉</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area4">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="新潟県">新潟</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="長野県">長野</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="富山県">富山</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="石川県">石川</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="福井県">福井</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area5">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="静岡県">静岡</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="岐阜県">岐阜</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="愛知県">愛知</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="三重県">三重</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area6">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="滋賀県">滋賀</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="京都府">京都</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="兵庫県">兵庫</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="大阪府">大阪</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="奈良県">奈良</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="和歌山県">和歌山</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area7">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="香川県">香川</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="愛媛県">愛媛</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="徳島県">徳島</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="高知県">高知</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area8">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="鳥取県">鳥取</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="島根県">島根</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="岡山県">岡山</a></td>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="広島県">広島</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="山口県">山口</a></td>
					<td>&nbsp;</td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area9">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="福岡県">福岡</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="佐賀県">佐賀</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="長崎県">長崎</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="熊本県">熊本</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="大分県">大分</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="宮崎県">宮崎</a></td>
				</tr>
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="鹿児島県">鹿児島</a></td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" class="area10">
				<tr>
					<td><a href="javascript:void(0)" class="selectPrefecture" name="沖縄県">沖縄</a></td>
				</tr>
			</table>

		</div>
	</div>

	<div class="popMapBox" id="localAreaContent" style="display: none;">
		<div class="title"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'pop_map1_title.gif')}" alt="配達地域を選ぶ" /></div>
		<p class="read">配達したい地域にチェックを入れて。「配達地域を決定」を押してください。<br />
			さらに地域を絞り込む場合は、地域名をクリックしてください。</p>

		<ul class="breadcrumb" id="localAreaNavi"></ul>

		<div class="mapIn">
			<div class="areaTitle" id="localAreaTitle"></div>
			<div class="scroll">
				<table cellpadding="0" cellspacing="0" class="areaTable" style="width: 100%;">
					<tbody id="localAreaList">
					</tbody>
				</table>
			</div>
			<div class="btnArea">
				<a href="javascript:void(0)" class="floatleft cancelDialogBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_cancel.gif')}" alt="キャンセル" /></a>
				<img id="disabledDetermineDeliveryAreaBtn" class="floatright" src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_haitatsu-disable.gif')}" alt="配達地域を決定" />
				<a id="determineDeliveryAreaBtn" href="javascript:void(0)" class="floatright" style="display: none;"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_haitatsu.gif')}" alt="配達地域を決定" /></a>
			</div>
		</div>
	</div>

	<div class="popMapBox" id="quantityPerAreaContent" style="display: none;">
		<div class="title"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'pop_map3_title.gif')}" alt="配達通数を入力する" /></div>
		<p class="read mB15">町丁目ごとに、郵便局から入手した通数を入力してください。<br />
			お客様ご自身の判断で、ご相談時に決めた通数を変更することはできません。</p>

		<div class="mapIn">

			<div class="innnerBox1" style="width:auto;">
				<div class="scroll">
					<h2>配達地域リスト</h2>
					<div class="blueBg">
						<div class="popMapBoxInnnerBox1in">
							<div class="listTableHead listTableHeadS pA5 align_left">
								<a id="deleteQuantityPerAreaBtn" href="javascript:void(0)" class="btn1"><img src="${r.resource(dir:'/static/dmol/users/images/common/bt',file:'btn_sakujyo.gif')}" alt="削除" /></a>
							</div>
						</div>
						<table cellpadding="0" cellspacing="0" class="listTable1">
							<thead>
								<tr>
									<th width="25"><input id="selectAllQuantityPerAreaCheckbox" type="checkbox" /></th>
									<th width="200" class="align_left">配達地域</th>
									<th width="200" class="align_left">配達事業者（郵便局）</th>
									<th width="40" class="align_right">通数</th>
								</tr>
							</thead>
							<tbody id="quantityPerAreaList"></tbody>
						</table>
					</div>
				</div>
				<div class="btnArea">
					<a href="javascript:void(0)" class="floatleft cancelDialogBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_cancel.gif')}" alt="キャンセル" /></a>
					<img id="disabledDetermineQuantityPerAreaBtn" class="floatright" src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_tsusu-disable.gif')}" alt="配達地域を決定" />
					<a id="determineQuantityPerAreaBtn" href="javascript:void(0)" class="floatright" style="display: none;"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_tsusu.gif')}" alt="配達地域を決定" /></a>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- town mail delivery area selection dialog END -->

<!-- town mail delivery area count dialog -->
<div title="通数の変更" id="updateSelectedQuantityPerAreaDialog" style="display: none; cursor: default">
	<div class="popMapBox">
		<p class="read mB15">郵便局から入手した通数を入力してください。<br />
			お客様ご自身の判断で、ご相談時に決めた通数を変更することはできません。</p>

		<div class="mapIn">
			<div class="mB10">
				通数：<input type="text" id="updateSelectedQuantityPerAreaText" name="updateSelectedQuantityPerAreaText" class="align_right w100 imeModeDisabled" value="" />
			</div>
			<div class="btnArea">
				<a id="cancelUpdateSelectedQuantityPerAreaBtn" href="javascript:void(0)" class="floatleft"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_cancel.gif')}" alt="キャンセル" /></a>
				<a id="updateSelectedQuantityPerAreaBtn" href="javascript:void(0)" class="floatright"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'bt_tsusu.gif')}" alt="配達地域を決定" /></a>
			</div>
		</div>
	</div>
</div>
<!-- town mail delivery area count dialog END -->

<g:if test="${prevBtnEnabled}">
<g:form method="get" action="${prevAction}" id="${params.id}" name="prevForm">
<input type="hidden" name="prevFlg" value="true" />
</g:form>
</g:if>
<g:form method="post" action="selectTownMailSendOption" id="${params.id}" name="nextForm">
<input type="hidden" name="optionTownMailSend" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
// listFunc
var townMailDeliveryAreaListFunc = null;
;jQuery(function(){
// blockUI
//$.blockUI.defaults.fadeIn = 200;
//$.blockUI.defaults.fadeOut = 400;
// wait message
var waitmessage = $('<tr><td style="width: 100%; text-align: center; font-size: 24px; padding: 16px;">お待ちください。</td></tr>');
// current selection info
var selectedTownMailDeliveryAreaTotalCount = 0; // 選択済み配達地域数：最大100件
var selectedTownMailDeliveryTotalQuantity = 0; // 合計通数：最大30000通
// selected delivery area list
var townMailDeliveryAreaList = $("#townMailDeliveryAreaList");
var updateSelectedQuantityPerAreaDialog = $("#updateSelectedQuantityPerAreaDialog");
var updateSelectedQuantityPerAreaText = $("#updateSelectedQuantityPerAreaText", updateSelectedQuantityPerAreaDialog);
var cancelUpdateSelectedQuantityPerAreaBtn = $("#cancelUpdateSelectedQuantityPerAreaBtn", updateSelectedQuantityPerAreaDialog);
var updateSelectedQuantityPerAreaBtn = $("#updateSelectedQuantityPerAreaBtn", updateSelectedQuantityPerAreaDialog);
// search condition
var selectedPrefecture = null;
var selectedCity = null;
var selectedTown = null;
// selected delivery area
var selectedDeliveryAreaList = new Array();
// dialog
var townMailDeliveryAreaSelectDialog = $('#townMailDeliveryAreaSelectDialog');
// naionalMap
var nationalMapContent = $("#nationalMapContent", townMailDeliveryAreaSelectDialog);
// localArea
var localAreaContent = $("#localAreaContent", townMailDeliveryAreaSelectDialog);
var localAreaNavi = $("#localAreaNavi", localAreaContent);
var localAreaList = $("#localAreaList", localAreaContent);
var disabledDetermineDeliveryAreaBtn = $("#disabledDetermineDeliveryAreaBtn", localAreaContent);
var determineDeliveryAreaBtn = $("#determineDeliveryAreaBtn", localAreaContent);
// quantityPerArea
var quantityPerAreaContent = $("#quantityPerAreaContent", townMailDeliveryAreaSelectDialog);
var deleteQuantityPerAreaBtn = $("#deleteQuantityPerAreaBtn", quantityPerAreaContent);
var selectAllQuantityPerAreaCheckbox = $("#selectAllQuantityPerAreaCheckbox", quantityPerAreaContent);
var quantityPerAreaList = $("#quantityPerAreaList", quantityPerAreaContent);
var disabledDetermineQuantityPerAreaBtn = $("#disabledDetermineQuantityPerAreaBtn", quantityPerAreaContent);
var determineQuantityPerAreaBtn = $("#determineQuantityPerAreaBtn", quantityPerAreaContent);
// option selection
var enableSelectTownMailDeliveryArea = function(enable) {
	if (enable) {
		$("#disabledSelectTownMailDeliveryAreaBtn").hide();
		$("#selectTownMailDeliveryAreaBtn").show();
		$("#townMailDeliveryAreaListArea").show();
	} else {
		$("#townMailDeliveryAreaListArea").hide();
		$("#selectTownMailDeliveryAreaBtn").hide();
		$("#disabledSelectTownMailDeliveryAreaBtn").show();
	}
	return false;
};
var enableNextBtn = function(enable) {
	if (enable) {
		$("#disabledNextBtn").hide();
		$("#nextBtn").show();
	} else {
		$("#nextBtn").hide();
		$("#disabledNextBtn").show();
	}
	return false;
};
var townMailSendSelected = function() {
	return $("#optionTwonMailSendUse").isChecked();
};
var updateForms = function() {
	var enable = townMailSendSelected();
	enableSelectTownMailDeliveryArea(enable);
	enable = !enable || (0 < selectedTownMailDeliveryAreaTotalCount) && (selectedTownMailDeliveryAreaTotalCount <= ${LocalSettingsService.MAX_TOTAL_AREA_COUNT})
		&& (${minQuantity} <= selectedTownMailDeliveryTotalQuantity) && (selectedTownMailDeliveryTotalQuantity <= ${LocalSettingsService.MAX_TOTAL_QUANTITY}); // 利用しない場合、または、利用する場合で配達地域選択済み、かつ、通数指定済みの場合
	enableNextBtn(enable);
	return true;
};
$("input:radio[name='optionTwonMailSendUsage']").click(function() {
	updateForms();
	return true;
});
// dialog
var initializeTownMailDeliveryAreaSelectDialog = function() {
	selectedPrefecture = null;
	selectedCity = null;
	selectedTown = null;
	nationalMapContent.show();
	localAreaContent.hide();
	quantityPerAreaContent.hide();
	return false;
};
$("#selectTownMailDeliveryAreaBtn").click(function() {
	initializeTownMailDeliveryAreaSelectDialog();
	$.blockUI({ message: townMailDeliveryAreaSelectDialog, css: { width: '640px', top: '10%', left: '20%' } });
	return false;
});
// dialog common
var updateLocalAreaNavi = function() {
	localAreaNavi.empty();
	var anchor = $('<a href="javascript:void(0)">全国</a>').click(function() {
		initializeTownMailDeliveryAreaSelectDialog();
		return false;
	});
	localAreaNavi.append($('<li />').append(anchor));
	if ($.isNull(selectedPrefecture)) {
		return false;
	}
	if (!$.isNull(selectedCity)) {
		anchor = $('<a href="javascript:void(0)" />').text(selectedPrefecture).click(function() {
			selectedCity = null;
			selectedTown = null;
			updateLocalAreaContent();
			return false;
		});
		localAreaNavi.append($('<li />').append(anchor));
		if (!$.isNull(selectedTown)) {
			anchor = $('<a href="javascript:void(0)" />').text(selectedCity).click(function() {
				selectedTown = null;
				updateLocalAreaContent();
				return false;
			});
			localAreaNavi.append($('<li />').append(anchor));
			localAreaNavi.append($('<li />').text(selectedTown));
		} else {
			localAreaNavi.append($('<li />').text(selectedCity));
		}
	} else {
		localAreaNavi.append($('<li />').text(selectedPrefecture));
	}
	return false;
};
$("a.cancelDialogBtn", townMailDeliveryAreaSelectDialog).click(function() {
	$.unblockUI();
	initializeTownMailDeliveryAreaSelectDialog();
	return false;
});
// national map
$("a.selectPrefecture", townMailDeliveryAreaSelectDialog).click(function() {
	selectedPrefecture = $(this).attr('name');
	if (!$.isNull(selectedPrefecture)) {
		nationalMapContent.hide();
		updateLocalAreaContent();
		localAreaContent.show();
	}
	return false;
});
// local area
var createLocalCityAreaTd = function(tmda) {
	var td = $('<td />');
	var selectAreaCheckbox = $('<input type="checkbox" />').attr('id', tmda.id).data(tmda);
	td.append(selectAreaCheckbox);
	if (tmda.selected) {
		selectAreaCheckbox.setChecked(true);
		selectAreaCheckbox.setDisabled(true);
		var span = $('<span />').text(tmda.city);
		td.append(span);
	} else {
		selectAreaCheckbox.addClass('selectCityAreaCheckbox');
		var selectAreaAnchor = $('<a href="javascript:void(0)" class="selectCityAreaAnchor" />').data(tmda).text(tmda.city);
		td.append(selectAreaAnchor);
	}
	return td;
};
var createLocalTownAreaTd = function(tmda) {
	var td = $('<td />');
	var selectAreaCheckbox = $('<input type="checkbox" />').attr('id', tmda.id).data(tmda);
	td.append(selectAreaCheckbox);
	if (tmda.selected) {
		selectAreaCheckbox.setChecked(true);
		selectAreaCheckbox.setDisabled(true);
	} else {
		selectAreaCheckbox.addClass('selectTownAreaCheckbox');
	}
	if (tmda.selected) {
		var span = $('<span />').text(tmda.town);
		td.append(span);
	} else if (tmda.nostreet) {
		var label = $('<label />').attr('for', tmda.id).text(tmda.town);
		td.append(label);
	} else {
		var selectAreaAnchor = $('<a href="javascript:void(0)" class="selectTownAreaAnchor" />').data(tmda).text(tmda.town);
		td.append(selectAreaAnchor);
	}
	return td;
};
var createLocalStreetAreaTd = function(tmda) {
	var td = $('<td />');
	var selectAreaCheckbox = $('<input type="checkbox" />').attr('id', tmda.id).data(tmda);
	td.append(selectAreaCheckbox);
	if (tmda.selected) {
		selectAreaCheckbox.setChecked(true);
		selectAreaCheckbox.setDisabled(true);
		var span = $('<span />').text(tmda.displayName);
		td.append(span);
	} else {
		selectAreaCheckbox.addClass('selectStreetAreaCheckbox');
		var label = $('<label />').attr('for', tmda.id).text(tmda.displayName);
		td.append(label);
	}
	return td;
};
var onClickCityAreaCheckbox = function() {
	enableSelectDeliveryAreaBtn();
	return true;
}
var onClickCityAreaAnchor = function() {
	var tmda = $(this).data();
	selectedCity = tmda.city;
	updateLocalAreaContent();
	return false;
}
var onClickTownAreaCheckbox = function() {
	enableSelectDeliveryAreaBtn();
	return true;
}
var onClickTownAreaAnchor = function() {
	var tmda = $(this).data();
	selectedTown = tmda.town;
	updateLocalAreaContent();
	return false;
}
var onClickStreetAreaCheckbox = function() {
	enableSelectDeliveryAreaBtn();
	return true;
}
var updateLocalAreaContent = function() {
	enableSelectDeliveryAreaBtn(true);
	updateLocalAreaNavi();
	var createLocalAreaTdFunc = null;
	if (!$.isNull(selectedTown)) {
		$("#localAreaTitle", localAreaContent).text(selectedTown);
		createLocalAreaTdFunc = createLocalStreetAreaTd;
	} else if (!$.isNull(selectedCity)) {
		$("#localAreaTitle", localAreaContent).text(selectedCity);
		createLocalAreaTdFunc = createLocalTownAreaTd;
	} else if (!$.isNull(selectedPrefecture)) {
		$("#localAreaTitle", localAreaContent).text(selectedPrefecture);
		createLocalAreaTdFunc = createLocalCityAreaTd;
	}
	localAreaList.empty();
	localAreaList.append(waitmessage);
	// 配達地域検索
	var sparams = { offset: 0, max: 10000, prefecture: $.nvl(selectedPrefecture), city: $.nvl(selectedCity), town: $.nvl(selectedTown) };
	$.ajax({
		url: "${createLink(action:'listTownMailDeliveryArea')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			localAreaList.empty();
			if (data.result == "success") {
				var tmdaList = data.list;
				if (tmdaList && (tmdaList.length > 0)) {
					var tdAttr = { style:"text-align: left; vertical-align: middle;" };
					var tmdano = 0;
					var tr = null;
					for (var index = 0; index < tmdaList.length; index++) {
						if ((tmdano % 3) == 0) {
							tr = $('<tr />');
							localAreaList.append(tr);
						}
						var tmda = tmdaList[index];
						tr.append(createLocalAreaTdFunc(tmda));
						tmdano++;
					}
					$("input:checkbox:enabled.selectCityAreaCheckbox", localAreaList).click(onClickCityAreaCheckbox);
					$("a.selectCityAreaAnchor", localAreaList).click(onClickCityAreaAnchor);
					$("input:checkbox:enabled.selectTownAreaCheckbox", localAreaList).click(onClickTownAreaCheckbox);
					$("a.selectTownAreaAnchor", localAreaList).click(onClickTownAreaAnchor);
					$("input:checkbox:enabled.selectStreetAreaCheckbox", localAreaList).click(onClickStreetAreaCheckbox);
				} else {
					var td = $('<td />', { style:'text-align:center; vertical-align:middle;' }).text('見つかりませんでした。');
					var tr = $('<tr />').append(td);
					localAreaList.append(tr);
				}

			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を取得出来ませんでした。");
			}
			return false;
		}
	});
	return false;
};
var enableSelectDeliveryAreaBtn = function(forceDisable) {
	var selectedDeliveryQuantityPerArea = 0;
	if (!forceDisable) {
		if (!$.isNull(selectedTown)) {
			selectedDeliveryQuantityPerArea = $("input:checkbox:enabled:checked.selectStreetAreaCheckbox", localAreaList).length;
		} else if (!$.isNull(selectedCity)) {
			selectedDeliveryQuantityPerArea = $("input:checkbox:enabled:checked.selectTownAreaCheckbox", localAreaList).length;
		} else if (!$.isNull(selectedPrefecture)) {
			selectedDeliveryQuantityPerArea = $("input:checkbox:enabled:checked.selectCityAreaCheckbox", localAreaList).length;
		}
	}
	if (selectedDeliveryQuantityPerArea > 0) {
		disabledDetermineDeliveryAreaBtn.hide();
		determineDeliveryAreaBtn.show();
	} else {
		determineDeliveryAreaBtn.hide();
		disabledDetermineDeliveryAreaBtn.show();
	}
	return false;
};
var showQuantityPerAreaContent = function() {
	// 配達通数指定ダイアログの表示
	nationalMapContent.hide();
	localAreaContent.hide();
	quantityPerAreaContent.show();
	updateQuantityPerAreaContent();
	return false;
};
var valdateTotalAreaCount = function(areaCount, message) {
	if (${LocalSettingsService.MAX_TOTAL_AREA_COUNT} < areaCount) {
		$().toastmessage('showErrorToast', message ? message : "1回のご注文で指定できる配達地域は${LocalSettingsService.MAX_TOTAL_AREA_COUNT}町丁目までです。\n${LocalSettingsService.MAX_TOTAL_AREA_COUNT}箇所を超える地域を指定する場合には新規に別途ご注文ください。");
	} else {
		// 配達通数指定ダイアログの表示
		showQuantityPerAreaContent();
	}
};
var getTownMailDeliveryArea = function(url, sparams) {
	$.ajax({
		url: url,
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var tmdaList = data.list;
				if (tmdaList && (tmdaList.length > 0)) {
					for (var index = 0; index < tmdaList.length; index++) {
						var tmda = tmdaList[index];
						selectedDeliveryAreaList.push(tmda);
					}
					valdateTotalAreaCount(selectedTownMailDeliveryAreaTotalCount + selectedDeliveryAreaList.length, data.message);

				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を取得出来ませんでした。");
				}

			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を取得出来ませんでした。");
			}
			townMailDeliveryAreaSelectDialog.unblock(); // ブロック解除
			return false;
		},
		error: function(jqXHR, textStatus, errorThrown) {
			townMailDeliveryAreaSelectDialog.unblock(); // ブロック解除
			oiyAlert('サーバー通信時にエラーが発生しました。');
			return false;
		}
	});
};
determineDeliveryAreaBtn.click(function() {
	townMailDeliveryAreaSelectDialog.block({ message:"しばらくお待ちください。", css:{ padding:'8px' } }); // ブロック開始
	selectedDeliveryAreaList = new Array();
	if (!$.isNull(selectedTown)) { // 丁目選択
		$("input:checkbox:enabled:checked.selectStreetAreaCheckbox", localAreaList).each(function(index, element) {
			var tmda = $(this).data();
			selectedDeliveryAreaList.push(tmda);
			return true;
		});
		valdateTotalAreaCount(selectedTownMailDeliveryAreaTotalCount + selectedDeliveryAreaList.length);
		townMailDeliveryAreaSelectDialog.unblock(); // ブロック解除
	} else if (!$.isNull(selectedCity)) {
		var townlist = new Array();
		$("input:checkbox:enabled:checked.selectTownAreaCheckbox", localAreaList).each(function(index, element) {
			var tmda = $(this).data();
			townlist.push(tmda.town);
			return true;
		});
		var tparams = { prefecture: selectedPrefecture, city: selectedCity, townlist: townlist };
		getTownMailDeliveryArea("${createLink(action:'getTownMailDeliveryAreaByTown')}", tparams);

	} else if (!$.isNull(selectedPrefecture)) {
		var citylist = new Array();
		$("input:checkbox:enabled:checked.selectCityAreaCheckbox", localAreaList).each(function(index, element) {
			var tmda = $(this).data();
			citylist.push(tmda.city);
			return true;
		});
		var tparams = { prefecture: selectedPrefecture, citylist: citylist };
		getTownMailDeliveryArea("${createLink(action:'getTownMailDeliveryAreaByCity')}", tparams);
	}
	return false;
});
// area count
var buildAreaName = function(tmda) {
	if (!tmda) {
		return '';
	}
	var areaName = '';
	if (!$.isNull(tmda.city)) {
		areaName += tmda.city;
		if (!$.isNull(tmda.town)) {
			areaName += tmda.town;
			if (!$.isNull(tmda.street)) {
				areaName += tmda.street;
			}
		}
	}
	return areaName;
}
var createQuantityPerArea = function(tmda) {
	var tr = $('<tr />');
	var td = $('<td />');
	var checkbox = $('<input type="checkbox" />').addClass('quantityPerAreaCheckbox').data(tmda);
	td.append(checkbox);
	tr.append(td);
	var areaName = buildAreaName(tmda);
	td = $('<td />').addClass('align_left').text(areaName);
	tr.append(td);
	td = $('<td />').addClass('align_left').text(tmda.distributionStation);
	tr.append(td);
	var quantityPerArea = $('<input type="text" maxlength="5" />').addClass('align_right w50 imeModeDisabled quantityPerAreaText').data(tmda);
	var value = tmda.quantityPerArea;
	if (!$.isNaN(value)) {
		quantityPerArea.val(value.toString());
	}
	td = $('<td />').addClass('align_right').append(quantityPerArea);
	tr.append(td);
	return tr;
};
var updateQuantityPerAreaContent = function() {
	quantityPerAreaList.empty();
	if (selectedDeliveryAreaList && (selectedDeliveryAreaList.length > 0)) {
		for (var index = 0; index < selectedDeliveryAreaList.length; index++) {
			var tmda = selectedDeliveryAreaList[index];
			var tr = createQuantityPerArea(tmda);
			quantityPerAreaList.append(tr);
		}
		$("input[type='text'].quantityPerAreaText", quantityPerAreaList).blur(function() {
			var tmda = $(this).data();
			var value = $(this).val();
			if (!$.isNull(value)) {
				var areaName = buildAreaName(tmda);
				if (/^\d+$/.test(value)) {
					value = value.replace(/^0+/, ''); // 先頭の0を削除
					value = parseInt(value);
					if ((value <= 0) || (${LocalSettingsService.MAX_TOTAL_QUANTITY} < value)) {
						$().toastmessage('showErrorToast', areaName + "の通数が正しくありません。");
					}
				} else {
					$().toastmessage('showErrorToast', areaName + "の通数が正しくありません。");
				}
			}
			enableDetermineQuantityPerAreaBtn(true);
			return true;
		});
	}
	enableDetermineQuantityPerAreaBtn(false);
	return false;
};
selectAllQuantityPerAreaCheckbox.click(function() {
	$("input:checkbox.quantityPerAreaCheckbox", quantityPerAreaList).setChecked($(this).isChecked());
	return true;
});
deleteQuantityPerAreaBtn.click(function() {
	var selected = $("input:checkbox:checked.quantityPerAreaCheckbox", quantityPerAreaList);
	if (selected.length <= 0) {
		$().toastmessage('showErrorToast', "削除する配達地域を選択してください。");
		return false;
	}
	var targetMap = {};
	selected.each(function() {
		var tmda = $(this).data();
		targetMap[tmda.id] = tmda;
	});
	var newlist = new Array();
	if (selectedDeliveryAreaList) {
		for (var index = 0; index < selectedDeliveryAreaList.length; index++) {
			var tmda = selectedDeliveryAreaList[index];
			if (targetMap[tmda.id]) {
				continue;
			}
			newlist.push(tmda);
		}
	}
	selectedDeliveryAreaList = newlist;
	updateQuantityPerAreaContent();
	return false;
});
var parseQuantityPerArea = function() {
	var quantityPerAreaMap = {};
	$("input[type='text'].quantityPerAreaText", quantityPerAreaList).each(function(index, element) {
		var tmda = $(this).data();
		var value = $(this).val();
		if (!$.isNull(value)) { // 入力有無
			if (!$.isNaN(value) && /^\d+$/.test(value)) { // 整数
				value = value.replace(/^0+/, ''); // 先頭の0を削除
				value = parseInt(value);
				quantityPerAreaMap[tmda.id] = value;
			} else { // 整数以外
				quantityPerAreaMap[tmda.id] = -1;
			}
		}
		return true;
	});
	if (selectedDeliveryAreaList) {
		for (var index = 0; index < selectedDeliveryAreaList.length; index++) {
			var tmda = selectedDeliveryAreaList[index];
			var value = quantityPerAreaMap[tmda.id];
			if ($.isNaN(value)) {
				tmda.quantityPerArea = null;
			} else {
				tmda.quantityPerArea = value;
			}
		}
	}
};
var validateQuantityPerArea = function() {
	parseQuantityPerArea();
	var totalQuantityPerArea = 0;
	var invalidExists = false;
	if (selectedDeliveryAreaList) {
		for (var index = 0; index < selectedDeliveryAreaList.length; index++) {
			var tmda = selectedDeliveryAreaList[index];
			var value = tmda.quantityPerArea;
			if ($.isNaN(value) || (value <= 0)) {
				invalidExists = true;
			} else {
				totalQuantityPerArea += value;
			}
		}
	}
	var invalidQuantityPerArea = (totalQuantityPerArea <= 0) || (${LocalSettingsService.MAX_TOTAL_QUANTITY} < (totalQuantityPerArea + selectedTownMailDeliveryTotalQuantity));
	var result = {
		invalidExists: invalidExists,
		totalQuantityPerArea: totalQuantityPerArea,
		invalidQuantityPerArea: invalidQuantityPerArea
	};
	return result;
};
var enableDetermineQuantityPerAreaBtn = function(showErrorMsg) {
	var validated = validateQuantityPerArea();
	if (validated.invalidExists) {
		determineQuantityPerAreaBtn.hide();
		disabledDetermineQuantityPerAreaBtn.show();
	} else if (validated.invalidQuantityPerArea) {
		determineQuantityPerAreaBtn.hide();
		disabledDetermineQuantityPerAreaBtn.show();
		if (showErrorMsg) {
			var maxTotalQuantity = $.insertComma("${LocalSettingsService.MAX_TOTAL_QUANTITY}");
			$().toastmessage('showErrorToast', "1回のご注文で指定できる合計通数は" + maxTotalQuantity + "通までです。\n" + maxTotalQuantity + "通を超える地域を指定する場合には新規に別途ご注文ください。");
		}
	} else { // valid quantityPerArea
		disabledDetermineQuantityPerAreaBtn.hide();
		determineQuantityPerAreaBtn.show();
	}
	return validated;
};
determineQuantityPerAreaBtn.click(function() {
	var validated = enableDetermineQuantityPerAreaBtn(true);
	if (validated.invalidExists || validated.invalidQuantityPerArea) {
		return false;
	}
	var selectedList = new Array();
	if (selectedDeliveryAreaList) {
		for (var index = 0; index < selectedDeliveryAreaList.length; index++) {
			var tmda = selectedDeliveryAreaList[index];
			var value = tmda.quantityPerArea;
			selectedList.push(tmda.id + ',' + value.toString());
		}
	}
	townMailDeliveryAreaSelectDialog.block({ message:"しばらくお待ちください。", css:{ padding:'8px' } }); // ブロック開始
	var uparams = { selectedList: selectedList };
	$.ajax({
		url: "${createLink(action:'addTownMailDeliveryArea')}",
		data: uparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				initializeTownMailDeliveryAreaSelectDialog();
				updateTownMailDeliveryAreaList();
				$.unblockUI();
			} else {
				$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を追加出来ませんでした。");
			}
			townMailDeliveryAreaSelectDialog.unblock(); // ブロック解除
			return false;
		},
		error: function(jqXHR, textStatus, errorThrown) {
			townMailDeliveryAreaSelectDialog.unblock(); // ブロック解除
			oiyAlert('サーバー通信時にエラーが発生しました。');
			return false;
		}
	});
	return false;
})
// selected town mail delivery area list
townMailDeliveryAreaListFunc = new listFunc("townMailDeliveryAreaListFunc", 20, "familyNameKana", "asc");
townMailDeliveryAreaListFunc.setDispPageCallback(function(startCount, endCount, totalCount) {
	var pageString = $.insertComma(startCount) + " ～ " + $.insertComma(endCount) + " / " + $.insertComma(totalCount) + "箇所";
	$(".dispPage", townMailDeliveryAreaListFunc.element).text(pageString);
});
var updateTownMailDeliveryAreaList = function(offset) {
	$("#deleteAllSelectedDeliveryAreaCheckbox").setChecked(false);
	if (!$.isNaN(offset)) {
		townMailDeliveryAreaListFunc.offset = offset;
	}
	if (townMailDeliveryAreaListFunc.offset < 0) {
		townMailDeliveryAreaListFunc.offset = 0;
	}
	var pparams = townMailDeliveryAreaListFunc.getPageSortParam(null);
	var sparams = { offset: pparams.offset, max: pparams.pageMax, sort: pparams.sortKey, order: pparams.sortOrder };
	$.ajax({
		url: "${createLink(action:'listSelectedTownMailDeliveryArea')}",
		data: sparams,
		success: function(data, textStatus, jqXHR) {
			if (data.result == "success") {
				var offset = data.offset;
				selectedTownMailDeliveryAreaTotalCount = data.totalCount;
				selectedTownMailDeliveryTotalQuantity = data.totalQuantity;
				$("#selectedTownMailDeliveryTotalQuantity").text($.insertComma(selectedTownMailDeliveryTotalQuantity));
				townMailDeliveryAreaListFunc.updatePagination(data.totalCount, data.offset);
				townMailDeliveryAreaList.empty();
				var tmdaList = data.list;
				if (tmdaList && (tmdaList.length > 0)) {
					var td0Attr = { style:"vertical-align:middle;" };
					var td1Attr = { style:"vertical-align:middle;" };
					var td2Attr = { style:"vertical-align:middle;" };
					var td3Attr = { style:"vertical-align:middle;" };
					var td4Attr = { style:"vertical-align:middle;" };
					var tmdano = offset;
					for (var index = 0; index < tmdaList.length; index++) {
						tmdano++;
						var tmda = tmdaList[index];
						var removeCheckbox = $('<input type="checkbox" />').addClass('selectTownMailDeliveryAreaCheckbox align_center').data(tmda);
						var td0 = $('<td />', td0Attr).addClass('align_center').append(removeCheckbox);
						var td1 = $('<td />', td1Attr).addClass('align_left').text($.nvlW(buildAreaName(tmda)));
						var td2 = $('<td />', td2Attr).addClass('align_left').text($.nvlW(tmda.distributionStation));
						var td3 = $('<td />', td3Attr).addClass('align_right').text($.insertComma(tmda.quantity));
						var editBtn = $('<input type="image" alt="変更" />').addClass('editTownMailDeliveryAreaBtn align_center').attr('src', "${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_henkou.gif").data(tmda);
						var td4 = $('<td />', td4Attr).append(editBtn);
						var tr = $('<tr />').append(td0).append(td1).append(td2).append(td3).append(td4);
						townMailDeliveryAreaList.append(tr);
					}
					$(".editTownMailDeliveryAreaBtn").click(function() {
						var tmda = $(this).data();
						updateSelectedQuantityPerArea(tmda);
						return false;
					});
				} else {
					var td = $('<td />', { 'colspan':'5', style:'text-align:center; vertical-align:middle;' }).text('登録されていません');
					var tr = $('<tr />').append(td);
					townMailDeliveryAreaList.append(tr);
				}

			} else {
				townMailDeliveryAreaListFunc.updatePagination(0, 0);
				$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を取得出来ませんでした。");
			}
			updateForms();
			return false;
		}
	});
	return false;
};
var updateSelectedQuantityPerArea = function(tmda) {
	updateSelectedQuantityPerAreaBtn.unbind('click').click(function() {
		var currentValue = tmda.quantity;
		var value = updateSelectedQuantityPerAreaText.val();
		if ($.isNull(value)) {
			$().toastmessage('showErrorToast', "通数を指定してください。");
		} else if ($.isNaN(value) || !(/^\d+$/.test(value))) {
			$().toastmessage('showErrorToast', "通数が正しくありません。");
		} else {
			value = value.replace(/^0+/, ''); // 先頭の0を削除
			value = parseInt(value);
			var invalidQuantityPerArea = (value <= 0) || (${LocalSettingsService.MAX_TOTAL_QUANTITY} < (selectedTownMailDeliveryTotalQuantity - currentValue + value));
			if (invalidQuantityPerArea) {
				var maxTotalQuantity = $.insertComma("${LocalSettingsService.MAX_TOTAL_QUANTITY}");
				$().toastmessage('showErrorToast', "1回のご注文で指定できる合計通数は" + maxTotalQuantity + "通までです。\n" + maxTotalQuantity + "通を超える地域を指定する場合には新規に別途ご注文ください。");
			} else {
				updateSelectedQuantityPerAreaDialog.block({ message:null }); // ブロック開始
				var uparams = { tmdaId: tmda.id, quantityPerArea: value };
				$.ajax({
					url: "${createLink(action:'updateTownMailDeliveryArea')}",
					data: uparams,
					success: function(data, textStatus, jqXHR) {
						updateSelectedQuantityPerAreaDialog.unblock(); // ブロック解除
						$.unblockUI();
						if (data.result == "success") {
							var pparams = townMailDeliveryAreaListFunc.getPageSortParam(null);
							updateTownMailDeliveryAreaList(pparams.offset);
						} else {
							$().toastmessage('showErrorToast', data.message ? data.message : "通数を更新出来ませんでした。");
						}
						return false;
					},
					error: function(jqXHR, textStatus, errorThrown) {
						updateSelectedQuantityPerAreaDialog.unblock(); // ブロック解除
						$.unblockUI();
						oiyAlert('サーバー通信時にエラーが発生しました。');
						return false;
					}
				});
			}
		}
		return false;
	});
	updateSelectedQuantityPerAreaText.val(tmda.quantity.toString());
	updateSelectedQuantityPerAreaDialog.unblock(); // ブロック解除
	$.blockUI({ message: updateSelectedQuantityPerAreaDialog, css: { width: '440px', top: '10%', left: '30%' } });
};
cancelUpdateSelectedQuantityPerAreaBtn.click(function() {
	$.unblockUI();
	return false;
});
$("#deleteAllSelectedDeliveryAreaCheckbox").click(function() {
	$("input[type='checkbox'].selectTownMailDeliveryAreaCheckbox", townMailDeliveryAreaList).setChecked($(this).isChecked());
	return true;
});
$("#deleteBtn").click(function() {
	var deleteList = new Array();
	$("input[type='checkbox']:checked.selectTownMailDeliveryAreaCheckbox", townMailDeliveryAreaList).each(function(index, element) {
		var tmda = $(this).data();
		deleteList.push(tmda.id);
		return true;
	});
	if (deleteList.length <= 0) {
		$().toastmessage('showErrorToast', "削除する配達地域を選択してください。");
		return false;
	}
	oiyConfirm("指定された配達地域を削除してもよろしいですか？", function() {
		pleaseWait();
		var dparams = { deleteList: deleteList };
		$.ajax({
			url: "${createLink(action:'deleteTownMailDeliveryArea')}",
			data: dparams,
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					var pparams = townMailDeliveryAreaListFunc.getPageSortParam(null);
					updateTownMailDeliveryAreaList(pparams.offset);
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を削除出来ませんでした。");
				}
				return false;
			}
		});
	}, {}, true);
	return false;
});
$("#deleteAllBtn").click(function() {
	oiyConfirm("選択済み配達地域を全て削除してもよろしいですか？", function() {
		pleaseWait();
		$.ajax({
			url: "${createLink(action:'deleteAllTownMailDeliveryArea')}",
			success: function(data, textStatus, jqXHR) {
				closeWait();
				if (data.result == "success") {
					updateTownMailDeliveryAreaList(0);
				} else {
					$().toastmessage('showErrorToast', data.message ? data.message : "配達地域を削除出来ませんでした。");
				}
				return false;
			}
		});
	}, {}, true);
	return false;
});
townMailDeliveryAreaListFunc.initList($("#townMailDeliveryAreaListArea"));
townMailDeliveryAreaListFunc.addEventListner(updateTownMailDeliveryAreaList, updateTownMailDeliveryAreaList);
updateTownMailDeliveryAreaList(${params.offset?.encodeAsHTML()});
updateForms();
$("#nextBtn").click(function() {
	pleaseWait();
	if (townMailSendSelected()) {
		document.nextForm.optionTownMailSend.value = "${optionTownMailSendInfo?.optionServiceId}";
	} else {
		document.nextForm.optionTownMailSend.value = "";
	}
	document.nextForm.submit();
	return false;
});
<g:if test="${prevBtnEnabled}">
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
</g:if>
});</r:script>
</body>
</html>
