<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>패스워드 변경</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/changePwForm/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/changePwForm/changePwForm.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/mypage/changePwForm/main.js" defer></script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				pw:"",
				pw_r:"",
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
						var msg = " ";
						this.msg = msg;
					}else{
						var msg = "일치하지않습니다.";
						this.msg = msg;
					}
				}
			}
		});// end of Vue
		
		// 확인 버튼 선택시
		$('#pwChange').on('click',function(){
			
			if(!chkSubmit($('#mpw_c'), "현재 비밀번호 입력을 ")){
				return ;
			} else if(!chkSubmit($('#mpw'), "새 비밀번호 입력을 ")){
				return ;
			} else if(!chkSubmit($('#mpw_r'), "새 비밀번호 확인 입력을 ")){
				return ;
			} else{
				
				var method = "POST";
				var goURL = "changePw.do";
				var param = {
						mpw_c:$('#mpw_c').val(),
						mpw:$('#mpw').val(),
						mpw_r:$('#mpw_r').val()
				};
				
				$.ajax({
					url:goURL,
					type:method,
					data:param,
					success:whenSuccess,
					error:whenError
				});
				
				function whenSuccess(resData){
					
					if(resData == "1"){
						alert("비밀번호가 변경되었습니다.")
						
						location.href="mySecpage.do";
					} else if(resData == "0"){
						
						alert("비밀번호 변경에 실패하였습니다.")
						
						console.log("업데이트 실패")
						$('#mpw_c').val('');
						$('#mpw').val('');
						$('#mpw_r').val('');
						$('#mpw_c').focus();
						
					} else if(resData == "2"){
						alert("비밀번호 변경에 실패하였습니다.")
						
						console.log("현재비밀번호 불일치")
						
						$('#mpw_c').val('');
						$('#mpw').val('');
						$('#mpw_r').val('');
						$('#mpw_c').focus();
					}
				}
				
				function whenError(e){
					alert("관리자에게 문의하세요");
					location.href="mySecpage.do";
				}
			}
		})// end of 확인버튼
		
		// 취소 버튼 선택
		$('#backBtn').on('click',function(){
			history.go(-1);
		})
		
	})
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
    	<!--board box-->
    	<div class="content_wrap">
    		<div class="check_head">
    			<p class="board_head">비밀번호변경</p>
				<p>안전한 비밀번호로 내정보를 보호하세요</p>
				<p>다른 아이디/사이트에서 사용한 적 없는 비밀번호</p>
				<p>이전에 사용한 적 없는 비밀번호</p>
    		</div>
    		<div class="content_group">
				<form id="changePwForm">
					<div id="show" v-cloak>
						<div class="member_content_section">
							<div class="member_content_t">
								<input type="password" id="mpw_c" name="mpw_c" placeholder="현재 비밀번호">
							</div>
						</div>
						<div class="member_content_section">
							<div class="member_content_p">
								<input type="password" id="mpw" name="mpw" placeholder="새 비밀번호" v-model="pw">
							</div>
							<div class="member_content_t">
								<input type="password" id="mpw_r" name="mpw_r" placeholder="새 비밀번호 확인" v-model="pw_r">
								<p><label>{{msg}}</label></p>
							</div>
						</div>
						<div>
							<input type="button" id="pwChange" class="result_btn" value="확인">
							<input type="button" id="backBtn" class="result_btn" value="취소">
						</div>
					</div>
				</form>
			</div><!--end of <div class="member_content">-->
		</div><!--end of <div class="member_box">-->
	</div><!--end of <div class="layout_box">-->
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>