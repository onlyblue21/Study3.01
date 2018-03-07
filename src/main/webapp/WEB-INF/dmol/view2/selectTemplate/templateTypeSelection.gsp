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
<g:set var="omoteTitleAlt" value="あて名面" />
<g:if test="${genrePattern == 'dmol_enclosed_leaf'}">
<g:set var="omoteTitleAlt" value="表面" />
</g:if>
			<h2>${omoteTitleAlt}のデザインを選ぶ<span>ご希望の作成方法をお選びください。</span></h2>

			<div class="mainteBox" style="display: none;">
				★★★ 2015年以前のオリジナル年賀はがきデザインを、使用されるお客様へ ★★★<br><br>
				2016年の年賀はがきのレイアウトが変更となった為、オリジナル年賀はがきを作成される場合は、<br>保存したデータは使用せず、新たにデザインの作成をお願いいたします。
			</div>

<g:if test="${(myLibraryCount <= 0) && (normalCount <= 0) && (blankCount <= 0)}">
<div class="errorM validatormessages">
	<h2>エラー</h2>
	<ul><li>条件に一致する基本テンプレートが見つかりませんでした。</li></ul>
</div>
</g:if>
<g:else>
<g:set var="omoteTitleImage" value="left_atena" />
<g:set var="omoteImageName" value="va_img38_01" />
<g:set var="omoteMyLibraryImage" value="va_bt38_01_1" /><g:set var="omoteMyLibraryAlt" value="過去に作成したデザインからつくる" />
<g:set var="omoteDesignImage" value="va_bt38_01_2" /><g:set var="omoteDesignAlt" value="はじめからつくる" />
<g:set var="omoteBlankImage" value="btn_tnp02" /><g:set var="omoteBlankAlt" value="白紙から自由につくる" />
<g:set var="omoteOtherImage" value="btn_tnp03" /><g:set var="omoteOtherAlt" value="他のソフトで作成した原稿をつかう" />
<g:if test="${genrePattern == 'original_kamomail' || genrePattern == 'original_kamomail_4'}">
<g:set var="omoteImageName" value="va_img38_05" />
<g:set var="omoteMyLibraryImage" value="va_bt38_05_1" />
<g:set var="omoteDesignImage" value="va_bt38_05_2" />
</g:if>
<g:elseif test="${genrePattern == 'special_original_card'}">
<g:set var="omoteImageName" value="va_img38_22" />
<g:set var="omoteMyLibraryImage" value="va_bt38_01_1" />
<g:set var="omoteDesignImage" value="va_bt38_22_1" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard'}">
<g:set var="omoteImageName" value="va_img38_10" />
<g:set var="omoteMyLibraryImage" value="va_bt38_10_1" />
<g:set var="omoteDesignImage" value="va_bt38_10_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard_long3'}">
<g:set var="omoteImageName" value="va_img38_11" />
<g:set var="omoteMyLibraryImage" value="va_bt38_11_1" />
<g:set var="omoteDesignImage" value="va_bt38_11_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_private_postcard_a4'}">
<g:set var="omoteImageName" value="va_img38_20" />
<g:set var="omoteMyLibraryImage" value="va_bt38_20_1" />
<g:set var="omoteDesignImage" value="va_bt38_20_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus'}">
<g:set var="omoteImageName" value="va_img38_12" />
<g:set var="omoteMyLibraryImage" value="va_bt38_12_1" />
<g:set var="omoteDesignImage" value="va_bt38_12_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus_long3'}">
<g:set var="omoteImageName" value="va_img38_13" />
<g:set var="omoteMyLibraryImage" value="va_bt38_13_1" />
<g:set var="omoteDesignImage" value="va_bt38_13_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_town_plus_a4'}">
<g:set var="omoteImageName" value="va_img38_21" />
<g:set var="omoteMyLibraryImage" value="va_bt38_21_1" />
<g:set var="omoteDesignImage" value="va_bt38_21_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_enclosed_leaf'}">
<g:set var="omoteTitleImage" value="left_omote" />
<g:set var="omoteImageName" value="va_img22_02" />
<g:set var="omoteMyLibraryImage" value="va_bt22_02_1" />
<g:set var="omoteDesignImage" value="va_bt22_02_2" /><g:set var="omoteDesignAlt" value="デザインテンプレートからつくる" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyearcard' || genrePattern == 'dmol_newyearcard_4'}">
<g:set var="omoteImageName" value="va_img38_02" />
<g:set var="omoteMyLibraryImage" value="va_bt38_02_1" />
<g:set var="omoteDesignImage" value="va_bt38_02_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail' || genrePattern == 'dmol_kamomail_4'}">
<g:set var="omoteImageName" value="va_img38_06" />
<g:set var="omoteMyLibraryImage" value="va_bt38_06_1" />
<g:set var="omoteDesignImage" value="va_bt38_06_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_normal_postcard'}">
<g:set var="omoteImageName" value="va_img38_09" />
<g:set var="omoteMyLibraryImage" value="va_bt38_09_1" />
<g:set var="omoteDesignImage" value="va_bt38_09_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_newyeartown_both'}">
<g:set var="omoteImageName" value="va_img38_04" />
<g:set var="omoteMyLibraryImage" value="va_bt38_04_1" />
<g:set var="omoteDesignImage" value="va_bt38_04_2" />
</g:elseif>
<g:elseif test="${genrePattern == 'dmol_kamomail_both'}">
<g:set var="omoteImageName" value="va_img38_08" />
<g:set var="omoteMyLibraryImage" value="va_bt38_08_1" />
<g:set var="omoteDesignImage" value="va_bt38_08_2" />
</g:elseif>
			<div class="w900 mB30">
				<div class="vaLeft">
					<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${omoteTitleImage}.gif" class="floatleft" alt="${omoteTitleAlt}" />
					<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${omoteImageName}.gif" class="floatright" alt="" />
				</div>
				<ul class="floatright" style="width:661px;">
<g:if test="${myLibraryCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType" params="[templateType:'myLibrary']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${omoteMyLibraryImage}-off.gif" alt="${omoteMyLibraryAlt}" /></g:link></li>
</g:if>
<g:if test="${normalCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType" params="[templateType:'normal']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${omoteDesignImage}-off.gif" alt="${omoteDesignImage}" /></g:link></li>
</g:if>
<g:if test="${blankCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType" params="[templateType:'blank']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/${omoteBlankImage}-off.gif" alt="${omoteBlankAlt}" /></g:link></li>
					<li class="mB10"><g:link action="selectTemplateType" params="[templateType:'blank']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/${omoteOtherImage}-off.gif" alt="${omoteOtherAlt}" /></g:link></li>
</g:if>
				</ul>
				<div class="clear"></div>
			</div>
</g:else>

		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<form name="prevForm" action="${prevPath}"></form>
<r:script>
;jQuery(function(){
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
