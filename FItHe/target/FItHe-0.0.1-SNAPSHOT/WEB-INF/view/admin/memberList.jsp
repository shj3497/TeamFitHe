<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tag" uri="/WEB-INF/tld/custom_tag.tld" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>manager</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/include/js/common.js"></script>
<!--common stylesheet-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/css/style.css">
<!---->
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/css/manager.css">
<!--font-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
<!--common script-->
<script src="${pageContext.request.contextPath}/include/js/menu.js" defer></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 검색 후 검색 대상과 검색 단어 출력
		if("<c:out value='${data.keyword}' />" != ""){
			// c:out은 문자열로 만드는 것이다.
			$('#keyword').val("<c:out value='${data.keyword}' />");
			$('#search').val("<c:out value='${data.search}' />");
		}
		
		// 한 페이지에 보여줄 레코드 수 조회후 선택 값 유지하기 위한 설정
		if("<c:out value='${data.pageSize}' />" != ""){
			$('#pageSize').val("<c:out value='${data.pageSize}' />");
		}
		
		/* 검색 대상이 변경될 때마다 처리 이벤트 */
		$('#search').on('change',function(){
			if($("#search").val() == "all"){
				$('#keyword').val('전체 데이터 조회합니다.');
			}else if($('#search').val() != "all"){
				$('#keyword').val('');
				$('#keyword').focus();
			}
		});
		
		/* 검색 버튼 클릭시 처리 이벤트 */
		$('#searchData').on('click',function(){
			if($('#search').val() != "all"){
				if(!chkSubmit($('#keyword'), "검색어를")){
					return;
				}
				
				goPage(1); // 검색버튼 클릭시 검색의 결과를 다시 1페이지 부터 보여준다는 소리
			}
		});
		
		// 한 페이지에 보여줄 레코드 수
		$('#pageSize').on('change',function(){
			goPage(1);
		})
		
		// 탈퇴 버튼 처리 이벤트
		$('.memDelBtn').on('click', function(){
			
			var goURL = "adminDelete.do";
			var method = "POST";
			var deldata = {
					mid:$(this).val()
			};
			
			$.ajax({
				url:goURL,
				type:method,
				data:deldata,
				success:whenSuccess,
				error:whenError
			});
			
			function whenSuccess(resData){
			
				if(resData=="1"){
					alert("탈퇴처리되었습니다.");
					goPage(1);
					
				}else if(resData=="0"){
					alert("탈퇴처리 실패하였습니다.");
				}
			}
			
			function whenError(e){
				console.log("e >>> : " + e)
			}
		});		
		
		// 로그아웃 버튼
		$('#logoutgo').on('click',function(){
			location.href="memberLogout.do";
		})
		
	});
	
	// 정렬 버튼 클릭시 처리함수
	function setOrder(order_by){
		$('#order_by').val(order_by); // 히든태그로 설정된 order_by에 val() 부여
		if($('#order_sc').val() == 'DESC'){
			$('#order_sc').val('ASC');
		}else{
			$('#order_sc').val('DESC');
		}
		goPage(1);
	}
	
	function goPage(page){
		console.log("goPage() 진입");
		if($('#search').val() == 'all'){
			$('#keyword').val('');
		}
		$('#page').val(page);
		$('#f_search').attr({
			'method':'GET',
			'action':"memberList.do"
		});
		$('#f_search').submit();
	}


