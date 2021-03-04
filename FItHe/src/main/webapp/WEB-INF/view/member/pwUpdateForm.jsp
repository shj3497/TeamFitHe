<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PW CHANGE</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind3/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind3/pwUpdateForm.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/member_login/pwfind3/main.js" defer></script>
    
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var vm = new Vue({
			el:'#show',
			data:{
				mid:"${memberVO.mid}",
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
		}) // end of Vue()
		
		$('#pwUpdate').on('click',function(){

			if(!chkSubmit($('#mpw'),"새 비밀번호를 ")){
				return ;
			}else if(!chkSubmit($('#mpw_r'),"새 비밀번호 확인을")){
				return ;
			}else{
				let goURL="pwUpdate.do";
				let method = "POST";
				let params = {
						mid:$('#mid').val(),
						mpw:$('#mpw').val()
				}
				
				$.ajax({
					url:goURL,
					type:method,
					data:params,
					success:whenSuccess,
					error:whenError
				})
				
				function whenSuccess(resData){
					alert("패스워드가 변경 되었습니다.");
					
					if(resData == 1){
						location.href="memberLoginForm.do"
					}else if(resData == 0){
						alert("패스워드 변경에 실패하였습니다. 관리자에게 문의하세요");
					}
				}
				
				function whenError(e){
					alert("시스템 오류입니다. 관리자에게문의해주세요." + e);
				}
			}// end of else{}
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
			<!-- 로그인 header -->
			<div class="check_head">
				<p class="board_head">PW 찾기</p>
				<p>영문, 숫자, 특수문자를 함께 사용하면(8자 이상 16자 이하)보다 안전합니다.</p>
				<p>다른 사이트와 다른 FitHe 아이디만의 비밀번호를 만들어 주세요.</p>
			</div>
			<!-- PW찾기 -->
			<div class="content_group">
				<form id="pwUpdateForm">
					<div id="show" v-cloak>
						<input type="hidden" id="mid" name="mid" value="${memberVO.mid}">
						<label class="login_content_id">FitHe 아이디 : {{mid}}</label>
						<div class="login_content_section">
							<input type="password" id="mpw" name="mpw" placeholder="새 비밀번호" v-model="pw"><br>
							<input type="password" id="mpw_r" placeholder="새 비밀번호 확인" v-model="pw_r"><br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label>{{msg}}</label>
						</div>
						<div>
							<input type="button" class="login_btn" id="pwUpdate" value="확인">
						</div>
					</div>
				</form>	
			</div><!--<div class="content_group">-->
		</div><!--end of <div class="content_wrap">-->
	</div><!--end of <div class="fithe_wrap">-->
	
	<!--footer-->
	<footer> 
		<p>TEAM : FITHE (핏해)</p>
		<address>github</address>
		<small>&copy unclepapa</small> 
	</footer>
</body>
</html>