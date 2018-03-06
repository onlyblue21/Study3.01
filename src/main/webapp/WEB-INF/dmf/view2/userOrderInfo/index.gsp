<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>注文履歴</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${createLinkTo(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'static/dmol/js',file:'status.js')}"></script>
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
			
			function formatNum(s)  
			{  var n = 0;
			   n = n > 0 && n <= 20 ? n : 0;  
			   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
			   var l = s.split(".")[0].split("").reverse(),  
			   r = s.split(".")[1];  
			   t = "";  
			   for(i = 0; i < l.length; i ++ )  
			   {  
			      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
			   }  
			   return t.split("").reverse().join("") ;  
			} 

			// 画面が読み込まれたときの処理
			function bodyOnload() {
				orderInfoListFunc.initList();
			}
	
			var orderInfoListFunc = new listFunc("orderInfoListFunc", 10, "orderNo", "asc");

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
				document.getElementById("sortKey").value="orderDate";
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
				window.location.href=href+"?pageid=recieverOrder";
				return false;
				}
			function openWindow(id){
				var url;
				url = "http://tracking.post.japanpost.jp/service/singleSearch.do?searchKind=S002&locale=ja&reqCodeNo1=" + id;
				window.open(url);
				return false;
				}
			String.prototype.replaceAll = function(s1,s2) { 
			    return this.replace(new RegExp(s1,"gm"),s2); 
			}
			// 受注一覧の取得
			function getOrderInfoList() {
				
				$("#OrderInfoListBody").empty();
				var param = orderInfoListFunc.getPageSortParam();
				document.getElementById("search").value = "true";
				param.sortKey=document.getElementById("sortKey").value;
				param.sortOrder=document.getElementById("sortOrder").value;
				param.orderInfoUserId = $('#orderInfoUserId').val();
				var number = 0;
				$.post("search", param, function(data) {
					orderInfoListFunc.updatePagination(data.totalCount, data.offset);
					var OrderInfoList = data.list;
					var html = "";
					if(data.totalCount<=0){
						document.getElementById("mainOrderMenu").style.display = "none";
						document.getElementById("ErrMessage").style.display = "block";
				   }else{
					   document.getElementById("mainOrderMenu").style.display = "block";
					   document.getElementById("ErrMessage").style.display = "none";
					   }
					$.each(data.list, function(i, OrderInfo) {
						number = number + 1;
						var htmlSettlementMethod = "";
						var htmlDetailNo = "";
						var htmlServiceDivision = "";
						var htmlQuantity = "";
						var htmlTotalAmount = "";
						var htmlOrderStatus = "";
						var htmlSettlementStatus = "";
						var htmlExaminationStatus = "";
						var htmlPrintStatus = "";
						var divClass = "border-bottom:dashed 1px #ccc;";
						var row = 1;
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
								htmlDetailNo += '<div class="tbpadding hright"><a onclick="return test(this.href)" class="order" href="<g:createLink controller="orderDetail" action="show"></g:createLink>/' + OrderDetail.id + '">' + turnNull(OrderDetail.detailNo) + '</a></div>';
								
								htmlServiceDivision += divClass;
								htmlServiceDivision += '<div class="tbpadding">' + turnNull(OrderDetail.serviceDivision) + '</div>';
								
								htmlQuantity += divClass;
								htmlQuantity += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.quantity)) + '</div>';
								
								htmlTotalAmount += divClass;
								htmlTotalAmount += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';
							
								htmlOrderStatus += divClass;
								htmlOrderStatus += '<div class="tbpadding">' + orderStatus(turnNull(OrderDetail.orderStatus)) + '</div>';
								
								htmlSettlementStatus += divClass;
								htmlSettlementStatus += '<div class="tbpadding">' + settlementStatus(turnNull(OrderDetail.settlementStatus)) + '</div>';
								
								htmlExaminationStatus += divClass;
								htmlExaminationStatus += '<div class="tbpadding">' + examinationStatus(turnNull(OrderDetail.examinationStatus)) + '</div>';
								
								htmlPrintStatus += divClass;
										
									htmlPrintStatus += '<div class="tbpadding tbunderlineorder">' + turnNull(OrderDetail.printStatus) + '</div>';
								if(OrderDetail.trackingNumber==null||OrderDetail.trackingNumber==""){
									htmlPrintStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
								}else{
									var trackNum = new Array();
									trackNum = OrderDetail.trackingNumber.split("/");
									var i;
									for(i = 0 ; i < trackNum.length;i ++){
										htmlPrintStatus += '<div class="' + lastDetailClass + '">' + HtmlEncode(turnNull(trackNum[i])) + '</div>';
										htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									}								
								}
								htmlExaminationStatus += '</div>';
								htmlSettlementStatus += '</div>';
								htmlOrderStatus += '</div>';
								htmlTotalAmount += '</div>';
								htmlQuantity += '</div>';
								htmlServiceDivision += '</div>';
								htmlDetailNo += '</div>';	
								htmlPrintStatus += '</div>';
							}
						})
						if(number%2==0){
							html += '<tr class="tbunderline prop odd">';
						}else{
							html += '<tr class="tbunderline prop even">';
						}
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div><div class="tbpadding">' + turnNull(OrderInfo.orderNo) + '</div></div></td>';
						//html += '<a onclick="return test(this.href)" href="';
						//html += '<g:createLink controller="orderInfo" action="show" />';
						//html += '/' + OrderInfo.id + '?prev=userOrderInfo">' + turnNull(OrderInfo.orderNo) + '</a></div></div></td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.orderDate) + '</td>';
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
						//注文者
						html += '<td style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div class="tbpadding"><input type="hidden" id="orderNameInput'+row+'" value="'+OrderInfo.owner+'"/>**********</div>';
						html += '</div>';
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '</td>';
						//送付先住所
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '</div>';
						html += '</td>';
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						//注文者
						html += '<td style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div class="tbpadding"><input type="hidden" id="orderNameInput'+row+'" value="'+OrderInfo.owner+'"/>' + HtmlEncode(turnNull(OrderInfo.name)) + '</div>';
						html += '</div>';
						html += '</td>';
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.email)) + '</div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.telno)) + '</div>';
						html += '</td>';
						
						//送付先住所
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.destinationAddress1)) +'<br />'+ HtmlEncode(turnNull(OrderInfo.destinationAddress2)) + '</div>';
						html += '</div>';
						html += '</td>';
						</sec:ifAnyGranted>
				
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += '<div class="tbpadding hright">' + turnNull(formatNum(OrderInfo.totalAmount)) + '</div>';
							html += '</td>';
						
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div class="tbpadding">' + turnNull(OrderInfo.settlementMethodId) + '</div>';
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
				
			}
			function test(url){
				$.post("test",function(data){
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
				getOrderInfoList();
			});
			(function($){

			  $.fn.back = function(href)
			  {
			 	var params = null;
				relayLogin(href, params);
			  };
			  $.fn.name = function(href,name)
			  {
			 	var params = {};
			 	params.userId=name;
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
			function namelink(id){
				$(id).name(document.getElementById(id).href,document.getElementById(id.replace("orderName","orderNameInput")).value);
				return false;
			}
		</script>
	</head>
	<body>
	<div class="mainBlock">
			<h1 align="left">注文履歴</h1>
			<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
			<div align="center"><b>会員名：**********</b></div>
			</sec:ifNotGranted>
			<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
			<div align="center"><b>会員名：${userName}</b></div>
			</sec:ifAnyGranted>

			<div align="left"><a href="${createLink(controller:'toDmfApplication', action:'s12list')}" onclick="return testlink(this.id)" id="goBack" name="goBack" class="button" ><span class="icon-search">&nbsp;戻る&nbsp;</span></a></div>        
<g:render template="/common/fragment/flashmessages" />	
           
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
				<g:form method="get" action="search" name="searhCondition">
				<g:hiddenField name="sortKey" value="orderDate" />
				<g:hiddenField name="sortOrder" value="desc" />
				<g:hiddenField name="search" value="true" />
				<g:hiddenField name="pageId" value="userOrderInfo" />
				<g:hiddenField name="orderInfoUserId" value="${params?.orderInfoUserId?.encodeAsHTML()}" />
				</g:form>
			</div>
			<div id="mainOrderMenu" style="display:none">
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
			
				<div class="list" id="searchDiv">
					<table style="table-layout:fixed;">
						<col style="width:135px"> <!-- 注文No -->
						<col style="width:80px"> <!-- 注文日 -->
						<col style="width:100px"><!-- ご注文者 -->
						<col style="width:200px"><!-- E-Mail/電話番号 -->
						<col style="width:300px"><!-- 送付先住所 -->
						
							<col style="width:80px"><!-- 合計金額 -->
						<col style="width:100px"><!-- 決済方法 -->
						<col style="width:50px"><!-- 明細 No-->
						<col style="width:130px"><!-- サービス区分/商品区分 -->
						<col style="width:50px"><!-- 数量 -->
							<col style="width:80px"><!-- 金額 -->
						<col style="width:100px"><!-- 注文ステータス -->
							<col style="width:100px"><!-- 決済ステータス -->
							<col style="width:120px"><!-- 審査ステータス -->
	
						<col style="width:150px"><!-- 印刷ステータス/伝票番号 -->
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
									<th rowspan="2" class="vhcenter">合計金額</th>
								
								<th rowspan="2" class="vhcenter">決済方法</th>
								<th rowspan="2" class="vhcenter">明細No.</th>
								<th rowspan="2" class="vhcenter">サービス区分</th>
								<th rowspan="2" class="vhcenter">数量</th>
				
									<th rowspan="2" class="vhcenter">金額</th>
				
									<th rowspan="2" class="vhcenter">注文ステータス</th>
		
									<th rowspan="2" class="vhcenter">決済ステータス</th>
									<th rowspan="2" class="vhcenter">審査ステータス</th>
								<th class="vhcenter">印刷ステータス</th>
							</tr>
							<tr>
								<th class="vhcenter">電話番号</th>
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
					<span id="pagecount2"></span>
					</div>
				</div>
			</div>
			<div class="vhcenter"  id="ErrMessage" style="display:none">
			<br>
				<b>
					<font color="#FF0000">
							該当会員の注文情報がありません。
					</font>
				</b>
		    </div>
		</div>
		
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
<jq:toggle speed="fast" sourceId="searchConditiontoggler" targetId="searchConditionFormArea" />
</jq:jquery>
	</body>
</html>
