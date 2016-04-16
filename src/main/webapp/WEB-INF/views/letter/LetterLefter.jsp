<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/jquery-ui.css" type="text/css">
<link rel="stylesheet" href="resources/css/ui.jqgrid.css" type="text/css">

<script src="resources/js/jquery-1.12.1.js" type="text/javascript"></script>
<script src="resources/js/jquery-ui.js" type="text/javascript"></script>
<script src="resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="resources/js/jquery.jqGrid.js" type="text/javascript"></script>

<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/letter.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
	$(function() {
		$("#addr").hide();
	});
</script>
		<div>
			<ul>
				<li><a href="#" onclick="letterGetLocation(2)">쪽지쓰기</a></li>
				<li><a href="#" onclick="letterGetLocation(1)">받은쪽지함</a></li>
				<li><a href="#" onclick="letterGetLocation(1)">보낸쪽지함</a></li>
				<li><a href="#" onclick="letterGetLocation(1)">보관쪽지함</a></li>						
			</ul>
		</div>
</body>
</html>