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
function profile(){
	var mainfrm = document.mainfrm;
	mainfrm.action = "/profile";
	mainfrm.submit();
}


function profileconfim(){
	var profilefrm = document.profilefrm;
	profilefrm.action = "/profileconfim";
	profilefrm.submit();
	
}





//----------------------------profile------------------------------------------

//----------------------------로그인,회원가입--------------------------------------------
function memberJoin(){
	var mainfrm = document.mainfrm;
	mainfrm.action = "/memberJoin";
	mainfrm.submit();
}




//----------------------------Login--------------------------------------------

function joinvalidate() {
	if (!document.memberjoin.id.value) {
		alert("id를 입력하세요.");
		document.memberjoin.id.focus();
		return false;
	}

	if (!document.memberjoin.pw.value) {
		alert("pw를 입력하세요.");
		document.memberjoin.pw.focus();
		return false;
	}
	
	if (!document.memberjoin.nick_name.value) {
		alert("nick_name을 입력하세요.");
		document.memberjoin.nick_name.focus();
		return false;
	}
	
	if(!document.memberjoin.email.value){
		alert("email을 입력하세요.");
		document.memberjoin.email.focus();
		return false;
	}
	
	return true;
}

//logout
function Logout() {
	var Listfrm = document.Listfrm;
	Listfrm.action = "/Logout";
	Listfrm.submit();
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



