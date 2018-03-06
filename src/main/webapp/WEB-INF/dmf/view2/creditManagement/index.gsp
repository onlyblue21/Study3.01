<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>クレジット管理</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${createLinkTo(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'static/dmol/js',file:'status.js')}"></script>
		<script>
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
				orderInfoListFunc.initList();
				document.getElementById("pageButtonsBot").style.display = "none";
				document.getElementById("pageButtonsTop").style.display = "none";
			}

			function formatNum(s)  
			{  var n = 0;
			   n = n > 0 && n <= 20 ? n : 2;  
			   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
			   var l = s.split(".")[0].split("").reverse(),  
			   r = s.split(".")[1];  
			   t = "";  
			   for(i = 0; i < l.length; i ++ )  
			   {  
			      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
			   }  
			   return t.split("").reverse().join(""); 
			} 
			var orderInfoListFunc = new listFunc("orderInfoListFunc", 10, "orderNo", "asc");

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
				document.getElementById("userNameCol").className = "vhcenter sortable";
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
				if($('#orderDateFrom').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateFrom').val())){
					return false;
				}
				if($('#orderDateTo').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateTo').val())){
					return false;
				}
				$("#OrderInfoListBody").empty();
				var param = orderInfoListFunc.getPageSortParam();
				document.getElementById("search").value = "true";
				param.sortKey=document.getElementById("sortKey").value;
				param.sortOrder=document.getElementById("sortOrder").value;
				param.orderNo = $('#orderNo').val();
				param.orderDateFrom = $('#orderDateFrom').val();
				param.orderDateTo = $('#orderDateTo').val();
				param.familyName = $('#familyName').val();
				param.firstName = $('#firstName').val();
				param.email = $('#email').val();
				param.telno = $('#telno').val();
				param.destinationAddress = $('#destinationAddress').val();
				param.cardCompany = $('#cardCompany').val();
				param.settlementStatusCredit = $('#settlementStatusCredit').val();
				param.serviceDivisionDMOnline = $('#serviceDivisionDMOnline').prop('checked');
				param.serviceDivisionNewYearCard = $('#serviceDivisionNewYearCard').prop('checked');
				param.serviceDivisionKamoMail = $('#serviceDivisionKamoMail').prop('checked');
				param.serviceDivisionFuTai = $('#serviceDivisionFuTai').prop('checked');
				param.orderStatus = $('#orderStatus').val();
				param.isExcludeCancel = $('#isExcludeCancel').prop('checked');
				param.examinationStatus = $('#examinationStatus').val();
				var number = 0;
				$.post("search", param, function(data) {
					orderInfoListFunc.updatePagination(data.totalCount, data.offset);
					var OrderInfoList = data.list;
					var html = "";
					document.getElementById("pageButtonsBot").style.display = "block";
					document.getElementById("pageButtonsTop").style.display = "block";
					$.each(data.list, function(i, OrderInfo) {
						number = number + 1;
						var htmlCardCompany = "";
						var htmlSettlementMethod = "";
						var htmlDetailNo = "";
						var htmlServiceDivision = "";
						var htmlQuantity = "";
						var htmlOrderStatus = "";
						var htmlTotalAmount = "";
						var htmlSettlementStatus = "";
						var htmlExaminationStatus = "";
						var htmlPrintStatus = "";
						var row = 1;
						var divClass = "border-bottom:dashed 1px #ccc;";
						$.each(OrderInfo.details, function(j, OrderDetail) {
							var isLastDetail = (j == (OrderInfo.details.length - 1));
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
								htmlDetailNo += '<div class="tbpadding hright"><a onclick="return setSession(this.href)" class="order" href="<g:createLink controller="orderDetail" action="show"></g:createLink>/' + OrderDetail.id + '">' + turnNull(OrderDetail.detailNo) + '</a></div>';

								htmlCardCompany += divClass;
								htmlCardCompany += '<div class="tbpadding">' + OrderDetail.cardCorporateId + '</div>';
								
								htmlServiceDivision += divClass;
								htmlServiceDivision += '<div class="tbpadding">' + turnNull(OrderDetail.serviceDivision) + '</div>';
								
								htmlQuantity += divClass;
								htmlQuantity += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.quantity)) + '</div>';
								htmlTotalAmount += divClass;
								htmlTotalAmount += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';
	
								htmlOrderStatus += divClass;
								htmlOrderStatus += '<div class="tbpadding"><a onclick="return setSession(this.href)" href="<g:createLink controller="orderDetail" action="status"></g:createLink>/' + OrderDetail.id + '">' + turnNull(OrderDetail.orderStatus) + '</a></div>';
	
								htmlSettlementStatus += divClass;
								htmlSettlementStatus += '<div class="tbpadding">' + turnNull(OrderDetail.settlementStatus) + '</div>';
								htmlSettlementStatus += '<div class="' + lastDetailClass + '">' + turnNull(OrderDetail.settlementError) + '</div>';
	
								htmlExaminationStatus += divClass;
								htmlExaminationStatus += '<div class="tbpadding">' + turnNull(OrderDetail.examinationStatus) + '</div>';
	
								htmlPrintStatus += divClass;
								htmlPrintStatus += '<div class="' + lastDetailClass + '">' + turnNull(OrderDetail.printStatus) + '</div>';
								if(OrderDetail.trackingNumber==null||OrderDetail.trackingNumber==""){
									htmlPrintStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlDetailNo += '</div>';
									htmlCardCompany += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlCardCompany += '</div>';
									htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlServiceDivision += '</div>';
									htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlQuantity += '</div>';
									htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlTotalAmount += '</div>';
									htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlOrderStatus += '</div>';
									htmlSettlementStatus += '</div>';
									htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlExaminationStatus += '</div>';
								}else{
									var trackNum = new Array();
									trackNum = OrderDetail.trackingNumber.split("/");
									var i;
									for(i = 0 ; i < trackNum.length;i ++){
										htmlPrintStatus += '<div class="' + lastDetailClass + '">' + turnNull(trackNum[i]) + '</div>';
										htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlCardCompany += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										if(i!=0){
											htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										}
										htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									}	
									htmlSettlementStatus += '</div>';
									htmlExaminationStatus += '</div>';
									htmlOrderStatus += '</div>';
									htmlTotalAmount += '</div>';
									htmlQuantity += '</div>';
									htmlServiceDivision += '</div>';
									htmlCardCompany += '</div>';
									htmlDetailNo += '</div>';
								}
								htmlPrintStatus += '</div>';
							}
						})
						if(number%2==0){
							html += '<tr class="tbunderline prop odd">';
						}else{
							html += '<tr class="tbunderline prop even">';
						}

						html += '<td id="Y'+i+'Order" style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.orderNo) + '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.orderDate) + '</td>';
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.name)) + '</td>';
						html += '<td>';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.email)) + '</div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.telno) + '</div>';
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.destinationAddress1)) +'<br />'+ HtmlEncode(turnNull(OrderInfo.destinationAddress2))+ '</td>';
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
						html += '<td style="word-wrap:break-word;word-break:break-all; ">**********</td>';
						html += '<td>';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">**********</td>';
						</sec:ifNotGranted>

    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlCardCompany;
						html += '</td>';

						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding hright">' + turnNull(formatNum(OrderInfo.totalAmount)) + '</div>';
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlDetailNo;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlServiceDivision;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlQuantity;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlTotalAmount;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlOrderStatus;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlSettlementStatus;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlExaminationStatus;
						html += '</td>';
    					html += '<td style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlPrintStatus;
						html += '</td>';
						html += '</tr>';
					})
					$("#OrderInfoListBody").html(html);
					var nowPage;
					var totalPage;
					nowPage = data.offset/10 + 1;
					totalPage = Math.ceil(data.totalCount/10);
					if(totalPage <= nowPage){
						nowPage = totalPage;
					}
					$("#pagecount1").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + data.totalCount + "件");
					$("#pagecount2").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + data.totalCount + "件");
				});
				//document.getElementById("ornoNo").className = "vhcenter sortable sorted desc";
			}
			function setSession(url){
				$.post("setSession",function(data){
					if(data.result=="ok"){
						window.location.href = url;
					}
				});
				return false;
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
				$(id).back(document.getElementById(id).href);
				return false;
			}
		</script>
	</head>
	<body>
	<div class="mainBlock">
			<h1 align="left">クレジット管理</h1>
			
