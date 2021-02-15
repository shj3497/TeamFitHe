<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>
</head>
<body>
	<h1>Id 찾기</h1>
	<form>
		<ul>
			<li>본인확인 이메일로 인증</li>
		</ul>
		
		<label>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</label>
		<br><br>
		<div>
			<label>이름</label>
			<input type="text" id="mname" name="mname">
		</div>
		<div>
			<label>이메일 주소</label>
			<input type="text" id="memail" name="memail">
			<input type="button" id="mailsend" value="인증번호받기">
		</div>
		<div>
			<input type="text" id="authnumber" placeholder="인증번호6자리">		
		</div>
		<div>
			<input type="button" id="showId" value="찾기">
		</div>
	</form>
</body>
</html>