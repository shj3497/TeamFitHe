<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>manager</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/css/style.css">
<!---->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/css/manager.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script-->
<script src="${pageContext.request.contextPath}/include/js/menu.js" defer></script>
<script type="text/javascript">

	$(document).ready(function(){
		// 로그아웃 버튼
		$('#logoutgo').on('click',function(){
			location.href="memberLogout.do";
		})
	})
</script>
</head>
<body>
	<div class="fithe_wrap">
		<div>
	<!-- 관리자 페이지들의 공통 div -->
		<!--(1) management bar-->
			<div class="menu_align">
				<div class="navbar_logo">
					<i class="fas fa-ice-cream"></i>
					<a href="#">FITHE</a>
				</div>
				<!--manager info-->
				<div class="thumb">
					<img class="img-circle" width="68" height="68" alt="관리자 이미지" src="${pageContext.request.contextPath}/include/img/sports.jpg" />
					<div>관리자</div>
					<div><a href="memberLogout.do">로그아웃</a></div>
				</div>
				<!--menu link-->
				<div class="menu_link">
					<ul>
						<li><a href="memberList.do">회원관리</a></li>
						<li><a href="#">게시판 관리</a></li>
						<li><a href="#">공지사항 관리</a></li>
					</ul>
				</div>
			</div>
			<!--end of <div class="menu_align">-->
			<!--animation : tablet version-->
			<div class="gif_animation">
				<iframe src="${pageContext.request.contextPath}/include/img/running.gif" width="100%" height="200" frameBorder="0" class="giphy-embed"
					scrolling="no" allowFullScreen></iframe>
			</div>
			<!--(2) content-->
			<div id="memberListForm" class="manage_group">
				<!--title : web version-->
				<!--title : tablet version-->
				<div class="content_head">		
					<select onchange="window.location.href=this.value">
						<option value="none">=== 선택 ===</option>
						<option value="memberList.do" selected>회원관리</option>
						<option value="#">게시판 관리</option>
						<option value="#">회원관리</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</body>
</html>