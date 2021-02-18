<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
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
	<form id="loginForm">
		<div>
			<label>아이디</label>
			<input type="text" id="mid" name="mid">
		</div>
		<div>
			<label>비밀번호</label>
			<input type="password" id="mpw" name="mpw">
		</div>
		<div>
			<input type="button" id="loginChk" value="로그인">
			<input type="button" id="memberInsert" value="회원가입">
		</div>
		<br>
		<div>
			<input type="button" id="findID" value="ID찾기">
			<input type="button" id="findPW" value="PW찾기">
		</div>
		<!-- 추후에 지울 태그 -->
		<div>
			<a href="tempmain.do">임시 메인페이지</a>		
		</div>
	</form>
</body>
</html>