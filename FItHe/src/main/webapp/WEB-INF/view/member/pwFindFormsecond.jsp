<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PW 찾기</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$('#sendAuthnum').on('click',function(){
			
			console.log("인증번호전송");
			
			let goURL = "sendAuthnum.do";
			let method = "POST";
			let param = {
					aname:$('#aname').val(),
					aemail:$('#aemail').val()
			} 
			
			$.ajax({
				url : goURL,
				type : method,
				data : param,
				success : whenSuccess,
				error : whenError
			});
			
			function whenSuccess(resData){
				if(resData == 1){
					alert("이메일을 확인해주세요");
					// 인증번호 전송에 성공하면 입력한 이름과 이메일은 수정 불가
					$('#aname').attr('readonly','true');
					$('#aemail').attr('readonly','true');
					$('#authnum').focus();
				}else if(resData == 0){
					alert("전송에 실패하였습니다.")
				}
			}
			
			function whenError(e){
				alert("시스템 오류입니다. 관리자에게문의해주세요." + e);
			}
		}) // 이메일 전송
		
		$('#findPW_next').on('click',function(){
			
			$('#pwFindForm').attr('action','pwFindsecond.do');
			$('#pwFindForm').attr('method','POST');
			$('#pwFindForm').submit();
			
		})
		
		
	})

</script>
</head>
<body>
<!-- PW찾기 시 이름과 이메일을 입력받아 인증번호를 전송한다. -->
<!-- 인증번호가 확인된다면 해당하는 pw변경하는 페이지로 이동한다. -->
	<form id="pwFindForm">
		<input type="hidden" id="mid" name="mid" value="${memberVO.mid}">
		<ul>
			<li>본인확인 이메일로 인증</li>
		</ul>
		
		<label>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</label>
		<br><br>
		<div>
			<label>이름</label>
			<input type="text" id="aname" name="aname">
		</div>
		<div>
			<label>이메일 주소</label>
			<input type="text" id="aemail" name="aemail">
			<input type="button" id="sendAuthnum" value="인증번호받기">
		</div>
		<div>
			<input type="text" id="authnum" name="authnum" placeholder="인증번호6자리">		
		</div>
		<div>
			<input type="button" id="findPW_next" value="다음">
		</div>
	</form>
</body>
</html>