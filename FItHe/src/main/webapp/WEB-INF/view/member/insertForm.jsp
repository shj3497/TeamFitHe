<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 아이디 중복 체크
		$('#midChk').on('click',function(){
			
			console.log("midChk 진입");
			
			let idURL = "memberIdCheck.do";
			let method = "POST";
			let param = {
					mid : $('#mid').val()
			}
			
			$.ajax({
				url : idURL,
				type : method,
				data : param,
				success : whenSuccess,
				error : whenError
			})
			function whenSuccess(resData){
				
				if(resData == 1){
					alert("중복된 ID입니다.")
					$('#mid').val('');
					$('#mid').focus();
				}else if(resData == 0){
					alert("사용가능한 ID입니다.")
				}
				
			} // end of whenSuccess()
			function whenError(e){
				alert("시스템 오류 입니다. 관리자에게 문의하세요." + e);
			}
		}) // end of 아이디 중복체크
		
		
		// 패스워드 확인 버튼
		$('#mpwChk').on('click',function(){
			
			var mpw = $('#mpw').val();
			var mpw_r = $('#mpw_r').val();
			console.log("mpw");
			console.log("mpw_r");
			
			if(mpw == mpw_r){
				alert("패스워드가 일치합니다.")
			}else{
				alert("패스워드를 확인해주세요.")
				$('#mpw').val('');
				$('#mpw_r').val('');
				$('#mpw').focus();
			}
		})// end of 패스워드 확인 버튼
		
		// 이메일 셀렉트 박스
		$('#memail_c').on('change', function() {
            if ($('#memail_c').val() == '1') {
            	$('#memail_b').attr('readonly', false);
            	$('#memail_b').val('');
            } else {
            	$('#memail_b').attr('readonly', true);
            	$('#memail_b').val('@' + $('#memail_c').val());
            }
        });
		
		
		// 회원가입 버튼
		$('#insertForm').on('click',function(){
			console.log("회원가입 버튼 선택");
			
			$('#fit_writeForm').attr('method', 'POST');
			$('#fit_writeForm').attr('action', 'memberInsert.do');
			$('#fit_writeForm').submit();
		})
	})
</script>
<!-- 다음 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                }else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mzonecode').value = data.zonecode;
                document.getElementById("maddress").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("maddress_detail").focus();
            }
        }).open();
    }
</script>
</head>
<body>
	<form id="fit_writeForm">
		<div>
			<label>아이디</label>
			<input type="text" id="mid" name="mid">
			<input type="button" id="midChk" value="중복체크">
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
			<input type="text" id="maddress" name="maddress">
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