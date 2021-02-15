<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Form</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		
	});

</script>
</head>
<body>
	<form id="fit_updateForm">
		<div>
			<label>아이디</label>
			<input type="text" id="mid" name="mid" value="${memberVO.mid }">
			
		</div>
		<div>
			<label>비밀번호</label>
			<input type="password" id="mpw" name="mpw">
		</div>
		<div>
			<label>비밀번호 확인</label>
			<input type="password" id="mpw_r" name="mpw_r">
			<input type="button" id="mpwChk" value="패스워드 확인">
		</div>
		<div>
			<label>이름</label>
			<input type="text" id="mname" name="mname">
		</div>
		<div>
			<label>성별</label>
			<input type="radio" id="mgender" name="mgender" value="F">여성
			<input type="radio" id="mgender" name="mgender" value="M">남성
		</div>
		<div>
			<label>생년월일</label>
			<input type="text" id="mbir" name="mbir" placeholder="주민등록번호 앞 6자리">
		</div>
		<div>
			<label>우편번호</label>
			<input type="text" id="mzonecode" name="mzonecode">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호찾기">
		</div>
		<div>
			<label>주소</label>
			<input type="text" id="maddress_road" name="maddress_road">
		</div>
		<div>
			<label>상세주소</label>
			<input type="text" id="maddress_detail" name="maddress_detail">
		</div>
		<div>
			<label>핸드폰번호</label>
			<input type="text" id="mph" name="mph" placeholder="ex)01012345678">
		</div>
		<div>
			<label>이메일</label>
			<input type="text" id="memail_a" name="memail_a">
			<input type="text" id="memail_b" name="memail_b">
			<select id="memail_c" name="memail_c">
				<option value="" disabled selected>선택하세요</option>
				<option value="gmail.com">gmail.com</option>
				<option value="naver.com">naver.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="1">직접입력</option>
			</select>
		</div>
		<div>
			<input type="button" id="insertForm" value="회원가입">
			<input type="reset" value="다시">
		</div>
	</form>
</body>
</html>