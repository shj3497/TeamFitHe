<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR PAGE</title>
</head>
<script>
	//String result = request.getAttribute("result");
	//console.log("result >>> : " + result);
	//alert(result);
	
	alert("잘못된 접근입니다.");
	history.go(-1);
</script>
<body>
</body>
</html>