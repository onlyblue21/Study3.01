<html>
<head>
	<meta name="layout" content="main" />
	<title>地図印刷データ作成サービス</title>
</head>
<body class="myPage myLibrary">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>地図印刷データ作成サービス</h1>

<!-- commonContents -->
		<div class="commonContents">

			<p class="mB20 align_center"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_mainmap.gif" alt="いただいた情報からお好みのデザインを選んで地図を作成！地図印刷データ作成サービス" /></p>

			<p class="logoread">印刷用の地図データがない！そんな時、住所さえわかれば、印刷用の地図データを作成します。デザイン（タイプ）をお選びいただき、目的地、掲載し たい目印や、スケールをご指定いただければ、プロのスタッフが印刷用の地図データを作成します。<br />
			完成した印刷データは、編集画面からご利用できる「過去に追加した画像」に納品します。</p>

			<h3 class="mB15"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/ttitle_m01.gif" alt="サービスの流れ" /></h3>

			<p class="mB30 align_center"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/map_img01.gif" alt="サービスの流れ" /></p>

			<h3><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/ttitle_m02.gif" alt="原稿のチェック" /></h3>
			<ul class="logolist">
				<li class="logotxt arrow_orange">校正なしの場合 ： 受注確定後、２週間程度</li>
				<li class="logotxt arrow_orange">校正2回の場合 ： 受注確定後、３週間程度</li>
			</ul>

<g:render template="/common/fragment/flashmessages" />
<g:render template="/common/fragment/validatormessages" />

			<a id="servicingFormPosition"></a>
			<div class="innnerBox3">
				<h2>依頼フォーム</h2>
				<g:form action="confirmMapDrawupKiyaku" name="mapDrawupForm" onsubmit="return false;">
				<div class="innnerBox3in">
					<p class="titleMap ">地図のデザイン（タイプ）を選んでください。</p>

					<div class="mapArea mB30">
						<ul>
							<li>
								<label for="mapDesignType_m1"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_map01.gif" width="180" height="180" alt="ベーシック" /></label><br />
								<input name="mapDesignType" type="radio" value="A:ベーシック" id="mapDesignType_m1" /> <label for="mapDesignType_m1">A : ベーシック</label>
							</li>
							<li>
								<label for="mapDesignType_m2"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_map02.gif" width="180" height="180" alt="筆タッチ" /></label><br />
								<input name="mapDesignType" type="radio" value="B:筆タッチ" id="mapDesignType_m2" /> <label for="mapDesignType_m2">B : 筆タッチ</label>
							</li>
							<li class="right">
								<label for="mapDesignType_m3"><img src="${r.resource(dir:'/static/dmol/users/images',file:'layout')}/img_map03.gif" width="180" height="180" alt="ライン" /></label><br />
								<input name="mapDesignType" type="radio" value="C:ライン" id="mapDesignType_m3" /> <label for="mapDesignType_m3">C : ライン</label>
							</li>
						</ul>
						<div class="clear"></div>
					</div>
							 
					<div class="clearboth"></div>
					<p class="titleMap ">地図の情報を入力してください。</p>

					<div class="textArea02 pT15">
						<p class="titleMap02">目的地名称、住所をご記入ください。</p>
						<ul>
							<li>目的地名称：</li>
							<li><input type="text" name="destinationName" maxlength="30" value="${params.destinationName?.encodeAsHTML()}" class="w200" />  <span class="size12">（地図中のふきだしの文言となります）</span></li>
						</ul>

						<div class="clearboth"></div>

						<ul>
							<li>目的地住所：</li>
							<li><textarea name="destinationAddress" cols="" rows="" class="w450 h80 mB15" >${params.destinationAddress?.encodeAsHTML()}</textarea></li>
						</ul>          

						<div class="clearboth"></div>

						<p class="titleMap02">掲載したい目印など  <span class="none">（最寄りの駅やIC、交差点、ランドマークなど）</span></p>

						<div class="mokuteki mB20">
							<p>
								<input type="text" name="landmark1" maxlength="15" value="${params.landmark1?.encodeAsHTML()}" class="w200" />  　 <input type="text" name="landmark2" maxlength="15" value="${params.landmark2?.encodeAsHTML()}" class="w200" />
								<input type="text" name="landmark3" maxlength="15" value="${params.landmark3?.encodeAsHTML()}" class="w200" /> 　  <input type="text" name="landmark4" maxlength="15" value="${params.landmark4?.encodeAsHTML()}" class="w200" />      
								<input type="text" name="landmark5" maxlength="15" value="${params.landmark5?.encodeAsHTML()}" class="w200" /> 　  <input type="text" name="landmark6" maxlength="15" value="${params.landmark6?.encodeAsHTML()}" class="w200" />
							</p>
						</div>

						<p class="titleMap02">目的地を中心に、おおよそ半径何キロメートルまでのエリアを作成しますか？</p>
						<div class="hankei">
						<ul>
							<li><input name="areaType" type="radio" value="500m" id="areaType_a1" /> <label for="areaType_a1">500m</label></li>
							<li><input name="areaType" type="radio" value="1km" id="areaType_a2" /> <label for="areaType_a2">1km</label></li>
							<li><input name="areaType" type="radio" value="2km" id="areaType_a3" /> <label for="areaType_a3">2km</label></li>
							<li><input name="areaType" type="radio" value="5km" id="areaType_a4" /> <label for="areaType_a4">5km</label></li>
						</ul>
						<div class="clearboth"></div>    
						</div>
						<br />
					</div>
					<p class="titleMap">ご要望や特記事項などございましたら、ご記入ください。</p>	
					<p class="align_center"><textarea name="orderMessage" cols="" rows="" class="w600 h125" >${params.orderMessage?.encodeAsHTML()}</textarea></p>
					<p class="align_center"><input type="image" id="orderBtn" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_irai-off.gif" alt="この内容で依頼する" /></p>

				</div>
				</g:form>
			</div>
		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<r:script>
