<html>
<head>
	<meta name="layout" content="main" />
	<title>あて名データ管理</title>
	<script type="text/javascript" src="${r.resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
</head>
<body class="myPage myList">
<g:render template="/common/fragment/header" model="['showMyPageBtn':true,'showUserInfo':true]" />

<!-- mainBlock -->
	<div class="mainBlock">
		<h1>CSVファイルアップロード</h1>

<!-- commonContents -->
		<div class="commonContents">

<g:render template="/common/fragment/flashmessages" />

			<div class="box700">
				<div class="boxTop"></div>
				<div class="boxMiddle">
					<h2>アップロードするファイルの種類を選択してください。</h2>
					<div class="lineGW mB10"></div>
					<ul>
						<li><input type="image" id="dmolCsvBtn" class="mB10" alt="DMファクトリー専用CSVファイル" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_big5-off.gif" /></li>
						<li><input type="image" id="otherCsvBtn" class="mB10" alt="その他のソフトで作成されたCSVファイル" src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/bt_big6-off.gif" /></li>
					</ul>
					<div class="lineGW mT10"></div>
					<div class="btnArea">
						<g:link action="index"><img src="${r.resource(dir:'/static/dmol/users/images',file:'common')}/bt/btn_modoruB.gif" alt="戻る" /></g:link>
					</div>
				</div>
				<div class="boxBottom"></div>
			</div>

		</div>
<!-- commonContents END -->

	</div>
<!-- /mainBlock END -->

<g:form action="selectMyAddressList" name="selectMyAddressListForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
</g:form>
<g:form action="selectCustomDataDelimiter" name="selectCustomDataDelimiterForm">
<input type="hidden" name="myAddressListId" value="${params.myAddressListId?.encodeAsHTML()}" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<r:script>
;jQuery(function(){
$("#dmolCsvBtn").click(function() {
	pleaseWait();
	document.selectMyAddressListForm.submit();
	return false;
});
$("#otherCsvBtn").click(function() {
	pleaseWait();
	document.selectCustomDataDelimiterForm.submit();
	return false;
});
});</r:script>
</body>
</html>