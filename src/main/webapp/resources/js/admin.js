function deleteSvc(){
    	if($('input:checkbox[name="memberSeqs"]:checked').length < 1){
    		alert("선택된 서비스가 없습니다.");
    		return;
    	}
    	console.log($('#AdminMemberform').serialize())
   	
    	$.ajax({
            url : '/adminMember' + '/deleteSvc',
            type : 'POST',
            data : $('#AdminMemberform').serialize(),
            dataType : "json",
            cache : false,
            success : function(data){
                    window.location.reload();
            },
            contentType : 'application/json;charset=UTF-8',
            error : function(e){
                alert("서비스 등록 중 오류가 발생하였습니다.");
            }
        });
}

function CheckAll(item){
	var id="#"+item.id;
	if($(id).is("checked")){
		$(".m_chkbox").prop("checked", true);
	}else{
		$(".m_chkbox").prop("checked", false);
	}
}