<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<% 
	// 컨텍스트 주소 불러오기
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 상세페이지</title>
    <!--common stylesheet-->
    <link rel="stylesheet" href="${ctx}/css/style.css">
    <!--style-->
    <link rel="stylesheet" href="${ctx}/css/board_detail.css">
    <!--font-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
    <!--common script-->
    <script src="${ctx}/include/js/main.js" defer></script>
    <script src="//code.jquery.com/jquery-latest.min.js"></script>
    <!--javascript-->
    <script type="text/javascript">
	$(document).ready(function(){
		// 작성한 글의 작성자가 아니면 수정, 삭제 버튼 안보이게 하기
		if ("${communityDetail.mid}" != "${sessionScope.mid}") {
			$(".userBtn").hide();
		}
		// 작성한 글의 작성자가 맞으면 수정, 삭제 버튼 보이게 하기
		if("${communityDetail.mid}" == "${sessionScope.mid}"){
			$(".userBtn").show(); 
		}
		// 관리자면 보이게 하기
		if ("${sessionScope.mauth}" == "A") {
			$(".userBtn").show();
		}
		// 수정 버튼 눌렀을 때
		$("#communityUpdatebtn").on("click", function(){
			$("#communityForm").attr({
				"action" : "communityCorrection.do",
				"method" : "POST",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 삭제 버튼 눌렀을 때
		$("#communityDeletebtn").on("click", function(){
			$.ajax({
				url : "communityDelete.do",
				type : "POST",
				data : {
					"cnum" : $("#cnum").val(),
					"mid" : $("#mid").val(),
				},
				success: function(data){
					if (data == "1") {
						alert("삭제에 성공했습니다.");
					} else{
						alert("삭제하지 못했습니다.");
					}
				},
				error : function(request,status,error){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				},
				complete : function(){
					if ('${boardtype}' == 'manage') {
						location.href = "communityManagement.do";
					} else{
						location.href = "communityList.do";
					}
				}
			});
		});
		// 목록 버튼 눌렀을 때
		$("#communityListbtn").on("click", function(){
			location.href = "communityList.do"
		});
	});
</script>
</head>
<body>
	<form id="communityForm" name="communityForm" >
		<input type="hidden" id="cnum" name="cnum" value="${communityDetail.cnum}">
		<input type="hidden" id="mid" name="mid" value="${communityDetail.mid}">
		<input type="hidden" id="boardtype" name="boardtype" value="${boardtype}">
		
		<!--navigator-->
	    <nav class="navbar">
	        <!--logo-->
	        <div class="navbar_logo">
	            <i class="fas fa-ice-cream"></i>
	            <a href="">FITHE</a>
	        </div>
	        <!--menu-->
	        <ul class="navbar_menu">
	            <!—unorder-list—>
	                <li><a href="">기초체력측정</a></li>
	                <li><a href="">헬스장 추천</a></li>
	                <li><a href="">게시판</a></li>
	                <li><a href="">마이페이지</a></li>
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
	    <div class="fithe_wrap">
        	<div class="content_wrap">
        		<div class="content_group">
					<table>
						<!--1. content_title-->
						<tr>
	                        <td>
	                            <div>
	                                <a href="communityList.do">자유게시판</a>
	                            </div>
	                            <div class="font_mid">${communityDetail.csubject}</div>
	                        </td>
                   		</tr>
						<tr class="user_content_info">
	                        <td>
	                            <div><i class="far fa-laugh-wink"></i></div>
	                            <div>
	                                ${communityDetail.mid}                            
	                                <div class="content_info">
	                                    ${communityDetail.cinsertdate} 조회수 : ${communityDetail.chit}
	                                </div>
	                            </div>
	                        </td>
                    	</tr>
                    	<!--2. content_content-->
						<tr>
                        	<td>${communityDetail.ccontent}</td>
                   		 </tr>
						<c:if test="${communityDetail.cfile != 'NA'}">
	                        <tr>
	                            <!--<%-- 파일을 업로드 하고 이클립스를 새로고침해야 파일을 컨텍스트에서 읽을 수 있다 이를 해결하기 위해 이클립스를 세팅을 따로 해준다 
	                                Window - Preferences - General - Workspace - refresh using native hook... check --%>-->
	                                <!--<%-- 테이블 틀 유지하기 위해 700고정 --%>-->
	                                <td>                                    
	                                    <img src="${pageContext.request.contextPath}/imgupload/${communityDetail.cfile}" />
	                                </td>
	                        </tr>
	                   </c:if>
	                        <tr>
		                        <td>
			                        
				                        	<jsp:include page="/WEB-INF/view/reply/replyForm.jsp" flush="false">
												<jsp:param name="cnum" value="${communityDetail.cnum}" />
											</jsp:include>
									
								</td>
							</tr>

                    	
					</table>
					<div class="btn_group">
	                    <div>
	                        <input type="button" value="수정" name="communityUpdatebtn" id="communityUpdatebtn" class="userBtn">
	                        <input type="button" value="삭제" name="communityDeletebtn" id="communityDeletebtn" class="userBtn">
	                    </div>
	                    	<input type="button" value="자유게시판 글 더보기 " name="communityListbtn" id="communityListbtn">
			        </div>
				</div>
            	<!--<div class="content_group">-->
        	</div>
        	<!--end of <div class="content_wrap">-->
    	</div>
    	<!--end of <div class="fithe_wrap">-->

	</form>
</body>
</html>