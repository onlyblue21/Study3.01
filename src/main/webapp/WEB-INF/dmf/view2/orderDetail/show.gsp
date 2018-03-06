<%@ page import="jp.co.reso.oiy.dmol.domain.orderinfo.OrderInfo" %>
<%@ page import="jp.co.reso.oiy.dmol.domain.orderinfo.OrderDetail" %>
<%@ page import="java.text.DecimalFormat" %>
<%
 String strPath = new String();
 strPath = resource(dir:'css/pepper-grinder/images/',file:'');
%>

<html>
<head>
	<meta name="layout" content="dmolBiz" />
	<title>注文明細</title>
</head>
<body>
<script type="text/javascript">
	function goBack(url){
		$.post("goBack",function(data){
			if(data.result == "ok"){
				window.location.href = document.getElementById("returnHref").value;
			}
		});
		return false;
	}
	function goForward(url){
		$.post("goForward",function(data){
			if(data.result=="ok"){
				window.location.href = url;
			}
		});
		return false;
	}
	function orderCancel(){
		//alert(document.getElementById("orderDetailId").value);
		var postId = "orderCancel,";
		var version;
		version = document.getElementById("versionCheck").value;
		if(confirm("注文をキャンセルしますか。")){
			$.post(postId+version,function(data){
				if(data.result == "ok"){
					window.location.reload(true);
					return true;
				}
				return false;
			});
			return true;
		}
		else{
			return false;
		}
	}
	function moneyCancel(){
		//alert(document.getElementById("orderDetailId").value);
		var version;
		version = document.getElementById("versionCheck").value;
		if(confirm("入金を取消しますか。")){
			$.post("moneyCancel,"+version,function(data){
				if(data.result == "ok"){
					window.location.reload(true);
					return true;
				}
				return false;
			});
		}
		else{
			return false;
		}
	}
	function examination(exa){
		//alert(exa);
		//alert(document.getElementById("orderDetailId").value);
		var version;
		version = document.getElementById("versionCheck").value;
		if(confirm(exa + "にしますか。")){
			if(exa == "審査OK"){
				$.post("OK,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					return false;
				});
			}
			else if(exa == "審査NG（通知要）"){
				$.post("NG1,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					return false;
				});
			}
			else if(exa == "審査NG（通知不要）"){
				$.post("NG2,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					return false;
				});
			}
			else if(exa == "審査保留"){
				$.post("HOLD,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					return false;
				});
			}
			return true;
		}
		else{
			return false;
		}
	}
	
	function authority(exa){
		var version;
		version = document.getElementById("versionCheck").value;
		if(confirm(exa + "にしますか。")){
			if(exa == "与信OK"){
				$.post("ssBillOK,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					else {
						oiyAlert(data.message);
					}
					return false;
				});
			}
			else if(exa == "与信中"){
				$.post("ssBillInCreditlimit,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					else {
						oiyAlert(data.message);
					}
					return false;
				});
			}
			else if(exa == "与信審査中"){
				$.post("ssBillInExamination,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					else {
						oiyAlert(data.message);
					}
					return false;
				});
			}
			else if(exa == "与信保留"){
				$.post("ssBillInReservation,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					else {
						oiyAlert(data.message);
					}
					return false;
				});
			}
			else if(exa == "与信NG"){
				$.post("ssBillNG,"+version,function(data){
					if(data.result == "ok"){
						window.location.reload(true);
						return true;
					}
					else {
						oiyAlert(data.message);
					}
					return false;
				});
			}
			return true;
		}
		else{
			return false;
		}
	}
	
	function openWindow(id){
		var url;
		url = "http://tracking.post.japanpost.jp/service/singleSearch.do?searchKind=S002&locale=ja&reqCodeNo1=" + id;
		window.open(url);
		return false;
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
	function reviewConfirm(id){
		var detailNo = document.getElementById("infoNo").innerHTML+"-"+document.getElementById("detailNo").innerHTML;
		var url = document.getElementById(id).href + "?detailNo=" + detailNo;
		$(id).name(url,detailNo);
		return false;
	}
</script>
	<div class="mainBlock">
	<table style="table-layout:fixed;">
		<g:hiddenField name="role" value = "${role.encodeAsHTML()}"></g:hiddenField>
		<input type='hidden' id='versionCheck' value='${orderDetailInstance.version.encodeAsHTML()}'/>
		<col style="width:450px">
		<col style="width:450px">
		<tr></tr>
		<tr>
			<td>
				<a href='javascript:void(0)' id='recievedOrderBtn' onclick='return goBack(this.href)' class='button'><span class='nowrap'>戻る</span></a>&nbsp;&nbsp;&nbsp;&nbsp;		 
				<sec:ifAnyGranted roles ="AUTHORITY_JPMD_MANAGE_USER,AUTHORITY_JPMD_PERSONAL_DATA_USER,AUTHORITY_JPMD_USER">
					<g:if test="${buttonDisplay?.isFuTai?:false == false}">
						<g:if test="${buttonDisplay?.esOK?:false == true}">
						<a href="javascript:void(0)" onclick="return examination('審査OK')" id="cancelOrderBtn" class="button" ${buttonDisplay.buttonDisplayExam1}><span class="nowrap">審査OK</span></a>
						</g:if>
						<g:if test="${buttonDisplay?.esNGNotify?:false == true}">
						<a href="javascript:void(0)" onclick="return examination('審査NG（通知要）')" id="cancelOrderBtn" class="button" ${buttonDisplay.buttonDisplayExam1}><span class="nowrap">審査NG（通知要）</span></a>
						</g:if>
						<g:if test="${buttonDisplay?.esNGNotNotify?:false == true}">
						<a href="javascript:void(0)" onclick="return examination('審査NG（通知不要）')" id="cancelOrderBtn" class="button" ${buttonDisplay?.buttonDisplayExam1}><span class="nowrap">審査NG（通知不要）</span></a>
						</g:if>
						<g:if test="${buttonDisplay?.esInReservation?:false == true}">
						<a href="javascript:void(0)" onclick="return examination('審査保留')" id="cancelOrderBtn" class="button"><span class="nowrap">審査保留</span></a>
						</g:if>
					</g:if>
				</sec:ifAnyGranted>
			</td>
			<td>
				<sec:ifAnyGranted roles ="AUTHORITY_JPMD_MANAGE_USER,AUTHORITY_JPMD_PERSONAL_DATA_USER,AUTHORITY_JPMD_USER">
					<g:if test="${buttonDisplay?.examinationPrint?:false == true}">
						<a onclick="return reviewConfirm(this.id)" href="<g:createLink controller='toDmfApplication' action='s11review'></g:createLink>"  id="reprintBtn" class="button"><span class="nowrap">審査用帳票再印刷</span></a>
					</g:if>
				</sec:ifAnyGranted>
			</td>
		</tr>
		<tr>
			<td style="vertical-align:top;position:relative;">
				<g:if  test="${buttonDisplay?.isFuTai?:false == false}">
				<div class="halfTitle">サムネイル</div>
				<div style="border: solid 1px #ccc;overflow:hidden; margin-bottom:2px;">
					<g:each in="${myPic}" var="d">
						<div class="list" style="float:left;">
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<img src="<g:createLink controller='toDmfApplication' action='s17thumbnail' params='[pageNo: "${d}",orderDetailNo: "${buttonDisplay.searchDetailNo}"]'></g:createLink>"/>
							</sec:ifAnyGranted>
						</div>
					</g:each>
					<div style="center;text-align:center;vertical-align:middle;padding:10px;float:right;width:130px;">
					<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
						<a onclick="return reviewConfirm(this.id)" href="<g:createLink controller='toDmfApplication' action='s17previewpdf'></g:createLink>" id="confirmBtn" class="button"><span class="nowrap">プレビュー用PDF</span></a>
						<br /><br />
						<a onclick="return reviewConfirm(this.id)" href="<g:createLink controller='toDmfApplication' action='s17printpdf'></g:createLink>" id="downloadBtn" class="button"><span class="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;印刷用PDF&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
					</sec:ifAnyGranted>
					</div>
				</div>
				</g:if>
				<div class="halfTitle">注文者情報</div>
				<g:render template="/common/fragment/flashmessages" />
				<g:hiddenField name="orderDetailId" value="${fieldValue(bean: orderDetailInstance, field: 'id')}"></g:hiddenField>
				<table style="table-layout:fixed;margin-bottom:2px;">
					<tbody>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.enabled.label" default="会員区分" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
									<g:formatBoolean boolean="${orderDetailInstance?.orderInfo?.owner?.userType == 300}" true="非会員" false="会員" />・<g:formatBoolean boolean="${orderDetailInstance?.orderInfo?.corporateUse}" true="法人" false="個人" />
								</sec:ifNotGranted>
								<sec:ifAnyGranted roles ="AUTHORITY_PRINT_USER">
									<g:formatBoolean boolean="${orderDetailInstance?.orderInfo?.corporateUse}" true="法人" false="個人" />
								</sec:ifAnyGranted>
							</td>
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.enabled.label" default="法人区分" /></td>
							<td valign="top"  style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatBoolean boolean="${orderDetailInstance?.orderInfo?.corporateUse}" true="法人" false="個人" /></td>
						</tr> 
						--%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.email.label" default="メールアドレス" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "email")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.zipcode.label" default="郵便番号" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "zipcode")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.address.label" default="住所" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "addressState")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "address1")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "address2")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "address3")}
								<br />
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "address4")}
								</td>
							</sec:ifAnyGranted>
							
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.name.label" default="氏名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "familyName")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "firstName")}
								<%-- 2013/03/04 項目追加 noz --%>
								&nbsp;（
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "familyNameKana")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "firstNameKana")}
								）
								<%-- ここまで --%>
							</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.corporateName.label" default="会社名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "corporateName")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.departmentName.label" default="部署名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "departmentName")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.departmentName.label" default="肩書・役職" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "businessTitle")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.telno.label" default="電話番号" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "telno")}</td>
							</sec:ifAnyGranted>
							
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.nameKana.label" default="氏名(かな)" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "familyNameKana")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "firstNameKana")}
							</td>
						</tr>
						--%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.npCustomerId.label" default="請求書決済顧客ID" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo.owner?.npCustomer, field: "npCustomerId")}
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;">請求書NP取引ID</td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${orderDetailInstancePlus?.npTransactionId?:''}
							</td>
						</tr>
					</tbody>
				</table>
				<div class="halfTitle">お届け先情報</div>
				<table style="table-layout:fixed;margin-bottom:2px;">
					<tbody>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationZipcode.label" default="郵便番号" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationZipcode")}</td>
							</sec:ifAnyGranted>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationAddressState.label" default="住所" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								**********
								</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationAddressState")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationAddress1")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationAddress2")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationAddress3")}
								<br />
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationAddress4")}
							</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationName.label" default="氏名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								**********
								</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance.orderInfo, field: "destinationFamilyName")}
								${fieldValue(bean: orderDetailInstance.orderInfo, field: "destinationFirstName")}
								<%-- 2013/03/04 項目追加 noz --%>
								&nbsp;（
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationFamilyNameKana")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationFirstNameKana")}
								）
								<%-- ここまで --%>
							</td>
							</sec:ifAnyGranted>
							
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationCorporateName.label" default="会社名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top"  style="word-wrap:break-word;word-break:break-all;width: 75%; "class="value" >**********</td>							
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top"  style="word-wrap:break-word;word-break:break-all;width: 75%; "class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationCorporateName")}</td>			
							</sec:ifAnyGranted>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationDepartmentName.label" default="部署名" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>							
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationDepartmentName")}</td>	
							</sec:ifAnyGranted>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.departmentName.label" default="肩書・役職" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationBusinessTitle")}</td>						
							</sec:ifAnyGranted>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationTelno.label" default="電話番号" /></td>
							<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >**********</td>						
							</sec:ifNotGranted>
							<sec:ifAnyGranted roles="AUTHORITY_PERSONAL_DATA">
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationTelno")}</td>						
							</sec:ifAnyGranted>
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderInfo.destinationNameKana.label" default="氏名(かな)" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationFamilyNameKana")}
								${fieldValue(bean: orderDetailInstance?.orderInfo, field: "destinationFirstNameKana")}
							</td>
						</tr>
						--%>
					</tbody>
				</table>
				<div class="dummy" style="padding:4px;">
					&nbsp;
				</div>
				<div style="padding:4px;position:absolute;bottom:0;">
					<input type='hidden' id='returnHref' value='<g:createLink controller="${gControll}" action="${gAction}"></g:createLink>${gAction2}'/>
					<a href='javascript:void(0)' id='recievedOrderBtn' onclick='return goBack(this.href)' class='button' style="font-size:10px;"><span class='nowrap'>　戻る　</span></a>
				</div>
			</td>
			<td style="vertical-align:top;position:relative;">
				<div class="halfTitle" style="width:457px;height:31px;padding:0;overflow:hidden;">
					<div class="halfTitle2">注文内容
