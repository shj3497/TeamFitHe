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
    <link rel="stylesheet" href="${ctx}/include/main/css/style.css"><!-- /css/style.css -->
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
		if ("${noticeDetail.mid}" != "${sessionScope.mid}") {
			$(".userBtn").hide();
		}
		// 작성한 글의 작성자가 맞으면 수정, 삭제 버튼 보이게 하기
		if("${noticeDetail.mid}" == "${sessionScope.mid}"){
			$(".userBtn").show(); 
		}
		// 관리자면 보이게 하기
		if ("${sessionScope.mauth}" == "A") {
			$(".userBtn").show();
		}
		// 수정 버튼 눌렀을 때 수정 페이지로 이동
		$("#noticeUpdatebtn").on("click", function(){
			$("#noticeForm").attr({
				"action" : "noticeCorrection.do",
				"method" : "POST",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 삭제 버튼 눌렀을 때
		$("#noticeDeletebtn").on("click", function(){
			/* $("#noticeForm").attr({
				"action" : "noticeDelete.do",
				"method" : "POST",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit(); */
			
			$.ajax({
				url : "noticeDelete.do",
				type : "POST",
				data : {
					"nnum" : $("#nnum").val(),
					"mid" : $("#mid").val()
				},
				success: function(data){
					if (data == "1") {
						alert("삭제에 성공했습니다.");
						location.href = "noticeList.do";
					} else{
						location.href = "noticeList.do";
					}
				},
				error : function(request,status,error){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				},
				complete : function(){
					if ('${boardtype}' == 'manage') {
						location.href = "noticeManagement.do";
					} else{
						location.href = "noticeList.do";
					}
				}
			});
		});
		// 목록 버튼 눌렀을 때
		$("#noticeListbtn").on("click", function(){
			location.href = "noticeList.do"
		});
	});
	</script>
</head>
<body>
	<form id="noticeForm" name="noticeForm">
		<input type="hidden" id="nnum" name="nnum" value="${noticeDetail.nnum}">
		<input type="hidden" id="mid" name="mid" value="${noticeDetail.mid}">
		<input type="hidden" id="boardtype" name="boardtype" value="${boardtype}">
		
		<!--navigator-->
	    <jsp:include page="../common/mainnav.jsp"></jsp:include>
	    
		<div class="fithe_wrap">
        	<div class="content_wrap">
        		<div class="content_group">
					<table>
						<!--1. content_title-->
						<tr>
	                        <td>
	                            <div>
	                                <a href="noticeList.do">공지게시판</a>
	                            </div>
	                            <div class="font_mid">${noticeDetail.nsubject}</div>
	                        </td>
                   		</tr>
                   		<tr class="user_content_info">
	                        <td>
	                            <div><i class="far fa-laugh-wink"></i></div>
	                            <div>
	                                ${noticeDetail.mid}                            
	                                <div class="content_info">
	                                    ${noticeDetail.ninsertdate} 조회수 : ${noticeDetail.nhit}
	                                </div>
	                            </div>
	                        </td>
                    	</tr>
                    	<!--2. content_content-->
						<tr>
							<td>${noticeDetail.ncontent}</td>
						</tr>
						<c:if test="${noticeDetail.nfile != 'NA'}">
							<tr>
								<%-- 파일을 업로드 하고 이클립스를 새로고침해야 파일을 컨텍스트에서 읽을 수 있다
									 이를 해결하기 위해 이클립스를 세팅을 따로 해준다
									 Window - Preferences - General - Workspace - refresh using native hook... check --%>
								<td>
									<img style="max-width: 700;" <%-- 테이블 틀 유지하기 위해 700고정 --%>
										 src="${pageContext.request.contextPath}/imgupload/${noticeDetail.nfile}" /> 
								</td>
							</tr>
						</c:if>
					</table>
					<div class="btn_group">
	                    <div>
	                        <input type="button" value="수정" name="noticeUpdatebtn" id="noticeUpdatebtn" class="userBtn">
	                        <input type="button" value="삭제" name="noticeDeletebtn" id="noticeDeletebtn" class="userBtn">
	                    </div>
	                    	<input type="button" value="공지게시판 글 더보기 " name="noticeListbtn" id="noticeListbtn">
			        </div>
				</div>
            	<!--<div class="content_group">-->
        	</div>
        	<!--end of <div class="content_wrap">-->
    	</div>
    	<!--end of <div class="fithe_wrap">-->
	</form>
	
	<!-- footer -->
	<jsp:include page="../common/mainfooter.jsp"></jsp:include>
</body>
</html>