<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>売掛金残高明細</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'status.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/kanri/js',file:'allPagenavfunc.js')}"></script>
		<script type="text/javascript">
			function HtmlEncode(text)
			{
				if(text != "" && text != null){
					return text.replace(/\"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
					}
				else{
					return text;
					}
			}
		
			$(document).ready( function() {
				bodyOnload();
			});

			// 画面が読み込まれたときの処理
			function bodyOnload() {
				orderInfoListPage.addEventListner(orderInfoListPage_PageChanged);
				orderInfoListFunc.initList();
				orderInfoListPage.initList($("#pageButtonTop, #pageButtonBot"));
				document.getElementById("pageButtonsBot").style.display = "none";
				document.getElementById("pageButtonsTop").style.display = "none";
			}
			var orderInfoListPage = new pageNavFunc("orderInfoListPage", 20);
			function orderInfoListPage_PageChanged(){
				$("div.paginateButtons a").addClass('ui-state-default ui-corner-all').hover(
					function() {
						if (!$(this).hasClass('ui-state-disabled')) {
							$(this).addClass('ui-state-hover');
						}
					},
					function() {
						if ($(this).hasClass('ui-state-hover')) {
							$(this).removeClass('ui-state-hover');
						}
					}
				);
				orderInfoListPage.drawHtml = true;
				getOrderInfoList();
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
			var orderInfoListFunc = new listFunc("orderInfoListFunc", 20, "orderNo", "asc");

		</script>
		<script>
			//１ページの行数の設定
			function setPageMax(max, updateList) {
				html = "";
				html += createMaxSelector(10, max) + "&nbsp;";
				html += createMaxSelector(20, max) + "&nbsp;";
				html += createMaxSelector(50, max) + "&nbsp;";
				html += createMaxSelector(100, max) + "&nbsp;";
				$("#maxSelector").html(html);
				
				orderInfoListFunc.pageMax = max;
				if(updateList)
					getOrderInfoList();
			}
		
			function createMaxSelector(lines, max) {
				if(lines == max)
					return lines;
				return '<a href="javaScript:setPageMax(' + lines + ', true);">' + lines + '</a>';
			}
			function noClick(id){
				if(document.getElementById("search").value != "true"){
					return;
				}
				document.getElementById("sortKey").value = id;
				if(document.getElementById("sortOrder").value == "asc"){
					document.getElementById("sortOrder").value = "desc";
				}
				else {
					document.getElementById("sortOrder").value = "asc";
				}
				
				document.getElementById("orderNoCol").className = "vhcenter sortable ";
				document.getElementById("orderDateCol").className = "vhcenter sortable ";
				document.getElementById("userNameCol").className = "vhcenter sortable ";
				
				document.getElementById(id + "Col").className += document.getElementById("sortOrder").value;
				getOrderInfoList();
			}
			function setDefault(){
				document.getElementById("sortKey").value=="orderDate";
				document.getElementById("sortOrder").value = "desc";
				document.getElementById("orderNoCol").className = "vhcenter sortable";
				document.getElementById("orderDateCol").className = "vhcenter sortable sorted desc";
		
			}
			function setSearchDefault(){
				orderInfoListFunc.updatePagination(0, 0);
				setDefault();
			}
			function isDate(str)
			{
			    var d = new Date(str)
			    return !isNaN(d)
			}
			function submitForm(url){
				document.searhCondition.action = url;
				document.searhCondition.submit();
				}
			// 受注一覧の取得
			function getOrderInfoList() {
				
				$("#OrderInfoListBody").empty();
				var param = orderInfoListFunc.getPageSortParam();
				document.getElementById("search").value = "true";
				param.offset = orderInfoListPage.offset;
				param.sortKey=document.getElementById("sortKey").value;
				param.sortOrder=document.getElementById("sortOrder").value;
				param.year = $('#year').val();
				param.month = $('#month').val();
				param.yearMonth = $('#year').val()+ $('#month').val();
				param.isCreditCard = $('#isCreditCard').val();
				param.isPaymentOnInvoice = $('#isPaymentOnInvoice').val();
				param.isBank = $('#isBank').val();
				param.isCashOnDelivery = $('#isCashOnDelivery').val();
				var number = 0;
				$.post("search", param, function(data) {
					orderInfoListFunc.updatePagination(data.totalCount, data.offset);
					var OrderInfoList = data.list;
					var html = "";
					document.getElementById("pageButtonsBot").style.display = "block";
					document.getElementById("pageButtonsTop").style.display = "block";
					$.each(data.list, function(i, OrderDetail) {
						number = number + 1;
						var htmlShippingDate = "";
						var htmlSettlementMethod = "";
						var htmlDetailNo = "";
						var htmlRecieptDate = "";
						var htmlTotalAmount = "";

						var row = 1;
						var divClass = "border-bottom:dashed 1px #ccc;";
						
							var isLastDetail = (i == (OrderDetail.length - 1));
							var lastDetailClass = "tbpadding";
							if (!isLastDetail) {
								lastDetailClass +=  " tbunderlineorder";
							}
							if(row == 1){
								divClass = '<div>';
							}else{
								divClass = '<div style="border-top:dashed 1px #ccc;">';
							}
							row = row + 1;
							if (OrderDetail != null) {
								htmlDetailNo += divClass;
								htmlDetailNo += '<div class="tbpadding hright">' + turnNull(OrderDetail.detailNo) + '</div>';

								htmlShippingDate += divClass;
								htmlShippingDate += '<div class="tbpadding">' + turnNull(OrderDetail.shippingDate) + '</div>';
								
								htmlRecieptDate += divClass;
								htmlRecieptDate += '<div class="tbpadding">' + turnNull(OrderDetail.recieptDate) + '</div>';
								
								
								htmlTotalAmount += divClass;
								htmlTotalAmount += '<div class="tbpadding">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';

							}
						
						if(number%2==0){
							html += '<tr class="tbunderline prop odd">';
						}else{
							html += '<tr class="tbunderline prop even">';
						}
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding">' + turnNull(OrderDetail.orderNo) + '</div>';
						html += '</td>';
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding">' + turnNull(OrderDetail.settlementMethodId) + '</div>';
						html += '</td>';
						
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlDetailNo;
						html += '</td>';

						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlRecieptDate;
						html += '</td>';

    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlShippingDate;
						html += '</td>';
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderDetail.orderDate) + '</td>';

						//html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						//html += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';
						//html += '</td>';
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlTotalAmount;
						html += '</td>';
						
						html += '</tr>';
					})
					$("#OrderInfoListBody").html(html);
					var nowPage;
					var totalPage;
					nowPage = data.offset/20 + 1;
					totalPage = Math.ceil(data.totalCount/20);
					if(totalPage <= nowPage){
						nowPage = totalPage;
					}
					$("#pagecount1").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + formatNum(data.totalCount) + "件");
					$("#pagecount2").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + formatNum(data.totalCount) + "件");
					document.getElementById("pageButtonsBot").style.display = "block";
					document.getElementById("pageButtonsTop").style.display = "block";
					if(!orderInfoListPage.drawHtml){
						orderInfoListPage.updatePagination(data.totalCount, data.offset);
						$("div.paginateButtons a").addClass('ui-state-default ui-corner-all').hover(
							function() {
								if (!$(this).hasClass('ui-state-disabled')) {
									$(this).addClass('ui-state-hover');
								}
							},
							function() {
								if ($(this).hasClass('ui-state-hover')) {
									$(this).removeClass('ui-state-hover');
								}
							}
						);
					}
					orderInfoListPage.drawHtml = false;
				});
				//document.getElementById("ornoNo").className = "vhcenter sortable sorted desc";
			}
			
			function pageJump(page){
				if(page=="endJump"){
					orderInfoListFunc.lastPage();
					}
				if(page=="firstJump"){
					orderInfoListFunc.firstPage();
					}
				if(page=="movenext"){
					orderInfoListFunc.movePage(1);
					}
				if(page=="movepre"){
					orderInfoListFunc.movePage(-1);
					}
			}
			function turnNull(cluValue){
				if(cluValue!=""){
					return cluValue;}
				else{
					return "&nbsp;";
					}
				}
			//初期化
			$(document).ready( function() {
				//ソートボタンとページングの初期化
				orderInfoListFunc.addEventListner(getOrderInfoList, getOrderInfoList);
				setPageMax(orderInfoListFunc.pageMax, false);
				if(document.getElementById("autoSearch").value == "true"){
					//遷移前のoffset設定
					orderInfoListPage.offset = ${params?.offset?:0};
					getOrderInfoList();
				}
			});
			
			(function($){

			  $.fn.back = function(href)
			  {
			 	var params = null;
				relayLogin(href, params);
			  };
			var relayLogin = function(url, params) {
				var form = document.relayLoginForm;
				var relayLoginparams = document.getElementById("relayLoginparams");
				$.post(url, params, function(data, textStatus) {
					if (textStatus == 'success') {
						pleaseWait();
						var result = data; //jQuery.secureEvalJSON(data);
						if (result.result == 'success') {
							var html = "";
							$.each(result.params, function(key, val) {
								html += '<input type="hidden" name="' + key + '" value="' + val + '" />';
							});
							form.action = result.url;
							relayLoginparams.innerHTML = html;
							form.submit();
						} else if (result.message) {
							oiyAlert(result.message);
						} else {
							oiyAlert(result.result);
						}
						return false;
					}
					oiyAlert('画面を表示することができませんでした。');
					return false;
				});
			};
			
		
			})(jQuery);
			function testlink(id){
				document.prevForm.submit();
				//window.history.back(-1); 
				return false;
			}
			
		</script>
	</head>
	<body>
	
	<div class="mainBlock">
			<h1 align="left">売掛金残高明細</h1>
			
