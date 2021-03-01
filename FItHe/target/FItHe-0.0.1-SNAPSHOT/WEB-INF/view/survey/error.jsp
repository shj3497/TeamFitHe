<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR PAGE</title>
</head>
<script type="text/javascript">
if(${loginerror} = "loginerror"){
	
	alert("로그인을 하셔야 이용가능한 페이지 입니다.");
	
	location.href="memberLoginForm.do";
}


</script>
<body>

	
	
</body>
</html>