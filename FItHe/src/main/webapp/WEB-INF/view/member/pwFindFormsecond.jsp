<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PW 찾기</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind2/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind2/pwFindFormSecond.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/member_login/pwfind2/main.js" defer></script>
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
				
				function whenError(e){
					alert("시스템 오류입니다. 관리자에게문의해주세요." + e);
				}
			} // end of elseP{}
			
		}) // 이메일 전송
		
		$('#findPW_next').on('click',function(){

			if(!chkSubmit($('#aname'),"이름을")){
				return ;
			} else if(!chkSubmit($('#aemail'),"이메일 주소를")){
				return ;
			} else if(!chkSubmit($('#authnum'),"인증번호를")){
				return ;
			} else{	
				$('#pwFindForm').attr('action','pwFindsecond.do');
				$('#pwFindForm').attr('method','POST');
				$('#pwFindForm').submit();
			}
		})
		
		
	})

</script>
</head>
<body>
<!-- PW찾기 시 이름과 이메일을 입력받아 인증번호를 전송한다. -->
<!-- 인증번호가 확인된다면 해당하는 pw변경하는 페이지로 이동한다. -->
	<!--navigator-->
    <nav class="navbar">
        <!--logo-->
		<div class="navbar_logo">
            <i class="fas fa-ice-cream"></i>
            <a href="#">FITHE</a>
        </div>
		<!--menu-->
        <ul class="navbar_menu"><!-- unorder-list -->
            <li><a href="#">기초체력측정</a></li>
            <li><a href="#">헬스장 추천</a></li>
            <li><a href="#">게시판</a></li>
            <li><a href="#">마이페이지</a></li>
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
    
    <div class="fithe_wrap">
    	<!--board box-->
		<div class="content_wrap">
			<!-- 로그인 header -->
			<div class="check_head">
				<p class="board_head">PW 찾기</p>
				<p>본인확인 이메일로 인증</p>
				<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야,인증번호를 받을 수 있습니다.</p>
			</div>
			<!-- PW찾기 -->
			<div class="content_group">
				<form id="pwFindForm">
					<input type="hidden" id="mid" name="mid" value="${memberVO.mid}">
					<div class="login_content_section">
						<label>이름</label>
						<div class="login_content_t">
							<input type="text" id="aname" name="aname">
						</div>
					</div>
					<div class="login_content_section">
						<label>이메일 주소</label>
						<div class="login_content_t">
							<input type="text" id="aemail" name="aemail" placeholder="이메일 입력">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" class="com_btn" id="sendAuthnum" value="인증번호받기">
						</div>
					</div>
					<div class="login_content_t">
						<input type="text" id="authnum" name="authnum" placeholder="인증번호6자리">		
					</div>
					<div>
						<input type="button" id="findPW_next" class="login_btn" value="다음">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>