<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				msg:"${memberVO.mid}",
				msg1:"${sessionScope.mid}"
			}
		})
		
	})
	
</script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 로그아웃 버튼
		$('#logoutgo').on('click',function(){
			location.href="memberLogout.do";
		})
		
		// 마이페이지로 이동
		$('#mypagego').on('click',function(){
			location.href="mypage.do";
		});
		
		
	})

</script>
<title>Insert title here</title>
</head>
<body>
<!-- 추후에 메인페이지로 이동해야한다. -->
	<h1>로그인 성공!!</h1>
	<h1>추후 메인페이지로 이동하게끔 결과를 이동시켜야한다.</h1>
	<h3>${memberVO.mid}</h3>
	<h2>${sessionScope.mid }</h2><!-- 게시판 글쓰기나 이런건 sessionScope.mid를 이용해서 호출하면 쌉가능 -->
	<h2>${memberVO.mname}</h2>
	<h2>${memberVO.mzonecode}</h2>
	sessionScope는 세션에 설정해주었던 Attribute값으로 호출하는 것 입니다.<br>
	또는<br>
	Model로 전달해준 memberVO로도 호출이 가능합니다.<br>
	<div id="show" v-cloak>
		<h1>{{msg}}</h1>
		<h1>세션호출 : {{msg1}}</h1>
	</div>
	<h3>kemail : ${sessionScope.kemail }</h3>
	<h3>kname : ${sessionScope.kname }</h3>
	<h3>kgender : ${sessionScope.kgender }</h3>
	<h3>kbirthday : ${sessionScope.kbirthday }</h3>
	<h3>kage : ${sessionScope.kage }</h3>
	
	<form id="loginSuccess">
		<input type="button" id="logoutgo" value="로그아웃">
		<input type="button" id="mypagego" value="내정보">
	</form>
	<a href="tempmain.do">임시 메인페이지</a>	
</body>
</html>