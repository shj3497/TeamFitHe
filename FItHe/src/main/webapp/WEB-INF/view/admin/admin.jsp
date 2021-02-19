<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
	<h1>관리자페이지</h1>
	<div>
	<!-- 관리자 페이지들의 공통 div -->
		<div>
			<div>
				<a href="memberList.do">회원관리</a>
			</div>
			<div>
				<a href="">게시판 관리</a>
			</div>
			<div>
				<a href="">공지사항 관리</a>
			</div>
		</div>
		<div>
		<!-- 나중에 없애거나 위치 조정 -->
		<input type="button" id="logoutgo" value="로그아웃">
		</div>
	</div>
</body>
</html>