<g:render template="/common/fragment/flashmessages" />		
			<div class="searchConditiontoggler"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
				<g:form method="get" action="search" name="searhCondition">
				<g:hiddenField name="sortKey" value="${params?.sortKey?.encodeAsHTML()}" />
				<g:hiddenField name="sortOrder" value="${params?.sortOrder?.encodeAsHTML()}" />
				<g:hiddenField name="autoSearch" value="${params?.autoSearch?.encodeAsHTML()}" />
				<g:hiddenField name="search" value="false" />
				<table>
					<tbody>
						<tr class="prop">
							<td class="name">注文No</td>
							<td class="value">
								<input type="text" id="orderNo" name="orderNo" size="50" maxlength="15" value="${params?.orderNo?.encodeAsHTML()}" /><div style="padding-top:1px;">&nbsp;（例）12345678901234</div>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">注文日</td>
							<td class="value">
								<span id="date">
								<input type="text" id="orderDateFrom" name="orderDateFrom" value="${params?.orderDateFrom?.encodeAsHTML()}" />
								～
								<input type="text" id="orderDateTo" name="orderDateTo" value="${params?.orderDateTo?.encodeAsHTML()}" />
								</span>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">ご注文者</td>
							<td class="value">
								<div style="float:left">
									<div>
										<span>姓</span>
										<span><input type="text" id="familyName" name="familyName" size="40" maxlength="128" value="${params?.familyName?.encodeAsHTML()}" /></span>
									</div>
									<div style="padding-left:15px;">
										（例）郵便
									</div>
								</div>
								<div style="float:left;padding-left:15px;">
									<div>
										<span>名</span>
										<span><input type="text" id="firstName" name="firstName" size="40" maxlength="128" value="${params?.firstName?.encodeAsHTML()}" /></span>
									</div>
									<div style="padding-left:15px;">
										（例）太郎
									</div>
								</div>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">メールアドレス</td>
							<td class="value">
								<span id="emailCheck">
								<input type="text" id="email" name="email" size="50" maxlength="128" value="${params?.email?.encodeAsHTML()}" /><br>&nbsp;（例）abc@def.co.jp
								</span>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">電話番号</td>
							<td class="value">
								<span id="telCheck">
								<input type="text" id="telno" name="telno" size="20" maxlength="16" value="${params?.telno?.encodeAsHTML()}" /><br>&nbsp;（例）03-1234-5678
								</span>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">送付先住所</td>
							<td>
								<input type="text" id="destinationAddress" name="destinationAddress" size="40" maxlength="256" value="${params?.destinationAddress?.encodeAsHTML()}" /><br>&nbsp;（例）東京都港区虎ノ門1-2-3
							</td>
						</tr>
						<tr class="prop">
							<td class="name">カード会社</td>
							<td class="value">
								<g:select id="cardCompany" name="cardCompany" value="${params?.cardCompanyList}"
									from="${cardCompanyList}"
									noSelection="${['null':'すべて']}"
									optionKey="id" optionValue="name" >
								</g:select>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">サービス区分</td>
							<td class="value">
								<div style="float:left;width:180px;">
									<g:checkBox id="serviceDivisionDMOnline" name="serviceDivisionDMOnline" value="${params?.serviceDivisionDMOnline?.encodeAsHTML()}"/><label for="serviceDivisionDMOnline">DMサービス</label>
								</div>
								<div style="float:left;width:180px;">
									<g:checkBox id="serviceDivisionNewYearCard" name="serviceDivisionNewYearCard" value="${params?.serviceDivisionNewYearCard?.encodeAsHTML()}"/><label for="serviceDivisionNewYearCard">オリジナル年賀</label>
								</div>
								<div style="float:left;width:180px;">
									<g:checkBox id="serviceDivisionKamoMail" name="serviceDivisionKamoMail" value="${params?.serviceDivisionKamoMail?.encodeAsHTML()}"/><label for="serviceDivisionKamoMail">オリジナルかもめ～る</label>
								</div>
								<div style="float:left;width:180px;">
									<g:checkBox id="serviceDivisionFuTai" name="serviceDivisionFuTai" value="${params?.serviceDivisionFuTai?.encodeAsHTML()}"/><label for="serviceDivisionFuTai">付帯サービス</label>
								</div>
							</td>
						</tr>
						<!--<tr class="prop">
							<td class="name">商品区分</td>
							<td class="value">
								<div style="float:left;width:200px;">
									<g:checkBox id="productDivisionPrint" name="productDivisionPrint" value="${params?.productDivisionPrint?.encodeAsHTML()}"/><label for="productDivisionPrint">印刷物</label>
								</div>
								<div style="float:left;width:200px;">
									<g:checkBox id="productDivisionOthers" name="productDivisionOthers" value="${params?.productDivisionOthers?.encodeAsHTML()}"/><label for="productDivisionOthers">付帯サービス</label>
								</div>
								<div style="float:left;width:200px;">
								</div>
							</td>
						</tr>-->
						<tr class="prop">
							<td class="name">注文ステータス</td>
							<td class="value">
								<div style="float:left;width:130px;">
									<g:select id="orderStatus" name="orderStatus" value="${params?.orderStatus}"
										from="${orderStatusList}"
										noSelection="${['null':'すべて']}"
										optionKey="id" optionValue="name" >
									</g:select>
								</div>
								<g:if test="${false}">
								<div style="float:left;width:150px;">
									<g:checkBox id="isExcludeCancel" name="isExcludeCancel" value="${params?.isExcludeCancel?.encodeAsHTML()}"/><label for="isExcludeCancel">キャンセルを除く</label>
								</div>
								</g:if>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">決済ステータス</td>
							<td class="value">
								<g:select id="settlementStatusCredit" name="settlementStatusCredit" value="${params?.settlementStatusCredit}"
									from="${settlementStatusCreditList}"
									noSelection="${['null':'すべて']}"
									optionKey="id" optionValue="name" >
								</g:select>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">審査ステータス</td>
							<td class="value">
								<g:select id="examinationStatus" name="examinationStatus" value="${params?.examinationStatus}"
									from="${examinationStatusList}"
									noSelection="${['null':'すべて']}"
									optionKey="id" optionValue="name" >
								</g:select>
							</td>
						</tr>
						<tr class="prop">
							<td colspan="2" style="text-align: center;">
								<div class="searchButtons" style="float:left;">
								<a href="${createLink(controller:'toDmfApplication', action:'mainMenu')}" onclick="return testlink(this.id)" id="goBack" name="goBack" class="button" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a> 
								</div>
								<div class="searchButtons">
									<a href="javascript:void(0)" id="clearSearchConditionBtn" class="button" onclick="setDefault()"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
									<a href="javascript:void(0)" id="searchBtn" class="button" onclick="setSearchDefault()"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</g:form>
			</div>
			<div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;" id="pageButtonsTop">
					<div  style="float:left">
					<a href="javascript:void(0)"  id="firstJump" class="button" onclick="pageJump('firstJump')">
					<span class="icon-search">&nbsp;先頭ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="movepre" class="button" onclick="pageJump('movepre')">
					<span class="icon-search">&nbsp;前ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="movenext" class="button" onclick="pageJump('movenext')">
					<span class="icon-search">&nbsp;次ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="endJump" class="button" onclick="pageJump('endJump')">
					<span class="icon-search">&nbsp;最終ページ&nbsp;</span></a>
					</div>
					<div  style="float:left;margin-left:20px">
					<span id="pagecount1" ></span>
					</div>
				</div>
				<div class="list">
					<table style="table-layout:fixed;">
						<col style="width:135px"><!-- 注文No -->
						<col style="width:80px"> <!-- 注文日 -->
						<col style="width:100px"><!-- ご注文者 -->
						<col style="width:200px"><!-- E-Mail/電話番号 -->
						<col style="width:300px"><!-- 送付先住所 -->
						<col style="width:120px"><!-- カード会社 -->
						<col style="width:80px"><!-- 合計金額 -->
						<col style="width:50px"><!-- 明細 No-->
						<col style="width:130px"><!-- サービス区分 -->
						<col style="width:50px"><!-- 数量 -->
						<col style="width:80px"><!-- 金額 -->
						<col style="width:100px"><!-- 注文ステータス -->
						<col style="width:100px"><!-- 決済ステータス -->
						<col style="width:120px"><!-- 審査ステータス -->
						<col style="width:120px"><!-- 印刷ステータス/伝票番号 -->
						<thead>
		                    <tr>
							<g:if test="${params?.sortKey?.encodeAsHTML() == 'orderNo'}">
								<th onclick="noClick('orderNo')" rowspan="2" name="orderNoCol" id="orderNoCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">注文No</a></th>
							</g:if>
							<g:else>
								<th onclick="noClick('orderNo')" rowspan="2" name="orderNoCol" id="orderNoCol" class="vhcenter sortable" ><a href="#">注文No</a></th>
							</g:else>
							
							<g:if test="${params?.sortKey?.encodeAsHTML() == 'orderDate'}">
								<th onclick="noClick('orderDate')" rowspan="2" name="orderDateCol" id="orderDateCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">注文日</a></th>
							</g:if>
							<g:else>
								<th onclick="noClick('orderDate')" rowspan="2" name="orderDateCol" id="orderDateCol" class="vhcenter sortable" ><a href="#">注文日</a></th>
							</g:else>
							
							<g:if test="${params?.sortKey?.encodeAsHTML() == 'userName'}">
								<th onclick="noClick('userName')" rowspan="2" name="userNameCol" id="userNameCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">ご注文者</a></th>
							</g:if>
							<g:else>
								<th onclick="noClick('userName')" rowspan="2" name="userNameCol" id="userNameCol" class="vhcenter sortable" ><a href="#">ご注文者</a></th>
							</g:else>
								<th class="vhcenter">E-Mail</th>
								<th rowspan="2" class="vhcenter">送付先住所</th>
								<th rowspan="2" class="vhcenter">カード会社 </th>
								<th rowspan="2" class="vhcenter">合計金額</th>
								<th rowspan="2" class="vhcenter">明細No.</th>
								<th rowspan="2" class="vhcenter">サービス区分</th>
								<th rowspan="2" class="vhcenter">数量</th>
								<th rowspan="2" class="vhcenter">金額</th>
								<th rowspan="2" class="vhcenter">注文ステータス</th>
								<th class="vhcenter">決済ステータス</th>
								<th rowspan="2" class="vhcenter">審査ステータス</th>
								<th class="vhcenter">印刷ステータス</th>
							</tr>
							<tr>
								<th class="vhcenter">電話番号</th>
								<th class="vhcenter">エラー</th>
								<th class="vhcenter">伝票番号</th>
							</tr>
						</thead>
						<tbody id="OrderInfoListBody" >
						</tbody>
					</table>
				</div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;" id="pageButtonsBot">
					<div  style="float:left">
					<a href="javascript:void(0)"  id="firstJump" class="button" onclick="pageJump('firstJump')">
					<span class="icon-search">&nbsp;先頭ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="movepre" class="button" onclick="pageJump('movepre')">
					<span class="icon-search">&nbsp;前ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="movenext" class="button" onclick="pageJump('movenext')">
					<span class="icon-search">&nbsp;次ページ&nbsp;</span></a>
					<a href="javascript:void(0)"  id="endJump" class="button" onclick="pageJump('endJump')">
					<span class="icon-search">&nbsp;最終ページ&nbsp;</span></a>
					</div>
					<div  style="float:left;margin-left:20px">
					<span id="pagecount2" ></span>
					</div>
				</div>
			</div>
		</div>
		</div>
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
var formValidator = $("#searhCondition").validate({
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	groups: {
		date: "orderDateFrom orderDateTo"
	},
	errorPlacement: function(error, element) {
		switch(element.prop('name')) {
			case "orderDateFrom":
			case "orderDateTo":
				error.insertAfter($('#date'));
				break;
			case "telno":
				error.insertAfter($('#telCheck'));
				break;
			case "email":
				error.insertAfter($('#emailCheck'));
				break;
			default:
				error.insertAfter(element);
		}
	},
	rules:{
		orderNo:{
			number:true
		},
		telno:{
			telnum:true
		},
		email:{
			email:true
		},
		orderDateFrom:{
			date:true,
			dateDiff:true
		},
		orderDateTo:{
			date:true,
			dateDiff:true
		}
	},
	messages:{
		orderNo:{
			number:"半角数字を入力してください。"
		},
		telno:{
			telnum:"電話番号を入力してください。"
		},
		email:{
			email:"メールアドレスが正しくありません。"
		},
		orderDateFrom:{
			date:"日付が正しくありません。",
			dateDiff:"終了日を開始日以降に入力してください。"
		},
		orderDateTo:{
			date:"日付が正しくありません。",
			dateDiff:"終了日を開始日以降に入力してください。"
		}
	}
});
$('#searchBtn').click(function() {
	if (formValidator.form()) {
		getOrderInfoList();
		return false;
	}
});
//電話番号（例:010-2345-6789）
jQuery.validator.addMethod("telnum", function(value, element) {
	return this.optional(element) || /^[0-9-]+$/.test(value);
	}, "電話番号を入力してください"
);
$("#clearSearchConditionBtn").click(function() {
	$(".searchConditionFormArea input, .searchConditionFormArea select").each(function(){  
		if (this.type == "checkbox" || this.type == "radio") {  
			this.checked = false;  
		} else if(this.type == "select-one") {  
			this.value = "null";
		}else{
			$(this).val(""); 
		}
	});
	return false;
});
//日付比較
jQuery.validator.addMethod("dateDiff", function(value, element) {
	var dateTo = $('#orderDateTo').val();
	var dateFrom = $('#orderDateFrom').val();
	if(!dateTo || dateTo == "" || !dateFrom || dateFrom == ""){
		return true;
	}else{
		return new Date(Date.parse(dateFrom.replace("-", "/"))) <= new Date(Date.parse(dateTo.replace("-", "/")));
	}},"終了日に開始日以降の日付を入力してください。"
);
$(".searchConditionFormArea table tbody tr.prop").evenodd();
$('#orderDateFrom').datepicker({
});
$('#orderDateTo').datepicker({
});
</jq:jquery>
	</body>
</html>
