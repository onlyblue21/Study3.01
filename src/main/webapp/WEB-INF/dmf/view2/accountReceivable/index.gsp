<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>売掛金残高一覧</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'status.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/kanri/js',file:'pagenavfunc.js')}"></script>
		<script>
		var creditCardSelected = function() {
		  if($('#isCreditCard').prop('checked')){
				table1.style.display ="";
				searchCondition.style.display="";
		
			}else {
				table1.style.display="none";
			} 
		};
		var paymentOnInvoiceSelected = function() {
		  if($('#isPaymentOnInvoice').prop('checked')){
				table2.style.display ="";
				searchCondition.style.display="";
		
			}else {
				table2.style.display="none";
			} 
		};
		var bankSelected = function() {
		  if($('#isBank').prop('checked')){
			table3.style.display ="";
			searchCondition.style.display="";

			}else {
				table3.style.display="none";
			}  
		};
		var cashOnDeliverySelected = function() {
			  if($('#isCashOnDelivery').prop('checked')){
				table4.style.display ="";
				searchCondition.style.display="";

				}else {
					table4.style.display="none";
				}  
			};
		function listBtn() {
			if(document.getElementById("flg").value == "true") {
				document.listForm.submit();
			} 
			return false;
		};
		
		function setSearchDefault(){
				if(!$('#isCreditCard').prop('checked') && 
				!$('#isPaymentOnInvoice').prop('checked') &&
				!$('#isBank').prop('checked') && 
				!$('#isCashOnDelivery').prop('checked')
				) {
					oiyConfirm("決済方法を指定して下さい。");
					searchCondition.style.display="none";

				}
				getOrderInfoList();
			};
		
		//初期化
		$(document).ready( function() {
			//ソートボタンとページングの初期化
			orderInfoListFunc.addEventListner(getOrderInfoList, getOrderInfoList);
			if(document.getElementById("autoSearch").value == "true"){
				getOrderInfoList();
			}
		});
		
		var orderInfoListFunc = new listFunc("orderInfoListFunc", 10, "orderNo", "asc");	
		function getOrderInfoList() {
			var param = orderInfoListFunc.getPageSortParam();
			param.year = $('#year').val();
			param.month = $('#month').val();
			param.yearMonth=param.year+param.month;
			param.isCreditCard = $('#isCreditCard').prop('checked');
			param.isPaymentOnInvoice = $('#isPaymentOnInvoice').prop('checked');
			param.isBank = $('#isBank').prop('checked');
			param.isCashOnDelivery = $('#isCashOnDelivery').prop('checked');
			$.post("searchList", param, function(data) {
				
				creditCardSelected();
				paymentOnInvoiceSelected();
				bankSelected();
				cashOnDeliverySelected();
				table5.style.display ="";
				detailButton.style.display ="";
				document.getElementById("flg").value = "true";
				document.listForm.selectYear.value = $("#year").val();
				document.listForm.selectMonth.value = $("#month").val();
				document.listForm.selectCreditCard.value = $('#isCreditCard').prop('checked');
				document.listForm.selectPaymentOnInvoice.value = $('#isPaymentOnInvoice').prop('checked');
				document.listForm.selectBank.value = $('#isBank').prop('checked');
				document.listForm.selectCashOnDelivery.value = $('#isCashOnDelivery').prop('checked');
				document.getElementById('totalAmount11').innerHTML=formatNum(data.totalAmount1);
				document.getElementById('totalAmount12').innerHTML=formatNum(data.totalAmount2);
				document.getElementById('totalAmount13').innerHTML=formatNum(data.totalAmount3);
				document.getElementById('totalAmount14').innerHTML=formatNum(data.totalAmount4);
				document.getElementById('totalAmount15').innerHTML=formatNum(data.totalAmount5);
			});
		}
		function formatNum(s)  
			{  var n = 0;
			   n = n > 0 && n <= 20 ? n : 2;  
			   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
			   var l = s.split(".")[0].split("").reverse(),  
			   r = s.split(".")[1];  
			   t = "";  
			   if(s>0) {
					for(i = 0; i < l.length; i ++ )  
					{  
					   t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
					}  
			   } else {
					for(i = 0; i < l.length; i ++ )  
					{  
					   t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length && (i + 2) != l.length ? "," : "");  
					}  
			   }
			   return t.split("").reverse().join(""); 
			} 
		
		</script>
	</head>
	<body>


	<div class="mainBlock">
			<h1 align="left">売掛金残高一覧</h1>
			
