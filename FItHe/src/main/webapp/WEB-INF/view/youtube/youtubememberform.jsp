<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fithe.youtube.vo.YoutubeVO" %>
<%
	Object obj = request.getAttribute("listy");
	List<YoutubeVO> listy = (List)obj;
%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>YOUTUBE FORM</title>
	<!--common stylesheet-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/style.css">
	<!--style-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/include/youtube/youtube.css">
	<!--font-->
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
	<title>check</title>
	<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
	<!--common script-->
	 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="${pageContext.request.contextPath}/include/youtube/js/menu.js" defer></script>
	<!--javascript--->
	<script type="text/javascript">
		$(document).ready(function () {
			$(document).on("click", "#button1", function () {
				$.ajax({
					url: "youtubeselect.do",
					type: "POST",
					data: {
						yid: $("#btn1").val(),
					},
					success: function (data) {
						if (data == "G") {
							alert("근지구력");
							$("#yid").val("1");
							$("#youtubeform").attr({
								"method": "POST",
								"action": "youtube.do"
							}).submit();
						} else {
							alert("동영상이 없습니다.")
						}
					},
					error: function (error) {
						alert("error : " + error)
					}
				});
			});
			$(document).on("click", "#button2", function () {
				$.ajax({
					url: "youtubeselect.do",
					type: "POST",
					data: {
						yid: $("#btn2").val(),
					},
					success: function (data) {
						if (data == "G") {
							alert("유연성");
							$("#yid").val("2");
							$("#youtubeform").attr({
								"method": "POST",
								"action": "youtube.do"
							}).submit();
						} else {
							alert("동영상이 없습니다.")
						}
					},
					error: function (error) {
						alert("error : " + error)
					}
				});

			});

			$(document).on("click", "#button3", function () {
				$.ajax({
					url: "youtubeselect.do",
					type: "POST",
					data: {
						yid: $("#btn3").val(),
					},
					success: function (data) {
						if (data == "G") {
							alert("순발력");
							$("#yid").val("3");
							$("#youtubeform").attr({
								"method": "POST",
								"action": "youtube.do"
							}).submit();
						} else {
							alert("동영상이 없습니다.")
						}
					},
					error: function (error) {
						alert("error : " + error)
					}
				});
			});

			$(document).on("click", "#button4", function () {
				$.ajax({
					url: "youtubeselect.do",
					type: "POST",
					data: {
						yid: $("#btn4").val(),
					},
					success: function (data) {
						if (data == "G") {
							alert("민첩성");
							$("#yid").val("4");
							$("#youtubeform").attr({
								"method": "POST",
								"action": "youtube.do"
							}).submit();
						} else {
							alert("동영상이 없습니다.")
						}
					},
					error: function (error) {
						alert("error : " + error)
					}
				});
			});

			$(document).on("click", "#button5", function () {
				$.ajax({
					url: "youtubeselect.do",
					type: "POST",
					data: {
						yid: $("#btn5").val(),
					},
					success: function (data) {
						if (data == "G") {
							alert("심폐지구력");
							$("#yid").val("5");
							$("#youtubeform").attr({
								"method": "POST",
								"action": "youtube.do"
							}).submit();
						} else {
							alert("동영상이 없습니다.")
						}
					},
					error: function (error) {
						alert("error : " + error)
					}
				});
			});
		});

	</script>
</head>

<body>
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
		
	<div class="fithe_wrap">
		<div class="content_wrap">	
			<div class="content_head" data-tooltip-text="♥ 근육그뉵근육그뉵 ♥">
				<img class="fitness_img" src="${pageContext.request.contextPath}/include/youtube/img/circle_logo_4.png">
				당신의 핏을 위한 운동
			</div>
			<div class="content_head_explain">
				필요한 요소에 따른 운동 영상을 구분해둔 페이지입니다.<br>
				기초 체력 측정을 통한 결과지에서 나에게 어떤 요소가 필요한지 알아보세요.<br>
				오늘도 핏해핏해!!<br>
			</div>
			<hr>
			<div class="content_group">
				<form id="youtubeform" class="youtubeform">
					<input type="hidden" name="yid" id="yid" value="${yid }">
					<table>
						<thead>
							<tr>
								<td colspan="2">									
									<input type="button" id="button1" name="button1" value="근지구력" />
                                    <input type="hidden" id="btn1" value="1">
                                    <input type="button" id="button2" name="button2" value="유연성" />
                                    <input type="hidden" id="btn2" value="2">
                                    <input type="button" id="button3" name="button3" value="순발력" />
                                    <input type="hidden" id="btn3" value="3">
                                    <input type="button" id="button4" name="button4" value="민첩성" />
                                    <input type="hidden" id="btn4" value="4">
                                    <input type="button" id="button5" name="button5" value="심폐지구력" />
                                    <input type="hidden" id="btn5" value="5">
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<% if(listy.size()> 0){
									for(int i=0; i<listy.size(); i++){ 
										YoutubeVO yvo=(YoutubeVO)listy.get(i); %>
										<td>
											<%=yvo.getYlink() %>
										</td>
											<% if(i%2==1){ %>
							</tr>
							<tr>
								<%			} 
										} 
									} %>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<!--<div class="content_group">-->

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
					<li><a href="#"><img src="${pageContext.request.contextPath}/include/youtube/img/facebook_logo.png"></a></li>
					<li><a href="https://www.instagram.com/fithe_2021/"><img src="${pageContext.request.contextPath}/include/youtube/img/instagram_circle.png"></a></li>
					<li><a href="https://www.notion.so/springiscoming/2021-FITHE-8f4a814cfc5040bbbb92897833f7676a">
							<img src="${pageContext.request.contextPath}/include/youtube/img/blog_logo.png"></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!--=========================// END footer //=========================-->
</body>

</html>