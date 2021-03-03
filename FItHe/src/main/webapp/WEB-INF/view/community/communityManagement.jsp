<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<% 
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시글 관리 페이지</title>
    <!--common stylesheet-->
    <link rel="stylesheet" href="./css/style.css">
    <!---->
    <link rel="stylesheet" href="./css/manager.css">
    <link rel="stylesheet" href="./css/manager_board.css">
    <!--font-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
    <!--common script-->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!--javascript-->
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
</head>

<body>
    <form name="communityForm" id="communityForm">
    	<input type="hidden" name="cnum" id="cnum" />
        <input type="hidden" name="boardtype" id="boardtype" value="manage"/>
        <input type="hidden" name="order_by" id="order_by" value="${paging.order_by}"/>
        <input type="hidden" name="order_sc" id="order_sc" value="${paging.order_sc}"/>
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
                        <img class="img-circle" width="68" height="68" alt="관리자 이미지" src="./img/sports.jpg" />
                        <div>관리자</div>
                        <div><a href="#">로그아웃</a></div>
                    </div>
                    <!--menu link-->
                    <div class="menu_link">
                        <ul>
                            <li><a href="#">회원관리</a></li>
                            <li><a href="#">게시판 관리</a></li>
                            <li><a href="#">공지사항 관리</a></li>
                        </ul>
                    </div>
                </div>
                <!--end of <div class="menu_align">-->

                <div class="gif_head">
                    <img src="./img/giphy.gif" class="giphy-embed" height="200px">
                </div>
                <!--(2) content-->
                <div class="manage_group">
                    <!--title : web version-->
                    <div class="content_title">자유게시글 관리</div>
                    <!--title : pad version-->
                    <div class="content_head">
                        <select onchange="window.location.href=this.value">
                            <option value="none">=== 선택 ===</option>
                            <option value="#">회원관리</option>
                            <option value="#" selected>게시판 관리</option>
                            <option value="#">공지 게시판 관리</option>
                        </select>
                    </div>

                    <!--##################################################################-->
                    <div>
                        <div class="content_search">
                            <div id="communityList">
                                <div class="content_table_td_1">
                                    <!-- ========== 검색창  시작 ========== -->
                                    <div>
                                        <select id="keyfilter" name="keyfilter">
                                            <option value="keyall" id="keyall">제목 + 내용</option>
                                            <option value="keysubject" id="keysubject">제목</option>
                                            <option value="keymid" id="keymid">작성자</option>
                                        </select>
                                        <input type="search" id="keyword" name="keyword" placeholder="검색어를 입력" value="${paging.keyword}"/>
                                        <input type="button" id="searchBtn" value="검색" class="com_btn">
                                    </div>
                                    <!-- ========== 검색창  끝   ========== -->

                                    <!-- ========== 옵션선택 시작  ==========-->
                                    <div>
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
                                </div>
                            </div>
                        </div>
                        <!--end of <div class="content_search">-->
                    </div>
                    

                    <div class="manage_group_list">
                        <!-- ========== 테이블 시작 ========== -->
                        <table>
                            <colgroup>
                                <col width="20%" />
								<!--전체선택-->
								<col width="40%" />
								<!--제목-->
								<col width="10%" />
								<!--작성자-->
								<col width="20%" />
								<!--작성일-->
								<col width="15%" />
								<!--조회수-->
                            </colgroup>
                            <thead class="list_head">
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
                                                 <c:when test="${paging.order_by == 'CHIT' and paging.order_sc=='ASC'}">
                                                    <span class="shapes_sty">&#9650</span>
                                                </c:when>
                                                 <c:when test="${paging.order_by == 'CHIT' and paging.order_sc=='DESC'}">
                                                    <span class="shapes_sty">&#9660</span>
                                                 </c:when>
                                                 <c:otherwise><span class="shapes_sty">&#9650</span></c:otherwise> 
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
                            <tbody class="list_body">
                                <c:forEach items="${communityList}" var="row">
                                    <tr data-num="${row.cnum}">	
                                        <td>
                                            <input type="checkbox" name="rowCheck" value="${row.cnum}" >
                                        </td>				 
                                        <td>
                                            <span class="communityDetail"><a href=#> ${row.csubject}</a></span>
                                        </td>
                                        <td>${row.mid}</td>
                                        <td>${row.cinsertdate}</td>
                                        <td>${row.chit}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <!-- =============== 데이터 출력  끝 =============== -->
                        </table>
                        <!-- ========== 테이블 끝 ========== -->
                    </div>
                    <!--end of <div class="manage_group_list">-->
                </div>
                <!--end of <div class="manage_group">-->
            </div>

            <div class="manage_bottom">
                <!--button-->
                <div>
                    <input type="button" id="insertCommunity" name="insertCommunity" value="작성" class="com_btn" />
                    <input type="button" id="deleteCommunity" name="deleteCommunity" value="삭제" class="com_btn" />
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
            </div>
            <!--end of <div class="manage_bottom">-->
        </div>
        <!--end of <div class="fithe_wrap">-->
    </form>
</body>
</html>