;jQuery(function(){
$.validator.addMethod("radioSelectionValidator", function(value, element, params) {
	return (params.filter(":checked").length > 0);
}, "選択してください。");
var mapDesignTypeRadios = $("input:radio[name='mapDesignType']");
var areaTypeRadios = $("input:radio[name='areaType']");
mapDesignTypeRadios.val(["${params.mapDesignType?.encodeAsHTML()}"]);
areaTypeRadios.val(["${params.areaType?.encodeAsHTML()}"]);
var formValidator = $("#mapDrawupForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	rules:{
		mapDesignType:{
			radioSelectionValidator:mapDesignTypeRadios
		},
		destinationName:{
			required:true,
			maxlength:30
		},
		destinationAddress:{
			required:true,
			maxlength:256
		},
		areaType:{
			radioSelectionValidator:areaTypeRadios
		},
		orderMessage:{
			maxlength:1000
		}
	},
	messages:{
		mapDesignType:{
			radioSelectionValidator:"地図のデザインを指定してください。"
		},
		destinationName:{
			required:"目的地名称を指定してください。",
			maxlength:"目的地名称は30文字以内でお願いいたします。"
		},
		destinationAddress:{
			required:"目的地住所を指定してください。",
			maxlength:"目的地住所は256文字以内でお願いいたします。"
		},
		areaType:{
			radioSelectionValidator:"エリアを指定してください。"
		},
		orderMessage:{
			maxlength:"お問い合わせは1000文字以内でお願いいたします。"
		}
	}
});
mapDesignTypeRadios.click(function() {
	formValidator.element(mapDesignTypeRadios);
	return true;
});
areaTypeRadios.click(function() {
	formValidator.element(areaTypeRadios);
	return true;
});
$("#orderBtn").click(function() {
	if (formValidator.form()) {
		pleaseWait();
		document.mapDrawupForm.submit();
	}
	return false;
});
});</r:script>
</body>
</html>