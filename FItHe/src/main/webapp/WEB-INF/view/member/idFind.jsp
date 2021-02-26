<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ID FIND</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/idfind2/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/idfind2/idFind.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/member_login/idfind2/main.js" defer></script>
    
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vue = new Vue({
			el:'#show',
			data:{
				id:"${memberVO.mid}",
				minsertdate:"${memberVO.minsertdate}"
			}
		})
		
		$('#loginGo').on('click',function(){
			
			console.log("로그인 버튼 선택");
			location.href="memberLoginForm.do"

		});
		
		$('#findPW').on('click',function(){
			
			console.log("패스워드 찾기 버튼 선택");
			location.href="memberPwFindForm.do"
		})
	})

</script>
</head>
<body>
	<!--navigator-->
    <nav class="navbar">
        <!--logo-->
		<div class="navbar_logo">
            <i class="fas fa-ice-cream"></i>
            <a href="">FITHE</a>
        </div>
		<!--menu-->
        <ul class="navbar_menu"><!-- un order-list -->
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
    </nav><!--end of <nav class="navbar">-->
    
    <div class="fithe_wrap">
    	<!-- board box -->
    	<div class="content_wrap">
    		<!-- 로그인 header -->
    		<div class="check_head">
    			<p class="board_head">ID 찾기</p>
    		</div>
    		<!-- 로그인 -->
    		<div class="content_group">
				<form>
					<div id="show" class="id_find" v-cloak>
						<div>
							{{id}}&nbsp;&nbsp;&nbsp;가입 : {{minsertdate}}
						</div>
					</div>
					<div>
						<input type="button" id="loginGo" class="result_btn" value="로그인">
						<input type="button" id="findPW"  class="result_btn" value="패스워드 찾기">
					</div>
				</form>
			</div><!--<div class="content_group">-->
		</div><!--end of <div class="content_wrap">-->
	</div><!--end of <div class="fithe_wrap">-->
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>