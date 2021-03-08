<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>보안정보</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/mySecpage/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/mypage/mySecpage/mySecpage.css" charset="UTF-8">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/include/mypage/mySecpage/main.js" defer></script>
<!--jquery-3.2.1.min.js-->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 패스워드 변경 페이지로 이동
		$('#changePwFormgo').on('click',function(){
			
			location.href="changePwFormgo.do";
		})
		
		// 회원 탈퇴페이지로 이동
		$('#delMemberFormgo').on('click',function(){
			
			location.href="delMemberFormgo.do";
		})
		
		// 내가 쓴 글 목록 리스트로 이동
		
		
	});

</script>
</head>
<body>
	<!--navigator-->
	<jsp:include page="../common/mainnav.jsp"></jsp:include>
	<%--
    <nav class="navbar">
        <!--logo-->
        <div class="navbar_logo">
            <i class="fas fa-ice-cream"></i>
            <a href="#">FITHE</a>
        </div>
        <!--menu-->
        <ul class="navbar_menu">
            <!--unorder-list-->
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
    </nav>
    <!--end of <nav class="navbar">-->
	--%>
	
	<div id="show" class="fithe_wrap"><!-- mypage.jsp와는 다르게 mySecpage에서는 Vue.js 안씀 -->
		<div class="content_wrap">
		
			<div class="content_head">
				<ul class="my_menu">
					<li><a href="mypage.do">회원정보</a></li>
					<li><a href="mySecpage.do">보안정보</a></li>
					<li><a href="calendar.do">캘린더</a></li>
				</ul>
			</div>
			<!--<div class="content_head">-->
			
			<div class="content_group">
            	<div class="user_info">
            	    <div class="font_mid">비밀번호</div>
						<div>FitHe 로그인 시 사용하는 비밀번호를 변경할 수 있습니다.<br> 
						주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요.</div>
                    <div class="button_small">
                        <input type="button" id="changePwFormgo" class="sec_btn" value="변경하기">
                    </div>
                </div>
				<div class="user_info">
                    <div class="font_mid">회원탈퇴</div>
                    <div class="button_small">
                        <input type="button" id="delMemberFormgo" class="sec_btn" value="탈퇴하기">
                    </div>
                </div>
                <div class="user_info_d">
                    <div class="font_mid">내가 작성한 글 목록</div>
                    <div class="button_small">
                        <input type="button" id="" class="sec_btn" value="확인하기">
                    </div>
                </div>
            </div><!--<div class="content_group">-->
		</div><!--<div class="content_wrap">-->
	</div>
	
	<!-- footer -->
	<jsp:include page="../common/mainfooter.jsp"></jsp:include>
</body>
</html>