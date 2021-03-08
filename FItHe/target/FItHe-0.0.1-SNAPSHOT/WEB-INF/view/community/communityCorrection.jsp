<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<% 
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판 수정페이지</title>
    <!--common stylesheet-->
    <link rel="stylesheet" href="${ctx}/css/style.css">
    <!--style-->
    <link rel="stylesheet" href="${ctx}/css/board_form.css">
    <!--font-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/8af2116aa4.js" crossorigin="anonymous"></script>
    <!--common script-->
    <script src="${ctx}/include/js/main.js" defer></script>
    <script src="//code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/common.js"></script>
    <!--javascript-->
    <script src="${ctx}/common/webedit/dist/js/service/HuskyEZCreator.js" charset="UTF-8"></script>
    <script type="text/javascript">
	
		$(document).ready(function(){
			//nhn 웹에디터 : 보안 취약점이 있어서 사용시 고려해야 함
			var oEditors = {};
			$(function(){
				nhn.husky.EZCreator.createInIFrame({
					oAppRef : oEditors,
					elPlaceHolder : "ccontent", // textarea id 				
					sSkinURI : "${ctx}/common/webedit/dist/SmartEditor2Skin.html", // SmartEditor2Skin.html 에디터 스킨 				
					fCreator : "createSEditor2"
				});
			});
			// 수정버튼
			$("#communityUpdatebtn").on("click", function(){
				/* alert("수정버튼 들어옴");
				alert($("#cnum").val());
				alert($("#cid").val());
				alert($("#cfile").val()); */
				
				oEditors.getById["ccontent"].exec("UPDATE_CONTENTS_FIELD", []);
				
				// Validation Check
				// 제목 빈칸체크
				if (!chkBoardItem($("#csubject"), "작성할 제목을")) return;
				else if (!chkBoardItem($("#ccontent"), "작성할 내용을")) return;
				// 올릴 파일이 있으면
				
					else if ($('#cfile').val() != "" &&  $('#cfile').length > 0) {
					var ext = $('#cfile').val().split('.').pop().toLowerCase();
					
					if(jQuery.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
					 alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					 return;
					 
					 	if($('#cfile').files[0].size > 2097152) {
						 	alert("파일 용량은 2MB까지 허용됩니다");
						 	return;
					 	}
					}
				}
				$("#communityForm").attr({
					'method':'POST',
					'action':'communityUpdate.do',
					'enctype':'multipart/form-data'
				}).submit();
			});
			// 이미지 수정하기 버튼 클릭
			$("#changeOption").on("click", function(){
				// alert("이미지 변경버튼 들어옴");
				$(".upload_file").remove(); // 수정버튼 삭제
				$(".fileUpdate").show(); // 이미지 변경, 삭제버튼 표시
			});
			// 이미지 변경하기 버튼 클릭
			$("#changeFilebtn").on("click", function(){
				$(this).next().remove(); //
				$(this).remove(); // 
				$(".fileUpdate").append(" <input type='file' id='cfile' name='cfile' />"); // 이미지 변경을 위해 file태그 추가
			});
			// 이미지 삭제하기 버튼 클릭
			$("#deleteFilebtn").on("click", function(){
				// 파일 삭제 확인 창
				deleteChk = confirm("파일을 삭제하시겠습니까?");
				if(deleteChk == true){ // 눌렀으면
					$.ajax({
						url : "communityFileDelete.do",
						type : "POST",
						data : { 
									"cnum" : $("#cnum").val(),
									"mid" : $("#mid").val()
								},
						success : function(result){
							alert(result);
							// 파일 삭제했으면 기존에 있는 이미지 안보이게
							$(".img").remove();
						},
						error : function(){
							alert("연결에 문제가 있습니다.");
						}
					});
				}
			});
		});
	</script>
</head>
<body>
	<form name="communityForm" id="communityForm">
		<input type="hidden" name="cnum" id="cnum" value='${communityDetail.cnum}' />
		<input type="hidden" name="mid" id="mid" value='${communityDetail.mid}' />
		<input type="hidden" name="boardtype" id="boardtype" value="${boardtype}"/>
		
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
	
            <!--content_head-->
            <div class="content_head">
                <div>게시글 수정</div>
            </div>
	
			<!--content_content-->
			<div class="content_group">
				<!-- ========= 테이블 시작 ============ -->
				<table>
					<tr>
						<td>제목 </td>
						<td>
							<input type="text" name="csubject" id="csubject" size="53" value="${communityDetail.csubject}">
						</td>
					</tr>	
					<tr>
						<td>내용</td>
						<td>
							<textarea name="ccontent" id="ccontent" cols="50"
									  rows="10">${communityDetail.ccontent}</textarea>
						</td>
					</tr>
					<tr>
						<td>사진</td>
						<td>
							<div class="fileChange">
								<div>
									<c:if test="${communityDetail.cfile != 'NA'}">
										<img class="img"
											 src="${pageContext.request.contextPath}/imgupload/${communityDetail.cfile}" />
										<br>
									</c:if>
								</div>
								<!--기존 input 숨기고 label 클릭시 기능하도록-->
								<div>
									<label class="upload_file" for="changeOption">이미지 수정하기</label>
									<input type="button" value="이미지 수정하기" name="changeOption" id="changeOption"
			                               style="display: none;" />
								</div>
								<div class="fileUpdate" style="display: none;">
		                           	<input type="button" value="이미지 변경하기" name="changeFilebtn" id="changeFilebtn" />
		                           	<input type="button" value="이미지 삭제하기" name="deleteFilebtn" id="deleteFilebtn" />
								</div>
							</div>
						</td>
					</tr>
				</table>
				<!-- ========= 테이블 끝 ============ -->
				<div>
	            	<input type="button" id="communityUpdatebtn" name="communityUpdatebtn" 
	            		   class="com_btn" value="수정하기" />
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