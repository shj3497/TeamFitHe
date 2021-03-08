<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<% 
	// 컨텍스트 주소 불러오기
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--common stylesheet-->
    <link rel="stylesheet" href="${ctx}/css/style.css">
	<!--style-->
	<link rel="stylesheet" href="${ctx}/css/board.css">
    <!--font-->
	<link rel="preconnect" href="https://fonts.gstatic.com"> 
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <title>공지게시판 목록</title>
    <script src="https://kit.fontawesome.com/8af2116aa4.js" 
            crossorigin="anonymous"></script>
	<!--common script-->
   	<script src="${ctx}/include/js/main.js" defer></script>
	<script src="//code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		// 작성 버튼 클릭
		$("#nformbtn").on("click", function(){
			$("#noticeForm").attr({
				"method" : "POST",
				"action" : "noticeForm.do",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 공지글 제목 누르면 상세 페이지 처리 함수
		$(".noticeDetail").on("click", function(){
			// alert("상세글");
			var nnum = $(this).parents("tr").attr("data-num");
			$("#nnum").val(nnum);
			// alert(nnum);
			$("#noticeForm").attr({
				"method" : "POST",
				"action" : "noticeDetail.do",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 공지글 숨기기 체크박스
		$("#noticeDisplayChk").on("click", function(){
			// 공지글 숨기기 체크되면
			if ($("#noticeDisplayChk").prop("checked") == true) {
				$(".notice_tr").hide();
			} else{
				$(".notice_tr").show();
			}
		});
		// 검색기능
		$("#searchBtn").on("click", function(){
			$("#noticeForm").attr({
				"method" : "GET",
				"action" : "noticeList.do",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 검색하고나서 검색 옵션 유지
		var searchoption = "${paging.keyfilter}";
		console.log(searchoption);
		if (searchoption.value == "keyall") {
			$("#keyall").attr('selected', true);
			console.log("keyall");
		}
		if (searchoption.value == "keysubject") {
			$("#keysubject").attr('selected', true);
			console.log("keysubject");
		}
		if (searchoption.value == "keymid") {
			$("#keymid").attr('selected', true);
			console.log("keymid");
		}
	});
		// 검색기능
		function selChange() {
			var sel = document.getElementById('cntPerPage').value;
			
			location.href="noticeList.do?nowPage=1&cntPerPage="+sel+"&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}";
		}
		// 정렬기능
		function setOrder(order_by){
			var sel = document.getElementById('cntPerPage').value;
			
			$("#order_by").val(order_by);
			
			if($("#order_sc").val()=='DESC'){
				$("#order_sc").val('ASC');
			} else{
				$("#order_sc").val('DESC');
			}
			
			location.href = "noticeList.do?nowPage=1&cntPerPage="+sel+"&keyfilter=${paging.keyfilter}"
						  + "&keyword=${paging.keyword}&order_by="+ $('#order_by').val() +"&order_sc="+$('#order_sc').val();
		}
	</script>
</head>
<body>
	<form name="noticeForm" id="noticeForm">
		<input type="hidden" name="nnum" id="nnum">
		<input type="hidden" name="boardtype" id="boardtype" value="common" />
		<input type="hidden" name="order_by" id="order_by" value="${paging.order_by}"/>
 		<input type="hidden" name="order_sc" id="order_sc" value="${paging.order_sc}"/>
		<!--navigator-->
	    <nav class="navbar">
	    	<!--logo-->
			<div class="navbar_logo">
	            <i class="fas fa-ice-cream"></i>
	            <a href="">FITHE</a>
	        </div>
			<!--menu-->
	        <ul class="navbar_menu">
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
	    </nav><!--end of <nav class="navbar">-->
	    
	    <div class="fithe_wrap" id="communityContainer">
			<!--board box-->
			<div class="content_wrap" id="outter">
			
			<!-- community board head -->
			<div class="content_head">
				<p>공지 게시판</p>
			</div>
	
			<div class="content_group">
	
				<!--board content list select & search-->
				<div class="board_content_bar">
					<!-- ========== 옵션선택 시작  ==========-->
					<div>
						<input type="checkbox" id="noticeDisplayChk" name="noticeDisplayChk" /> 공지글 숨기기
						<select id="cntPerPage" name="sel" onchange="selChange()">
							<option value="5"
								<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
							<option value="10"
								<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
							<option value="15"
								<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
							<option value="20"
								<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
						</select>
					</div>
					<!-- ========== 옵션선택 끝  ========== -->
					<!-- ========== 검색창  시작 ========== -->
					<div class="board_search">
						<select id="keyfilter" name="keyfilter">
							<option value="keyall" id="keyall">제목 + 내용</option>
							<option value="keysubject" id="keysubject">제목</option>
							<option value="keymid" id="keymid">작성자</option>
						</select> &nbsp;&nbsp;
						<input type="search" id="keyword" name="keyword" placeholder="무엇을 찾고 계세요?" value="${paging.keyword}"/>
						<input type="button" id="searchBtn" value="검색">
					</div>
					<!-- ========== 검색창  끝   ========== -->
				</div> <!-- end of <div class="board_content_bar">-->
			<!-- ========== 테이블 시작 ========== -->
				<!-- board table -->
				<div class="board_list">
					<table class="board_list_table">
						<!--table width-->
						<colgroup>
							<col width="60%"/>
							<col width="10%"/>
							<col width="20%"/>
							<col width="10%"/>
						</colgroup>
						<!--table head-->
						<thead class="board_list_head">
							<tr class="board_list_tr">
							<th>제목</th>
                           	<th>작성자</th>
                           	<th>
                           		작성일 
							</th>
								<th>
	                           		<a href="javascript:setOrder('NHIT');">조회수 &nbsp; <!-- <a href="javascript:setOrder('chit');">▲</a>  -->
	                           		<c:choose> 
											<c:when test="${paging.order_by == 'NHIT' and paging.order_sc=='ASC'}">▲</c:when>
											<c:when test="${paging.order_by == 'NHIT' and paging.order_sc=='DESC'}">▼</c:when>
											<c:otherwise>▲</c:otherwise> 
									</c:choose>
									</a>
                           		</th>
							</tr>
							<!-- ============================= 공지사항 표시 시작 ========================= -->
							<c:if test="${paging.nowPage == 1}"> <%-- 페이지 1일때만 표시 --%>
								<%-- 공지 숨기기 체크 박스 unchecked 되면 --%>
								<c:forEach items="${noticeExposureList}" var="notice">
									<tr class="notice_tr" data-num="${notice.nnum}">				 
										<td>
											<span class="notice__alarm">공지</span>
											<span class="noticeDetail">
												<a href=#>${notice.nsubject}</a> 
											</span>
										</td>
										<td>${notice.mid}</td>
										<td>${notice.ninsertdate}</td>
										<td>${notice.nhit}</td>
									</tr>
								</c:forEach>
							</c:if>
							<!-- ============================= 공지사항 표시 끝    =========================== -->
							<c:if test="${empty noticeList}">
								<tr>
									<td colspan="5" align="center">등록된 게시글이 없습니다.</td>
								</tr>
							</c:if>
						</thead>
						<!--공지사항 css class : notice-->
						<!--댓글?추천수? css class : ref_num-->
						<!--table body-->
						<!-- =============== 데이터 출력 시작 =============== -->	
						<tbody>
							<c:forEach items="${noticeList}" var="row">
								<tr data-num="${row.nnum}">				 
									<td>
										<span class="noticeDetail">
											<a href=#>${row.nsubject}</a>
										</span>
									</td>
									<td>${row.mid}</td>
									<td>${row.ninsertdate}</td>
									<td>${row.nhit}</td>
								</tr>
							</c:forEach>
						</tbody>
						<!-- =============== 데이터 출력  끝 =============== -->
					</table>
					<!-- ========== 테이블 끝 ========== -->
				</div><!--end of <div class="board_list">-->
				<!-- 글쓰기 버튼 -->
				<div class="board_write">
					<input type="button" id="nformbtn" name="nformbtn" class="com_btn" value="작성" />
					<br>
				</div>
				<!-- ========== 페이지 목록 시작 ========== -->
				<div class="board_list_paging">	
					<c:if test="${paging.startPage != 1 }">
						<a href="noticeList.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">이전</a>
					</c:if>
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
						<c:choose> <%--  p: 현재 페이지 --%>
							<c:when test="${p == paging.nowPage}">
								<b>${p}</b>
							</c:when>
							<c:when test="${p != paging.nowPage}">
								<a href="noticeList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">[${p }]</a>
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.endPage != paging.lastPage}">
						<a href="noticeList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">다음</a>
					</c:if>
				</div>
				<!-- ========== 페이지 목록 끝 ========== -->
			</div><!-- end of <div class="content_group"> -->
			</div><!--end of <div class="content_wrap">-->
		</div><!--end of <div class="fithe_wrap">-->
	</form>
</body>
</html>