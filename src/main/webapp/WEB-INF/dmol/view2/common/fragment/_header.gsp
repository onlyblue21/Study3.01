<g:if test="${false}">
/**
 * @param showMyPageBtn マイページボタンの表示有無
 */
</g:if>
<!-- header -->
<div id="header">
	<div class="top">
		<a href="http://www.post.japanpost.jp/" class="logo"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/h_logo.gif" alt="郵便局" /></a>
		<p class="text1"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/h_text01.gif" alt="そばにいるから、できることがある" /></p>
<g:if test="${showUserInfo}">
<sec:ifLoggedIn>
<g:if test="${!largeInstitutionalCustomerInfo?.customerName && (loginUserInfo?.justNowUser || loginUserInfo?.registeredUser)}">
		<div class="loginName">
			<strong>${loginUserInfo?.familyName?.encodeAsHTML()}${loginUserInfo?.firstName?.encodeAsHTML()}</strong>　さま
			<g:link controller="logout" class="logoutBt logout transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt_logout.gif" alt="ログアウト" /></g:link>
		</div>
</g:if>
</sec:ifLoggedIn>
</g:if>
		<div class="box1">
			<p class="link">
				<a href="/guide/index.html" target="_blank">ご利用ガイド</a>　|　<a href="/faq/index.php" target="_blank">よくあるご質問</a>
			</p>
			<div class="boxRight"></div>
		</div>
	</div>
		
	<div class="gMenu">
		<div class="over">
			<g:link url="/"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/mypage/kh_logo_my.gif" alt="DM Factory.jp" class="logo2" /></g:link>
<g:if test="${showMyPageBtn}">
<sec:ifLoggedIn>
<g:if test="${loginUserInfo?.registeredUser}">
			<ul class="loginBt02">
				<li><g:link controller="myPage" action="index"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_mypage-off.gif" alt="マイページ" /></g:link></li>
				<li><g:link controller="myProduct" action="index"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt/btn_cart-off.gif" alt="買い物カゴ" /></g:link></li>
			</ul>
</g:if>
</sec:ifLoggedIn>
</g:if>
		</div>
	</div>

<g:if test="${showUserInfo}">
<sec:ifLoggedIn>
<g:if test="${largeInstitutionalCustomerInfo?.customerName}">
		<div class="loginNameLarge">
			<div class="companyName">${largeInstitutionalCustomerInfo.customerName.encodeAsHTML()}</div>
			<div class="userName"><strong>${loginUserInfo?.familyName?.encodeAsHTML()}${loginUserInfo?.firstName?.encodeAsHTML()}</strong>　さま</div>
			<g:link controller="logout" class="logoutBt logout transition"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/3rd/bt_logout_large.gif" alt="ログアウト" /></g:link>
		</div>
</g:if>
</sec:ifLoggedIn>
</g:if>
</div>
<!-- /header END -->
