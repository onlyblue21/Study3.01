<html>
	<head>
		<meta name="layout" content="dmolBiz" />
		<title>広告審査</title>
		<g:javascript library="jquery" plugin="jquery" />
		<script type="text/javascript" src="${createLinkTo(dir:'static/moon/js',file:'listfunc.js')}"></script>
		<script type="text/javascript" src="${createLinkTo(dir:'static/dmol/js',file:'status.js')}"></script>
		<script>
		
			function HtmlEncode(text)
			{
				if(text != "" && text != null){
					return text.replace(/\"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;'); //"
					}
				else{
					return text;
					}
			}
		(function (bool) {
		    function setInnerText(o, s) {
		        while (o.childNodes.length != 0) {
		            o.removeChild(o.childNodes[0]);
		        }

		        o.appendChild(document.createTextNode(s));
		    }

		    function getInnerText(o) {
		        var sRet = "";

		        for (var i = 0; i < o.childNodes.length; i ++) {
		            if (o.childNodes[i].childNodes.length != 0) {
		                sRet += getInnerText(o.childNodes[i]);
		            }

		            if (o.childNodes[i].nodeValue) {
		                if (o.currentStyle.display == "block") {
		                    sRet += o.childNodes[i].nodeValue + "\n";
		                } else {
		                    sRet += o.childNodes[i].nodeValue;
		                }
		            }
		        }

		        return sRet;
		    }

		    if (bool) {
		        HTMLElement.prototype.__defineGetter__("currentStyle", function () {
		            return this.ownerDocument.defaultView.getComputedStyle(this, null);
		        });

		        HTMLElement.prototype.__defineGetter__("innerText", function () {
		            return getInnerText(this);
		        })

		        HTMLElement.prototype.__defineSetter__("innerText", function(s) {
		            setInnerText(this, s);
		        })
		    }
		})(/Firefox/.test(window.navigator.userAgent));
			$(document).ready( function() {
				bodyOnload();
			});

			// 画面が読み込まれたときの処理
			function bodyOnload() {
				orderInfoListFunc.initList();
				document.getElementById("pageButtonsBot").style.display = "none";
				document.getElementById("pageButtonsTop").style.display = "none";
			}
	
			var orderInfoListFunc = new listFunc("orderInfoListFunc", 10, "orderNo", "asc");

			//１ページの行数の設定
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
			function onCheck(para){
				var tbody = document.getElementById('OrderInfoListBody');
				var colls = tbody.getElementsByTagName( "input"); 
				var collsNumber = tbody.getElementsByTagName("span"); 
				var collnum = colls.length;
				var spanName;
				var spanId;
				for(var i=0;i < collnum;i++){
					spanName = "";
					spanId = "";
					if(colls[i].type.toLowerCase()== "checkbox" && colls[i].style.display.toLowerCase()!= "none"){
						if(para=="true"){
							colls[i].checked = true;
						}
						else{
							colls[i].checked = false;
						}
					}
				}
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
			(function($){
				  $.fn.name = function(href,detailNo)
				  {
				 	var params = {};
				 	params.orderDetailNo=detailNo;
				 	relayLoginMy(href, params);
				  };
				  var relayLoginMy = function(url, params) {
						var form = document.relayLoginForm;
						var relayLoginparams = document.getElementById("relayLoginparams");
						$.post(url, params, function(data, textStatus) {
							if (textStatus == 'success') {
								//pleaseWait();
								var result = data; //jQuery.secureEvalJSON(data);
								if (result.result == 'success') {
									var html = "";
									$.each(result.params, function(key, val) {
										if(val instanceof Array){
											$.each(val, function(name, value) {
												html += '<input type="hidden" name="' + key + '" value="' + value + '" />';
											});
										} else {
											html += '<input type="hidden" name="' + key + '" value="' + val + '" />';
										}
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
			function reviewConfirm(id){
				var r=confirm("実施しますか？");
				if (r==true)
				{
					var tbody = document.getElementById('OrderInfoListBody');
					var colls = tbody.getElementsByTagName( "input");
					var collnum = colls.length;
					var detailNo = "";
					var j = 1;
					var url = document.getElementById("printHref").value;
					for(var i=0;i < collnum;i++){
						if(colls[i].type.toLowerCase()== "checkbox" && colls[i].checked == true){
							if(j==1){
								detailNo = document.getElementById(colls[i].name.split("C")[0]).innerText+"-"+document.getElementById(colls[i].name.replace("C","D")).innerText;
							}else{
								detailNo = detailNo + "," + document.getElementById(colls[i].name.split("C")[0]).innerText+"-"+document.getElementById(colls[i].name.replace("C","D")).innerText;
							}
							j = j + 1;
						}
					}
					//detailNo = "111-11,111,111,222";
					if(detailNo != ""){
						//url = url + detailNo;
						var param = {};
						param.detailNo = detailNo;
						$.post("updateStatus", param, function(data) {
							if(data.result == "ok"){
								$(id).name(url,detailNo);
								getOrderInfoList();
							}
						});
					}
					return false;
				}
				else
				{
					return false;
				}
				return false;
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
				
				param.settlementStatusCredit = $.map($(':checkbox[name="settlementStatusCredit"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodCredit = param.settlementStatusCredit.length > 0;
				param.settlementStatusBank = $.map($(':checkbox[name="settlementStatusBank"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodBank = param.settlementStatusBank.length > 0;
				param.settlementStatusPoi = $.map($(':checkbox[name="settlementStatusPoi"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodPoi = param.settlementStatusPoi.length > 0;
				param.settlementStatusCod = $.map($(':checkbox[name="settlementStatusCod"]:checked'), function(v, n){return $(v).val();});
				param.settlementMethodCod = param.settlementStatusCod.length > 0;
				
				param.serviceDivisionDMOnline = $('#serviceDivisionDMOnline').prop('checked');
				param.serviceDivisionNewYearCard = $('#serviceDivisionNewYearCard').prop('checked');
				param.serviceDivisionKamoMail = $('#serviceDivisionKamoMail').prop('checked');
				param.serviceDivisionFuTai = $('#serviceDivisionFuTai').prop('checked');
				
				param.examinationStatus = $.map($(':checkbox[name="examinationStatus"]:checked'), function(v, n){return $(v).val();});
				param.printStatus = $.map($(':checkbox[name="printStatus"]:checked'), function(v, n){return $(v).val();});
				
				param.orderStatus = $.map($(':checkbox[name="orderStatus"]:checked'), function(v, n){return $(v).val();});
				param.examinationStatus = $.map($(':checkbox[name="examinationStatus"]:checked'), function(v, n){return $(v).val();});
				param.printStatus = $.map($(':checkbox[name="printStatus"]:checked'), function(v, n){return $(v).val();});
<%--
				param.settlementStatus = $('#settlementStatus').val();
				param.isExcludeCancel = $('#isExcludeCancel').prop('checked');
--%>
				$.post("search", param, function(data) {
					orderInfoListFunc.updatePagination(data.totalCount, data.offset);
					var OrderInfoList = data.list;
					var html = "";
					document.getElementById("pageButtonsBot").style.display = "block";
					document.getElementById("pageButtonsTop").style.display = "block";
					var i = 0;
					$.each(data.list, function(i, OrderInfo) {
						i = i + 1;
    					var htmlSettlementMethod = "";
    					var htmlDetailNo = "";
    					var htmlServiceDivision = "";
    					var htmlQuantity = "";
    					var htmlTotalAmount = "";
						var htmlOrderStatus = "";
						var htmlSettlementStatus = "";
						var htmlExaminationStatus = "";
						if(i%2==0){
							html += '<tr class="tbunderline prop odd">';
						}else{
							html += '<tr class="tbunderline prop even">';
						}
						html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
						var h = 0;
    					var row = 1;
    					var divClass = "border-bottom:dashed 1px #ccc;";
						$.each(OrderInfo.details, function(j, OrderDetail) {
							h = h + 1;
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
								if(OrderDetail.showCheckBox == "show"){
									html += '<div class="tbpadding" style="width:100%" align="center"><input name="Y'+i+'C'+h+'" type="checkbox"/>';
									html += '<a id="Y'+i+'L'+h+'" herf="javascript:void(0)"></a></div>';
								}
								else{
									html += '<div class="tbpadding">&nbsp;</div>';
								}
								htmlDetailNo += divClass;
								htmlDetailNo += '<div class="tbpadding tbunderlineorder"  id="Y'+i+'D'+h+'"><a onclick="return setSession(this.href)" class="order" href="<g:createLink controller="orderDetail" action="show"></g:createLink>/' + OrderDetail.id + '">' + turnNull(OrderDetail.detailNo) + '</a></div>';
								
								htmlDetailNo += '</div>';

								htmlServiceDivision += divClass;
								htmlServiceDivision += '<div class="tbpadding">' + turnNull(OrderDetail.serviceDivision) + '</div>';
								htmlServiceDivision += '</div>';
								
								htmlQuantity += divClass;
								htmlQuantity += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.quantity)) + '</div>';
								htmlQuantity += '</div>';
								htmlTotalAmount += divClass;
								htmlTotalAmount += '<div class="tbpadding hright">' + turnNull(formatNum(OrderDetail.totalAmount)) + '</div>';
								htmlTotalAmount += '</div>';
		
								htmlOrderStatus += divClass;
								htmlOrderStatus += '<div class="tbpadding"><a onclick="return setSession(this.href)" href="<g:createLink controller="orderDetail" action="status"></g:createLink>/' + OrderDetail.id + '">' + orderStatus(turnNull(OrderDetail.orderStatus)) + '</a></div>';
								htmlOrderStatus += '</div>';
								
								htmlSettlementStatus += divClass;
								htmlSettlementStatus += '<div class="tbpadding">' + settlementStatus(turnNull(OrderDetail.settlementStatus)) + '</div>';
								htmlSettlementStatus += '</div>';
								
								htmlExaminationStatus += divClass;
								htmlExaminationStatus += '<div class="tbpadding tbunderlineorder">' + turnNull(OrderDetail.examinationStatus) + '</div>';
								htmlExaminationStatus += '</div>';
	
							}
						})
						html += '</td>';
						html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all;" id="Y'+ i + '">' + turnNull(OrderInfo.orderNo) + '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; " class="tbpadding tbunderlineorder">' + turnNull(OrderInfo.orderDate) + '</td>';
						html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.name)) + '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; " class="tbpadding tbunderlineorder">';
						html += '<div class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.email)) + '</div>';
						html += '<div class="tbpadding" style="word-wrap:break-word;word-break:break-all; ">' + turnNull(OrderInfo.telno) + '</div>';
						html += '</td>';
						html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">' + HtmlEncode(turnNull(OrderInfo.destinationAddress1)) +'<br />'+ HtmlEncode(turnNull(OrderInfo.destinationAddress2));
						html += '</td>';
						html += '<td style="word-wrap:break-word;word-break:break-all; " class="tbpadding tbunderlineorder">';
						html += '<div class="tbpadding hright">' + turnNull(formatNum(OrderInfo.totalAmount)) + '</div>';
						html += '</td>';
						
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlDetailNo;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlServiceDivision;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlQuantity;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlTotalAmount;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlOrderStatus;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlSettlementStatus;
						html += '</td>';
    					html += '<td class="tbpadding tbunderlineorder" style="word-wrap:break-word;word-break:break-all; ">';
    					html += htmlExaminationStatus;
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
	<body>
	<div class="mainBlock">
			<h1 align="left">広告審査</h1>
			
<g:render template="/common/fragment/flashmessages" />		
			<div class="searchConditiontoggler"><a id="searchConditiontoggler" class="button" href="javascript:void(0)"><span class="icon-conditiontoggler">検索条件</span></a></div>
			<div class="dialog searchConditionFormArea" id="searchConditionFormArea">
				<g:form method="get" action="search" name="searhCondition">
				<g:hiddenField name="sortKey" value="${params?.sortKey?.encodeAsHTML()}" />
				<g:hiddenField name="sortOrder" value="${params?.sortOrder?.encodeAsHTML()}" />
				<g:hiddenField name="search" value="false"/>
				<g:hiddenField name="autoSearch" value="${params?.autoSearch?.encodeAsHTML()}" />
				<g:hiddenField name="pageId" value="adReview" />
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
							<td class="name">決済方法</td>
							<td class="value">
		<table style="border:0px;">
			<col style="width:80px">
			<col style="width:60px">
			<col>
		<tr >
			<td>クレジットカード</td>
			<td><a href="javascript:void(0)" id="ac_credit" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusCredit')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusCredit?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
			</td>
			<td>
			<g:each var="item" status="i" in="${settlementStatusCreditList}">
				<g:checkBox name="settlementStatusCredit" id="smCredit_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusCredit}"/>
				<label for="smCredit_${i}">${item.name}</label>
			</g:each>
			</td>
		</tr>
		<tr>
			<td class="even">銀行振込</td>
			<td class="even"><a href="javascript:void(0)" id="ac_Bank" class="button" onclick="toggleButtonAndCheckState(this, 'settlementMethodBank')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementMethodBank?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
			</td>
			<td class="even">
			<g:each var="item" status="i" in="${settlementStatusBankList}">
				<g:checkBox name="settlementMethodBank" id="smBank_${i}" value="${item.id}" checked="${item.id in params?.settlementMethodBank}"/>
				<label for="smBank_${i}">${item.name}</label>
			</g:each>
			</td>
		</tr>
		<tr>
			<td>請求書払い</td>
			<td><a href="javascript:void(0)" id="ac_Poi" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusPoi')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusPoi?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
			</td>
			<td>
			<g:each var="item" status="i" in="${settlementStatusPoiList}">
				<g:checkBox name="settlementStatusPoi" id="smPoi_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusPoi}"/>
				<label for="smPoi_${i}">${item.name}</label>
			</g:each>
			</td>
		</tr>
		<tr>
			<td class="even">代引き</td>
			<td class="even"><a href="javascript:void(0)" id="ac_Cod" class="button" onclick="toggleButtonAndCheckState(this, 'settlementStatusCod')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.settlementStatusCod?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a></td>
			</td>
			<td class="even">
			<g:each var="item" status="i" in="${settlementStatusCodList}">
				<g:checkBox name="settlementStatusCod" id="smCod_${i}" value="${item.id}" checked="${item.id in params?.settlementStatusCod}"/>
				<label for="smCod_${i}">${item.name}</label>
			</g:each>
			</td>
		</tr>
		</table>
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
						<tr class="prop">
							<td class="name">注文ステータス</td>
							<td class="value">
		<div style="float: left;margin: 0 15px 0 0;">
			<a href="javascript:void(0)" id="ac_orderST" class="button" onclick="toggleButtonAndCheckState(this, 'orderStatus')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.orderStatus?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a>
		</div>
		<div style="float: left;">
			<g:each var="item" status="i" in="${orderStatusList}">
				<g:checkBox name="orderStatus" id="orderST_${i}" value="${item.id}" checked="${item.id in params?.orderStatus}"/>
				<label for="orderST_${i}">${item.name}</label>
			</g:each>
		</div>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">審査ステータス</td>
							<td class="value">
		<div style="float: left;margin: 0 15px 0 0;">
			<a href="javascript:void(0)" id="ac_examST" class="button" onclick="toggleButtonAndCheckState(this, 'examinationStatus')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.examinationStatus?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a>
		</div>
		<div style="float: left;">
			<g:each var="item" status="i" in="${examinationStatusList}">
				<g:checkBox name="examinationStatus" id="examST_${i}" value="${item.id}" checked="${item.id in params?.examinationStatus}"/>
				<label for="examST_${i}">${item.name}</label>
			</g:each>
		</div>
							</td>
						</tr>
						<tr class="prop">
							<td class="name">印刷ステータス</td>
							<td class="value">
		<div style="float: left;margin: 0 15px 0 0;">
			<a href="javascript:void(0)" id="ac_printST" class="button" onclick="toggleButtonAndCheckState(this, 'printStatus')">
				<span class="icon-search"> <g:formatBoolean boolean="${(params?.printStatus?:[]).size() > 0}" true="全解除" false="全選択"/> </span></a>
		</div>
		<div style="float: left;">
			<g:each var="item" status="i" in="${printStatusList}">
				<g:checkBox name="printStatus" id="printST_${i}" value="${item.id}" checked="${item.id in params?.printStatus}"/>
				<label for="printST_${i}">${item.name}</label>
			</g:each>
		</div>
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
					<a href="javascript:void(0)"  id="getData1" class="button" onclick="return reviewConfirm(this.id)">
					<span class="icon-search">&nbsp;審査用帳票印刷&nbsp;</span></a>
					<a href="<g:createLink controller='adReview' action='uploadFile'></g:createLink>"  id="endJump" class="button">
					<span class="icon-search">&nbsp;審査結果アップロード&nbsp;</span></a>
					</div>
					<div  style="float:left;margin-left:20px">
					<span id="pagecount1" ></span>
					</div>
					<br/>
					<br/>
					<a href="javascript:void(0)"  id="firstJump" class="button" onclick="onCheck('true')">
					<span class="icon-search">&nbsp;全選択&nbsp;</span></a>
					<a href="javascript:void(0)"  id="firstJump" class="button" onclick="onCheck('false')">
					<span class="icon-search">&nbsp;全選択解除&nbsp;</span></a>
				</div>
				<div class="list">
					<table style="table-layout:fixed;">
						<col style="width:50px"> <!-- 印刷 -->
						<col style="width:135px"> <!-- 注文No -->
						<col style="width:80px"> <!-- 注文日 -->
						<col style="width:100px"><!-- ご注文者 -->
						<col style="width:200px"><!-- E-Mail/電話番号 -->
						<col style="width:300px"><!-- 送付先住所 -->
						<col style="width:80px"><!-- 合計金額 -->
						<col style="width:50px"><!-- 明細 No-->
						<col style="width:130px"><!-- サービス区分/商品区分 -->
						<col style="width:50px"><!-- 数量 -->
						<col style="width:80px"><!-- 金額 -->
						<col style="width:100px"><!-- 注文ステータス -->
						<col style="width:100px"><!-- 決済ステータス -->
						<col style="width:120px"><!-- 審査ステータス -->
						<thead>
							<tr>
								<th rowspan="2" class="vhcenter">印刷</th>
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
								<th rowspan="2" class="vhcenter">明細No.</th>
								<th rowspan="2" class="vhcenter">サービス区分</th>
								<th rowspan="2" class="vhcenter">数量</th>
								<th rowspan="2" class="vhcenter">金額</th>
								<th rowspan="2" class="vhcenter">注文ステータス</th>
								<th rowspan="2" class="vhcenter">決済ステータス</th>
								<th rowspan="2" class="vhcenter">審査ステータス</th>
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
					<a href="javascript:void(0)"  id="getData1" class="button" onclick="return reviewConfirm(this.id)">
					<span class="icon-search">&nbsp;審査用帳票印刷&nbsp;</span></a>
					<a href="<g:createLink controller='adReview' action='uploadFile'></g:createLink>"  id="endJump" class="button"">
					<span class="icon-search">&nbsp;審査結果アップロード&nbsp;</span></a>
					</div>
					<div  style="float:left;margin-left:20px">
					<span id="pagecount2" ></span>
					</div>
					
					<input type='hidden' id='printHref' value='<g:createLink controller="toDmfApplication" action="s11review"></g:createLink>'/>
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