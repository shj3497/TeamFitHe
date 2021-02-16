<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My page</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
		$('#changeinfogo').on('click',function(){
			location.href="memberupdateForm.do";
		})
		
		// 로그아웃 버튼
		$('#logoutgo').on('click',function(){
			location.href="memberLogout.do";
		})
		
	})

</script>
</head>
<body>
	<div id="show" v-cloak>
		<div>
			<ul>
				<!-- 회원 정보 Mypage 이동시 기본은 회원정보를 보여준다. -->
				<li><a href="">회원정보</a></li>
				<!-- 보안 정보 -->
				<li><a href="">보안정보</a></li>
			</ul>
		</div>
		<div>
			<div>
				<label>캘린더</label>
				<input type="button" id="calendergo" value="조회하기">
			</div>
		</div>
		<div>
			<div>
				<h3>연락처 및 알림</h3>
				<label>이메일</label>&nbsp;&nbsp;<label>{{memail}}</label><br>			
				<label>연락처</label>&nbsp;&nbsp;<label>{{mph}}</label>
				<input type="button" id="changeinfogo" value="수정">
				<input type="button" id="logoutgo" value="로그아웃">
			</div>
		</div>
	</div>
</body>
</html>