</script>
</head>
<body>
<!-- 회원 전체 조회 -->
	<div class="fithe_wrap">
		<div>
			<!--(1) management bar-->
			<div class="menu_align">
				<div class="navbar_logo">
					<i class="fas fa-ice-cream"></i>
					<a href="#">FITHE</a>
				</div>
				<!--manager info-->
				<div class="thumb">
					<img class="img-circle" width="68" height="68" alt="관리자 이미지" src="${pageContext.request.contextPath}/include/img/sports.jpg" />
					<div>관리자</div>
					<div><a href="memberLogout.do">로그아웃</a></div>
				</div>
				<!--menu link-->
				<div class="menu_link">
					<ul>
						<li><a href="memberList.do">회원관리</a></li>
						<li><a href="#">게시판 관리</a></li>
						<li><a href="#">공지사항 관리</a></li>
					</ul>
				</div>
			</div>
			<!--end of <div class="menu_align">-->
			<!--animation : tablet version-->
			<div class="gif_animation">
				<iframe src="${pageContext.request.contextPath}/include/img/running.gif" width="100%" height="200" frameBorder="0" class="giphy-embed"
					scrolling="no" allowFullScreen></iframe>
			</div>
			<!--(2) content-->
			<div id="memberListForm" class="manage_group">
				<!--title : web version-->
				<div class="content_title">회원관리</div>
				<!--title : tablet version-->
				<div class="content_head">		
					<select onchange="window.location.href=this.value">
						<option value="none">=== 선택 ===</option>
						<option value="memberList.do" selected>회원관리</option>
						<option value="#">게시판 관리</option>
						<option value="#">회원관리</option>
					</select>
				</div>
			</div>

			<!--end of <div class="menu_align">-->
			<div id="memberListForm">
				<%-- === 검색기능!! === --%>
				<div id="memberSearch" class="content_search">
					<form id="f_search" name="f_search">
						<input type="hidden" id="page" name="page" value="${data.page }">
						<input type="hidden" id="order_by" name="order_by" value="${data.order_by }">
						<input type="hidden" id="order_sc" name="order_sc" value="${data.order_sc }">
						<table summary="검색">
							<colgroup>
								<col width="70%" />
								<col width="30%" />
							</colgroup>
							<tr>
								<td id="btd1" class="content_table_td_1">
									<label>검색조건</label>
									<select id="search" name="search">
										<option value="" disabled selected>선택하세요</option>
										<option value="mid">아이디</option>
										<option value="mname">이름</option>
									</select>
									<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요">
									<input type="button" id="searchData" value="검색" class="com_btn">
								</td>
								<!-- btd2 우측 끝 -->
								<td id="btd2" class="content_table_td_2">
									<select id="pageSize" name="pageSize">
										<option value="10">10줄</option>
										<option value="20">20줄</option>
										<option value="50">50줄</option>
										<option value="100">100줄</option>
									</select>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<%-- === 검색기능 끝!! === --%>
				<%-- === 리스트 시작!! === --%>
				<div id="memberList" class="manage_group_list">
					<table summary="회원 리스트">
						<colgroup>
							<col width="10%" />
							<!--회원번호-->
							<col width="20%" />
							<!--아이디-->
							<col width="20%" />
							<!--회원이름-->
							<col width="25%" />
							<!--가입일-->
							<col width="5%" />
							<!--등록여부-->
							<col width="20%" />
							<!--button-->
						</colgroup>
						<thead class="list_head">
							<tr>
								<th>회원 번호</th>
								<th>아이디</th>
								<th>회원 이름</th>
								<th>
									<a href="javascript:setOrder('minsertdate');">가입일
										<c:choose>
											<c:when test="${data.order_by == 'minsertdate' and data.order_sc == 'ASC' }"><span class="shapes_sty">&#9650</span></c:when>
											<c:when test="${data.order_by == 'minsertdate' and data.order_sc == 'DESC' }"><span class="shapes_sty">&#9660</c:when>
											<c:otherwise><span class="shapes_sty">&#9650</span></c:otherwise>
										</c:choose>
									</a>
								</th>
								<th>등록여부</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody class="list_body">
							<!-- 데이터 출력 -->
							<c:choose>
								<c:when test="${not empty memberList }">
									<c:forEach var="member" items="${memberList}" varStatus="status">
									<!-- member in memberList -->
										<tr align="center">
											<td>${member.mnum}</td>
											<td>${member.mid}</td>
											<td>${member.mname}</td>
											<td>${member.minsertdate}</td>
											<td>${member.mdelyn}</td>
											<td><button class='memDelBtn' id="mid" name="mid" value="${member.mid}">탈퇴</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" align="center">등록된 회원이 존재 하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<%-- === 리스트 종료 === --%>
				<%-- === 페이지 네비게이션 시작 === --%>
				<div id="memberPage">
					<tag:paging page="${param.page}" total="${total}" list_size="${data.pageSize}" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>