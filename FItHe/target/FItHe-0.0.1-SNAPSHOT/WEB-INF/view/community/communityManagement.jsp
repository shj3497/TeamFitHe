<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 관리 페이지 </title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		// 관리자 구분은 컨트롤러에서 처리했음
		
		// 전체선택 누르면 모든 체크박스 체크, 다시 누르면 해제도?
		$("#allCheck").on("click", function(){
			// 체크되면
			if ($("#allCheck").prop("checked")) {
				$("input[name=rowCheck]").prop("checked", true);
			}
			// 체크 해제되면
			if (!$("#allCheck").prop("checked")) {
				$("input[name=rowCheck]").prop("checked", false);
			}
		});
		// 작성 버튼 누름
		$("#insertCommunity").on("click", function(){
			$("#communityForm").attr({
				"method" : "POST",
				"action" : "communityForm.do",
				"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 삭제 버튼 누름
		$("#deleteCommunity").on("click", function(){
			// 체크박스가 1개이상 체크되지 않았으면 경고표시
			// alert("삭제버튼");
			$('input:checkbox[name="rowCheck"]').each(function(){
				if(this.checked){
					// alert(this.value);
					$.ajax({
						url : "communityDelete.do",
						type : "POST",
						data : {
							"cnum" : $(this).val(),
							"mid" : $("#mid").val()
						},
						error : function(){
							alert("연결에 문제가 있습니다");
						}
					});
				}
				// 페이지 새로고침
				window.location.reload();
			});
			/*
			$("#communityForm").attr({
					"action" : "communityDelete.do",
					"method" : "POST",
					"enctype": "application/x-www-form-urlencoded"
			}).submit();
			*/
		});
		// 자유게시글 제목 누르면 상세 페이지 처리 함수
		$(".communityDetail").on("click", function(){
			// alert("상세글");
			var cnum = $(this).parents("tr").attr("data-num");
			$("#cnum").val(cnum);
			// alert(cnum);
			$("#communityForm").attr({
					"method" : "POST",
					"action" : "communityDetail.do",
					"enctype" : "application/x-www-form-urlencoded"
			}).submit();
		});
		// 검색기능
		$("#searchBtn").on("click", function(){
			$("#communityForm").attr({
				"method" : "GET",
				"action" : "communityManagement.do",
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
	// 검색 필터 기능
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		
		location.href="communityManagement.do?nowPage=1&cntPerPage="+sel+"&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}";
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
		
		location.href = "communityManagement.do?nowPage=1&cntPerPage="+sel+"&keyfilter=${paging.keyfilter}"
					  + "&keyword=${paging.keyword}&order_by="+$('#order_by').val()+"&order_sc="+$('#order_sc').val();
	}
</script>
<body>
	<form name="communityForm" id="communityForm">
		<input type="hidden" name="cnum" id="cnum" />
		<input type="hidden" name="boardtype" id="boardtype" value="manage"/>
		<input type="hidden" name="order_by" id="order_by" value="${paging.order_by}"/>
 		<input type="hidden" name="order_sc" id="order_sc" value="${paging.order_sc}"/>
		<div id="communityList" style="width: 900px;">
			<h3 align="center">자유게시글 관리</h3>
			<!-- ========== 옵션선택 시작  ==========-->
			<div style="float: right;">
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
			<br> <br>
			<!-- ========== 검색창  시작 ========== -->
			<div style="float: right;">
				<select id="keyfilter" name="keyfilter">
					<option value="keyall" id="keyall">제목 + 내용</option>
					<option value="keysubject" id="keysubject">제목</option>
					<option value="keymid" id="keymid">작성자</option>
				</select>
				<input type="search" id="keyword" name="keyword" placeholder="검색어를 입력" value="${paging.keyword}"/>
				<input type="button" id="searchBtn" value="검색">
			</div>
			<!-- ========== 검색창  끝   ========== -->
			<br> <br>
			<!-- ========== 테이블 시작 ========== -->
			<table style="width: 100%;" border="1">
				<colgroup>
					<!-- 테이블 column 크기 정해주기 -->
					<col width="10%"/>
					<col width="60%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="allCheck" name="allCheck" />전체선택
						</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>
                           	<a href="javascript:setOrder('CHIT');">조회수 &nbsp; <!-- <a href="javascript:setOrder('chit');">▲</a>  -->
                           		<c:choose> 
										<c:when test="${paging.order_by == 'CHIT' and paging.order_sc=='ASC'}">▲</c:when>
										<c:when test="${paging.order_by == 'CHIT' and paging.order_sc=='DESC'}">▼</c:when>
										<c:otherwise>▲</c:otherwise> 
								</c:choose>
							</a>
                        </th>
					</tr>
					<c:if test="${empty communityList}">
						<tr>
							<td colspan="6" align="center">등록된 게시글이 없습니다.</td>
						</tr>
					</c:if>
				</thead>
				<!-- =============== 데이터 출력 시작 =============== -->		
				<tbody>
					<c:forEach items="${communityList}" var="row">
						<tr data-num="${row.cnum}">	
							<td align="center">
								<input type="checkbox" name="rowCheck" value="${row.cnum}" >
							</td>				 
							<td align="center">
								<span class="communityDetail"><a href=# style="color: black"> ${row.csubject}</a></span>
							</td>
							<td align="center">${row.mid}</td>
							<td align="center">${row.cinsertdate}</td>
							<td align="center">${row.chit}</td>
						</tr>
					</c:forEach>
				</tbody>
				<!-- =============== 데이터 출력  끝 =============== -->
			</table>
			<!-- ========== 테이블 끝 ========== -->
			<div style="float: right;">
				<input type="button" id="insertCommunity" name="insertCommunity" value="작성" /> 
				<input type="button" id="deleteCommunity" name="deleteCommunity" value="삭제" /> 
			</div>
		</div>
		<!-- ========== 페이지 목록 시작 ========== -->
		<div style="display: block; text-align: center;">		
			<c:if test="${paging.startPage != 1 }">
				<a href="communityManagement.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">이전</a>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
				<c:choose> <%--  p: 현재 페이지 --%>
					<c:when test="${p == paging.nowPage}">
						<b>${p}</b>
					</c:when>
					<c:when test="${p != paging.nowPage}">
						<a href="communityManagement.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">[${p }]</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a href="communityManagement.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&keyfilter=${paging.keyfilter}&keyword=${paging.keyword}">다음</a>
			</c:if>
		</div>
		<!-- ========== 페이지 목록 끝 ========== -->
	</form>
</body>
</html>