<%--						&nbsp;&nbsp;<a href='javascript:void(0)' id='recievedOrderBtn2' onclick='return goBack(this.href)' class='button'><span class='nowrap'>　戻る　</span></a>--%>
					</div>
					<div class="rightTitle2">
						<sec:ifAnyGranted roles ="AUTHORITY_JPMD_MANAGE_USER,AUTHORITY_JPMD_PERSONAL_DATA_USER,AUTHORITY_JPMD_USER">
							<g:if test="${buttonDisplay?.cancel?:false == true}">
								<a href="javascript:void(0)" onclick="return orderCancel()" id="cancelOrderBtn" class="button rightTitle2" style="background-image:url(<%= strPath %>ui-bg_fine-grain_68_ff0000_60x60.png);color:white;" onmouseover="this.style.backgroundImage='url(<%= strPath %>ui-bg_fine-grain_65_654b24_60x60.png)'" onmouseout="this.style.backgroundImage='url(<%= strPath %>ui-bg_fine-grain_68_ff0000_60x60.png)'" onmouseover="this.style.backgroundImage='url(<%= strPath %>ui-bg_fine-grain_68_ff0000_60x60.png)'"><span class="nowrap">&nbsp;注文キャンセル&nbsp;</span></a>
							</g:if>
						</sec:ifAnyGranted>
					</div>
				</div>
				<table style="table-layout:fixed;margin-bottom:2px;">
					<tbody>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderInfo.orderNo.label" default="注文No" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value"  id="infoNo">${fieldValue(bean: orderDetailInstance?.orderInfo, field: "orderNo")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderInfo.detailNo.label" default="明細No" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value"  id="detailNo">${fieldValue(bean: orderDetailInstance, field: "detailNo")}</td>
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.serviceDivisionName.label" default="サービス区分" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${orderDetailInstancePlus.serviceDivisionName}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.myProductName.label" default="マイプロダクト" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "myProductNo")}&nbsp;&nbsp;${fieldValue(bean: orderDetailInstance, field: "myProductName")}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.mySpecName.label" default="マイスペック" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "mySpecNo")}&nbsp;&nbsp;${fieldValue(bean: orderDetailInstance, field: "mySpecName")}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.myLibraryName.label" default="マイライブラリ" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "myLibraryNo")}&nbsp;&nbsp;${fieldValue(bean: orderDetailInstance, field: "myLibraryName")}</td>
						</tr>
						--%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.targetProduct.label" default="アイテム" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "targetProduct")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.paperType.label" default="用紙" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "paperType")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.paperSize.label" default="サイズ" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "paperSize")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.colorType.label" default="色数" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "colorType")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.futaiServiceName.label" default="付帯サービス" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "futaiServiceName")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.modifyType.label" default="加工" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "modifyType")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.quantity.label" default="数量" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "quantity")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.addressPrintFlg.label" default="あて名印字" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
	<g:if test="${orderDetailInstance?.addressPrintFlg}">
							${fieldValue(bean: orderDetailInstance, field: "addressPrintQuantity")}件
							&nbsp;&nbsp;手数料：${fieldValue(bean: orderDetailInstance, field: "addressPrintFee")}円
	</g:if>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.postingProxyFlg.label" default="差出代行" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
	<g:if test="${orderDetailInstance?.postingProxyFlg}">
							${fieldValue(bean: orderDetailInstance, field: "postingProxyQuantity")}件
							&nbsp;&nbsp;手数料：${fieldValue(bean: orderDetailInstance, field: "postingProxyFee")}円
							&nbsp;&nbsp;郵便料金：${fieldValue(bean: orderDetailInstance, field: "postingProxyAmount")}円
	</g:if>
							</td>
						</tr>
						<%-- 2013/03/01 項目追加 noz --%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.addressListName.label" default="タウン差出代行" /></td>
							<td valign="top" class="value" >
	<g:if test="${orderDetailInstancePlus?.townSendFlg}">
								<a onclick="return reviewConfirm(this.id)" id="towncsvDownload" href="<g:createLink controller='toDmfApplication' action='${deliveryorderUrl}'></g:createLink>" >
									<g:formatNumber number="${orderDetailInstancePlus?.townSendQuantity}" format="###,##0" />件
								</a>
								&nbsp;&nbsp;手数料：<g:formatNumber number="${orderDetailInstancePlus?.townSendAmount}" format="###,##0" />円
	</g:if>
							</td>
						</tr>
						<%-- ここまで --%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.deliveryRequestType.label" default="希望納期" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "deliveryRequestType")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.deliveryRequestType.label" default="オプション追加納期" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
							<g:if test="${orderDetailInstancePlus?.optionTotalDelivery}"><g:formatNumber number="${orderDetailInstancePlus?.optionTotalDelivery}" format="###,##0" />日</g:if></td>
						</tr>
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderInfo.settlementMethodId.label" default="決済方法" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
									<g:if test="${orderDetailInstance.orderInfo.settlementMethodId == '01'}" >
										銀行振込&nbsp;&nbsp;入金確認日：<g:formatDate date="${orderDetailInstance.recieptDate}" format="yyyy/MM/dd HH:mm:ss" />
									</g:if>
									<g:if test="${orderDetailInstance.orderInfo.settlementMethodId == '02'}" >
										クレジット決済&nbsp;&nbsp;カード会社：${orderDetailInstancePlus.cardCorporateName}
									</g:if>
									<g:if test="${orderDetailInstance.orderInfo.settlementMethodId == '03'}" >
										請求書払い
									</g:if>
									<g:if test="${orderDetailInstance.orderInfo.settlementMethodId == '04'}" >
										代引き&nbsp;&nbsp;入金確認日：<g:formatDate date="${orderDetailInstance.recieptDate}" format="yyyy/MM/dd HH:mm:ss" />
									</g:if>
								</td>
							</tr>
						</sec:ifNotGranted>
					</tbody>
				</table>

				<table style="table-layout:fixed;margin-bottom:2px;">
					<tbody>
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER"> <%-- office, jpost --%>
						<%-- 2013/03/01 項目追加 noz --%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.orderFixedDate.label" default="注文受付日" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.orderInfo.orderDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						<%-- ここまで --%>
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.orderFixedDate.label" default="注文確定日" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.orderFixedDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.recieptDate.label" default="入金日" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.recieptDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
							</tr>
						</sec:ifNotGranted>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.printDataAcceptanceDate.label" default="入稿完了日" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.printDataAcceptanceDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.printOrderAcceptanceDate.label" default="印刷会社受付確定日" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.printOrderAcceptanceDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						--%>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.printShipScheduledDate.label" default="出荷予定日" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.printShipScheduledDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.shippingDate.label" default="出荷日" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatDate date="${orderDetailInstance.shippingDate}" format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.orderStatus.label" default="注文ステータス" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><a onclick="return goForward(this.href)" href="<g:createLink controller="orderDetail" action="status" id="${detailId}"></g:createLink>">${orderDetailInstancePlus.orderStatusName}</a>&nbsp;<g:formatDate date="${orderDetailInstance?.orderStatusUpdated}"  format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
						<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.settlementStatus.label" default="決済ステータス" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${orderDetailInstancePlus.settlementStatusName}&nbsp;&nbsp;<g:formatDate date="${orderDetailInstance?.settlementStatusUpdated}"  format="yyyy/MM/dd HH:mm:ss" />
							<g:if test="${orderDetailInstance.settlementError}">
									<p>${orderDetailInstance.settlementError}</p>
							</g:if>
								</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.examinationStatus.label" default="審査ステータス" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${orderDetailInstancePlus.examinationStatusName}&nbsp;&nbsp;<g:formatDate date="${orderDetailInstance?.examinationStatusUpdated}"  format="yyyy/MM/dd HH:mm:ss" /></td>
							</tr>
						</sec:ifNotGranted>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.printStatus.label" default="印刷ステータス" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${orderDetailInstancePlus.printStatusName}&nbsp;&nbsp;<g:formatDate date="${orderDetailInstance?.printStatusUpdated}"  format="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>
					</tbody>
				</table>

				<table style="table-layout:fixed;margin-bottom:2px;">
					<tbody>
			<sec:ifNotGranted roles ="AUTHORITY_PRINT_USER">
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderInfo.printAmount.label" default="印刷料" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "printAmount")}円</td>
							</tr>						
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.mailAmount.label" default="郵券代" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "mailAmount")}円</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.futaiServiceAmount.label" default="付帯サービス料" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "futaiServiceAmount")}円</td>
							</tr>

							<%-- 2013/03/01 項目追加 noz --%>
							<tr class="prop">
								<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.futaiServiceAmount.label" default="オプション料" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" ><g:formatNumber number="${orderDetailInstancePlus?.optionTotalAmount}" format="###,##0" />円</td>
							</tr>
							<%-- ここまで --%>

							<tr class="prop">
								<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.handbillBreakFee.label" default="折り加工料" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "handbillBreakFee")}円</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.cashOnDeliveryFee.label" default="代引手数料" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "cashOnDeliveryFee")}円</td>
							</tr>
							<tr class="prop">
								<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.totalAmount.label" default="合計金額" /></td>
								<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "totalAmount")}円</td>
							</tr>
			</sec:ifNotGranted>
					</tbody>
				</table>

				<table style="table-layout:fixed;">
					<tbody>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.trackingNumber.label" default="伝票番号" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >
								<g:each in="${trackingNumberSplit}" var="d">
									<li><a href="javascript:viod(0)" onclick = "return openWindow(this.innerHTML)">
									${d}</a></li>
								</g:each>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.serviceNo.label" default="サービスNo" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "serviceNo")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.addressListName.label" default="あて名リスト名" /></td>
						<sec:ifAnyGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value" ><a onclick="return reviewConfirm(this.id)" id="csvDownload" href="<g:createLink controller='toDmfApplication' action='s17addresslist'></g:createLink>" >${fieldValue(bean: orderDetailInstance, field: "addressListName")}</a></td>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles ="AUTHORITY_PERSONAL_DATA">
							<td valign="top" class="value" >${fieldValue(bean: orderDetailInstance, field: "addressListName")}</td>
						</sec:ifNotGranted>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.addressListFont.label" default="あて名フォント" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "addressListFont")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.addressListFont.label" default="デザイン面テンプレート" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "designItemNo")}</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name" style="width: 35%;"><g:message code="orderDetail.addressListFont.label" default="あて名面テンプレート" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "atenaItemNo")}</td>
						</tr>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.productSetId.label" default="商品セットID" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "productSetId")}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.colorTypeId.label" default="色数ID" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "colorTypeId")}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.deliveryId.label" default="納期ID" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "deliveryId")}</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.printCost.label" default="印刷料(印刷会社原価)" /></td>
							<td valign="top" style="word-wrap:break-word;word-break:break-all;width: 75%; " class="value" >${fieldValue(bean: orderDetailInstance, field: "printCost")}円</td>
						</tr>
						--%>
						<%-- 2013/03/01 項目削除 noz
						<tr class="prop">
							<td valign="top" class="name" style="width: 25%;"><g:message code="orderDetail.optionAmount1.label" default="オプション" /></td>
							<td>
								<table style="table-layout:fixed;border-collapse:collapse;border:1">
									<tr>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">ＩＤ</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">料金</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">枚数</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">納期</td>
									</tr>
									<tr>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">
										${fieldValue(bean: orderDetailInstance, field: "optionId1")}
										</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">&nbsp;
										<g:if test="${orderDetailInstance.optionId1}">
										${fieldValue(bean: orderDetailInstance, field: "optionCost1")}円
										</g:if>
										</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">&nbsp;
										<g:if test="${orderDetailInstance.optionId1}">
										${fieldValue(bean: orderDetailInstance, field: "optionQuantity1")}件
										</g:if>
										</td>
										<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">&nbsp;
										<g:if test="${orderDetailInstance.optionId1}">
										${fieldValue(bean: orderDetailInstance, field: "optionDelivery1")}日
										</g:if>
										</td>
									</tr>
									<g:if test="${orderDetailInstance.optionId2}">
										<tr>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionId2")}</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionCost2")}円</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionQuantity2")}件</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionDelivery2")}日</td>
										</tr>
									</g:if>
									<g:if test="${orderDetailInstance.optionId3}">
										<tr>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionId3")}</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionCost3")}円</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionQuantity3")}件</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionDelivery3")}日</td>
										</tr>
									</g:if>
									<g:if test="${orderDetailInstance.optionId4}">
										<tr>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionId4")}</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionCost4")}円</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionQuantity4")}件</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionDelivery4")}日</td>
										</tr>
									</g:if>
									<g:if test="${orderDetailInstance.optionId5}">
										<tr>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: center;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionId5")}</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionCost5")}円</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionQuantity5")}件</td>
											<td valign="top" class="name" style="width: 25%;padding:0px;text-align: right;border:1px solid #CCCCCC">${fieldValue(bean: orderDetailInstance, field: "optionDelivery5")}日</td>
										</tr>
									</g:if>
								</table>
							</td>
						</tr>
						--%>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	</div>
<jq:jquery>
$("table tbody tr.prop").evenodd();
</jq:jquery>
</body>
</html>
