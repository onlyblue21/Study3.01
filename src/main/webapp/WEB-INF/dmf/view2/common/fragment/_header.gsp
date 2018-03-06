
<!-- header -->
<div id="container">
		<div id="header">
			<div class="container">
					<div class="col-xs-12">
						<div class="inner-header">
						<%--一般ユーザ--%>
							<sec:ifLoggedIn>
									<div class="loginName">
										<strong>
											${loginUserInfo?.familyName?.encodeAsHTML()}${loginUserInfo?.firstName?.encodeAsHTML()}
										</strong> さま
									</div>
							</sec:ifLoggedIn>
						<%--一般ユーザEnd--%>
						<a href="http://www.post.japanpost.jp/" class="logo" target="_blank">
						<img src="${resource(dir:'/static/dmol/users/images',file:'common')}/3rd/h_logo.gif" alt="郵便局" />
						</a>
						<p class="text1">
							<img src="${resource(dir:'/static/dmol/users/images',file:'common')}/3rd/h_text01.gif" alt="そばにいるから、できることがある" />
						</p>
					</div>
					<div class="inner-content">
						<div class="logo-block left">
						<a href="/">
								<img src="${resource(dir:'/static/dmol/users/images',file:'common')}/3rd/kh_logo_my.gif" alt="DM Factory.jp" />
						</a>
						</div>
						<%--ログアウトボタン--%>
							<sec:ifLoggedIn>
								<div class="panel-block right">
										<g:link controller="logout" class="logout">
										<img src="${resource(dir:'/static/dmol/users/images',file:'common')}/icn_logout-off.png" alt="ログアウト" />
									</g:link>
								</div>
							</sec:ifLoggedIn>
						<%--ログアウトボタンEnd--%>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- /header END -->
