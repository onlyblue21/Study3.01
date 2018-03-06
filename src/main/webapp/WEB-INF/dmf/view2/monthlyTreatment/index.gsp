<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>月次処理</title>
</head>
<body>
	
	<div class="mainBlock">
		<h1>月次処理</h1>
<g:render template="/common/fragment/flashmessages" />
		
		<table id="menu" >
			<col style="width:200px;">
			<col style="width:400px;">
			<col style="width:100px;">
			<tbody>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="40px"><div style="text-align: center;padding-top: 5px;">
					<a href="${createLink(controller:'monthlyTreatment', action:'creditsSalesInitialView')}" id="salesAccountBtn" class="button" >
					<span class="nowrap" >クレジット　売り上げデータCSV作成</span></a></div></td>
					<td><div style="padding-top: 5px;padding-left: 5px;">クレジット売上データCSV作成画面を表示します。</div></td>
					<td height="40px"><div style="text-align: center;padding-top: 5px;">
					<a href="${createLink(controller:'salesManagement', action:'index')}" id="" class="button" ><span class="nowrap" >戻る</span></a></div></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
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