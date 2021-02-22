<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$('#sendAuthnum').on('click',function(){
			
			if(!chkSubmit($('#aname'),"이름을")){
				return ;
			} else if(!chkSubmit($('#aemail'),"이메일 주소를")){
				return ;
			} else {
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
				
				function whenError(resData){
					alert("시스템 오류입니다. 관리자에게문의해주세요." + e);
				}
			}
		}) // 이메일 전송
		
		$('#showId').on('click',function(){
			
			if(!chkSubmit($('#aname'),"이름을")){
				return ;
			} else if(!chkSubmit($('#aemail'),"이메일 주소를")){
				return ;
			} else if(!chkSubmit($('#authnum'),"인증번호를")){
				return ;
			} else{
				
				$('#idFindForm').attr('action','memberIdFind.do');
				$('#idFindForm').attr('method','POST');
				$('#idFindForm').submit();
			}
		})
		
		
	})

</script>

</head>
<body>
<!-- ID찾기 시 이름과 이메일을 입력받아 인증번호를 전송한다. -->
<!-- 인증번호가 확인된다면 해당하는 id를 반환한다. -->
	<form id="idFindForm">
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
			<input type="button" id="showId" value="찾기">
		</div>
	</form>
</body>
</html>