<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보안정보</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 패스워드 변경 페이지로 이동
		$('#changePwFormgo').on('click',function(){
			
			location.href="changePwFormgo.do";
		})
		
		// 회원 탈퇴페이지로 이동
		$('#delMemberFormgo').on('click',function(){
			
			location.href="";
		})
		
		// 내가 쓴 글 목록 리스트로 이동
		
		
	});

</script>
</head>
<body>
<!-- mypage에서 보안정보를 누르면 이동되는 페이지 -->
<!-- 여기서 패스워드 변경, 회원 탈퇴, 내가 작성한 글 목록으로 이동페이지가 보여질거임 -->
	
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
		<!-- 2*2 행렬 기준 (1,1)에 위치 시계방향 11시쯤 -->
			<h3><label>비밀번호</label></h3>
			<label>FitHe 로그인 시 사용하는 비밀번호를 변경할 수 있습니다.<br> 
			주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요.</label><br><br>
			<input type="button" id="changePwFormgo" value="변경하기">
		</div>
		
		<div>
		<!-- 2*2 행렬 기준 (2,1)에 위치 시계방향 7시쯤-->
			<h3><label>회원탈퇴</label></h3>
			<input type="button" id="delMemberFormgo" value="탈퇴하기">
		</div>
		
		<div>
		<!-- 2*2 행렬 기준 (1,2)에 위치 시계방향 1시쯤-->
			<h3><label>내가 작성한 글 목록</label></h3>
			<input type="button" id="" value="확인하기">
		</div>
	</div>
</body>
</html>