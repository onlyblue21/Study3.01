<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>操作ログ出力</title>
		<r:require modules="application-pagenavfunc,application-status" />
	</head>
	<body>
	<div class="mainBlock">
		<g:render template="/common/fragment/flashmessages" />
		<h1 align="left">ログ・ファイルダウンロード</h1>
		<g:form method='post' action='list' name='outputForm'>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="padding:1px;border: 1px solid #CCC;clear:both;">
				<table>
					<tr><td width=100><label style="padding:5px 10px;text-align:left;float:left;">出力年月指定</label></td>
					<td style="padding:0px 90px;text-align:left;float:left;">
						<g:select name="year" id="year" from="${years}"/>&nbsp;&nbsp;年&nbsp;&nbsp;
						<g:select id="month" name="month" from="${(1..12).collect{formatNumber(number:it, format:'00')}}" />&nbsp;&nbsp;月
					</td>
					</tr>
				</table>
			</div>
			<div>
				<div style="margin:10p;overflow:hidden;">
					<div style="padding:10px 3px;text-align:left;float:left;">
                    <a id="backBtn" class="button ui-state-default ui-corner-all" href="javascript:void(0)">
                        <span class="icon-conditiontoggler">戻る</span></a>
				</div>
				<div style="padding:12px 20px 8px 20px;float:right;">
					<a id="clearBtn" class="button ui-state-default ui-corner-all" href="javascript:void(0)">
						<span class="icon-conditiontoggler">クリア</span></a>
					<a href="javascript:void(0)" id="downLoadBtn" class="button ui-state-default ui-corner-all">
						<span class="icon-conditiontoggler">ログファイルダウンロード</span></a>
				</div>
				</div>
			</div>
		</g:form>
	</div>

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
;jQuery(function(){
$("#clearBtn").click(function(){
	window.location.reload(true);
});
$("#backBtn").click(function() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'mainMenu')}', params);
});
$(document).ready( function() {
	$("#month").find("option[value = ${monthNow}]").prop("selected",true);
});
$("#downLoadBtn").click(function(){
	var r=confirm("CSVファイルダウンロードを実施しますか？");
	if (r==true){
		document.outputForm.submit();
	}else{
		return false;
	}
	return false;
});
});
</jq:jquery>
	</body>
</html>
