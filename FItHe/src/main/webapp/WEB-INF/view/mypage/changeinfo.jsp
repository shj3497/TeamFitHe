<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
				mname:"${memberVO.mname}",
				mph:"${memberVO.mph}",
				memail:"${memberVO.memail}",
				mzonecode:"${memberVO.mzonecode}",
				maddress:"${memberVO.maddress}",
				maddress_detail:"${memberVO.maddress_detail}"		
			}
		}) // end of vue
		
		$('#updateBtn').on('click',function(){
			
			console.log("수정하기 버튼 선택");
			
			$('#updateInfoForm').attr('method','POST');
			$('#updateInfoForm').attr('action','');
			$('#updateInfoForm').submit();
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
	<form id="updateInfoForm">
		<div id="show" v-cloak>
			<div>
				<h3>연락처 및 알림 설정</h3>
				<label>{{mid}}님의 연락처 정보입니다.<br>
				회원정보는 개인정보처리방침에 따라 안전하게 보호되며,회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.<br>
				</label>
			</div>
			<div>
				<label>사용자이름</label>
				<input type="text" id="mname" name="mname" v-model="mname">
			</div>
			<div>
				<label>휴대전화</label>
				<input type="text" id="mph" name="mph" v-model="mph">
			</div>
			<div>
				<label>이메일</label>
				<input type="text" id="memail" name="memail" v-model="memail">
			</div>
			<div>
				<label>우편번호</label>
				<input type="text" id="mzonecode" name="mzonecode" v-model="mzonecode">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호찾기">
			</div>
			<div>
				<label>주소</label>
				<input type="text" id="maddress" name="maddress" v-model="maddress">
			</div>
			<div>
				<label>상세주소</label>
				<input type="text" id="maddress_detail" name="maddress_detail" v-model="maddress_detail">
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" id="mpw" name="mpw">		
			</div>
			<div>
				<input type="button" id="updateBtn" value="수정하기">
			</div>
		</div>
	</form>
</body>
</html>