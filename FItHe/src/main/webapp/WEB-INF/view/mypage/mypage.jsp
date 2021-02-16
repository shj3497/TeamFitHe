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
<!-- 회원정보 보안정보 태그를 nav태그 밑에 위치시켜서 tab형태로 페이지를 바꿔서 보여주고 싶습니다. -->
<!-- 캘린더와 사용자 정보는 반반으로 오른쪽 왼쪽 나누어서 보여주고 싶습니다. -->
<!-- 단지 디자인적으로 생각만 하고있는거라 언제든지 변경 가능합니다. -->
	<div id="show" v-cloak>
		<div>
			<ul>
				<!-- 회원 정보 Mypage 이동시 기본은 회원정보를 보여준다. -->
				<li><a href="mypage.do">회원정보</a></li>
				<!-- 보안 정보 -->
				<li><a href="mySecpage.do">보안정보</a></li>
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
				<label>연락처</label>&nbsp;&nbsp;<label>{{mph}}</label><br>
				<input type="button" id="changeinfogo" value="수정">
				<input type="button" id="logoutgo" value="로그아웃">
			</div>
		</div>
	</div>
</body>
</html>