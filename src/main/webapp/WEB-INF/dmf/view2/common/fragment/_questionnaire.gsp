		  <h3 class="align_left" style="font-size: 14px;">アンケート:</h3>
		  <g:set var="jpValue" value="郵便局からのご案内" />
		<!-- <g:set var="ybValue" value="郵便局社員からのご案内" />-->
		  <g:set var="hpValue" value="ゆうびんホームページ" />
		  <g:set var="fyValue" value="チラシ" />
		  <g:set var="newValue" value="新聞" />
		  <g:set var="mzValue" value="雑誌" />
		  <g:set var="iaValue" value="インターネット広告" />
		  <g:set var="seValue" value="検索エンジン" />
		  <g:set var="dmValue" value="DM" />
		  <g:set var="rvValue" value="クチコミ" />
		  <g:set var="otValue" value="その他" />
		   <table cellpadding="0" cellspacing="0" class="commonTable2 w664 mB5" >
	   		<tr>
	   			<td class="tdborder" style="width:200px;vertical-align:top" >
	   			
	   				<ul style="list-style:none;width:180px;">
						<li style="float:left;font-size:14px">DMファクトリーをご利用・お知りになったきっかけ</li>
						<li style="color:#FF0000;clear:left;font-size:10px">※該当するものを選択してください。</li>
						<li style="width:30px; background-color: #FF0000;color: #FFFFFF;text-align:center;float:left;font-size:10px" >任意</li>
					</ul>
	   			</td>
	   			
	   			<td style="vertical-align:top;">
	   			<ul style="list-style:none" class="enqUl">
	   			<li><input type="radio" id="settlementJp" name="settlement" value="${jpValue.encodeAsHTML()}"/><label for="settlementJp">郵便局からのご案内</label></li>
	   			<li><input type="radio" id="settlementHomePage" name="settlement" value="${hpValue.encodeAsHTML()}" /><label for="settlementHomePage">ゆうびんホームページ</label></li>
	   			<li><input type="radio" id="settlementFlyer" name="settlement" value="${fyValue.encodeAsHTML()}" /><label for="settlementFlyer">チラシ</label></li>
	   			<li><input type="radio" id="settlementNews" name="settlement" value="${newValue.encodeAsHTML()}" /><label for="settlementNews">新聞</label></li>
	   			<li><input type="radio" id="settlementMagazine" name="settlement" value="${mzValue.encodeAsHTML()}" /><label for="settlementMagazine">雑誌</label></li>
	   			</ul>
	   				
	   			</td>
	   		    <td style="vertical-align:top;">
	   			<ul style="list-style:none" class="enqUl">
	   			<li> <input type="radio" id="settlementInternetAdvertising" name="settlement" value="${iaValue.encodeAsHTML()}" /><label for="settlementInternetAdvertising">インターネット広告</label></li>
	   			<li><input type="radio" id="settlementSearchEngine" name="settlement" value="${seValue.encodeAsHTML()}" /><label for="settlementSearchEngine">検索エンジン</label></li>
	   			<li><input type="radio" id="settlementDM" name="settlement" value="${dmValue.encodeAsHTML()}" /><label for="settlementDM">DM</label></li>
	   			<li><input type="radio" id="settlementReviews" name="settlement" value="${rvValue.encodeAsHTML()}" /><label for="settlementReviews">クチコミ</label></li>
	   			<li><input type="radio" id="settlementOther" name="settlement" value="${otValue.encodeAsHTML()}" /><label for="settlementOther">その他</label>	</li>
	   			</ul>
                 <br>
	   			</td>
	   		</tr>
	   			<tr class="row">
	   			<td class="tdbottomborder enqTableSelectWrap" colspan="3" style="">
	   				<div>
						<h3>本サービスを案内された郵便局を選択してください。</h3>
						
						<table class="enqTableIn" cellpadding="0" cellspacing="0">
							<tr>
								<th>郵便番号から<br />さがす</th>
								<td>
									<div>ハイフンなしの7桁の半角数字を入力してください。　例）1008798</div>
									<div><input id ="searchZip"  type="txt" class="formS textForm" /><input type="image"  class= "searchDate" id ="searchByZip" src="${resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_kensaku.gif" alt="検索" /></div>
								</td>
							</tr>
							<tr>
								<th>局名からさがす</th>
								<td>
									<div>一部分の言葉で検索できます。</div>
									<div><input id ="searchNm" type="txt" class="formL textForm" /><input type="image" class= "searchDate" id ="searchByNm" src="${resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_kensaku.gif" alt="検索" /></div>
								</td>
							</tr>
							<tr>
								<th>住所からさがす</th>
								<td>
									<div>一部分の言葉で検索できます。都道府県は必ず選択してください。</div>
									<div>
										<g:select id="address" name="address" 
											from="${stateList}"
											noSelection="${['':'都道府県選択']}"
											optionKey="name" optionValue="name" >
										</g:select>
										
									</div>
									<div><input id ="searchAddress" type="txt" class="formL textForm" /><input type="image" class= "searchDate" id ="searchByAddress" src="${resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_kensaku.gif" alt="検索" /></div>
								</td>
							</tr>
							<tr>
								<th>局所コードから<br />さがす</th>
								<td>
									<div>
										局所コード6桁を入力してください。<br />
										局所コードをご存知でない方は、上記の郵便番号・局名・住所のいずれかで<br />
										検索してください。
									</div>
									<div><input id ="searchNo" type="txt" class="formL textForm" /><input type="image" class= "searchDate" id ="searchByNo" src="${resource(dir:'/static/dmol/users/images',file:'3rd')}/btn_kensaku.gif" alt="検索" /></div>
								</td>
							</tr>
						</table>
						
						<div class="resultsWrap">
							<h3 id ="searchShow">【該当の郵便局をクリックしてください】</h3>
							<h3 id ="searchHidd" style="color: #ff0000;display: none">【該当の郵便局が見当たりません】</h3>
							<h3 id ="searchMax" style="color: #ff0000;display: none">【検索結果が100件を超えています。範囲を絞り込んでもう一度検索してください】</h3>
							<ul id ="ulDate">
							<!-- 	<li><input type="radio" class="radio" name="ra" id="r1" value="銀座郵便局（東京都）" /><label for="r1">銀座郵便局（東京都）</label></li>
								<li><input type="radio" class="radio" name="ra" id="r2" value="選択項目2" /><label for="r2">選択項目2</label></li>
								<li><input type="radio" class="radio" name="ra" id="r3" value="選択項目3" /><label for="r3">選択項目3</label></li> -->
							</ul>
							
						</div>
					</div>
	   			</td>
	   		</tr>
			<tr class="row">
				<td class="tdbottomborder tdborder size14">選択した郵便局名</td>
				<td class="tdbottomborder pL15" colspan="2"><div id="tenpoSelected" class="tenpoSelected">　</div></td>
			</tr>
			<tr class="row">
				<td class="tdbottomborder tdborder size14">部署名・担当者名を<br />ご記入ください。</td>
				<td class="tdbottomborder pL15" colspan="2"><input type="text" id="salesPerson"class="commonFormL" /></td>
			</tr>
			<tr class="row2">
				<td class="tdbottomborder tdborder size14">「その他」の内容を<br />入力してください。</td>
				<td class="tdbottomborder pL15" colspan="2"><textarea class="textareaL" id="myField" name="myField"></textarea></td>
			</tr>
	   	</table>
	   	<br>
	   	<input type="hidden" id="settlementValue" value="" />
	   	<input type="hidden" id="settlementId" value="" />
	   	<input type="hidden" id="settlementPostCd" value="" />
	   	<jq:jquery>
	   		 $(".searchDate").click(function() {
			  var param = {};
			  var type = this.id;
			  param.type = type;
			  if(type =="searchByZip") {
			  	param.searchNo = $("#searchZip").val();
			  	$("#searchNm").val("");
			  	$("#searchAddress").val("");
			  	$("#searchNo").val("");
			  } else if(type =="searchByNm") {
			  	param.searchNo = $("#searchNm").val();
			    $("#searchZip").val("");
			  	$("#searchAddress").val("");
			  	$("#searchNo").val("");
			  } else if(type =="searchByAddress"){
			  	param.area = $("#address").find("option:selected").val();
			  	param.searchNo = $("#searchAddress").val();
			  	$("#searchZip").val("");
			  	$("#searchNm").val("");
			  	$("#searchNo").val("");
			  } else if(type =="searchByNo"){
			  	param.searchNo = $("#searchNo").val();
			  	$("#searchZip").val("");
			  	$("#searchNm").val("");
			  	$("#searchAddress").val("");
			  }
			  $.post("searchDate", param, function (data) {
			  	 $("#ulDate").empty();
			  	 $("#settlementPostCd").val("");
			  	 $("#tenpoSelected").text("");	
			  	 if(data.length == 0) {
			  	   $("#searchShow").css("display","none");
			  	   $("#searchMax").css("display","none");
			  	   $("#searchHidd").css("display","block");
			  	   $("#ulDate").append("<li><input type='radio' class='radio' name='ra' id='r1' value='' /><label for='r1' >&nbsp;</label></li>");
			  	   $(".radio")[0].focus();
			  	 } else if(data.length < 100){
			  	  $.each(data, function(i, OrderInfo) {
			  	  var index = i+1
			  	  var id = 'r' + index;
			  	  var officeNm = OrderInfo.kyokuName + "（" + OrderInfo.area + "）";
			  	  var value = OrderInfo.kyokusyoCode;
			  	  if (type =="searchByZip" || type =="searchByNo") {
			  	  	$("#ulDate").append("<li><input type='radio' class='radio' name='ra' id="+ id +" value='"+value+"' /><label for='"+id+"' class='selected'>"+officeNm+"</label></li>");
			  	  	$("#tenpoSelected").text(OrderInfo.kyokuName);	
			  	  } else{
			  	  	$("#ulDate").append("<li><input type='radio' class='radio' name='ra' id="+ id +" value='"+value+"' /><label for='"+id+"' >"+officeNm+"</label></li>");
			  	  }
			  	  $(".radio")[0].focus();
			      })
			      $("#searchShow").css("display","block");
			  	  $("#searchHidd").css("display","none");
			  	  $("#searchMax").css("display","none");
			  	} else{
			  	  $("#searchShow").css("display","none");
			  	  $("#searchMax").css("display","block");
			  	  $("#searchHidd").css("display","none");
			  	  $("#ulDate").append("<li><input type='radio' class='radio' name='ra' id='r1' value='' /><label for='r1' >&nbsp;</label></li>");
			  	  $(".radio")[0].focus();
			  	}
			  	itemDate();
			  });
			});
	   	
			
	   		var settlementTypes = $("input:radio[name='settlement']");
	   		
	   		function itemDate(){
	   			  	$("input[type='radio']").change(function(){
				  $("input[type='radio'][name='ra']").each(function(){
					if($(this).is(":checked")){
					  $(this).next().addClass("selected");
						var data = $(':radio[name="ra"]:checked').next().text();
						$("#tenpoSelected").text(data.substring(0,data.length-5));	
						document.getElementById("settlementPostCd").value=this.value;
					}else{
					  $(this).next().removeClass("selected");
					}
				  });
				});
	   		}
			
	   		$(document).ready(function(){
	   			if(document.getElementById("settlementId").value=="settlementJp"){
	   				$(".row").show();
	   			}else{
	   		    	$(".row").hide();
					document.getElementById("settlementValue").value = "";
					document.getElementById("settlementPostCd").value = "";
				}
	   			if(document.getElementById("settlementId").value=="settlementOther"){
	   				$(".row2").show();
	   			}else{
	   		    	$(".row2").hide();
					document.getElementById("settlementValue").value = "";
					document.getElementById("settlementPostCd").value = "";
				}
			});	
			
			settlementTypes.click(function() {
			    if(this.id=="settlementJp"){
			    	$(".row").show();
			    	$(".row2").hide();
			    	document.getElementById('myField').value="";
			    }else if(this.id=="settlementOther"){
			    	$(".row2").show();
			    	$(".row").hide();
			    	$("#settlementPostCd").val("");
			    	$("#salesPerson").val("");
			    //	document.getElementById('myField').value="";
			    }else{
			    	$(".row").hide();
			    	$(".row2").hide();
			    	$("#settlementPostCd").val("");
			    	$("#salesPerson").val("");
			    	document.getElementById('myField').value="";
			    }
				
			    document.getElementById("settlementId").value = this.id;
				document.getElementById("settlementValue").value = this.value;
				return true;
			});
			
			var textarea = $('textarea[maxlength]');
		textarea.bind(
	    	"keydown keyup click blur",
	    	function(){
	        	var max = $(this).prop('maxlength');
	        	if($(this).val().length > max){
	            	$(this).val($(this).val().substr(0, max));
	        	}
	    	}
		);
	   	</jq:jquery>