<html>
<head>
	<meta name="layout" content="main" />
	<title>利用規約</title>
</head>
<body class="myPage">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>利用規約</h1>
		
<!-- commonContents -->
		<div class="commonContents w664">
			<h2>DMファクトリー　利用規約</h2>

			<iframe src="/agreement/index.html" class="kiyakuBox"></iframe>

<div class="cautionBox">
<p class="chui">&lt;&lt;ご注意ください!&gt;&gt;</p>
<h3>1 オリジナルはがき作成サービスをお申込みされるお客さまへ</h3>

<p>
・オリジナルはがき作成サービスは、DM作成サービスとは違い、年賀はがき又はかもめ～るの、通常はご利用いただけない 範囲などにお客さまの広告等を当社として掲載するサービスであり、当社が発行する年賀はがき又はかもめ～るに掲載する広告等としての条件(DMファクトリー利用規約第二章参照)を満たしているかのデザイン審査を行います。<br />
・一旦契約成立となっても、デザイン審査の結果、条件を満たしていない場合は契約を解除させていただくこともございますので、ご注意ください。
</p>
 
<h3>2 DM作成サービスをお申込みされるお客さまへ</h3>
<h4>ゆうメール(タウンプラスを含みます。)としてご利用される場合(小型メール便用紙又は一般メール便用紙ご利用の場合)</h4>

<p>・タウンプラスとして差し出すために必要な表示(料金納付表示及び「タウンプラス」)を印刷したものは、その印刷対象物を、タウンプラス以外のゆうメール又は郵便物として差し出すことはできませんので、ご注意ください。<br />
	・信書に該当する文書を印刷したものは、ゆうメール(タウンプラスを含みます。)として差し出すことはできませんので、ご注意ください。<br />
(参考)<a href="http://www.post.japanpost.jp/shiten_search/index.html" target="_blank">集荷、配達に関する連絡先の検索</a><br />
(参考)<a href="http://www.soumu.go.jp/yusei/shinsho_guide.html" target="_blank">信書のガイドライン（総務省）</a></p>

<h3>3 年賀はがき(私製年賀はがきを含みます。)について</h3>

<p>
・12月15日から同年12月28日までに郵便局に差し出されたものでなければ年賀はがきの取扱いとなりません。<br />
印刷対象物を出荷してからお届けするまでには数日かかりますので、日数に余裕を持ってお申込みください。<br />
(伏見郵便局(〒612-8799)からゆうパックで出荷します(発送(差出)代行サービスお申込み時は郵便物として差出し)。 <br />
(参考)<a href="http://www.post.japanpost.jp/deli_days/index.html" target="_blank">郵便物等のお届け日数を調べる</a></p>
</div>

			<p class="align_center">上記内容をご確認いただき、「同意して進む」ボタンを押してください</p>
			<div class="align_center">
				<g:link controller="myProduct" action="index" class="mR15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoru.gif" alt="戻る" /></g:link>
				<input type="image" id="nextBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_d_susumu-off.gif" alt="同意して進む" />
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form method="get" name="nextForm" action="confirmOrdering" />
<r:script>
;jQuery(function(){
$("#nextBtn").click(function() {
	document.nextForm.submit();
	return false;
});
});</r:script>
</body>
</html>