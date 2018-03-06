<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>売上管理</title>
</head>
<body>
	<div class="mainBlock">
		<h1>売上管理</h1>
<g:render template="/common/fragment/flashmessages" />
		
		<table id="menu" >
			<col style="width:100px;">
			<col style="width:400px;">
			<tbody>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr class="prop odd">
					<td height="40px">
						<div style="text-align: center;padding-top: 5px;">
							<a href="${createLink(controller:'dailyTreatment', action:'index')}" class="button" >
							<span class="nowrap" >日次処理</span>
							</a>
						</div>
					</td>
					<td><div style="padding-top: 5px;padding-left: 5px;">日次処理画面を表示します。</div></td>
				</tr>
				<tr>
					<td height="40px">
						<div style="text-align: center;padding-top: 5px;">
							<a href="${createLink(controller:'monthlyTreatment', action:'index')}" class="button">
							<span class="nowrap">月次処理</span>
							</a>
						</div>
					</td>
					<td><div style="padding-top: 5px;padding-left: 5px;">月次処理画面を表示します。</div></td>
				</tr>
				<tr class="prop odd">
					<td height="40px">
						<div style="text-align: center;padding-top: 5px;">
							<a href="<g:createLink controller="performanceAggregate" action="performanceInitialView"></g:createLink>" class="button">
							<span class="nowrap">実績集計</span>
							</a>
						</div>
					</td>
					<td><div style="padding-top: 5px;padding-left: 5px;">実績集計画面を表示します。</div></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="40px"><div style="text-align: center;padding-top: 5px;">
					<a href="javascript:void(0)" id="goBackBtn" class="button"><span class="nowrap" >戻る</span></a></div></td>
				</tr>
			</tbody>
		</table>
	</div>

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#goBackBtn").click(function() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'mainMenu')}', params);
});
</jq:jquery>
</body>
</html>