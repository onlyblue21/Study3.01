<html>
<head>
	<meta name="layout" content="main" />
	<title>ロゴ印刷データ変換サービス</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>ロゴ印刷データ変換サービス</h1>

<!-- commonContents -->
		<div class="commonContents">

			<p class="mB30 align_center"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_mainLogo.gif" alt="ロゴ印刷データ変換サービス！ロゴ印刷データ変換サービス 価格2300円（税込）" /></p>

			 <p class="logoread">印刷物はあるけれど、ロゴのデータがない！データが荒くて印刷に使えない！そんな時に便利なロゴ印刷データ変換サービスです。プロのスタッフが、 いただいたラフデータを、印刷用のデータに変換します。<br />
				完成した印刷データは、編集画面からご利用できる「過去に追加した画像」に納品します。<br />
				<span class="red size12">※既存の完成ロゴを印刷用にデータ変換するものです。新規ロゴデザインを考案・制作するものではありません。</span>
			</p>

			<h3 class="mB15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/title_01.gif" alt="サービスの流れ" /></h3>
			<p class="align_center"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/logo_img01.gif" alt="サービスの流れ" /></p>

			<h3><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/title_02.gif" alt="完成までの目安時間" /></h3>

			<ul class="logolist">
				<li class="logotxt arrow_orange">校正なしの場合 ： 受注確定後、２週間程度</li>
				<li class="logotxt arrow_orange">校正2回の場合 ： 受注確定後、３週間程度</li>
			</ul>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<a id="servicingFormPosition"></a>
			<g:uploadForm action="uploadLogoTrace" name="uploadForm">
			<div class="innnerBox2 mB0">
<g:if test="${flash.filemessage}">
<div class="message flashmessages">${flash.filemessage}</div>
</g:if>
				<h2>依頼フォーム</h2>
				<div class="innnerBox2in">
					<p class="titleLogo ">印刷用にデータ変換するロゴ原稿をアップロードしてください。<br />
          				<span class="red size12">※アップロード可能なファイルフォーマットは、jpg、pdf、tiff、gif、bmp、png、pct、epsです。</span></p>
	                <p><input type="file" name="logoTraceFile" class="w300" /></p>
	                <div class="borderLogo"></div>
					<p class="titleLogo">ご要望や特記事項などございましたら、ご記入ください。</p>	
	                <p class="align_center"><textarea name="orderMessage" cols="" rows="" class="w500 h125" >${params.orderMessage?.encodeAsHTML()}</textarea></p>
					<input type="image" id="orderBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_irai-off.gif" alt="この内容で依頼する" />
				</div>
			</div>
			</g:uploadForm>

			<p class="logotxt size12 red w566">【ご注意】著作権が問題となる原稿やその他の法律に抵触する様な原稿についてはご遠慮ください。わいせつ的な表現、暴力的・残虐的な表現、法令に違反する、又は違反するおそれのある表現、その他弊社が不適切と判断する表現に関する制作はお断りいたします。</p>

		</div>
		<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<r:script>
;jQuery(function(){
var formValidator = $("#uploadForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		logoTraceFile:{
			required:true,
			extension:'jpeg|jpg|pdf|tiff|tif|gif|bmp|png|pct|eps'
		},
		orderMessage:{
			maxlength:1000
		}
	},
	messages:{
		logoTraceFile:{
			required:"トレースする原稿を指定してください。",
			extension:'アップロード可能なファイルフォーマットは、jpg、pdf、tiff、gif、bmp、png、pct、epsです。'
		},
		orderMessage:{
			maxlength:"お問い合わせは1000文字以内でお願いいたします。"
		}
	}
});
$("#orderBtn").click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.uploadForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>