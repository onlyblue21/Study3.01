<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/js/member/member.js" type="text/javascript"></script>
<title>Mypage</title>
</head>
<body>
<h1>
mypage
</h1>
     <form name="mypagefrm" action="/memberUpdate" method="POST" >
     <div align="center">
		 <table border="2" width=250 bordercolor="green" cellspacing="2"
        	bordercolor="green">
             <tr>
                <td>ID :</td>
                <td>${memberInfo.id}</td>
            </tr>
            <tr>
                <td>이름 :</td>
                <td>${memberInfo.user_name}</td>
            </tr>
           
            <tr>
                <td> 닉네임  :</td>
                <td>${memberInfo.nick_name}</td>
            </tr>
            <tr>
                <td> email :</td>
                <td>${memberInfo.email}</td>
            </tr>
            <tr>
                <td>직업 :</td>
                <td>${memberInfo.job}</td>
            </tr>
            <tr>
				<td></td> 
				<td></td>       
            </tr>
            <tr>
	            <td align="center" colspan=2>
	           		<input class="btn btn-success" type="button" value="확인 " onclick="javascript:history.back()">
	            	<input class="btn btn-success" type="button" value="수정" onclick="mypageModefy()"> 
	            	<input class="btn btn-cancle" type="submit" value="회원탈퇴">
	            </td>
            </tr>
	    </table>
	    </div>
      </form>
</body>
</html>