<g:render template="/common/fragment/flashmessages" />		
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
				<g:form method="get" action="search" name="searhCondition">
				<g:hiddenField name="sortKey" value="${params?.sortKey?.encodeAsHTML()}" />
				<g:hiddenField name="sortOrder" value="${params?.sortOrder?.encodeAsHTML()}" />
				<g:hiddenField name="autoSearch" value="${params?.autoSearch?.encodeAsHTML()}" />
				<g:hiddenField name="isCreditCard" value="${params?.selectCreditCard?.encodeAsHTML()}" />
				<g:hiddenField name="isPaymentOnInvoice" value="${params?.selectPaymentOnInvoice?.encodeAsHTML()}" />
				<g:hiddenField name="isBank" value="${params?.selectBank?.encodeAsHTML()}" />
				<g:hiddenField name="isCashOnDelivery" value="${params?.selectCashOnDelivery?.encodeAsHTML()}" />
				<g:hiddenField name="search" value="true" />
				<table>
					<tbody>
						<tr class="prop">
							<td class="name">報告月（出荷月）：</td>
							<td class="value">
									<div style="padding-left: 5px;float:left;">
										<input type="hidden" id="year" name="year" value="${params.selectYear?.encodeAsHTML()}" />
										${params.selectYear?.encodeAsHTML()}
										<span class="icon-search">年</span>
									</div>
									<div style="padding-left: 5px;float:left;">
										<input type="hidden" id="month" name="month" value="${params.selectMonth?.encodeAsHTML()}" />
										${params.selectMonth?.encodeAsHTML()}
										<span class="icon-search">月</span>
									</div>
									
							</td>
						</tr>
						<tr class="prop">
							<td class="name">決済方法：</td>
							<td class="value">
							<g:if test="${params.selectCreditCard == 'true'}">
									<div style="padding-left: 5px;float:left;">
									
										<span class="icon-search">クレジットカード</span>
									</div>
							</g:if>
							<g:if test="${params.selectCreditCard == 'true' && 
								(params.selectPaymentOnInvoice == 'true' || params.selectBank == 'true' || params.selectCashOnDelivery == 'true')}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">／</span>
									</div>
							</g:if>
							
							<g:if test="${params.selectPaymentOnInvoice == 'true'}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">請求書払い</span>
									</div>
							</g:if>
							<g:if test="${params.selectPaymentOnInvoice == 'true' && (params.selectBank == 'true' || params.selectCashOnDelivery == 'true')}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">／</span>
									</div>
							</g:if>
							<g:if test="${params.selectBank == 'true'}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">銀行振込</span>
									</div>
							</g:if>	
							<g:if test="${params.selectCashOnDelivery == 'true' && params.selectBank == 'true'}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">／</span>
									</div>
							</g:if>
							<g:if test="${params.selectCashOnDelivery == 'true'}">
									<div style="padding-left: 5px;float:left;">
										<span class="icon-search">代引き</span>
									</div>
							</g:if>		
							</td>
						</tr>
						
						<tr class="prop">
							<td colspan="2" style="text-align: center;">
								<div class="searchButtons" style="float:left;">
								<a href="${createLink(controller:'accountReceivable', action:'index')}" onclick="return testlink(this.id)" id="goBack" name="goBack" class="button" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a>
								</div>
								
							</td>
						</tr>
					</tbody>
				</table>
				</g:form>
			</div>
			<div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;line-height:18px;" id="pageButtonsTop">
					<div id="pageButtonTop" style="float:left;">
					</div>
					
					<div  style="float:left;margin-left:20px">
						<span id="pagecount1" ></span>
					</div>
				</div>
				<div class="list">
					<table style="table-layout:fixed;">
						<col style="width:135px"><!-- 注文No -->
						<col style="width:100px"><!-- 決済方法 -->
						<col style="width:50px"><!-- 明細 No-->
						<col style="width:80px"><!-- 入金日-->
						<col style="width:80px"><!-- 出荷日-->
						<col style="width:80px"> <!-- 注文日 -->
						<col style="width:80px"><!-- 金額 -->
						
						<thead>
		                    <tr>
							<th rowspan="2" class="vhcenter">注文No.</th>
							<th rowspan="2" class="vhcenter">決済方法</th>
							<th rowspan="2" class="vhcenter">明細No.</th>
							<th rowspan="2" class="vhcenter">入金日</th>
							<th rowspan="2" class="vhcenter">出荷日</th>
							<th rowspan="2" class="vhcenter">注文日</th>
							<th rowspan="2" class="vhcenter">金額</th>
							</tr>
							
						</thead>
						<tbody id="OrderInfoListBody" >
						</tbody>
					</table>
				</div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;" id="pageButtonsBot">
					<div id="pageButtonBot" style="float:left">
						<ft:paginate2 total="90" offset="30" title=" " />
					</div>
					<div  style="float:left;margin-left:20px">
						<span id="pagecount2"></span>
					</div>
				</div>
			</div>
		</div>
		</div>
<g:form method="get" action="index" name="prevForm">
<input type="hidden" name="prevFlg" value="true" />
</g:form>

<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
var formValidator = $("#searhCondition").validate({
	
	
});

	if (formValidator.form()) {
		orderInfoListPage.offset = 0;
		getOrderInfoList();
		return false;
	}


</jq:jquery>
	</body>
</html>
