<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="main" content="width=device-width, initial-scale=1.0">
<title>FitHe</title>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/style.css">
<!--style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/main/css/main.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script
<script src="${pageContext.request.contextPath}/include/main/js/menu.js" defer></script>-->
<script src="//code.jquery.com/jquery-latest.min.js"></script>
<!--javaScript-->
<script src="${pageContext.request.contextPath}/include/main/js/main.js" defer></script>
</head>
<body>
<!-- 
	<a href="test.do">클릭클릭!!</a><br>
	<a href="memberInsertForm.do">회원가입 폼</a><br>
	<a href="memberLoginForm.do">로그인 폼</a><br>
	<a href="mypage.do">내정보 보기</a>
	
	<hr>
	<a href="noticeList.do">공지사항 게시판 리스트</a> <br>
	<a href="communityList.do">커뮤니티 게시판 리스트</a> <br>
	
	<hr>
	<a href="noticeManagement.do">공지사항 관리 페이지</a> <br>
	<a href="communityManagement.do">자유게시판 관리 페이지</a>
	
	<hr>
	<a href="kakaomaplist.do">카카오맵 리스트 </a> <br>
 -->

	<!--navigator-->
	<%--
	<nav id="navshow" class="navbar">
		<!--logo-->
		<div class="navbar_logo">
			<i class="fas fa-anchor"></i>
			<a href="#">FITHE</a>
		</div>
		<!--menu-->
		<ul class="navbar_menu">
				<li><a href="#">기초체력측정</a></li>
				<li><a href="kakaomaplist.do">헬스장 추천</a></li>
				<li><a href="#">게시판</a></li>
		</ul>
		<!--login icon-->
		<ul v-if="session_chk==='null'" class="navbar_icons">
			<li><a href="memberLoginForm.do">로그인<i class="fas fa-user-plus"></i></a></li>
			<!-- <li><a href="mypage.do">mypage<i class="fas fa-user-plus"></i></a></li> -->
		</ul>
		<ul v-else class="navbar_icons">
			<li>{{session_mid}}</li>
			<li><a href="mypage.do">내정보</a></li>
			<li><a href="mailto:testshj3497@gmail.com">고객지원</a></li>
			<li><a href="memberLogout.do">로그아웃</a></li>
		</ul>
		
		<!--@pad @phone-->
		<a href="#" class="navbar_toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
	</nav>
 	--%>
 	<jsp:include page="../common/mainnav.jsp"></jsp:include>
 	
	<!--content-->
	<div class="fithe_wrap">
		<div class="content_wrap">
			<!--banner-->
			<div class="banner">
				<ul>
					<li><img src="${pageContext.request.contextPath}/include/main/img/banner/pc_banner_5.png"></li>
					<li><img src="${pageContext.request.contextPath}/include/main/img/banner/pc_banner_2.png"></li>
					<li><img src="${pageContext.request.contextPath}/include/main/img/banner/pc_banner_3.png"></li>
					<li><img src="${pageContext.request.contextPath}/include/main/img/banner/pc_banner_4.png"></li>
					<li><img src="${pageContext.request.contextPath}/include/main/img/banner/pc_banner_1.png"></li>
				</ul>
			</div>
		
			<!--infomation-->
			<div class="content_info">
			
				<div>
					<img class="rotate_txt" src="${pageContext.request.contextPath}/include/main/img/circle_logo_3.png">
					<p>FIT YOUR HEALTHY LIFE WITH US</p>
				</div>
				
				<div class="problem_section">
					<div>PROBLEM</div>
					<div>
						<span><a href="http://ncov.mohw.go.kr/">코로나 19</a></span>
						<span><a href="http://ncov.mohw.go.kr/tcmBoardView.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=362950&contSeq=362950&board_id=140&gubun=BDJ">체육시설 이용에 제한</a></span>
						<span><a href="https://info.incruit.com/pr/report_view.asp?newsno=4438375">확찐자 증가</a></span>
					</div>
					<a href="https://www.khealth.or.kr/kps/publish/view?menuId=MENU00891&page_no=B2017004&pageNum=1&siteId=&srch_text=&srch_cate=&srch_type=&str_clft_cd_list=&str_clft_cd_type_list=&board_idx=10374">
						적합한 운동(건강관리) 방법을 알 수 없어 효과적인 건강 관리에 어려움
					</a> 
				</div>
				<div class="suggest_section">
					<div>SUGGEST</div>
					<span>자신의 몸 상태(기초체력)에 맞는 운동방법을 알고자 하는 고객 대상</span>
					<ul>
						<li>간단한 체력 수치를 기준 데이터(빅데이터)와 비교</li>
						<li>현재 고객의 체력 상태 및 위치를 파악</li>
						<li>결과를 시각화하여 결과 레포트를 제공</li>
						<li>현 체력 상태에서 부족한 체력 항목에 해당하는 운동 방법을 제안</li>
					</ul>
				</div>
				<!--
				<div>
					<div>ABOUT OUR TEAM</div>
					<ul>
						<li>
							<div>TEAM LEADER</div>
							<div>안석현</div>
						</li>
						<li>
							<div>TEAM MEMBER</div>
							<div>권기상, 문건일, 심혁진, 이유선, 임윤정, 임병찬, 최영</div>
						</li>
					</ul>
					<ul>
						<li>
							<div>DEVELOPMENT PERIODS</div>
							<div>2021.02.08 - 2021.03.08</div>
						</li>
						<li>
							<div>MAJOR TOOLS</div>
							<div>JAVA ...</div>
						</li>
					</ul>					
				</div>
				-->
			</div>
		</div>
		<!--end of <div class="content_wrap">-->
	</div>
	<!--end of <div class="fithe_wrap">-->

	<!--=========================// START footer //=========================-->
	<div class="footer_group">
		<!--kosmo info-->
		<div>
			<div>
				<ul>
					<li><a href="#">이용약관 ㅣ </a></li>
					<li><a href="#">개인정보처리방침</a></li>
				</ul>
				<p>(153-759) 서울시 금천구 가산동 426-5 월드메르디앙 2차 404호</p>
				<p>Copyright (C) 2021 KOSMO FITHE. All rights reserved.</p>
				<ul class="sns">
					<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/facebook_logo.png" width="25"></a></li>
					<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/instagram_circle.png" width="27"></a></li>
					<li><a href="#"><img src="${pageContext.request.contextPath}/include/main/img/blog_logo.png" width="20"></a></li>
				</ul>
			</div>			
		</div>
		<!--footer-->
		<div>
			
		</div>
	</div>
	<!--=========================// END footer //=========================-->
</body>
</html>