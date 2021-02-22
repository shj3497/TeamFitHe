<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
				mname:"${memberVO.mname}",
				mph:"${memberVO.mph}",
				mzonecode:"${memberVO.mzonecode}",
				maddress:"${memberVO.maddress}",
				maddress_detail:"${memberVO.maddress_detail}",
				memail:"${memberVO.memail}"
			},
			computed:{
				// db에서 받아온 memail은 합쳐저 있는 것 이므로 쪼개서 뿌려준다.
				memail_a:function(){
					return this.memail.split('@')[0];
				},
				memail_b:function(){
					var mail_b = this.memail.split('@')[1];
					return '@'.concat(mail_b);
				}
			}

		}) // end of vue
		
		// 이메일 중복 체크
		$('#memailChk').on('click',function(){
			
			if(!chkSubmit($('#memail_a'), "이메일을 ")){
				return ;
			}else if(!chkSubmit($('#memail_b'), "이메일을 ")){
				return; 
			}else {
				console.log("memailChk 진입");
				
				// 아이디 중복체크
				let goURL = "memberEmailCheck.do";
				let method = "POST";
				let param = {
						memail : $('#memail_a').val() + $('#memail_b').val()
				}
				
				$.ajax({
					url : goURL,
					type : method,
					data : param,
					success : whenSuccess,
					error : whenError
				})
				function whenSuccess(resData){
					
					if(resData == 1){
						alert("중복된 Email 입니다.")
						$('#memail_a').val('');
						$('#memail_b').val('');
						$('#memail_a').focus();
					}else if(resData == 0){
						alert("사용가능한 Email입니다.")
						$('#memail_a').attr('readonly','true')
						$('#memail_b').attr('readonly','true')
						$('#memail_c').attr('disabled','true')
					}
					
				} // end of whenSuccess()
				function whenError(e){
					alert("시스템 오류 입니다. 관리자에게 문의하세요." + e);
				}

				
			}// end of else{}
		}) // end of 이메일 중복체크
		
		// 수정하기 버튼을 클릭해서 db업데이트가 이루어진다.
		$('#updateBtn').on('click',function(){
			
			console.log("수정하기 버튼 선택");
			if(!chkSubmit($('#mid'),"아이디를 ")){
				return ;
			}else if(!chkSubmit($('#mpw'),"비밀번호를 ")){
				return ;
			}else if(!chkSubmit($('#mname'),"이름을 ")){
				return ;
			}else if(!chkSubmit($('#mzonecode'),"우편번호를 ")){
				return ;
			}else if(!chkSubmit($('#maddress'),"주소를 ")){
				return ;
			}else if(!chkSubmit($('#mph'), "핸드폰번호를 ")){
				return ;
			}else if(!chkSubmit($('#memail_a'), "이메일을 ")){
				return ;
			}else if(!chkSubmit($('#memail_b'), "이메일을 ")){
				return ;
			}else{
				$('#updateInfoForm').attr('method','POST');
				$('#updateInfoForm').attr('action','memberUpdate.do');
				$('#updateInfoForm').submit();
			}
		})
		
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
                document.getElementById("maddress_detail");
            }
        }).open();
    }
</script>
</head>
<body>
	<form id="updateInfoForm">
		<div id="show" v-cloak>
			<input type="hidden" id="mid" name="mid" v-model="mid">
			<div>
				<h3>연락처 및 알림 설정</h3>
				<label>{{mid}}님의 연락처 정보입니다.<br>
				회원정보는 개인정보처리방침에 따라 안전하게 보호되며,<br> 
				회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.<br>
				</label>
			</div>
			<br>
			<div>
				<label>사용자이름</label>
				<input type="text" id="mname" name="mname" :value="mname">
			</div>
			<div>
				<label>휴대전화</label>
				<input type="text" id="mph" name="mph" :value="mph">
			</div>
			<div>
				<label>이메일</label>
				<input type="text" id="memail_a" name="memail_a" :value="memail_a">
				<input type="text" id="memail_b" name="memail_b" :value="memail_b">
				<select id="memail_c" name="memail_c">
				<option value="" disabled selected>선택하세요</option>
				<option value="gmail.com">gmail.com</option>
				<option value="naver.com">naver.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="1">직접입력</option>
			</select>
			<input type="button" id="memailChk" value="중복체크"><!-- 이메일 중복체크 -->
			</div>
			<div>
				<label>우편번호</label>
				<input type="text" id="mzonecode" name="mzonecode" :value="mzonecode">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호찾기">
			</div>
			<div>
				<label>주소</label>
				<input type="text" id="maddress" name="maddress" :value="maddress">
			</div>
			<div>
				<label>상세주소</label>
				<input type="text" id="maddress_detail" name="maddress_detail" :value="maddress_detail">
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