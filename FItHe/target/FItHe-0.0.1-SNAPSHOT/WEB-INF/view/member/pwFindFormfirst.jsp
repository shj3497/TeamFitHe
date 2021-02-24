<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PW 찾기</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind1/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/member_login/pwfind1/pwFindFormFirst.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--script-->
<script src="${pageContext.request.contextPath}/include/member_login/pwfind1/main.js" defer></script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$('#findPW_next').on('click',function(){
			
			if(!chkSubmit($('#mid'), "FitHe 아이디를")){
				return ;
			} else{
				$('#pwFindForm_1').attr('method','POST')
				$('#pwFindForm_1').attr('action','pwFindfirst.do')
				$('#pwFindForm_1').submit();
			}
		})
	})
	
</script>
</head>
<body>
<!-- pw를 찾는 과정에 있어 첫번쨰로 id를 입력받는다. -->
<!-- 해당하는 정보가 있으면 다음페이지로 이동하여 이름,이메일을 입력받아 인증번호를 확인한다. -->
<!-- 인증번호가 확인되면 새로운 비밀번호 설정에 들어간다. -->
<!-- 새로운 비밀번호가 입력되면 db에 있는 pw업데이트해주고, 로그인 페이지로 이동한다. -->
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
    	<!-- board box -->
    	<div class="content_wrap">
    		<!-- 로그인 header -->
    		<div class="check_head">
    			<p class="board_head">PW 찾기</p>
				<p>FitHe 아이디를 입력해 주세요</p>
    		</div>
    		<!-- 로그인 -->
    		<div class="content_group">
				<form id="pwFindForm_1">
					<div class="login_content_section">
						<label>아이디</label>
						<div class="login_content_t">
							<input type="text" id="mid" name="mid" placeholder="FitHe 아이디">
						</div>		
					</div>
					<div>
						<input type="button" id="findPW_next" class="login_btn" value="다음">
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