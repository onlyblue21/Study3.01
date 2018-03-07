<html>
<head>
	<meta name="layout" content="maintenance" />
	<title>JPMDメニュー</title>
<style type="text/css">
<!--
table#menu tbody tr td {
	padding: 4px;
}
.leftcol {
	width: 14em;
}
-->
</style>
</head>
<body>
<!-- breadcrumb -->
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${r.resource(dir:'/')}">メインメニュー</a></li>
		</ul>
	</div>
<!-- /breadcrumb END -->

	<div class="mainBlock">
		<h1>メインメニュー</h1>

<g:render template="/common/fragment/flashmessages" />

		<table id="menu">
			<tbody>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_ITEM">
				<tr>
					<td class="leftcol"><g:link controller="itemInfo" action="list" class="button"><span class="nowrap">アイテム一覧</span></g:link></td>
					<td>アイテム一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_USER">
				<tr>
					<td class="leftcol"><g:link controller="user" action="list" class="button"><span class="nowrap">ユーザ一覧</span></g:link></td>
					<td>ユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_OFFICE_USER">
				<tr>
					<td class="leftcol"><g:link controller="officeUser" action="list" class="button"><span class="nowrap">事務局ユーザ一覧</span></g:link></td>
					<td>事務局ユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_JPOST_USER">
				<tr>
					<td class="leftcol"><g:link controller="jpostUser" action="list" class="button"><span class="nowrap">JPユーザ一覧</span></g:link></td>
					<td>JPユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_PRINT_USER">
				<tr>
					<td class="leftcol"><g:link controller="printUser" action="list" class="button"><span class="nowrap">印刷会社ユーザ一覧</span></g:link></td>
					<td>印刷会社ユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_JPMD_USER">
				<tr>
					<td class="leftcol"><g:link controller="jpmdUser" action="list" class="button"><span class="nowrap">JPMDユーザ一覧</span></g:link></td>
					<td>JPMDユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_MASTER">
					<tr>
						<td class="leftcol"><g:link controller="salesBranchMaster" action="index" class="button"><span class="nowrap">営業担当支店マスタ</span></g:link></td>
						<td>営業担当支店マスタメンテナンス画面を表示します</td>
					</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_MASTER">
					<tr>
						<td class="leftcol"><g:link controller="salesBranchZipcodeMaster" action="index" class="button"><span class="nowrap">担当エリアマスタ</span></g:link></td>
						<td>担当エリアマスタマスタメンテナンス画面を表示します</td>
					</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_ITEM">
				<tr>
					<td class="leftcol"><g:link controller="goodsInfo" action="list" class="button"><span class="nowrap">商品一覧</span></g:link></td>
					<td>商品一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_MANAGE_ROLE">
				<tr>
					<td class="leftcol"><g:link controller="role" action="list" class="button"><span class="nowrap">ロール一覧</span></g:link></td>
					<td>ロール一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

<sec:ifAllGranted roles="AUTHORITY_LOGIN_STATE">
				<tr>
					<td class="leftcol"><g:link controller="loginState" action="list" class="button"><span class="nowrap">ログインユーザ一覧</span></g:link></td>
					<td>ログインユーザ一覧画面を表示します</td>
				</tr>
</sec:ifAllGranted>

			</tbody>
		</table>
	</div>

<r:script>
;jQuery(function(){
$("#menu tbody tr:visible").evenodd();
});</r:script>
</body>
</html>