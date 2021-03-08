<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="main" content="width=device-width, initial-scale=1.0">
<title>FitHe</title>
<!--common style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/main.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script-->
<script src="${pageContext.request.contextPath}/include/main/js/menu.js" defer></script>
<!--javaScript
<script src="${pageContext.request.contextPath}/include/main/js/main.js" defer></script>-->

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#navshow',
			data:{
				session_chk:"<%=(String)session.getAttribute("mid") %>",
				session_mid:"${sessionScope.mid}"+"님"
				
			},
			methods:{
				my_info_true:function(){
					$('#login_info_tab').attr('style','visibility:visible')
				},
				my_info_false:function(){
					$('#login_info_tab').attr('style','visibility:hidden')
				}
			}
		})
	})

</script>
<style type="text/css">
[v-cloak]{
	display:none;
}
</style>
</head>
<body>

<!--navigator-->
    <nav id="navshow" class="navbar">
        <!--logo-->
        <div class="navbar_logo">
            <i class="fas fa-anchor"></i>
            <a href="#">FITHE</a>
        </div>
        <!--menu-->
        <ul class="navbar_menu">
            <li><a href="#">기초체력측정</a></li>
            <li><a href="kakaomaplist.do">헬스장 추천</a></li>
            <li><a href="#">커뮤니티</a></li>
            <li class="member_field">
                <span>내정보</span>
                <span>로그아웃</span>
            </li>
        </ul>
        <!--login icon-->
        <ul v-if="session_chk==='null'" class="navbar_icons">

            <li><a href="memberLoginForm.do">로그인<i class="fas fa-user-plus"></i></a></li>

        </ul>
        <!--@pad @phone-->
        <a href="#" class="navbar_toggleBtn" onclick="gogo();">
            <i class="fas fa-bars"></i>
        </a>

        <!--login 후 member field-->
        <div class="login_member">
            <span id="userid">{{session_mid}}</span>
        </div>
        <ul v-else class="navbar_icons" class="user_info">
            <!--<li>{{session_mid}}</li>-->
            <li><a href="mypage.do">내정보</a></li>
            <li><a href="testshj3497@gmail.com">고객지원</a></li>
            <li><a href="memberLogout.do">로그아웃</a></li>
        </ul>

    </nav>
<!--  
	<nav id="navshow" class="navbar" v-cloak>
		
		<div class="navbar_logo">
			<i class="fas fa-anchor"></i>
			<a href="mainpageForm.do">FITHE</a>
		</div>
		
		<ul class="navbar_menu">
			<li><a href="#">기초체력 태스트</a></li>
			<li><a href="kakaomaplist.do" target="_blank">헬스장 찾기</a></li>
			<li><a href="youtube.do">운동시작히기</a></li>
			<li><a href="communityList.do">커뮤니티</a></li>				
		</ul>
	
		<ul v-if="session_chk==='null'" class="navbar_icons" v-cloak>
			<li><a href="memberLoginForm.do">로그인<i class="fas fa-user-plus"></i></a></li>
		</ul>
		
		<div v-else class= "login_member" v-on:mouseover="my_info_true" v-on:mouseout="my_info_false">
			<span><i class="fas fa-user-circle"></i></span>&nbsp;&nbsp;
			<span>{{session_mid}}&nbsp;</span>
			<div id="login_info_tab" class="navbar_icons2" style="visibility:hidden;">
				<ul>
					<li><a href="mypage.do">내정보</a></li>
					<li><a href="mailto:testshj3497@gmail.com">고객지원</a></li>
					<li><button class="logout_btn" onclick="logoutM()">로그아웃</button></li>
					
				</ul>
			</div>
		</div>
		
		<a href="#" class="navbar_toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
	</nav>
-->


<!-- --------------------------------------------------------------------------------- -->
<script>
	// 로그아웃 alert 후, logout 실행
	function logoutM(){		
		var logout = confirm("로그아웃 하시겠습니까?");
		if(logout){
			location.replace('memberLogout.do');
		}
	}
</script>
<!-- --------------------------------------------------------------------------------- -->

<script>
function gogo(){
	var toggleBtn = document.querySelector('.navbar_toggleBtn');
	var menu = document.querySelector('.navbar_menu');
	var icons = document.querySelector('.navbar_icons');
	var userid = document.querySelector('.userid');
	var navbar_icons = document.getElementById("user_info");

	// 햄버거 btn 클릭시 메뉴/아이콘 펼침
	toggleBtn.addEventListener('click', function() {
	    //active속성 활용하여 토글 이벤트 적용
	    menu.classList.toggle('active');
	    icons.classList.toggle('active');
	});

	userid.addEventListener('click', function() {
	    alert("hello");

	});	
}
</script>

</body>
</html>