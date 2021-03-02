<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="main" content="width=device-width, initial-scale=1.0">
<title>FitHe</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/main.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<title>main</title>
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script-->
<script src="${pageContext.request.contextPath}/include/main/js/menu.js" defer></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!--javaScript-->
<script src="${pageContext.request.contextPath}/include/main/js/main.js" defer></script>
</head>
<body>
<nav class="navbar">
		<!--logo-->
		<div class="navbar_logo">
			<i class="fas fa-anchor"></i>
			<a href="#">FITHE</a>
		</div>
		<!--menu-->
		<ul class="navbar_menu">
				<li><a href="#">기초체력측정</a></li>
				<li><a href="kakaomaplist.do">헬스장 추천</a></li>
				<li><a href="#">게시판</a></li>
				<li><a href="#">마이페이지</a></li>
		</ul>
		<!--login icon-->
		<ul class="navbar_icons">
			<li><a href="memberLoginForm.do">로그인<i class="fas fa-user-plus"></i></a></li>
		</ul>
		<!--@pad @phone-->
		<a href="#" class="navbar_toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
	</nav>
</body>
</html>