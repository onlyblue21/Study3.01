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
<g:set var="uraTitleAlt" value="デザイン面" />
<g:set var="uraTarget" value="テンプレート" />
<g:if test="${genrePattern == 'dmol_enclosed_leaf'}">
<g:set var="uraTitleAlt" value="裏面" />
<g:set var="uraTarget" value="デザイン" />
</g:if>
			<h2>${uraTitleAlt}の${uraTarget}を選ぶ<span>ご希望の作成方法をお選びください。</span></h2>

<g:if test="${(myLibraryCount <= 0) && (normalCount <= 0) && (blankCount <= 0)}">
<div class="errorM validatormessages">
<!-- no design -->
</div>
</g:if>
<g:else>
<g:set var="uraTitleImage" value="left_design" />
<g:set var="uraImageName" value="va_img22_01" />
<g:set var="uraMyLibraryImage" value="va_bt22_01_1" /><g:set var="uraMyLibraryAlt" value="過去に作成したデザインからつくる" />
<g:set var="uraDesignImage" value="va_bt22_01_2" /><g:set var="uraDesignAlt" value="デザインテンプレートからつくる" />
<g:set var="uraBlankImage" value="btn_tnp02" /><g:set var="uraBlankAlt" value="白紙から自由につくる" />
<g:set var="uraOtherImage" value="btn_tnp03" /><g:set var="uraOtherAlt" value="他のソフトで作成した原稿をつかう" />
<g:if test="${genrePattern == 'dmol_enclosed_leaf'}">
<g:set var="uraTitleImage" value="left_ura" />
<g:set var="uraImageName" value="va_img22_03" />
<g:set var="uraMyLibraryImage" value="va_bt22_03_1" />
<g:set var="uraDesignImage" value="va_bt22_03_2" />
</g:if>
			<div class="w900 mB30">
				<div class="vaLeft">
					<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${uraTitleImage}.gif" class="floatleft" alt="${uraTitleAlt}" />
					<img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${uraImageName}.gif" class="floatright" alt="" />
				</div>
				<ul class="floatright" style="width:661px;">
<g:if test="${myLibraryCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType2nd" params="[templateType2nd:'myLibrary']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${uraMyLibraryImage}-off.gif" alt="${uraMyLibraryAlt}" /></g:link></li>
</g:if>
<g:if test="${normalCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType2nd" params="[templateType2nd:'normal']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images/3rd',file:'va')}/${uraDesignImage}-off.gif" alt="${uraDesignAlt}" /></g:link></li>
</g:if>
<g:if test="${blankCount > 0}">
					<li class="mB10"><g:link action="selectTemplateType2nd" params="[templateType2nd:'blank']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/${uraBlankImage}-off.gif" alt="${uraBlankAlt}" /></g:link></li>
					<li class="mB10"><g:link action="selectTemplateType2nd" params="[templateType2nd:'blank']" class="selectTemplateTypeBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/${uraOtherImage}-off.gif" alt="${uraOtherAlt}" /></g:link></li>
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
