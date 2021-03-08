<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<!--javaScript-->
<script src="${pageContext.request.contextPath}/include/main/js/main.js" defer></script>
</head>
<body>
	<script>
		// index.jsp 에서 보여주었던 메인 페이지가 webapp/mainapge/mainpage.jsp로 이동되었습니다.
		// mainpage에 좌측 하단 맨 밑을 보면 로그아웃 버튼있으니까 로그아웃 필요시 활용바람
		location.href="mainpageForm.do";
	</script>
</body>
</html>