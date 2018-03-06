<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>実績管理メニュー</title>
</head>
<body>
	<div class="breadcrumb bgGrad">
		<ul>
			<li><a class="home transition" href="${createLinkTo(dir:'')}">メインメニュー</a></li>
		</ul>
	</div>
	<div class="mainBlock">
		<h1>実績管理</h1>
<g:render template="/common/fragment/flashmessages" />
		<table id="menu">
			<tbody>
				<tr>
					<td class="leftcol"><a href="${createLink(controller:'officeSalesAccount', action:'index')}" id="salesAccountBtn" class="button"><span class="nowrap">実績集計</span></a></td>
					<td>実績集計画面を表示します。</td>
				</tr>
			</tbody>
		</table>
	</div>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#menu tbody tr:visible").evenodd();
</jq:jquery>
</body>
</html>