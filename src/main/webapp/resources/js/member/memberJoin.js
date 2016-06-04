$(function() {
		
		$("#password").keyup(function() {
				$("#passwordmsg").text('');
			});
		
		$("#password2").keyup(function() {
			if($("#password").val() != $("#password2").val()) {
				$("#passwordmsg").css('color','RED');
				$("#passwordmsg").text('');
				$("#passwordmsg").html('암호가 일치 하지 않습니다.');
			}else {
				$("#passwordmsg").css('color','#00FF24');
				$("#passwordmsg").text('');
				$("#passwordmsg").html('암호가 일치 합니다.');
			}
		});
	
	
// 		$("#action-button").click(function(){
		$("#id").keyup(function(){
			var id = $("#id").val();
			var length = id.length;
			
			if(length > 3){
				$("#result").html('');
			$.ajax({
				url:"/id_check",
				type:'post',
				data: {"id":id},
				error:function(data){
					$("#result").css('color','red');
					$("#result").html("ajax : error");
				},
				
				success:function(data){
					console.log(data);
					if(data){
						$("#result").css('color','red');
						$("#result").html("같은 ID가 이미 사용중입니다.");	
						document.memberjoin.id.focus();
						return false;
					}else{
						$("#result").css('color','#00FF24');	
						$("#result").html('사용할수 있는 ID입니다.');	
						}
					},
				}); 	//ajax end
				
			}else if(length < 3){
				$("#result").css('color','red');
				$("#result").html('4글자 이상 입력하세요.')
			}	//length if end
			
			
		});		//id end
		 
	});//ready end