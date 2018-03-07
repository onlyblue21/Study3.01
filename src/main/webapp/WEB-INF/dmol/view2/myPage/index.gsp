<html>
<head>
	<meta name="layout" content="main" />
	<title>マイページ</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myHome">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">

<!-- commonContents -->
		<div class="commonContents flow">
			<h2>マイページ</h2>

			<div class="mainteBox" style="display: none;">
				★★★ 2015年以前のオリジナル年賀はがきデザインを、使用されるお客様へ ★★★<br><br>
				2016年の年賀はがきのレイアウトが変更となった為、オリジナル年賀はがきを作成される場合は、<br>保存したデータは使用せず、新たにデザインの作成をお願いいたします。
			</div>

			<div id="tmpleCont">
				<h3 class="mB0"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_title.gif" alt="マイページメニュー" /></h3>
				<div class="tmpIn">
					<div class="mypageIn">
						<div class="btnArea">
							<a href="${kamomailTopPath}" class="btKamo"><g:if test="${false}"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_bt_kamo.gif" alt="かもめ～るを作成する" /></g:if><g:else><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_bt_nenga.gif" alt="年賀ハガキを作成する" /></g:else></a>
							<a href="${normalTopPath}" class="btHagaki"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_bt_hagaki.gif" alt="はがきやチラシを作成する" /></a>
							<g:link controller="myLibrary" action="index" class="btDesign"><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_bt_design.gif" alt="保存したデザイン一覧 これまで作成し、保存したデザインをご確認頂けます。" /></g:link>
						</div>

						<div class="menuArea">
							<div class="listBox floatleft">
								<h4><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_m_design.jpg" alt="デザイン作成 デザインの編集やロゴ・地図の作成ができます。" /></h4>
								<ul>
									<li><g:link controller="myLibrary" action="index">保存したデザインを見る</g:link></li>
									<li><g:link controller="servicingOrder" action="editLogoTrace">ロゴ印刷データ変換サービス</g:link></li>
									<li><g:link controller="servicingOrder" action="editMapDrawup">地図印刷データ作成サービス</g:link></li>
								</ul>
							</div>
							<div class="listBox floatright">
								<h4><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_m_kanri.jpg" alt="お客様情報の管理 お客さま情報の確認と変更ができます。" /></h4>
								<ul>
									<li><g:link controller="profile" action="edit">登録情報の変更</g:link></li>
									<li><g:link controller="profile" action="passwd">パスワードの変更</g:link></li>
									<li><g:link controller="profile" action="withdrawalConfirm">退会する</g:link></li>
								</ul>
							</div>
							<div class="clear"></div>						
							<div class="listBox floatleft">
								<h4><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_m_atena.jpg" alt="あて名登録 あて名リストの登録と編集ができます。" /></h4>
								<ul>
									<li><g:link controller="myAddressList" action="index">あて名登録</g:link></li>
								</ul>
							</div>
							<div class="listBox floatright">
								<h4><img src="${r.resource(dir:'/static/dmol/users/images',file:'3rd')}/mypage_m_rireki.jpg" alt="ご注文履歴 今までのご注文履歴を確認できます。" /></h4>
								<ul>
									<li><g:link controller="myPage" action="orderHistory">ご注文履歴</g:link></li>
								</ul>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- tmpIn END -->
				<div class="tmpBtm"></div>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

</body>
</html>