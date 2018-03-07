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
			<h2>テンプレートを確認する<span>テンプレートをご確認ください。</span></h2>

			<div id="tmpleCont">
				<h3 class="h3Top">テンプレート詳細</h3>
				<div class="tmpIn">
					<table class="tmpNaka" width="0" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
<g:if test="${itemInfo}">
								<img style="border:solid 1px #ccc;" src="${createLink(controller:'itemInfo',action:'largeThumb')}/${itemInfo.id}" alt="1" />
</g:if><g:elseif test="${myLibraryPageInfo}">
								<img style="border:solid 1px #ccc;" src="${createLink(controller:'myLibrary',action:'getLargeThumbnail')}/${myLibraryPageInfo.myLibrary.id}?pageNo=${myLibraryPageInfo.pageNo}" alt="1" />
</g:elseif>
							</td>
							<td>
<g:if test="${itemInfo2nd}">
								<img style="border:solid 1px #ccc;" src="${createLink(controller:'itemInfo',action:'largeThumb')}/${itemInfo2nd.id}" alt="2" />
</g:if><g:elseif test="${myLibraryPageInfo2nd}">
								<img style="border:solid 1px #ccc;" src="${createLink(controller:'myLibrary',action:'getLargeThumbnail')}/${myLibraryPageInfo2nd.myLibrary.id}?pageNo=${myLibraryPageInfo2nd.pageNo}" alt="2" />
</g:elseif><g:elseif test="${blankClass}">
								<div class="b24img ${blankClass}"></div>
</g:elseif>
							</td>
						</tr>
					</table>

<g:if test="${description}">
					<div class="setsumeiTmp">
						<div class="setsuTop"></div>
						<div class="setsuIn">
							<h4 class="tempST"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/h4_tempsetsumei.gif" width="143" height="27" alt="テンプレートの説明" /></h4>
							<p class="tmpTxt">${description}</p>
							<div class="clear"></div>
						</div>
						<div class="setsuBtm"></div>
					</div>
</g:if>
				</div>
				<!-- tmpIn END -->
				<div class="tmpBtm"></div>
			</div>
		</div>
<!-- commonContents END -->

		<!--btmNavi BEGIN-->
		<div class="btmNavi clearfix">
			<ul>
				<li class="floatleft"><a href="javascript:void(0)" id="prevBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_back-off.gif" alt="戻る" /></a></li>
				<li class="floatright"><a href="javascript:void(0)" id="nextBtn"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_dc-off.gif" alt="決定" /></a></li>
			</ul>
		</div>
		<!--btmNavi END-->

	</div>
<!-- /mainBlock END -->

<form name="nextForm" action="${editPath}"></form>
<form name="prevForm" action="${prevPath}"></form>
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	document.nextForm.submit();
	return false;
});
$("#prevBtn").click(function() {
	document.prevForm.submit();
	return false;
});
});</r:script>
</body>
</html>