<g:render template="/common/fragment/flashmessages" />		
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
				<g:form method="get" action="searchlist" name="searhCondition">
				<g:hiddenField name="autoSearch" value="${params?.autoSearch?.encodeAsHTML()}" />
				<g:hiddenField name="flg" value="false" />
				<table>
					<tbody>
						<tr class="prop">
							<td class="name">報告月（出荷月）：</td>
							<td class="value">
									<div style="padding-left: 5px;float:left;">
										<g:select id="year" name="year" from="${params?.addYearList}" value="${params?.year?.encodeAsHTML()}" />
										<span class="icon-search">年</span>
									</div>

									<div style="padding-left: 5px;float:left;">
										<g:select id="month" name="month" from="${params?.addMonthList}" value="${params?.month?.encodeAsHTML()}" />
										<span class="icon-search">月</span>
									</div>
									
							</td>
						</tr>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">
								<div style="float:left;width:150px;">
									<g:checkBox id="isCreditCard" name="isCreditCard" value="${params?.settlementMethodCredit?.encodeAsHTML()}"/><label for="isCreditCard">クレジットカード</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isPaymentOnInvoice" name="isPaymentOnInvoice" value="${params?.settlementMethodPoi?.encodeAsHTML()}"/><label for="isPaymentOnInvoice">請求書払い</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isBank" name="isBank" value="${params?.settlementMethodBank?.encodeAsHTML()}"/><label for="isBank">銀行振込</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isCashOnDelivery" name="isCashOnDelivery" value="${params?.settlementMethodCash?.encodeAsHTML()}"/><label for="isCashOnDelivery">代引き</label>
								</div>
							</td>
						</tr>

						<tr class="prop">
							<td colspan="2" style="text-align: center;">
								
								<div class="searchButtons" style="float:right;">
									<a href="javascript:void(0)" id="searchBtn" class="button" onclick="setSearchDefault()"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</g:form>
			</div>
			<div class="dialog searchConditionFormArea" id="searchCondition">
				<table id="table1" style="display:none">
					<tbody>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">クレジットカード</td>
						</tr>
						<tr class="prop">
							<td class="name">売掛金合計（決済方法）：</td>
							<td class="value">
								<label id="totalAmount11">${params?.totalAmount1?.encodeAsHTML()}</label>円
							</td>
						</tr>
					</tbody>
				</table>
				<table id="table2" style="display:none">
					<tbody>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">請求書払い</td>
						</tr>
						<tr class="prop">
							<td class="name">売掛金合計（決済方法）：</td>
							<td class="value">
								<label id="totalAmount12">${params?.totalAmount2?.encodeAsHTML()}</label>円
							</td>
						</tr>
					</tbody>
				</table>
				<table  id="table3" style="display:none">
					<tbody>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">銀行振込</td>
						</tr>
						<tr class="prop">
							<td class="name">売掛金合計（決済方法）：</td>
							<td class="value">
								<label id="totalAmount13">${params?.totalAmount3?.encodeAsHTML()}</label>円
							</td>
						</tr>
					</tbody>
				</table>
				<table  id="table4" style="display:none">
					<tbody>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">代引き</td>
						</tr>
						<tr class="prop">
							<td class="name">売掛金合計（決済方法）：</td>
							<td class="value">
								<label id="totalAmount14">${params?.totalAmount4?.encodeAsHTML()}</label>円
							</td>
						</tr>
					</tbody>
				</table>
				<table  id="table5" style="display:none">
					<tbody>
						<tr class="prop">
							<td class="name">売掛金合計：</td>
							<td class="value">
								<label id="totalAmount15">${params?.totalAmount5?.encodeAsHTML()}</label>円
							</td>
						</tr>
				</table>
				<br>
				<div class="searchButtons" id="detailButton" style="float:right;display:none">
					<a href="javascript:void(0)" onclick="listBtn()" class="button"><span class="icon-search">&nbsp;明細&nbsp;</span></a>
				</div>
			</div>
		</div>
<g:form method="get" action="list" name="listForm">
<input type="hidden" name="selectYear" value="" />
<input type="hidden" name="selectMonth" value="" />
<input type="hidden" name="selectCreditCard" value="" />
<input type="hidden" name="selectPaymentOnInvoice" value="" />
<input type="hidden" name="selectBank" value="" />
<input type="hidden" name="selectCashOnDelivery" value="" />
</g:form>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
$(".searchConditionFormArea table tbody tr.prop").evenodd();
</jq:jquery>
	</body>
</html>
