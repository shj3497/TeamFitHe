<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 폼</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/member/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/member/member.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<title>board</title>
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/member_login/member/main.js" defer></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
				pw:"",
				pw_r:"",
				bir:"",
				msg:""
			},
			watch:{
				pw:function(pw){
					if(this.pw.length < 8){
						let msg = "8자리 이상 입력하세요";
						this.msg = msg;
					}else if(this.pw.length > 16){
						this.pw = pw.substring(0,16);
					}else {
						let msg = " ";
						this.msg = msg;
					}
				},
				pw_r:function(pw_r){
					
					if(this.pw == this.pw_r){
						let msg = " ";
						this.msg = msg;
					}else{
						var msg = "일치하지않습니다.";
						this.msg = msg;
					}
				},
				bir:function(bir){
					if(this.bir.length != 6){
						this.bir = bir.substring(0,6);
					}else{
						this.bir = bir;
					}
				}
			}
		}) // end of Vue()
		
		
		// 아이디 중복 체크
		$('#midChk').on('click',function(){
			
			if(!chkSubmit($('#mid'), "아이디를 ")){
				return ;
			}else{
				console.log("midChk 진입");
				
				// 아이디 중복체크
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
						$('#mid').attr('readonly','true')
					}
					
				} // end of whenSuccess()
				function whenError(e){
					alert("시스템 오류 입니다. 관리자에게 문의하세요." + e);
				}

				
			}// end of else{}
		}) // end of 아이디 중복체크
		
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
		
		
		// 회원가입 버튼
		$('#insertForm').on('click',function(){
			console.log("회원가입 버튼 선택");
			
			
			// 널값 체크
			if(!chkSubmit($('#mid'),"아이디를 ")){
				return ;
			}else if(!chkSubmit($('#mpw'),"비밀번호를 ")){
				return ;
			}else if(!chkSubmit($('#mname'),"이름을 ")){
				return ;
			}else if(!chkSubmit($('#mbir'),"생일을 ")){
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
				// 중복체크를 실행했는지 확인
				if($('#mid').prop('readonly')){
					if($('#memail_a').prop('readonly')){
						$('#fit_writeForm').attr('method', 'POST');
						$('#fit_writeForm').attr('action', 'memberInsert.do');
						$('#fit_writeForm').submit();
					}else{
						alert("이메일 중복체크를 해주세요");
					}
				}else{
					alert("아이디 중복체크를 해주세요");
				}
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
                document.getElementById("maddress_detail").focus();
            }
        }).open();
    }
</script>
</head>
<body>
	<!--navigator-->
	<jsp:include page="../common/mainnav.jsp"></jsp:include>
    <%-- <nav class="navbar">
        <!--logo-->
		<div class="navbar_logo">
            <i class="fas fa-ice-cream"></i>
            <a href="#">FITHE</a>
        </div>
		<!--menu-->
        <ul class="navbar_menu"><!—unorder-list—>
            <li><a href="#">기초체력측정</a></li>
            <li><a href="#">헬스장 추천</a></li>
            <li><a href="#">게시판</a></li>
            <li><a href="mypage.do">마이페이지</a></li>
        </ul>
		<!--login icon-->
        <ul class="navbar_icons">
            <li><i class="fas fa-user-plus"></i></li>
		</ul>
        <!--@pad @phone-->
		<a href="#" class="navbar_toggleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </nav><!--end of <nav class="navbar">-->
    --%>
    
    <div class="fithe_wrap">
    	<!-- board -->
    	<div class="content_wrap">
    		<!-- 회원가입 header -->
    		<div>
				<p class="member_head">회원 가입</p>
				<div class="user_head">FIT &amp; HEALTH</div>
				<div class="user_check">
					
					<!--<p>여러분을 환영합니다</p>
						<p>다양한 FITHE 서비스를 즐겨보세요.
						회원으로 가입하시면 FITHE 서비스를 보다 편리하게 이용할 수 있습니다.</p>
						<p>여러분이 제공한 콘텐츠를 소중히 다룰 것입니다.
						여러분의 개인정보를 소중히 보호합니다.</p>
						타인의 권리를 존중해 주세요.-->
					<div class="user_agreement">
						<div>
							<p>여러분을 환영합니다</p>
							<p>다양한 FITHE 서비스를 즐겨보세요.
							회원으로 가입하시면 FITHE 서비스를 보다 편리하게 이용할 수 있습니다.</p>
							<p>여러분이 제공한 콘텐츠를 소중히 다룰 것입니다.
							여러분의 개인정보를 소중히 보호합니다.</p>
							타인의 권리를 존중해 주세요.
						</div>
						<input type="checkbox"/>
						<label>이용약관</label>
					</div>
				</div>		
    		</div>
    		
    		<div class="content_group">
				<form id="fit_writeForm">
					<input type="hidden" id="chkid" value="N">
					<div id="show" v-cloak>
						<div class="member_content_section">
							<label>아이디</label>
							<div class="member_content_t">
								<input type="text" id="mid" name="mid" placeholder="아이디 입력" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" class="com_btn" id="midChk" value="중복체크">
							</div>
						</div>
						<div class="member_content_section">
							<label>비밀번호</label>
							<div class="member_content_p">
								<input type="password" id="mpw" name="mpw" v-model="pw" placeholder="비밀번호 입력" />
							</div>
							<div class="member_content_t">
								<!-- <label>비밀번호 확인</label> -->
								<input type="password"  id="mpw_r" name="mpw_r" v-model="pw_r" placeholder="비밀번호 재입력">
								<p><label>{{msg}}</label></p>
							</div>
						</div>
						<div class="member_content_section">
							<label>이름</label>
							<div class="member_content_t">
								<input type="text" id="mname" name="mname" placeholder="이름을 입력해주세요">
							</div>
						</div>
						<div class="member_content_g">
							<label>성별</label>
							<input type="radio" name="mgender" value="F" checked>여성
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="mgender" value="M">남성
						</div>
						<div class="member_content_section">
							<label>생년월일</label>
							<div class="member_content_t">
								<input type="text" id="mbir" name="mbir" placeholder="주민등록번호 앞 6자리" v-model="bir">
							</div>
						</div>
						<div class="member_content_section">
							<label>주소</label>
							<div class="member_content_p">
								<input type="text" id="mzonecode" name="mzonecode" placeholder="우편번호">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" class="com_btn" onclick="sample6_execDaumPostcode()" value="우편번호찾기">
							</div >
							<div class="member_content_p">
								<input type="text" id="maddress" name="maddress" placeholder="주소">
							</div>
							<div class="member_content_t">
								<input type="text" id="maddress_detail" name="maddress_detail" placeholder="상세주소">
							</div>
						</div>
						<div class="member_content_section">
							<label>핸드폰번호</label>
							<div class="member_content_t">
								<input type="text" id="mph" name="mph" placeholder="ex)01012345678">
							</div>
						</div>
						<div class="member_content_section">
							<label>이메일</label>
								<input type="button" class="email_btn" id="memailChk" value="이메일 중복체크"><!-- 이메일 중복체크 -->
							<div class="member_content_e">
								<input type="text" id="memail_a" name="memail_a">
								<input type="text" id="memail_b" name="memail_b">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<select class="sel_btn" id="memail_c" name="memail_c">
									<option value="" disabled selected>선택하세요</option>
									<option value="gmail.com">gmail.com</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="1">직접입력</option>
								</select>
							</div>
						</div>
						<div>
							<input type="button" id="insertForm" value="회원가입">
							<input type="button" value="다시" onClick="window.location.reload()">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>