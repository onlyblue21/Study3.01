<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>OrderInfo出力</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'status.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/kanri/js',file:'pagenavfunc.js')}"></script>
		<script type="text/javascript">
			$(document).ready( function() {
				$("#month").find("option[value = ${monthNow}]").prop("selected",true);
			});
			function isDate(str){
				var d = new Date(str)
				return !isNaN(d)
			}
		</script>
	</head>
	<body>
	<div class="mainBlock">
			<h1 align="left">OrderInfo出力</h1>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="padding:4px;border: 1px solid #CCC;clear:both;">
				<g:form method='get' action='output' name='outputForm'>
				<br>
				<h4 style="float:left;">期間指定方法</h4>
								<table>
									<tr>
									   <td>
									     <g:radio name="outPutGroup" id="outPutGroup1" value="1" checked="true"/><label for="outPutGroup1">受注日指定</label>
									   </td>
									</tr>
									<tr>
									   <td>
									      <g:radio name="outPutGroup" id="outPutGroup2" value="2" /><label for="outPutGroup2">出荷日指定</label>
									   </td>
		                            </tr>
								</table>
				<br>
				<h4 style="float:left;">出力期間</h4>
								<table>
									<tr><td><g:radio name="dateGroup" id="dateGroup1" value="0" checked="true"/><label for="dateGroup1">年月指定</label></td>
									<td>
										<span style="padding-left: 5px;">
											<g:select name="year" id="year" from="${years}"/>&nbsp;&nbsp;年&nbsp;&nbsp;
											<!-- 以下、name"month"を"month2"に変更17_05_8_kim -->
											<g:select id="month2" name="month2" from="${(1..12).collect{formatNumber(number:it, format:'00')}}" />&nbsp;&nbsp;月 
										</span>
									</td>
									</tr>
									<tr><td><g:radio name="dateGroup" id="dateGroup2" value="-1"/><label for="dateGroup2">日付指定</label></td>
									<td>
										<span id="date" style="padding-left: 5px;">
		                                <input type="text" id="orderDateFrom" name="orderDateFrom" value="${dateMonthAgo?.encodeAsHTML()}" />
		                              	  ～
		                                <input type="text" id="orderDateTo" name="orderDateTo" value="${dateNow?.encodeAsHTML()}"/>
		                            </span>
									</td></tr>
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
		                     <span class="icon-conditiontoggler">CSVファイルダウンロード</span></a>
		                </div>
				</div>
			</g:form>
			<div>
	</div>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$("#backBtn").click(function() {
	var params = null;
	return relayLogin('${createLink(controller:'toDmfApplication', action:'mainMenu')}', params);
});
var formValidator = $("#outputForm").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	groups: {
		date: "orderDateFrom orderDateTo",
	},
	errorPlacement: function(error, element) {
		switch(element.prop('name')) {
			case "orderDateFrom":
			case "orderDateTo":
				error.insertAfter($('#date'));
				break;
		}
	},
	rules:{
		orderDateFrom:{
			required:'#dateGroup2:checked',
			date: {depends: function(element) {return !!$('#dateGroup2:checked').length;}},
			dateForma:{depends: function(element) {return !!$('#dateGroup2:checked').length;}},
			dateDiff:{depends: function(element) {return !!$('#dateGroup2:checked').length;}}
		},
		orderDateTo:{
			required:'#dateGroup2:checked',
			date:{depends: function(element) {return !!$('#dateGroup2:checked').length;}},
			dateForma:{depends: function(element) {return !!$('#dateGroup2:checked').length;}},
			dateDiff:{depends: function(element) {return !!$('#dateGroup2:checked').length;}}
		}
	},
	messages:{
		orderDateFrom:{
			date:"日付が正しくありません。",
			dateForma:"日付が正しくありません。" /* ,
			dateDiff:"終了日を開始日以降に入力してください。" */
		},
		orderDateTo:{
			date:"日付が正しくありません。",
			dateForma:"日付が正しくありません。" /* ,
			dateDiff:"終了日を開始日以降に入力してください。" */
		}
	}
});


jQuery.validator.addMethod("dateForma", function(value, element) {
	var DATE_FORMAT = /^[0-9]{4}\/[0-1]?[0-9]{1}\/[0-3]?[0-9]{1}$/;
    return DATE_FORMAT.test(value);
},"日付が正しくありません。");

jQuery.validator.addMethod("dateDiff", function(value, element) {
	var dateTo = $('#orderDateTo').val();
	var dateFrom = $('#orderDateFrom').val();
	if(!dateTo || dateTo == "" || !dateFrom || dateFrom == ""){
		return true;
	}else{
		dateTo = new Date(Date.parse(dateTo.replace("-", "/")));
		dateFrom = new Date(Date.parse(dateFrom.replace("-", "/")));
		
		if(dateFrom > dateTo) {
			return false;
		}else if(dateTo >= dateFrom.setFullYear(dateFrom.getFullYear()+1)){
			return false;
		}else
			return true;
	}},"１年未満を指定してください" //終了日に開始日以降の日付を入力してください。"
);

$("#clearBtn").click(function(){
	window.location.reload();
});
$("#downLoadBtn").click(function(){
/*
    if($('#dateGroup2').is(':checked')){
	    if($('#orderDateFrom').val() == "" || $('#orderDateTo').val() == ""){
	   		  alert("日付指定に入力された日付が１年の範囲を指定してください。");
		      return false;
	    }
    }
    var fromdate = new Date($('#orderDateFrom').val());
    var todate = new Date($('#orderDateTo').val());
    fromdate.setFullYear(fromdate.getFullYear()+1);
    if($('#dateGroup2').is(':checked')){
	    if(fromdate <= todate){
	      alert("日付指定に入力された日付が１年の範囲を超えています。");
	      return false;
	    }
    }
*/
	if (formValidator.form()) {
		var r=confirm("CSVファイルダウンロードを実施しますか？");
		if (r==true){
			if($('#orderDateFrom').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateFrom').val())){
				return false;
			}
			if($('#orderDateTo').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateTo').val())){
				return false;
			}
			document.outputForm.submit();
		}else{
			return false;
		}
	}
	return false;
});
$('#orderDateFrom').datepicker({});
$('#orderDateTo').datepicker({});
</jq:jquery>
	</body>
</html>
