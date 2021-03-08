<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/mypage/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/mypage/mypage.css" charset="UTF-8">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<title>board</title>
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/include/mypage/mypage/main.js" defer></script>
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vue = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
				memail:"${memberVO.memail}",
				mph:"${memberVO.mph}"
			}
		})
		
		
		// 개인정보 수정하는 페이지로 이동
		$('#changeInfogo').on('click',function(){
			location.href="memberupdateForm.do";
		})
		
		// 로그아웃 버튼
		$('#logoutgo').on('click',function(){
			location.href="memberLogout.do";
		})
		
	})

</script>
<style> 
		body {
				margin: 40px 10px; 
				padding: 0; 
				font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif; 
				font-size: 14px; } 
		#calendar { 
			max-width: 500px;
			margin: 0 auto; 
		}	
</style>

</head>
<body>
	<!--navigator-->
	<jsp:include page="../common/mainnav.jsp"></jsp:include>
	<%--
    <nav class="navbar">
        <!--logo-->
        <div class="navbar_logo">
            <i class="fas fa-ice-cream"></i>
            <a href="#">FITHE</a>
        </div>
        <!--menu-->
        <ul class="navbar_menu">
            <!--unorder-list-->
            <li><a href="#">기초체력측정</a></li>
            <li><a href="#">헬스장 추천</a></li>
            <li><a href="#">게시판</a></li>
            <li><a href="mypage.do">마이페이지</a></li>
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
    <!--end of <nav class="navbar">-->
    --%>
    
	<div id="show" class="fithe_wrap" v-cloak>
		<div class="content_wrap">
			<div class="content_head">
                <!---->
                <ul class="my_menu">
                    <li><a href="mypage.do">회원정보</a></li>
					<li><a href="mySecpage.do">보안정보</a></li>
					<li><a href="calendar.do">캘린더</a></li>
                </ul>
                <!--<Select onchange="window.location.href=this.value">                    
                    <option value="#">회원정보</option>
                    <option value="#">보안정보</option>                    
                </Select>-->
            </div>
			<!--<div class="content_wrap">-->
			<div class="content_group">
				<div class="user_info">
					<div class="font_mid">연락처 및 알림</div>
				</div>
				<div>
					<span>이메일</span>&nbsp;&nbsp;&nbsp;
					<input type="text" class="com_in_txt" :value="memail" disabled>
					<br>
	                <span>연락처</span>&nbsp;&nbsp;
	                <input type="text" class="com_in_txt" v-bind:value="mph" disabled>
	                <br>
	                <input type="button" id="changeInfogo" class="re_btn" value="수정">
				</div>
			</div>
		</div><!--<div class="content_wrap">-->
	</div><!--<div id="show" class="fithe_wrap" v-cloak>-->
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>