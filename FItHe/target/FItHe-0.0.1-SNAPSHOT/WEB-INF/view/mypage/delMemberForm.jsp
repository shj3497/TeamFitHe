<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원탈퇴</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/delMemberForm/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/delMemberForm/delMemberForm.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/mypage/delMemberForm/main.js" defer></script>
    
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				msg:"FitHe/"+"${sessionScope.mid}",
				chkMsg:"",
			},
			watch:{
				chkMsg:function(chkMsg){
					var chkMsg = this.chkMsg;
					var msg = this.msg;
					if(msg == chkMsg){
						console.log("같음 진입")
					}
				}
			},
			methods:{
				goDelete:function(){
					console.log("탈퇴하기 버튼 선택")
					if(!chkSubmit($('#mpw'),"비밀번호를 ")){
						return ;
					}else{
						
						var goURL = "delMemberForm.do";
						var param = {
								mpw:$('#mpw').val()
						}
						var method = "POST";
						
						$.ajax({
							url:goURL,
							type:method,
							data:param,
							success:whenSuccess,
							error:whenError
						})
						
						function whenSuccess(resData){
							if(resData == "1"){
								alert("회원정보가 삭제되었습니다. FitHe를 이용해주셔서 감사합니다.");
								location.href="tempmain.do";
							}else if(resData == "2"){
								alert("비밀번호를 다시한번 확인해 주세요");
							}else if(resData == "0"){
								alert("관리자에게 문의하세요");
							}
								
						}
						
						function whenError(e){
							alert("에러가 발생하였습니다. 관리자에게 문의하세요" + e)
						}
					}
				}
			}
		})
	})
	
</script>
</head>
<body>
	<!--navigator-->
    <nav class="navbar">
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
    
    <div class="fithe_wrap">
    	<!--board box-->
    	<div class="content_wrap">
    		<div class="check_head">
    			<p class="board_head">탈퇴하기</p>
    		</div>
    		<!-- 회원가입 테이블 -->
    		<div class="content_group">
    			<form id="memWithdraw">
					<div id="show" v-cloak>
						<div class="member_content_section">
							<div class="member_content_t">
								<p>확인메세지 <span>{{msg}}</span>를 입력하세요</p>
								<input type="text" id="chkMsg" v-model="chkMsg">
							</div>
						</div>
						<div class="member_content_section">
							<div class="member_content_t">
								<input type="password" id="mpw" name="mpw" placeholder="현재 비밀번호">
							</div>
						</div>
						<div>
							<!-- 확인메세지를 입력해서 같으면 버튼이 활성화 비활성화된다. -->
							<span v-if="msg===chkMsg"><input type="button" id="memDelBtn" class="result_btn" value="탈퇴하기" @click="goDelete"></span>
							<span v-else><input type="button" class="middle_btn" value="탈퇴하기" disabled></span>
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