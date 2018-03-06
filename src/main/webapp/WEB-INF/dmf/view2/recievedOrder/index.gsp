<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>受注管理</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${resource(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/js',file:'status.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'static/dmol/kanri/js',file:'pagenavfunc.js')}"></script>
		<script type="text/javascript">
			function HtmlEncode(text)
			{
				if(text != "" && text != null){
					return text.replace(/\"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;'); //"
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
				orderInfoListPage.addEventListner(orderInfoListPage_PageChanged);
				orderInfoListFunc.initList();
				orderInfoListPage.initList($("#pageButtonTop, #pageButtonBot"));
				document.getElementById("pageButtonsBot").style.display = "none";
				document.getElementById("pageButtonsTop").style.display = "none";
<g:if test="${role != 'print'}">
				document.getElementById("outDtlBtnArea").style.display = "none";
				document.getElementById("outDtlBtnAreas").style.display = "none";
</g:if>
			}
	
			var orderInfoListFunc = new listFunc("orderInfoListFunc", 10, "orderNo", "asc");
			var orderInfoListPage = new pageNavFunc("orderInfoListPage", 10);
			var excludeDlItems = new Array();
			
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

			function setDefault(){
				document.getElementById("sortKey").value=="orderDate";
				document.getElementById("sortOrder").value = "desc";
				document.getElementById("orderNoCol").className = "vhcenter sortable";
				document.getElementById("orderDateCol").className = "vhcenter sortable sorted desc";
				document.getElementById("lastUpdatedCol").className = "vhcenter sortable";
				document.getElementById("userNameCol").className = "vhcenter sortable";
			}
			function setSearchDefault(){
				orderInfoListFunc.updatePagination(0, 0);
				setDefault();
			}
			function submitForm(url){
				window.location.href=href+"?pageid=recieverOrder";
				return false;
			}
			function toggleButtonAndCheckState(button, chkName) {
				var checked, caption;
				//toggle button text
				if($("span", button).text() == " 全選択 ") {
					checked = true;
					caption = " 全解除 ";
				}else{
					checked = false;
					caption = " 全選択 ";
				}
				
				$("span", button).text(caption);
				
				$("input[name='" + chkName + "']").each(function () {
					if(this.checked != checked){
						this.checked = checked;
					}
				});
			}
			function setAllCheckState2(checked) {
				$("input[name='isPrintTarget']").each(function () {
					if(this.checked != checked){
						this.checked = checked;
						dlItemCheck(this);
					}
				});
			}
			<%-- List内コンテンツ用 --%>
			function noClick(id){<%-- ソート条件変更 --%>
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
				document.getElementById("lastUpdatedCol").className = "vhcenter sortable ";
				document.getElementById("userNameCol").className = "vhcenter sortable ";
				
				document.getElementById(id + "Col").className += document.getElementById("sortOrder").value;
				getOrderInfoList();
			}
			<%-- Link --%>
			function openWindow(id){
				var url;
				url = "http://tracking.post.japanpost.jp/service/singleSearch.do?searchKind=S002&locale=ja&reqCodeNo1=" + id;
				window.open(url);
				return false;
			}
			function saveExcludeItems(delg){
				var param = {};
				param.excludeDlItemssCount = excludeDlItems.length;
				param.excludeDlItems = excludeDlItems;
				$.post("saveExcludeDlItem", param, function(data) {
					delg();
				});
			}
			function test(url){
				saveExcludeItems(function() {
					$.post("test",function(data){
						if(data.result=="ok"){
							window.location.href = url;
						}
					});
				});
				return false;
			}
			function namelink(id){
				saveExcludeItems(function(){
					$(id).name(document.getElementById(id).href, document.getElementById(id.replace("orderName","orderNameInput")).value);
				});
				return false;
			}
			function reviewConfirm(url, detailNo){
				var params = {};
				params.orderDetailNo=detailNo;
				var form = document.relayLoginForm;
				var relayLoginparams = document.getElementById("relayLoginparams");
				$.post(url, params, function(data, textStatus) {
					if (textStatus == 'success') {
						//pleaseWait();
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
				return false;
			}
			function dlItemCheck(chk) {
				if(!chk.checked){
					//unchecked - entry excludeDlItems
					excludeDlItems.push(chk.value);
				}else{
					var index = $.inArray(chk.value, excludeDlItems);
					if(index != -1){
						excludeDlItems.splice(index, 1);
						return false;
					}
				}
			}
			<%-- 検索実行 --%>
			function isDate(str)
			{
				var d = new Date(str)
				return !isNaN(d)
			}
			function turnNull(cluValue){
				if(cluValue!=""){
					return cluValue;
				}else{
					return "&nbsp;";
				}
			}
			// 受注一覧の取得
			function getOrderInfoList() {
				if($('#orderDateFrom').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateFrom').val())){
					return false;
				}
				if($('#orderDateTo').val().replace(/(^\s*)|(\s*$)/g, "") != "" && !isDate($('#orderDateTo').val())){
					return false;
				}
				<%-- data initialize --%>
				$("#OrderInfoListBody").empty();
				<%-- create search parameter --%>
				var param = orderInfoListFunc.getPageSortParam();
				document.getElementById("search").value = "true";
				if($('#showStdLi').hasClass('selected')){
					param.searchMode = "0";
				}else{
					param.searchMode = "1";
				}
				param.offset = orderInfoListPage.offset;
				param.sortKey = document.getElementById("sortKey").value;
				param.sortOrder = document.getElementById("sortOrder").value;
				param.orderNo = $('#orderNo').val();
				// 日付検索
				if($('#dateGroup1').prop('checked')){
					param.dateFilterType = 0;
				}else{
					param.dateFilterType = $('#updStatusType').val();
				}
				param.orderDateFrom = $('#orderDateFrom').val();
				param.orderDateTo = $('#orderDateTo').val();
				param.statusUpdDateFrom = $('#statusUpdDateFrom').val();
				param.statusUpdDateTo = $('#statusUpdDateTo').val();
				
				param.familyName = $('#familyName').val();
				param.firstName = $('#firstName').val();
				param.email = "";<%-- ★$('#email').val(); --%>
				param.telno = "";<%-- ★$('#telno').val(); --%>
				param.destinationAddress = "";<%-- $('#destinationAddress').val(); --%>
				
				param.settlementStatusCredit = $.map($(':checkbox[name="settlementStatusCredit"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodCredit = param.settlementStatusCredit.length > 0;
				
				param.settlementStatusBank = $.map($(':checkbox[name="settlementStatusBank"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodBank = param.settlementStatusBank.length > 0;
				
				param.settlementStatusPoi = $.map($(':checkbox[name="settlementStatusPoi"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodPoi = param.settlementStatusPoi.length > 0;
				
				param.settlementStatusCod = $.map($(':checkbox[name="settlementStatusCod"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodCod = param.settlementStatusCod.length > 0;
				
				param.serviceDivisionDMOnline = false;<%-- ★$('#serviceDivisionDMOnline').prop('checked'); --%>
				param.serviceDivisionNewYearCard = false<%-- ★$('#serviceDivisionNewYearCard').prop('checked'); --%>
				param.serviceDivisionKamoMail = false;<%-- ★$('#serviceDivisionKamoMail').prop('checked'); --%>
				param.serviceDivisionFuTai = $('#serviceDivisionFuTai').prop('checked');
				param.settlementStatus = $('#settlementStatus').val();
				//param.orderStatus = $('#orderStatus').val();
				param.isSettlemented = $('#isSettlemented').prop('checked');
				param.isPreOrder = $('#isPreOrder').prop('checked');
				param.isPrinting = $('#isPrinting').prop('checked');
				param.isCanceled = $('#isCanceled').prop('checked');
				param.isShipmented = $('#isShipmented').prop('checked');
				
				param.examinationStatus = $.map($(':checkbox[name="examinationStatus"]:checked'), function(v, n){return $(v).val();});
				param.printStatus = $.map($(':checkbox[name="printStatus"]:checked'), function(v, n){return $(v).val();});
				
				param.itemGenre = $.map($(':checkbox[name="itemGenre"]:checked'), function(v, n){return $(v).val();});
				param.itemGenreCount = param.itemGenre.length;
				
				$.post("search", param, function(data) {
					var role = data.role;
					orderInfoListFunc.updatePagination(data.totalCount, data.offset);
					var OrderInfoList = data.list;
					var html = "";
	<g:if test="${role != 'print'}">
					document.getElementById("outDtlBtnArea").style.display = "block";
					document.getElementById("outDtlBtnAreas").style.display = "block";
					
	</g:if>
					var number = 0;
					if (data.list == null) data.list = [];
					$.each(data.list, function(i, OrderInfo) {
						number = number + 1;
						var htmlCheckTargetId = "";
						var htmlSettlementMethod = "";
						var htmlDetailNo = "";
						var htmlThumbnail = "";
						var htmlServiceDivision = "";
						var htmlQuantity = "";
						var htmlTotalAmount = "";
						var htmlOrderStatus = "";
						var htmlSettlementStatus = "";
						var htmlExaminationStatus = "";
						var htmlPrintStatus = "";
						var htmlAddrPrint = "";
						var htmlPostProxy = "";
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
			<g:if test="${role != 'print'}">
								htmlCheckTargetId += divClass;
								htmlCheckTargetId += '<div class="tbpadding vhcenter">';
								htmlCheckTargetId += '<input type="checkbox" name="isPrintTarget" value="' + turnNull(OrderDetail.id) + '" onclick="dlItemCheck(this);" ';
								if($.inArray(turnNull(OrderDetail.id), excludeDlItems) == -1){
									htmlCheckTargetId += 'checked ';
								}
								htmlCheckTargetId += '/></div>';
			</g:if>
								htmlDetailNo += divClass;
								htmlDetailNo += '<div class="tbpadding hright"><a onclick="return test(this.href)" class="order" href="<g:createLink controller="orderDetail" action="show"></g:createLink>/' + OrderDetail.id + '">' + turnNull(OrderDetail.detailNo) + '</a></div>';
								
								htmlThumbnail += divClass;
								htmlThumbnail += '<div class="tbpadding vhcenter">'
								for(var thumbIdx=0; thumbIdx < OrderDetail.thumbnailCount; thumbIdx++) {
									htmlThumbnail += '<a onclick="return reviewConfirm(this.href, \'' + turnNull(OrderInfo.orderNo) + '-' + turnNull(OrderDetail.detailNo) + '\')" href="<g:createLink controller='toDmfApplication' action='${previewpdfAction}'></g:createLink>">';
									htmlThumbnail += '<img src="<g:createLink controller='toDmfApplication' action='${thumbnailAction}' />?pageNo=' + (thumbIdx + 1) + '&orderDetailNo=' + turnNull(OrderInfo.orderNo) + '-' + turnNull(OrderDetail.detailNo) + '">';
									htmlThumbnail += '</a>';
								}
								htmlThumbnail += '</div>';
								
								htmlServiceDivision += divClass;
								htmlServiceDivision += '<div class="tbpadding">' + turnNull(OrderDetail.itemGenreName) + '</div>';
								
								htmlQuantity += divClass;
								htmlQuantity += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.quantity)) + '</div>';
								
								htmlTotalAmount += divClass;
								htmlTotalAmount += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';
							
								htmlAddrPrint += divClass;
								if(OrderDetail.addressPrintFlg){
									htmlAddrPrint += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.addressPrintQuantity)) + '</div>';
								}else{
									htmlAddrPrint += '<div class="tbpadding hright">なし</div>';
								}
								htmlPostProxy += divClass;
								if(OrderDetail.postingProxyFlg){
									htmlPostProxy += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.postingProxyQuantity)) + '</div>';
								}else{
									htmlPostProxy += '<div class="tbpadding hright">なし</div>';
								}
								
								htmlOrderStatus += divClass;
								htmlOrderStatus += '<div class="tbpadding vhcenter"><a onclick="return test(this.href)" href="<g:createLink controller="orderDetail" action="status"></g:createLink>/' + OrderDetail.id + '">' + orderStatus(turnNull(OrderDetail.orderStatus)) + '</a></div>';
								htmlOrderStatus += '<div class="tbpadding vhcenter ' + lastDetailClass + '">' + turnNull(OrderDetail.orderStatusUpdated) + '</div>';
								
								htmlSettlementStatus += divClass;
								htmlSettlementStatus += '<div class="tbpadding vhcenter">' + settlementStatus(turnNull(OrderDetail.settlementStatus)) + '</div>';
								htmlSettlementStatus += '<div class="tbpadding vhcenter ' + lastDetailClass + '">' + turnNull(OrderDetail.settlementStatusUpdated) + '</div>';
								
								htmlExaminationStatus += divClass;
								htmlExaminationStatus += '<div class="tbpadding vhcenter">' + examinationStatus(turnNull(OrderDetail.examinationStatus)) + '</div>';
								htmlExaminationStatus += '<div class="tbpadding vhcenter ' + lastDetailClass + '">' + turnNull(OrderDetail.examinationStatusUpdated) + '</div>';
								
								htmlPrintStatus += divClass;
								htmlPrintStatus += '<div class="tbpadding vhcenter tbunderlineorder">' + turnNull(OrderDetail.printStatus) + '</div>';
								// 400:出荷済み　だったら、伝票番号を表示
								if(OrderDetail.printStatusOrg != '400'){
									//更新日を表示
									htmlPrintStatus += '<div class="tbpadding vhcenter ' + lastDetailClass + '">' + turnNull(OrderDetail.printStatusUpdated) + '</div>';
									
									htmlCheckTargetId += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlThumbnail += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlAddrPrint += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlPostProxy += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									
								} else if(OrderDetail.trackingNumber==null||OrderDetail.trackingNumber==""){
									htmlCheckTargetId += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlPrintStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlThumbnail += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									//htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlAddrPrint += '<div class="' + lastDetailClass + '">&nbsp;</div>';
									htmlPostProxy += '<div class="' + lastDetailClass + '">&nbsp;</div>';
								}else{
									var trackNum = new Array();
									trackNum = OrderDetail.trackingNumber.split("/");
									var i;
									for(i = 0 ; i < trackNum.length;i ++){
										htmlCheckTargetId += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlPrintStatus += '<div class="' + lastDetailClass + '"><a href="javascript:viod(0)" onclick = "return openWindow(this.innerHTML)">' + HtmlEncode(turnNull(trackNum[i])) + '</a></div>';
										htmlDetailNo += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlThumbnail += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlServiceDivision += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlQuantity += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlTotalAmount += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlAddrPrint += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										htmlPostProxy += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										
										if(i > 0){
											htmlOrderStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
											htmlSettlementStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
											htmlExaminationStatus += '<div class="' + lastDetailClass + '">&nbsp;</div>';
										}
									}
								}
								htmlExaminationStatus += '</div>';
								htmlSettlementStatus += '</div>';
								htmlOrderStatus += '</div>';
								htmlTotalAmount += '</div>';
								htmlQuantity += '</div>';
								htmlServiceDivision += '</div>';
								htmlDetailNo += '</div>';	
								htmlThumbnail += '</div>';
								htmlPrintStatus += '</div>';
								htmlCheckTargetId += '</div>';
								htmlAddrPrint += '</div>';
								htmlPostProxy += '</div>';
							}
						})
						if(number%2==0){
							html += '<tr class="tbunderline prop odd">';
						}else{
							html += '<tr class="tbunderline prop even">';
						}
			<g:if test="${role != 'print'}">
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlCheckTargetId;
						html += '</td>';
			</g:if>
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.orderDate) + '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.lastUpdated) + '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div><div class="tbpadding">';
<%--★						html += '<a onclick="return test(this.href)" href="';
						html += '<g:createLink controller="orderInfo" action="show"></g:createLink>';
						html += '/' + OrderInfo.id + '">' + turnNull(OrderInfo.orderNo) + '</a></div></div></td>';
--%>
						html += turnNull(OrderInfo.orderNo) + '</div></div></td>';
						<g:set var="showUserAction" value="s3s13" />
						<sec:ifAllGranted roles="AUTHORITY_SELECT_USER">
						<g:set var="showUserAction" value="p3p13" />
						</sec:ifAllGranted>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
						//注文者&email
						html += '<td style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div class="tbpadding"><input type="hidden" id="orderNameInput'+number+'" value="'+OrderInfo.owner+'"/><a onclick="return namelink(this.id)" id="orderName'+number+'" href="<g:createLink controller="toDmfApplication" action="${showUserAction}"></g:createLink>/'+ OrderInfo.owner + '">**********</a></div>';
						html += '</div>';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">**********</div>';
						html += '</td>';
						
						//送付先
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; "><a onclick="return test(this.href)" href="<g:createLink controller="orderInfo" action="view"></g:createLink>/'+ OrderInfo.id + '">**********</a></div>';
						html += '</div>';
						html += '</td>';
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						//注文者&email
						html += '<td style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div style="word-wrap:break-word;word-break:break-all;overflow:hidden;">';
						html += '<div class="tbpadding"><input type="hidden" id="orderNameInput'+number+'" value="'+OrderInfo.owner+'"/><a onclick="return namelink(this.id)" id="orderName'+number+'" href="<g:createLink controller="toDmfApplication" action="${showUserAction}"></g:createLink>/'+ OrderInfo.owner + '">' + HtmlEncode(turnNull(OrderInfo.name)) + '</a></div>';
						html += '</div>';
						html += '<div style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.email)) + '</div>';
						html += '</td>';
						
						//送付先
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += '<div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; "><a onclick="return test(this.href)" href="<g:createLink controller="orderInfo" action="edit"></g:createLink>/'+ OrderInfo.id + '">' + HtmlEncode(turnNull(OrderInfo.destinationAddressState)) + '</a></div>';
						html += '</div>';
						html += '</td>';
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += '<div class="tbpadding">' + turnNull(OrderInfo.settlementMethodId) + '</div>';
							html += '</td>';
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += '<div class="tbpadding hright">' + turnNull(formatNum(OrderInfo.totalAmount)) + '</div>';
							html += '</td>';
						</sec:ifNotGranted>
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlDetailNo;
						html += '</td>';
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlThumbnail;
						html += '</td>';
						</sec:ifAnyGranted>
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlServiceDivision;
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlQuantity;
						html += '</td>';
						
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlAddrPrint;
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlPostProxy;
						html += '</td>';

						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += htmlTotalAmount;
							html += '</td>';
						</sec:ifNotGranted>
						html += '<td style="word-wrap:break-word;word-break:break-all; ">';
						html += htmlOrderStatus;
						html += '</td>';
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += htmlSettlementStatus;
							html += '</td>';
							html += '<td style="word-wrap:break-word;word-break:break-all; ">';
							html += htmlExaminationStatus;
							html += '</td>';
						</sec:ifNotGranted>
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
					$("#pagecount1").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + data.totalCount + "件" +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総合計金額：" + formatNum(data.sumTotalAmount)+ "円");
					$("#pagecount2").html(nowPage + "/" + totalPage+ "ページ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;総件数：" + data.totalCount + "件");
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
			}
			
			//初期化
			$(document).ready( function() {
				//ソートボタンとページングの初期化
				orderInfoListFunc.addEventListner(getOrderInfoList, getOrderInfoList);
				
				if(document.getElementById("autoSearch").value == "true"){
					//遷移前excludeDlItemsの再現
					excludeDlItems = ${excludeDlItemList};
					//遷移前のoffset設定
					orderInfoListPage.offset = ${params?.offset?:0};
					getOrderInfoList();
				}
				
				//updStatusType value set
				var typeVal;
				<g:if test="${params?.dateFilterType <= '1'}" >typeVal = "1";</g:if>
				<g:else>typeVal = "${params?.dateFilterType}";</g:else>
				$('#updStatusType').val(typeVal);
				
			});
			(function($){
				$.fn.back = function(href) {
					var params = null;
					relayLogin(href, params);
				};
				$.fn.name = function(href,name) {
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
			<%-- ★ --%>
			String.prototype.replaceAll = function(s1,s2) {
				return this.replace(new RegExp(s1,"gm"),s2);
			}
			function testlink(id){
				$(id).back(document.getElementById(id).href);
				return false;
			}
		</script>
	</head>
	<body>

	<div class="mainBlock">
			<h1 align="left">受注管理</h1>
			
<g:render template="/common/fragment/flashmessages" />
			<ul class="searchConditionTab">
				<li id="showStdLi" <g:formatBoolean boolean="${params?.searchMode == '0'}" true="class='selected'" false="class=''" />><a href="javascript:void(0)" id="showstdBtn">簡易版</a></li>
				<li id="showExpLi" <g:formatBoolean boolean="${params?.searchMode == '0'}" true="class=''" false="class='selected'" />><a href="javascript:void(0)" id="showexpBtn">詳細版</a></li>
				<li class="sep"></li>
				<li class="searchButtons">
						<a href="javascript:void(0)" id="searchBtn" class="button" onclick="setSearchDefault()" style="width:40px;float:left;"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
						<a href="javascript:void(0)" id="clearSearchConditionBtn" class="button" onclick="setDefault()" style="width:40px;float:left;"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
<!--					<div style="height:19px;">
					</div> -->
				</li>
			</ul>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea" style="padding:4px;border: 1px solid #CCC;clear:both;">
				<g:form method="get" action="search" name="searhCondition">
				<g:hiddenField name="sortKey" value="${params?.sortKey?.encodeAsHTML()}" />
				<g:hiddenField name="sortOrder" value="${params?.sortOrder?.encodeAsHTML()}" />
				<g:hiddenField name="search" value="false" />
				<g:hiddenField name="autoSearch" value="${params?.autoSearch?.encodeAsHTML()}" />
				<g:hiddenField name="pageId" value="recievedOrder" />
				<g:hiddenField name="role" value="${role}" />
				
				<div class="condSectionD" style="overflow:hidden;">
					<div class="condSection" style="float:left;margin-right:4px;width:415px;"><%-- 日付検索 --%>
						<h5>日付検索</h5>
						<table>
							<tr><td><g:radio name="dateGroup" id="dateGroup1" value="0" checked="${params?.dateFilterType == '0'}"/><label for="dateGroup1">注文日</label></td>
							<td>
								<span id="date">
									<input type="text" id="orderDateFrom" name="orderDateFrom" value="${params?.orderDateFrom?.encodeAsHTML()}" />
									～
									<input type="text" id="orderDateTo" name="orderDateTo" value="${params?.orderDateTo?.encodeAsHTML()}" />
								</span>
							</td></tr>
							<tr><td><g:radio name="dateGroup" id="dateGroup2" value="-1" checked="${params?.dateFilterType != '0'}"/><label for="dateGroup2">ステータス更新日</label></td>
							<td>
								<span id="stdate">
									<input type="text" id="statusUpdDateFrom" name="statusUpdDateFrom" value="${params?.statusUpdDateFrom?.encodeAsHTML()}" />
									～
									<input type="text" id="statusUpdDateTo" name="statusUpdDateTo" value="${params?.statusUpdDateTo?.encodeAsHTML()}" />
								</span>
							</td></tr>
							<tr><td>&nbsp;</td>
							<td>
								<select name="updStatusType" id="updStatusType">
									<option value="1">注文ステータス</option>
		<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
									<option value="2">決済ステータス</option>
									<option value="3">審査ステータス</option>
		</sec:ifNotGranted>
									<option value="4">印刷ステータス</option>
								</select>
							</td></tr>
						</table>
					</div>
					
					<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
					<div class="condSection" style="float:left;"><%-- 注文ステータス --%>
						<h5>注文ステータス</h5>
						<table style="width:100%;">
							<tr><td>
								<div style="float:left;width:150px;">
									<g:checkBox id="isSettlemented" name="isSettlemented" value="${params?.isSettlemented?.encodeAsHTML()}"/><label for="isSettlemented">注文済</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isPreOrder" name="isPreOrder" value="${params?.isPreOrder?.encodeAsHTML()}"/><label for="isPreOrder">印刷前</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isPrinting" name="isPrinting" value="${params?.isPrinting?.encodeAsHTML()}"/><label for="isPrinting">印刷中</label>
								</div>
							</td></tr>
							<tr><td>
								<div style="float:left;width:150px;">
									<g:checkBox id="isShipmented" name="isShipmented" value="${params?.isShipmented?.encodeAsHTML()}"/><label for="isShipmented">出荷済み</label>
								</div>
								<div style="float:left;width:150px;">
									<g:checkBox id="isCanceled" name="isCanceled" value="${params?.isCanceled?.encodeAsHTML()}"/><label for="isCanceled">キャンセル済み</label>
								</div>	
							</td></tr>
						</table>
					</div>
					</sec:ifNotGranted>
					
				</div>
				
				<div class="exCondSection" style="<g:formatBoolean boolean="${params?.searchMode == '0'}" true="display: none;" false="" />"><%-- 詳細版 検索条件 --%>
					<div class="condSection" style="width:875px;"><%-- 注文者検索 --%>
						<h5>注文者検索</h5>
						<table>
							<tr class="prop">
								<td>注文No</td>
								<td><input type="text" id="orderNo" name="orderNo" size="25" maxlength="15" value="${params?.orderNo?.encodeAsHTML()}" /></td>
								<td>ご注文者</td>
								<td><span>姓</span><input type="text" id="familyName" name="familyName" size="40" maxlength="128" value="${params?.familyName?.encodeAsHTML()}" /></td>
								<td><span>名</span><input type="text" id="firstName" name="firstName" size="40" maxlength="128" value="${params?.firstName?.encodeAsHTML()}" /></td>
							</tr>
						</table>
					</div>
					
					<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
					<div class="condSection" style="width:820px;"><%-- 決済方法検索 --%>
						<h5>決済方法検索</h5>
						<table>
							<col style="width:80px;">
							<col style="width:60px;">
							<col>
							<tr>
								<td>クレジットカード</td>
								<td><a href="javascript:void(0)" id="ac_credit" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusCredit')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusCredit?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
						<g:each var="item" status="i" in="${settlementStatusCreditList}">
							<span class="chkItem">
								<g:checkBox name="settlementStatusCredit" id="smCredit_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusCredit}"/>
								<label for="smCredit_${i}">${item.name}</label>
							</span>
						</g:each>
								</td>
							</tr>
							<tr>
								<td>銀行振込</td>
								<td><a href="javascript:void(0)" id="ac_bank" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusBank')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusBank?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
						<g:each var="item" status="i" in="${settlementStatusBankList}">
							<span class="chkItem">
								<g:checkBox name="settlementStatusBank" id="smBank_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusBank}"/>
								<label for="smBank_${i}">${item.name}</label>
							</span>
						</g:each>
								</td>
							</tr>
							<tr>
								<td>請求書決済</td>
								<td><a href="javascript:void(0)" id="ac_poi" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusPoi')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusPoi?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
						<g:each var="item" status="i" in="${settlementStatusPoiList}">
							<span class="chkItem">
								<g:checkBox name="settlementStatusPoi" id="smPoi_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusPoi}"/>
								<label for="smPoi_${i}">${item.name}</label>
							</span>
						</g:each>
								</td>
							</tr>
							<tr>
								<td>代金引換</td>
								<td><a href="javascript:void(0)" id="ac_cod" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusCod')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusCod?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
						<g:each var="item" status="i" in="${settlementStatusCodList}">
							<span class="chkItem">
								<g:checkBox name="settlementStatusCod" id="smCod_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusCod}"/>
								<label for="smCod_${i}">${item.name}</label>
							</span>
						</g:each>
								</td>
							</tr>
						</table>
					</div>
					</sec:ifNotGranted>
					
					<div class="condSection" style="width:850px;"><%-- アイテム検索 --%>
						<h5>アイテム検索</h5>
						<table>
							<col style="width:170px;">
							<col style="width:170px;">
							<col style="width:170px;">
							<col style="width:170px;">
	<g:if test="${!itemGenreList?.isEmpty()}">
		<g:set var="outnow" value="${true}" />
		<g:set var="hutad" value="${0}" />
		<g:set var="lastd" value="${false}" />
		<g:set var="i" value="${0}" />
		<g:while test="${!(!outnow && lastd)}">
			<%-- 開始タグ判定 --%>
			<g:if test="${i%4 == 0}">
							<tr>
			</g:if>
			<%-- GenreListからの取得 --%>
			<g:if test="${outnow && (i < itemGenreList.size())}">
				<g:set var="igenre" value="${itemGenreList[i]}" />
			</g:if><g:elseif test="${hutad == 0}">
				<g:set var="hutad" value="${1}" />
			</g:elseif><g:else>
				<g:set var="outnow" value="${false}" />
			</g:else>
			<%-- 出力 --%>
			<g:if test="${hutad == 1}">
				<g:set var="hutad" value="${2}" />
								<td><g:checkBox id="serviceDivisionFuTai" name="serviceDivisionFuTai" value="${params?.serviceDivisionFuTai?.encodeAsHTML()}"/><label for="serviceDivisionFuTai">付帯サービス</label></td>
			</g:if><g:elseif test="${outnow}">
								<td><g:checkBox name="itemGenre" value="${igenre.genreId?.encodeAsHTML()}" checked="${params?.itemGenre?.contains(igenre.genreId)}" id="itm${i}" /><label for="itm${i}">${igenre.genreName?.encodeAsHTML()}</label></td>
			</g:elseif><g:else>
								<td></td>
			</g:else>
			<%-- lastd 判定 --%>
			<g:if test="${(i+1) % 4 == 0}">
				<g:set var="lastd" value="${true}" />
							</tr>
			</g:if><g:else>
				<g:set var="lastd" value="${false}" />
			</g:else>
			<g:set var="i" value="${i+1}" />
		</g:while>
	</g:if><g:else>
							<tr>
								<td><g:checkBox id="serviceDivisionFuTai" name="serviceDivisionFuTai" value="${params?.serviceDivisionFuTai?.encodeAsHTML()}"/><label for="serviceDivisionFuTai">付帯サービス</label></td>
								<td></td><td></td><td></td>
							</tr>
	</g:else>
						</table>
					</div>
					
					<div class="condSection" style="width:870px;"><%-- 審査・印刷ステータス --%>
						<h5>審査・印刷ステータス</h5>
						<table>
							<col style="width:80px;">
							<col style="width:60px;">
							<col>
	<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<tr>
								<td>審査ステータス</td>
								<td><a href="javascript:void(0)" id="ac_examStatus" class="button" onclick="toggleButtonAndCheckState(this, 'examinationStatus')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.examinationStatus?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
		<g:each var="item" status="i" in="${examinationStatusList}">
			<span class="chkItem">
				<g:checkBox name="examinationStatus" id="examStatus_${i}" value="${item.id}" checked="${item.id in params?.examinationStatus}"/>
				<label for="examStatus_${i}">${item.name}</label>
			</span>
		</g:each>
								</td>
							</tr>
	</sec:ifNotGranted>
							<tr>
								<td>印刷ステータス</td>
								<td><a href="javascript:void(0)" id="ac_examStatus" class="button" onclick="toggleButtonAndCheckState(this, 'printStatus')">
									<span class="icon-search"> <g:formatBoolean boolean="${(params?.printStatus?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
								<td>
	<g:each var="item" status="i" in="${printStatusList}">
		<span class="chkItem">
			<g:checkBox name="printStatus" id="printStatus_${i}" value="${item.id}" checked="${item.id in params?.printStatus}"/>
			<label for="printStatus_${i}">${item.name}</label>
		</span>
	</g:each>
								</td>
							</tr>
						</table>
					</div>
					
					<div class="searchButtons" style="text-align: right;">
						<a href="javascript:void(0)" id="searchBtn2" class="button" onclick="setSearchDefault()"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
						<a href="javascript:void(0)" id="clearSearchConditionBtn2" class="button" onclick="setDefault()"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
					</div>
<%--				*** 条件と並べて、検索ボタン下寄せの場合
					<div class="floatingbox" style="overflow:hidden;position:relative;">
						<div class="condSection" style="float:left;width:650px;">
							<h5>Content</h5>
							<table>
								(ry
							</table>
						</div>
						
						<div class="searchButtons" style="float:right;width:100px;position:absolute;bottom:0;right:0;">
							<a href="javascript:void(0)" id="searchBtn2" class="button" onclick="setSearchDefault()"><span class="icon-search">&nbsp;検索&nbsp;</span></a>
							<a href="javascript:void(0)" id="clearSearchConditionBtn2" class="button" onclick="setDefault()"><span class="icon-clearSearchCondition">&nbsp;クリア&nbsp;</span></a>
						</div>
					</div>
--%>
				</div>
				</g:form>
			</div>
			
			<div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;line-height:18px;" id="pageButtonsTop"><%-- paginate --%>
					<div id="pageButtonTop" style="float:left;">
					</div>
					<div  style="float:left;margin-left:20px">
						<span id="pagecount1" ></span>
					</div>
				</div>
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
				<div class="" style="text-align:left;padding:10px 3px;float:left" id="outDtlBtnArea">
					<a href="javascript:void(0)" id="outDtlBtn" class="button"><span class="icon-search">明細ダウンロード</span></a>
					<g:form name="downloadForm" action="downloadDetailData"></g:form>
				</div>
				<div class="" style="text-align:left;padding:10px 3px;float:left;" id="outDtlBtnAreas">
					<sec:ifNotGranted roles ="AUTHORITY_JPOST_USER">
				   		<a href="javascript:void(0)" id="outDtlCsvBtn" class="button"><span class="icon-search">CSVファイルダウンロード</span></a>
						<g:form name="downloadCsvForm" action="downloadDetailDataCsv"></g:form>
					</sec:ifNotGranted>
				</div>
			</sec:ifNotGranted>
				<div class="list" id="searchDiv">
					<table style="table-layout:fixed;">
			<g:if test="${role != 'print'}">
						<col style="width:30px"><!-- check -->
			</g:if>
						<col style="width:80px"> <!-- 注文日 -->
						<col style="width:80px"> <!-- 更新日 -->
						<col style="width:135px"> <!-- 注文No -->
						<col style="width:200px"><!-- ご注文者/E-Mail -->
						<col style="width:50px"><!-- 送付先 -->
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<col style="width:100px"><!-- 決済方法 -->
							<col style="width:80px"><!-- 合計金額 -->
						</sec:ifNotGranted>
						<col style="width:50px"><!-- 明細 No-->
			<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						<col style="width:250px"><!-- デザイン -->
			</sec:ifAnyGranted>
						<col style="width:130px"><!-- サービス区分/商品区分 -->
						<col style="width:68px"><!-- 数量 -->
						
						<col style="width:68px"><!-- あて名 -->
						<col style="width:68px"><!-- 差出 -->
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<col style="width:80px"><!-- 金額 -->
			</sec:ifNotGranted>
						<col style="width:120px"><!-- 注文ステータス -->
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<col style="width:120px"><!-- 決済ステータス -->
							<col style="width:120px"><!-- 審査ステータス -->
			</sec:ifNotGranted>
						<col style="width:120px"><!-- 印刷ステータス/伝票番号 -->
						<thead>
							<tr>
			<g:if test="${role != 'print'}">
								<th rowspan="2" class="vhcenter">
									<g:checkBox id="chkAll" name="chkAll" value="-1" onclick="setAllCheckState2(this.checked);" />
								</th>
			</g:if>
			<g:if test="${params?.sortKey?.encodeAsHTML() == 'orderDate'}">
								<th onclick="noClick('orderDate')" rowspan="2" name="orderDateCol" id="orderDateCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">注文日</a></th>
			</g:if><g:else>
								<th onclick="noClick('orderDate')" rowspan="2" name="orderDateCol" id="orderDateCol" class="vhcenter sortable" ><a href="#">注文日</a></th>
			</g:else>
			<g:if test="${params?.sortKey?.encodeAsHTML() == 'lastUpdated'}">
								<th onclick="noClick('lastUpdated')" rowspan="2" name="lastUpdatedCol" id="lastUpdatedCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">更新日</a></th>
			</g:if><g:else>
								<th onclick="noClick('lastUpdated')" rowspan="2" name="lastUpdatedCol" id="lastUpdatedCol" class="vhcenter sortable" ><a href="#">更新日</a></th>
			</g:else>
			<g:if test="${params?.sortKey?.encodeAsHTML() == 'orderNo'}">
								<th onclick="noClick('orderNo')" rowspan="2" name="orderNoCol" id="orderNoCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">注文No</a></th>
			</g:if><g:else>
								<th onclick="noClick('orderNo')" rowspan="2" name="orderNoCol" id="orderNoCol" class="vhcenter sortable" ><a href="#">注文No</a></th>
			</g:else>
			<g:if test="${params?.sortKey?.encodeAsHTML() == 'userName'}">
								<th onclick="noClick('userName')" name="userNameCol" id="userNameCol" class="vhcenter sortable ${params?.sortOrder?:''}" ><a href="#">ご注文者</a></th>
			</g:if><g:else>
								<th onclick="noClick('userName')" name="userNameCol" id="userNameCol" class="vhcenter sortable" ><a href="#">ご注文者</a></th>
			</g:else>
								<th rowspan="2" class="vhcenter">送付先</th>
								<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
									<th rowspan="2" class="vhcenter">決済方法</th>
									<th rowspan="2" class="vhcenter">合計金額</th>
								</sec:ifNotGranted>
								<th rowspan="2" class="vhcenter">明細No.</th>
			<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<th rowspan="2" class="vhcenter">デザイン</th>
			</sec:ifAnyGranted>
								<th rowspan="2" class="vhcenter">アイテム</th>
								<th rowspan="2" class="vhcenter">数量</th>
								<th rowspan="2" class="vhcenter">あて名</th>
								<th rowspan="2" class="vhcenter">差出</th>
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
								<th rowspan="2" class="vhcenter">金額</th>
								<th colspan="4" class="vhcenter">ステータス</th>
			</sec:ifNotGranted>
			<sec:ifAnyGranted roles ="AUTHORITY_PRINT_USER">
								<th colspan="2" class="vhcenter">ステータス</th>
			</sec:ifAnyGranted>
							</tr>
							<tr>
								<th class="vhcenter">メールアドレス</th>
								
								<th class="vhcenter">注文</th>
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
								<th class="vhcenter">決済</th>
								<th class="vhcenter">審査</th>
			</sec:ifNotGranted>
								<th class="vhcenter">印刷</th>
							</tr>
						</thead>
						<tbody id="OrderInfoListBody" >
						</tbody>
					</table>
				</div>
				<div class="paginateButtons paginateBottomButtons" style="border:0px;" id="pageButtonsBot"> <%-- Pageing Affter --%>
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
<script type="text/javascript" src="${createLink(controller:'javascript', action:'cacheable', id:'ajaxSetup')}"></script>
<jq:jquery>
var formValidator = $("#searhCondition").validate({<%-- 検索ボタン入力チェック --%>
	errorContainer:"#validatorMessageArea",
	errorLabelContainer:"#validatorMessageBox",
	wrapper:"li",
	errorClass: "invalidField",
	groups: {
		date: "orderDateFrom orderDateTo",
		stdate: "statusUpdDateFrom statusUpdDateTo"
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
			case "statusUpdDateFrom":
			case "statusUpdDateTo":
				error.insertAfter($('#stdate'));
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
		},
		statusUpdDateFrom:{
			date:true,
			dateDiff2:true
		},
		statusUpdDateTo:{
			date:true,
			dateDiff2:true
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
		},
		statusUpdDateFrom:{
			date:"日付が正しくありません。",
			dateDiff2:"終了日を開始日以降に入力してください。"
		},
		statusUpdDateTo:{
			date:"日付が正しくありません。",
			dateDiff2:"終了日を開始日以降に入力してください。"
		}
	}
});
$('#showstdBtn').click(function() {
	$('#showStdLi').addClass('selected');
	$('#showExpLi').removeClass('selected');
	
	$('.exCondSection').hide("fast");
});
$('#showexpBtn').click(function() {
	$('#showStdLi').removeClass('selected');
	$('#showExpLi').addClass('selected');
	
	$('.exCondSection').show("fast");
});
function searchBtn_Click(){
	if (formValidator.form()) {
		excludeDlItems = new Array();
		orderInfoListPage.offset = 0;
		getOrderInfoList();
		return false;
	}
}
$('#searchBtn, #searchBtn2').click(searchBtn_Click);
//電話番号（例:010-2345-6789）
jQuery.validator.addMethod("telnum", function(value, element) {
	return this.optional(element) || /^[0-9-]+$/.test(value);
	}, "電話番号を入力してください"
);

function clearSearchConditionBtn_Click() {
	$(".searchConditionFormArea input, .searchConditionFormArea select").each(function(){
		if (this.id == "dateGroup1") {
			this.checked = true;
		} else if(this.name == "updStatusType") {
			$(this).val("1");
		} else if (this.type == "checkbox" || this.type == "radio") {
			this.checked = false;
		} else if(this.type == "select-one") {
			this.value = "null";
		}else{
			$(this).val(""); 
		}
	});
	return false;
}
$("#clearSearchConditionBtn").click(clearSearchConditionBtn_Click);
$("#clearSearchConditionBtn2").click(clearSearchConditionBtn_Click);
<g:if test="${role != 'print'}">
$("#outDtlBtn").click(function() {
	saveExcludeItems(function(){
		document.downloadForm.submit();
	});
});
$("#outDtlCsvBtn").click(function() {
	saveExcludeItems(function(){
		document.downloadCsvForm.submit();
	});
});
</g:if>
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
jQuery.validator.addMethod("dateDiff2", function(value, element) {
	var dateTo = $('#statusUpdDateTo').val();
	var dateFrom = $('#statusUpdDateFrom').val();
	if(!dateTo || dateTo == "" || !dateFrom || dateFrom == ""){
		return true;
	}else{
		return new Date(Date.parse(dateFrom.replace("-", "/"))) <= new Date(Date.parse(dateTo.replace("-", "/")));
	}},"終了日に開始日以降の日付を入力してください。"
);
$(".searchConditionFormArea table tbody tr.prop").evenodd();
$('#orderDateFrom').datepicker({});
$('#orderDateTo').datepicker({});

$('#statusUpdDateFrom').datepicker({});
$('#statusUpdDateTo').datepicker({});
</jq:jquery>
	</body>
</html>
