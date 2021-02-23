<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LOGIN</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/login/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/login/login.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!-- script -->
<script src="${pageContext.request.contextPath}/include/member_login/login/main.js" defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 패스워드 입력후 엔터 입력시 바로 로그인 버튼 선택
		$(document).on("keypress","#mpw",function(e){
			if(e.keyCode == '13'){
				$('#loginChk').click();
			}
		})

		// 로그인 버튼 선택
		$('#loginChk').on('click',function(){
			
			if(!chkSubmit($('#mid'),'아이디를')){
				return;
			}else if(!chkSubmit($('#mpw'), '비밀번호를')){
				return;
			}else{
				
				$('#loginForm').attr('method','POST');
				$('#loginForm').attr('action','memberLogin.do');
				$('#loginForm').submit();
			}
		});
		
		// 회원가입 버튼 선택
		$('#memberInsert').on('click',function(){
			location.href="memberInsertForm.do"
		})
		
		// ID찾기 버튼 선택
		$('#findID').on('click',function(){
			console.log("id찾기 버튼 선택");
			location.href="memberIdFindForm.do"
		})
		
		// PW찾기 버튼 선택
		$('#findPW').on('click',function(){
			console.log("pw찾기 버튼 선택");
			location.href="memberPwFindForm.do"
		})
	})
	
</script>
</head>
<body>
	<!-- navigator -->
	<nav class="navbar">
		<!-- logo -->
		<div class="navbar_logo">
			<i class="fas fa-ice-cream"></i>
			<a href="#">FITHE</a>
		</div>
		<!-- menu -->
		<ul class="navbar_menu">
			<li><a href="#">기초체력측정</a></li>
            <li><a href="#">헬스장 추천</a></li>
            <li><a href="#">게시판</a></li>
            <li><a href="#">마이페이지</a></li>
		</ul>
		<!--login icon-->
        <ul class="navbar_icons">
            <li><i class="fas fa-user-plus"></i></li>
		</ul>
        <!--@pad @phone-->
		<a href="#" class="navbar_toggleBtn">
            <i class="fas fa-bars"></i>
        </a>
	</nav>
	<div class="fithe_wrap">
		<!-- board box -->
		<div class="content_wrap">
		<!-- 로그인 header -->
		<div>
			<p class="board_head">로그인&nbsp;</p>
		</div>
		<!-- 로그인 -->
		<div class="content_group">
			<form id="loginForm">
				<div class="login_content_section">
					<label>아이디</label>
					<div class="login_content_t">
						<input type="text" id="mid" name="mid" placeholder="아이디 입력">
					</div>
				</div>
				<div class="login_content_section">
					<label>비밀번호</label>
					<div class="login_content_t">
						<input type="password" id="mpw" name="mpw" placeholder="비밀번호 입력">
					</div>
				</div>
				<div>
					<input type="button" class="login_btn" id="loginChk" value="로그인">
					<input type="button" class="mem_btn"
					id="memberInsert" value="회원가입">
				</div>
				<br>
				<div>
					<input type="button" class="find_btn" id="findID" value="ID찾기">|
					<input type="button" class="find_btn" id="findPW" value="PW찾기">
				</div>
				<!-- 추후에 지울 태그 -->
				<div>
					<a href="tempmain.do">임시 메인페이지</a>		
				</div>
			</form>
		</div>
		</div>
	</div>
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>