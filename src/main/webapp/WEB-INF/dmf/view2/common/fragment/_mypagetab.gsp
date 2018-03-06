<div>
	<button id="gotoMyPageBtn" class="gotoPageBtn">ホーム</button>
	<button id="gotoMySpecBtn" class="gotoPageBtn">マイスペック</button>
	<button id="gotoMyLibraryBtn" class="gotoPageBtn">マイライブラリ</button>
	<button id="gotoMyAddressListBtn" class="gotoPageBtn">マイリスト</button>
	<button id="gotoMyProductBtn" class="gotoPageBtn">マイプロダクト</button>
</div>
<g:form method="get" controller="myPage" action="index" name="gotoMyPageBtnForm" />
<g:form method="get" controller="mySpec" action="index" name="gotoMySpecBtnForm" />
<g:form method="get" controller="myLibrary" action="index" name="gotoMyLibraryBtnForm" />
<g:form method="get" controller="myAddressList" action="index" name="gotoMyAddressListBtnForm" />
<g:form method="get" controller="myProduct" action="index" name="gotoMyProductBtnForm" />
<jq:jquery>
$(".gotoPageBtn").button({disabled:true}).click(function() {
	var formName = $(this).attr('id') + "Form";
	document.forms[formName].submit();
	return false;
});
$(".gotoPageBtn[id!='${disableBtnId}']").button('enable');
</jq:jquery>