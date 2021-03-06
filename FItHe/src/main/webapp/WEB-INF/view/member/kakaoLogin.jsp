<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
    <title>Login Demo - Kakao JavaScript SDK</title>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/login/kakao.css" charset="UTF-8">
</head>

<body>
    <div id="kakao_id_login" class="kakao_url"> 
    	<a href="${kakao_url}"> 
   			<img height="50px" width="150px" src="${pageContext.request.contextPath}/include/kakao/kakao_login.png">
   		</a>
   	</div>
</body>
</html>