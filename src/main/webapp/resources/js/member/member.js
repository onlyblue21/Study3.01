//Login start
function Joinpage(actionfrm) {
	var Test = confirm("회원 가입 하시겠습니까?");
	if (Test) {
		var actionfrm = document.actionfrm;
		actionfrm.action = "/goJoin";
		actionfrm.id.value = "";
		actionfrm.pw.value = "";
		actionfrm.submit();

	} else {
		return false;
	}
}

//----------------------------profile------------------------------------------
function mypage(){
	var mainfrm = document.mainfrm;
	mainfrm.action = "/mypage";
	mainfrm.submit();
}


function profileconfim(){
	var profilefrm = document.profilefrm;
	profilefrm.action = "/profileconfim";
	profilefrm.submit();
	
}

function mypageModefy(){
	var mypagefrm = document.mypagefrm;
	mypagefrm.action ="/mypagemodify";
	mypagefrm.submit();
}
//----------------------------profile------------------------------------------




//----------------------------memberdelete-------------------------------------
function memberdelete(){
	
}





//-----------------------------------------------------------------------------




//----------------------------Login--------------------------------------------


function joinvalidate() {
	
	if (!document.memberjoin.id.value) {
		alert("id를 입력하세요.");
		document.memberjoin.id.focus();
		return false;
	}

	if (!document.memberjoin.password.value) {
		alert("pw를 입력하세요.");
		document.memberjoin.password.focus();
		return false;
	}
	
	if (!document.memberjoin.user_name.value) {
		alert("user_name을 입력하세요.");
		document.memberjoin.user_name.focus();
		return false;
	}
	
	if(!document.memberjoin.nick_name.value){
		alert("nick_name을 입력하세요.");
		document.memberjoin.nick_name.focus();
		return false;
	}
	if(!document.memberjoin.email.value){
		alert("email을 입력하세요.");
		document.memberjoin.email.focus();
		return false;
	}
	if(!document.memberjoin.phone_num.value){
		alert("phone_num를 입력하세요.");
		document.memberjoin.phone_num.focus();
		return false;
	}
	if(!document.memberjoin.address.value){
		alert("address를 입력하세요.");
		document.memberjoin.address.focus();
		return false;
	}
	if(!document.memberjoin.birth.value){
		alert("생년월일을 입력하세요.");
		document.memberjoin.birth.focus();
		return false;
	}
//	if(!document.memberjoin.sex.value){
//		alert("성별을 입력하세요.");
//		document.memberjoin.sex.focus();
//		return false;
//	}
	if(!document.memberjoin.upload.value){
		alert("프로필 사진을 업로드 하세요.");
		document.memberjoin.upload.focus();
		return false;
	}
	if(!document.memberjoin.upload.value){
		alert("프로필 사진을 업로드 하세요.");
		document.memberjoin.upload.focus();
		return false;
	}
	if(!document.memberjoin.live_nationality.value){
		alert("국적을 선택 하세요.");
		document.memberjoin.live_nationality.focus();
		return false;
	}
	if(!document.memberjoin.city.value){
		alert("거주지역을 선택 하세요.");
		document.memberjoin.city.focus();
		return false;
	}
	if(!document.memberjoin.job.value){
		alert("직업을 선택 하세요.");
		document.memberjoin.job.focus();
		return false;
	}
	if(!document.memberjoin.religion.value){
		alert("종교를 선택 하세요.");
		document.memberjoin.religion.focus();
		return false;
	}
	if(!document.memberjoin.introduction.value){
		alert("자기 소개란을 작성 해주세요.");
		document.memberjoin.introduction.focus();
		return false;
	}
	return true;
	
//	$("document").ready(function() { 
//		  $('textarea[maxlength]').live('keyup change', function() { 
//		   var str = $(this).val() 
//		   var mx = parseInt($(this).attr('maxlength')) 
//		   if (str.length > mx) { 
//		    $(this).val(str.substr(0, mx));
//		     return false; 
//		    } 
//		  }) 
//		 }) 
}

//logout
function logout() {
	var mainfrm = document.mainfrm;
	mainfrm.action = "/logout";
	mainfrm.submit();
}

function addContent() {
	var Listfrm = document.Listfrm;
	Listfrm.action = "/addContent";
	Listfrm.process.value = "add";
	Listfrm.submit();
}

function Joinvalidate() {
	if (!document.Joinfrm.id.value) {
		alert("id를 입력하세요.")
		document.Joinfrm.id.focus();
		return false;
	}
	if (!document.Joinfrm.pw.value) {
		alert("pw를 입력하세요.")
		document.Joinfrm.id.focus();
		return false;
	}
}

function cancle() {
	var Joinfrm = document.Joinfrm;
	Joinfrm.action = "/login";
	Joinfrm.submit();
}
// join end

// addcontent start
function valcheck() {
	if(!document.addcontent.title.value){
		alert("title을 입력하세요.");
		document.addcontent.title.focus();
		return false;
	}
	if (!document.addcontent.content.value) {
		alert("content를 입력하세요.");
		document.addcontent.content.focus();
		return false;
	}
	if (!document.addcontent.reg_id.value) {
		alert("글쓴이를 입력하세요.");
		document.addcontent.reg_id.focus();
		return false;
	}
}
// addcontent end


//Content start
function contentdelete(SEQ){
	
	var cList = document.contentList;
	cList.seq.value = SEQ;
	cList.action= "/contentdelete";
	cList.submit();
}

function contentupdate(SEQ,CONTENT){
	var cList = document.contentList;
	cList.seq.value = SEQ;
	cList.action= "/contentupdate";
	cList.submit();
	
	
	
}
// Content end

//---------------create db user start ---------------------------
function create_db_user(){
	var create_db = document.actionfrm;
	create_db.action = "/create_db_user";
	create_db.submit();
}

//------------- create db board start---------------
function create_db_board(){
	var create_db = document.actionfrm;
	create_db.action = "/create_db_board";
	create_db.submit();
}

//------Content_update start-------------
function Content_update(){
	var c_update = document.Listfrm;
	c_update.action = "/c_update";
	c_update.submit();
}

//------Content_delete start-------------
function Content_delete(){
	var c_delete = document.Listfrm;
	c_delete.action = "/c_delete";
	c_delete.submit();
}
//------------------------------------





/*function idcheck(){
	
	var data=new Object();
	data.type=$("#id").attr("id");
	data.value=$("#id").val();
	var param =JSON.stringify(data);
	console.log(param);
	
	var success = function(json){
		console.log(json);
		if(json.size>0){
		
			        	
		}
	}
	_ajax("post","/ajax","json",param,success);
}*/


/*function idCheck(){
	
	var idText = document.getElementById("id").value;
	var span = document.getElementById("result");
	if(idText.length < 8){
		span.innerHTML = "ID는 8글자 이상 입력하세요.";
	}else{
		span.innerHTML="";
		
		if(window.ActiveXObject){
			xhr = new XMLHttpRequest("Microsoft.XMLHTTP");
			
		}else{
			xhr = new XMLHttpRequest();
		}
		
		xhr.open("POST","/javascript/AjaxServlet",true);
		xhr.onreadystatechange = callback();
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		xhr.send("command=idDupCheck&id="+idtext);
	}
}*/



