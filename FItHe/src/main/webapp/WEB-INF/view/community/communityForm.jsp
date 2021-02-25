<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<% 
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<head>
    <meta charset="UTF-8">
    <title>자유게시글 작성페이지</title>
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
    <script src="${ctx}/include/js/common.js" defer></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
		
		$("#cinsertbtn").on("click", function(){
			oEditors.getById["ccontent"].exec("UPDATE_CONTENTS_FIELD", []);
			
			// alert($("#cfile").val());
			
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
				'action':'communityInsert.do',
				'enctype':'multipart/form-data'
			}).submit();
		});
		
		document.getElementById('cfile').addEventListener('change', function(){
            var filename = document.getElementById('file_name_in');
            if(this.files[0] == undefined){
                filename.innerText = '선택된 파일없음';
                return;
            }
           	
            filename.innerText = this.files[0].name;
    	});
	});
	</script>
</head>
<body>
	<form name="communityForm" id="communityForm" >
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
                    <div>자유게시판</div>
                </div>
                <!--content_content-->
                <div class="content_group">
                    <table>
						<tr>
                            <td>제목 </td>
                            <td><input type="text" name="csubject" id="csubject"></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td>
                                <textarea name="ccontent" id="ccontent" cols="50" rows="10"></textarea>
                            </td>
                        </tr>
						<tr>
                            <td>사진</td>
                            <td>
                                <div class="filebox">
                                    <!--기존 input 숨기고 label 클릭시 기능하도록-->
                                    <label class="upload_file" for="cfile">업로드</label>
                                    <input type="file" name="cfile" id="cfile" style="display: none;">
                                    <span id="file_name_in">선택된 파일없음</span>
                                </div>
                            </td>
                       	</tr>
                        </table>
					<div>
                       	<input type="button" value="글쓰기" id="cinsertbtn" name="cinsertbtn" class="com_btn">
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