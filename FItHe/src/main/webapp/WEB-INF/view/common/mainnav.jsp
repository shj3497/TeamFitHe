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
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script-->
<script src="${pageContext.request.contextPath}/include/main/js/menu.js" defer></script>
<!--javaScript-->
<script src="${pageContext.request.contextPath}/include/main/js/main.js" defer></script>

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
	<nav id="navshow" class="navbar" v-cloak>
		<!--logo-->
		<div class="navbar_logo">
			<i class="fas fa-anchor"></i>
			<a href="mainpageForm.do">FITHE</a>
		</div>
		<!--menu-->
		<ul class="navbar_menu">
			<li><a href="#">기초체력측정</a></li>
			<li><a href="kakaomaplist.do" target="_blank">헬스장 추천</a></li>
			<li><a href="communityList.do">게시판</a></li>
			<li><a href="youtube.do">운동영상</a></li>
		</ul>
		<!--login icon-->
		<ul v-if="session_chk==='null'" class="navbar_icons" v-cloak>
			<li><a href="memberLoginForm.do">로그인<i class="fas fa-user-plus"></i></a></li>
		</ul>
		<!-- 
		<div v-else class="login_member" v-cloak v-on:mouseover="testtest" v-on:mouseout="testtesttest">
			<span>{{session_mid}}</span>
			<div id="login_info_tab" style="visibility:hidden;">
				<ul class="navbar_icons2">
					<li><a href="mypage.do">내정보</a></li>
					<li><a href="mailto:testshj3497@gmail.com">고객지원</a></li>
					<li><a href="memberLogout.do">로그아웃</a></li>
				</ul>
			</div>
		</div>
		 -->
		<!-- 
		<ul v-else class="login_member" v-on:mouseover="my_info_true" v-on:mouseout="my_info_false">
			<li>{{session_mid}}</li>
			<li id="login_info_tab" class="navbar_icons2" style="visibility:hidden;">
				<ul>
					<li><a href="mypage.do">내정보</a></li>
					<li><a href="mailto:testshj3497@gmail.com">고객지원</a></li>
					<li><a href="memberLogout.do">로그아웃</a></li>
				</ul>
			</li>
		</ul>
		 -->
		<div v-else class= "login_member" v-on:mouseover="my_info_true" v-on:mouseout="my_info_false">
			<span>{{session_mid}}</span>
			<div id="login_info_tab" class="navbar_icons2" style="visibility:hidden;">
				<ul>
					<li><a href="mypage.do">내정보</a></li>
					<li><a href="mailto:testshj3497@gmail.com">고객지원</a></li>
					<li><a href="memberLogout.do">로그아웃</a></li>
				</ul>
			</div>
		</div>
		
		<!--@pad @phone-->
		<a href="#" class="navbar_toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
	</nav>
	
	<div style="height:50px">
		&nbsp;
	</div>
</body>
</html>